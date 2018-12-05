Received: from eggs.gnu.org ([2001:4830:134:3::10]:41781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUaor-0002UI-T2
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUaol-0006yO-No
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:18:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gUaol-0006ka-7f
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:18:35 -0500
Date: Wed, 5 Dec 2018 17:18:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181205171818.GA1136@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181025140631.634922-1-sameeh@daynix.com>
Subject: Re: [Qemu-devel] [RFC 0/2] Attempt to implement the standby feature
 for assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Thu, Oct 25, 2018 at 05:06:29PM +0300, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> Hi all,
> 
> Background:
> 
> There has been a few attempts to implement the standby feature for vfio
> assigned devices which aims to enable the migration of such devices. This
> is another attempt.
> 
> The series implements an infrastructure for hiding devices from the bus
> upon boot. What it does is the following:
> 
> * In the first patch the infrastructure for hiding the device is added
>   for the qbus and qdev APIs. A "hidden" boolean is added to the device
>   state and it is set based on a callback to the standby device which
>   registers itself for handling the assessment: "should the primary device
>   be hidden?" by cross validating the ids of the devices.
> 
> * In the second patch the virtio-net uses the API to hide the vfio
>   device and unhides it when the feature is acked.

IIUC, the general idea is that we want to provide a pair of associated NIC
devices to the guest, one emulated, one physical PCI device. The guest would
put them in a bonded pair. Before migration the PCI device is unplugged & a
new PCI device plugged on target after migration. The guest traffic continues
without interuption due to the emulate device.

This kind of conceptual approach can already be implemented today by management
apps. The only hard problem that exists today is how the guest OS can figure
out that a particular pair of devices it has are intended to be used together. 

With this series, IIUC, the virtio-net device is getting a given property which
defines the qdev ID of the associated VFIO device. When the guest OS activates
the virtio-net device and acknowledges the STANDBY feature bit, qdev then
unhides the associated VFIO device.

AFAICT the guest has to infer that the device which suddenly appears is the one
associated with the virtio-net device it just initialized, for purposes of
setting up the NIC bonding. There doesn't appear to be any explicit assocation
between the devices exposed to the guest.

This feels pretty fragile for a guest needing to match up devices when there
are many pairs of devices exposed to a single guest.

Unless I'm mis-reading the patches, it looks like the VFIO device always has
to be available at the time QEMU is started. There's no way to boot a guest
and then later hotplug a VFIO device to accelerate the existing virtio-net NIC.
Or similarly after migration there might not be any VFIO device available
initially when QEMU is started to accept the incoming migration. So it might
need to run in degraded mode for an extended period of time until one becomes
available for hotplugging. The use of qdev IDs makes this troublesome, as the
qdev ID of the future VFIO device would need to be decided upfront before it
even exists.

So overall I'm not really a fan of the dynamic hiding/unhiding of devices. I
would much prefer to see some way to expose an explicit relationship between
the devices to the guest.

> Disclaimers:
> 
> * I have only scratch tested this and from qemu side, it seems to be
>   working.
> * This is an RFC so it lacks some proper error handling in few cases
>   and proper resource freeing. I wanted to get some feedback first
>   before it is finalized.
> 
> Command line example:
> 
> /home/sameeh/Builds/failover/qemu/x86_64-softmmu/qemu-system-x86_64 \
> -netdev tap,id=hostnet0,script=world_bridge_standalone.sh,downscript=no,ifname=cc1_71 \
> -netdev tap,vhost=on,id=hostnet1,script=world_bridge_standalone.sh,downscript=no,ifname=cc1_72,queues=4 \
> -device virtio-net,host_mtu=1500,netdev=hostnet1,id=cc1_72,vectors=10,mq=on,primary=cc1_71 \
> -device e1000,netdev=hostnet0,id=cc1_71,standby=cc1_72 \
> 
> Migration support:
> 
> Pre migration or during setup phase of the migration we should send an
> unplug request to the guest to unplug the primary device. I haven't had
> the chance to implement that part yet but should do soon. Do you know
> what's the best approach to do so? I wanted to have a callback to the
> virtio-net device which tries to send an unplug request to the guest and
> if succeeds then the migration continues. It needs to handle the case where
> the migration fails and then it has to replug the primary device back.

Having QEMU do this internally gets into a world of pain when you have
multiple devices in the guest.

Consider if we have 2 pairs of devices. We unplug one VFIO device, but
unplugging the second VFIO device fails, thus we try to replug the first
VFIO device but this now fails too. We don't even get as far as starting
the migration before we have to return an error.

The mgmt app will just see that the migration failed, but it will not
be sure which devices are now actually exposed to the guest OS correctly.

The similar problem hits if we started the migration data stream, but
then had to abort and so need to tear try to replug in the source but
failed for some reasons.

Doing the VFIO device plugging/unplugging explicitly from the mgmt app
gives that mgmt app direct information about which devices have been
successfully made available to the guest at all time, becuase the mgmt
app can see the errors from each step of the process.  Trying to do
this inside QEMU doesn't achieve anything the mgmt app can't already
do, but it obscures what happens during failures.  The same applies at
the libvirt level too, which is why mgmt apps today will do the VFIO
unplug/replug either side of migration themselves.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
