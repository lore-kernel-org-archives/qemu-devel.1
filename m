Received: from eggs.gnu.org ([2001:4830:134:3::10]:43943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUqYG-0001hc-D9
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUqYA-0005n6-Un
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:06:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gUqYA-0005k2-2h
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:06:30 -0500
Date: Thu, 6 Dec 2018 10:06:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206100618.GF29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
	<154404147264.6063.14869520867110106084@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154404147264.6063.14869520867110106084@sif>
Content-Transfer-Encoding: quoted-printable
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Dec 05, 2018 at 02:24:32PM -0600, Michael Roth wrote:
> Quoting Daniel P. Berrang=C3=A9 (2018-12-05 11:18:18)
> > On Thu, Oct 25, 2018 at 05:06:29PM +0300, Sameeh Jubran wrote:
> > > From: Sameeh Jubran <sjubran@redhat.com>
> > >=20
> > > Hi all,
> > >=20
> > > Background:
> > >=20
> > > There has been a few attempts to implement the standby feature for =
vfio
> > > assigned devices which aims to enable the migration of such devices=
. This
> > > is another attempt.
> > >=20
> > > The series implements an infrastructure for hiding devices from the=
 bus
> > > upon boot. What it does is the following:
> > >=20
> > > * In the first patch the infrastructure for hiding the device is ad=
ded
> > >   for the qbus and qdev APIs. A "hidden" boolean is added to the de=
vice
> > >   state and it is set based on a callback to the standby device whi=
ch
> > >   registers itself for handling the assessment: "should the primary=
 device
> > >   be hidden?" by cross validating the ids of the devices.
> > >=20
> > > * In the second patch the virtio-net uses the API to hide the vfio
> > >   device and unhides it when the feature is acked.
> >=20
> > IIUC, the general idea is that we want to provide a pair of associate=
d NIC
> > devices to the guest, one emulated, one physical PCI device. The gues=
t would
> > put them in a bonded pair. Before migration the PCI device is unplugg=
ed & a
> > new PCI device plugged on target after migration. The guest traffic c=
ontinues
> > without interuption due to the emulate device.
> >=20
> > This kind of conceptual approach can already be implemented today by =
management
> > apps. The only hard problem that exists today is how the guest OS can=
 figure
> > out that a particular pair of devices it has are intended to be used =
together.=20
> >=20
> > With this series, IIUC, the virtio-net device is getting a given prop=
erty which
> > defines the qdev ID of the associated VFIO device. When the guest OS =
activates
> > the virtio-net device and acknowledges the STANDBY feature bit, qdev =
then
> > unhides the associated VFIO device.
> >=20
> > AFAICT the guest has to infer that the device which suddenly appears =
is the one
> > associated with the virtio-net device it just initialized, for purpos=
es of
> > setting up the NIC bonding. There doesn't appear to be any explicit a=
ssocation
> > between the devices exposed to the guest.
> >=20
> > This feels pretty fragile for a guest needing to match up devices whe=
n there
> > are many pairs of devices exposed to a single guest.
>=20
> The impression I get from linux.git:Documentation/networking/net_failov=
er.rst=20
> is that the matching is done based on the primary/standby NICs having
> the same MAC address. In theory you pass both to a guest and based on
> MAC it essentially does automatic, and if you additionally add STANDBY
> it'll know to use a virtio-net device specifically for failover.
>=20
> None of this requires any sort of hiding/plugging of devices from
> QEMU/libvirt (except for the VFIO unplug we'd need to initiate live mig=
ration
> and the VFIO hotplug on the other end to switch back over).
>=20
> That simplifies things greatly, but also introduces the problem of how
> an older guest will handle seeing 2 NICs with the same MAC, which IIUC
> is why this series is looking at hotplugging the VFIO device only after
> we confirm STANDBY is supported by the virtio-net device, and why it's
> being done transparent to management.
>
> >=20
> > Unless I'm mis-reading the patches, it looks like the VFIO device alw=
ays has
> > to be available at the time QEMU is started. There's no way to boot a=
 guest
> > and then later hotplug a VFIO device to accelerate the existing virti=
o-net NIC.
> > Or similarly after migration there might not be any VFIO device avail=
able
> > initially when QEMU is started to accept the incoming migration. So i=
t might
> > need to run in degraded mode for an extended period of time until one=
 becomes
> > available for hotplugging. The use of qdev IDs makes this troublesome=
, as the
> > qdev ID of the future VFIO device would need to be decided upfront be=
fore it
> > even exists.
>=20
> >=20
> > So overall I'm not really a fan of the dynamic hiding/unhiding of dev=
ices. I
> > would much prefer to see some way to expose an explicit relationship =
between
> > the devices to the guest.
>=20
> If we place the burden of determining whether the guest supports STANDB=
Y
> on the part of users/management, a lot of this complexity goes away. Fo=
r
> instance, one possible implementation is to simply fail migration and s=
ay
> "sorry your VFIO device is still there" if the VFIO device is still aro=
und
> at the start of migration (whether due to unplug failure or a
> user/management forgetting to do it manually beforehand).
>=20
> So how important is it that setting F_STANDBY cap doesn't break older
> guests? If the idea is to support live migration with VFs then aren't
> we still dead in the water if the guest boots okay but doesn't have
> the requisite functionality to be migrated later? Shouldn't that all
> be sorted out as early as possible? Is a very clear QEMU error message
> in this case insufficient?
>=20
> And if backward compatibility is important, are there alternative
> approaches? Like maybe starting off with a dummy MAC and switching over
> to the duplicate MAC only after F_STANDBY is negotiated? In that case
> we could still warn users/management about it but still have the guest
> be otherwise functional.

Relying on F_STANDBY negotiation to decide whether to activate the VFIO
device is a bad idea. PCI devices are precious, so if the guest OS does
not support this standby feature, we must never add the VFIO device to
QEMU in the first place.

We have the libosinfo project which provides metadata on what features
different guest OS versions support. This can be used to indicate whether
a guest OS version supports the standby NIC concept and thus avoid needin=
g
to allocate PCI devices to guests that will never use them.

F_STANDBY is still useful as a flag to inform the guest OS that it should
pair up NICs with identical MACs, as opposed to configuring them separate=
ly.
It shouldn't be used to show/hide the device though, we should simply nev=
er
add the 2nd device if we know it won't be used by a given guest OS versio=
n.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
