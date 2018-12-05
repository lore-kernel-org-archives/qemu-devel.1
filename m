Received: from eggs.gnu.org ([2001:4830:134:3::10]:43306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUdix-00088C-NE
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUdit-00036u-PB
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:24:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gUdit-00036O-GT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:24:43 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5KOUGQ133459
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 15:24:42 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p6kwn4wyy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 15:24:41 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 5 Dec 2018 20:24:40 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181205171818.GA1136@redhat.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
Date: Wed, 05 Dec 2018 14:24:32 -0600
Message-Id: <154404147264.6063.14869520867110106084@sif>
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
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Sameeh Jubran <sameeh@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

Quoting Daniel P. Berrang=C3=A9 (2018-12-05 11:18:18)
> On Thu, Oct 25, 2018 at 05:06:29PM +0300, Sameeh Jubran wrote:
> > From: Sameeh Jubran <sjubran@redhat.com>
> > =

> > Hi all,
> > =

> > Background:
> > =

> > There has been a few attempts to implement the standby feature for vfio
> > assigned devices which aims to enable the migration of such devices. Th=
is
> > is another attempt.
> > =

> > The series implements an infrastructure for hiding devices from the bus
> > upon boot. What it does is the following:
> > =

> > * In the first patch the infrastructure for hiding the device is added
> >   for the qbus and qdev APIs. A "hidden" boolean is added to the device
> >   state and it is set based on a callback to the standby device which
> >   registers itself for handling the assessment: "should the primary dev=
ice
> >   be hidden?" by cross validating the ids of the devices.
> > =

> > * In the second patch the virtio-net uses the API to hide the vfio
> >   device and unhides it when the feature is acked.
> =

> IIUC, the general idea is that we want to provide a pair of associated NIC
> devices to the guest, one emulated, one physical PCI device. The guest wo=
uld
> put them in a bonded pair. Before migration the PCI device is unplugged &=
 a
> new PCI device plugged on target after migration. The guest traffic conti=
nues
> without interuption due to the emulate device.
> =

> This kind of conceptual approach can already be implemented today by mana=
gement
> apps. The only hard problem that exists today is how the guest OS can fig=
ure
> out that a particular pair of devices it has are intended to be used toge=
ther. =

> =

> With this series, IIUC, the virtio-net device is getting a given property=
 which
> defines the qdev ID of the associated VFIO device. When the guest OS acti=
vates
> the virtio-net device and acknowledges the STANDBY feature bit, qdev then
> unhides the associated VFIO device.
> =

> AFAICT the guest has to infer that the device which suddenly appears is t=
he one
> associated with the virtio-net device it just initialized, for purposes of
> setting up the NIC bonding. There doesn't appear to be any explicit assoc=
ation
> between the devices exposed to the guest.
> =

> This feels pretty fragile for a guest needing to match up devices when th=
ere
> are many pairs of devices exposed to a single guest.

The impression I get from linux.git:Documentation/networking/net_failover.r=
st =

is that the matching is done based on the primary/standby NICs having
the same MAC address. In theory you pass both to a guest and based on
MAC it essentially does automatic, and if you additionally add STANDBY
it'll know to use a virtio-net device specifically for failover.

None of this requires any sort of hiding/plugging of devices from
QEMU/libvirt (except for the VFIO unplug we'd need to initiate live migrati=
on
and the VFIO hotplug on the other end to switch back over).

That simplifies things greatly, but also introduces the problem of how
an older guest will handle seeing 2 NICs with the same MAC, which IIUC
is why this series is looking at hotplugging the VFIO device only after
we confirm STANDBY is supported by the virtio-net device, and why it's
being done transparent to management.

> =

> Unless I'm mis-reading the patches, it looks like the VFIO device always =
has
> to be available at the time QEMU is started. There's no way to boot a gue=
st
> and then later hotplug a VFIO device to accelerate the existing virtio-ne=
t NIC.
> Or similarly after migration there might not be any VFIO device available
> initially when QEMU is started to accept the incoming migration. So it mi=
ght
> need to run in degraded mode for an extended period of time until one bec=
omes
> available for hotplugging. The use of qdev IDs makes this troublesome, as=
 the
> qdev ID of the future VFIO device would need to be decided upfront before=
 it
> even exists.

> =

> So overall I'm not really a fan of the dynamic hiding/unhiding of devices=
. I
> would much prefer to see some way to expose an explicit relationship betw=
een
> the devices to the guest.

If we place the burden of determining whether the guest supports STANDBY
on the part of users/management, a lot of this complexity goes away. For
instance, one possible implementation is to simply fail migration and say
"sorry your VFIO device is still there" if the VFIO device is still around
at the start of migration (whether due to unplug failure or a
user/management forgetting to do it manually beforehand).

So how important is it that setting F_STANDBY cap doesn't break older
guests? If the idea is to support live migration with VFs then aren't
we still dead in the water if the guest boots okay but doesn't have
the requisite functionality to be migrated later? Shouldn't that all
be sorted out as early as possible? Is a very clear QEMU error message
in this case insufficient?

And if backward compatibility is important, are there alternative
approaches? Like maybe starting off with a dummy MAC and switching over
to the duplicate MAC only after F_STANDBY is negotiated? In that case
we could still warn users/management about it but still have the guest
be otherwise functional.

> =

> > Disclaimers:
> > =

> > * I have only scratch tested this and from qemu side, it seems to be
> >   working.
> > * This is an RFC so it lacks some proper error handling in few cases
> >   and proper resource freeing. I wanted to get some feedback first
> >   before it is finalized.
> > =

> > Command line example:
> > =

> > /home/sameeh/Builds/failover/qemu/x86_64-softmmu/qemu-system-x86_64 \
> > -netdev tap,id=3Dhostnet0,script=3Dworld_bridge_standalone.sh,downscrip=
t=3Dno,ifname=3Dcc1_71 \
> > -netdev tap,vhost=3Don,id=3Dhostnet1,script=3Dworld_bridge_standalone.s=
h,downscript=3Dno,ifname=3Dcc1_72,queues=3D4 \
> > -device virtio-net,host_mtu=3D1500,netdev=3Dhostnet1,id=3Dcc1_72,vector=
s=3D10,mq=3Don,primary=3Dcc1_71 \
> > -device e1000,netdev=3Dhostnet0,id=3Dcc1_71,standby=3Dcc1_72 \
> > =

> > Migration support:
> > =

> > Pre migration or during setup phase of the migration we should send an
> > unplug request to the guest to unplug the primary device. I haven't had
> > the chance to implement that part yet but should do soon. Do you know
> > what's the best approach to do so? I wanted to have a callback to the
> > virtio-net device which tries to send an unplug request to the guest and
> > if succeeds then the migration continues. It needs to handle the case w=
here
> > the migration fails and then it has to replug the primary device back.
> =

> Having QEMU do this internally gets into a world of pain when you have
> multiple devices in the guest.
> =

> Consider if we have 2 pairs of devices. We unplug one VFIO device, but
> unplugging the second VFIO device fails, thus we try to replug the first
> VFIO device but this now fails too. We don't even get as far as starting
> the migration before we have to return an error.
> =

> The mgmt app will just see that the migration failed, but it will not
> be sure which devices are now actually exposed to the guest OS correctly.
> =

> The similar problem hits if we started the migration data stream, but
> then had to abort and so need to tear try to replug in the source but
> failed for some reasons.
> =

> Doing the VFIO device plugging/unplugging explicitly from the mgmt app
> gives that mgmt app direct information about which devices have been
> successfully made available to the guest at all time, becuase the mgmt
> app can see the errors from each step of the process.  Trying to do
> this inside QEMU doesn't achieve anything the mgmt app can't already
> do, but it obscures what happens during failures.  The same applies at
> the libvirt level too, which is why mgmt apps today will do the VFIO
> unplug/replug either side of migration themselves.
> =

> =

> Regards,
> Daniel
> -- =

> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20
