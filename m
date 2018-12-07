Received: from eggs.gnu.org ([2001:4830:134:3::10]:52772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVJHQ-0004mg-1B
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVJHM-0008Oq-5d
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:47:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gVJHL-0006sN-RJ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:47:04 -0500
Date: Fri, 7 Dec 2018 16:46:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181207164629.GP13784@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
	<154404147264.6063.14869520867110106084@sif>
	<20181206100618.GF29540@redhat.com>
	<20181207163607.GD7395@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207163607.GD7395@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On Fri, Dec 07, 2018 at 02:36:07PM -0200, Eduardo Habkost wrote:
> On Thu, Dec 06, 2018 at 10:06:18AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Dec 05, 2018 at 02:24:32PM -0600, Michael Roth wrote:
> > > Quoting Daniel P. Berrang=C3=A9 (2018-12-05 11:18:18)
> > > > On Thu, Oct 25, 2018 at 05:06:29PM +0300, Sameeh Jubran wrote:
> > > > > From: Sameeh Jubran <sjubran@redhat.com>
> > > > >=20
> > > > > Hi all,
> > > > >=20
> > > > > Background:
> > > > >=20
> > > > > There has been a few attempts to implement the standby feature =
for vfio
> > > > > assigned devices which aims to enable the migration of such dev=
ices. This
> > > > > is another attempt.
> > > > >=20
> > > > > The series implements an infrastructure for hiding devices from=
 the bus
> > > > > upon boot. What it does is the following:
> > > > >=20
> > > > > * In the first patch the infrastructure for hiding the device i=
s added
> > > > >   for the qbus and qdev APIs. A "hidden" boolean is added to th=
e device
> > > > >   state and it is set based on a callback to the standby device=
 which
> > > > >   registers itself for handling the assessment: "should the pri=
mary device
> > > > >   be hidden?" by cross validating the ids of the devices.
> > > > >=20
> > > > > * In the second patch the virtio-net uses the API to hide the v=
fio
> > > > >   device and unhides it when the feature is acked.
> > > >=20
> > > > IIUC, the general idea is that we want to provide a pair of assoc=
iated NIC
> > > > devices to the guest, one emulated, one physical PCI device. The =
guest would
> > > > put them in a bonded pair. Before migration the PCI device is unp=
lugged & a
> > > > new PCI device plugged on target after migration. The guest traff=
ic continues
> > > > without interuption due to the emulate device.
> > > >=20
> > > > This kind of conceptual approach can already be implemented today=
 by management
> > > > apps. The only hard problem that exists today is how the guest OS=
 can figure
> > > > out that a particular pair of devices it has are intended to be u=
sed together.=20
> > > >=20
> > > > With this series, IIUC, the virtio-net device is getting a given =
property which
> > > > defines the qdev ID of the associated VFIO device. When the guest=
 OS activates
> > > > the virtio-net device and acknowledges the STANDBY feature bit, q=
dev then
> > > > unhides the associated VFIO device.
> > > >=20
> > > > AFAICT the guest has to infer that the device which suddenly appe=
ars is the one
> > > > associated with the virtio-net device it just initialized, for pu=
rposes of
> > > > setting up the NIC bonding. There doesn't appear to be any explic=
it assocation
> > > > between the devices exposed to the guest.
> > > >=20
> > > > This feels pretty fragile for a guest needing to match up devices=
 when there
> > > > are many pairs of devices exposed to a single guest.
> > >=20
> > > The impression I get from linux.git:Documentation/networking/net_fa=
ilover.rst=20
> > > is that the matching is done based on the primary/standby NICs havi=
ng
> > > the same MAC address. In theory you pass both to a guest and based =
on
> > > MAC it essentially does automatic, and if you additionally add STAN=
DBY
> > > it'll know to use a virtio-net device specifically for failover.
> > >=20
> > > None of this requires any sort of hiding/plugging of devices from
> > > QEMU/libvirt (except for the VFIO unplug we'd need to initiate live=
 migration
> > > and the VFIO hotplug on the other end to switch back over).
> > >=20
> > > That simplifies things greatly, but also introduces the problem of =
how
> > > an older guest will handle seeing 2 NICs with the same MAC, which I=
IUC
> > > is why this series is looking at hotplugging the VFIO device only a=
fter
> > > we confirm STANDBY is supported by the virtio-net device, and why i=
t's
> > > being done transparent to management.
> > >
> > > >=20
> > > > Unless I'm mis-reading the patches, it looks like the VFIO device=
 always has
> > > > to be available at the time QEMU is started. There's no way to bo=
ot a guest
> > > > and then later hotplug a VFIO device to accelerate the existing v=
irtio-net NIC.
> > > > Or similarly after migration there might not be any VFIO device a=
vailable
> > > > initially when QEMU is started to accept the incoming migration. =
So it might
> > > > need to run in degraded mode for an extended period of time until=
 one becomes
> > > > available for hotplugging. The use of qdev IDs makes this trouble=
some, as the
> > > > qdev ID of the future VFIO device would need to be decided upfron=
t before it
> > > > even exists.
> > >=20
> > > >=20
> > > > So overall I'm not really a fan of the dynamic hiding/unhiding of=
 devices. I
> > > > would much prefer to see some way to expose an explicit relations=
hip between
> > > > the devices to the guest.
> > >=20
> > > If we place the burden of determining whether the guest supports ST=
ANDBY
> > > on the part of users/management, a lot of this complexity goes away=
. For
> > > instance, one possible implementation is to simply fail migration a=
nd say
> > > "sorry your VFIO device is still there" if the VFIO device is still=
 around
> > > at the start of migration (whether due to unplug failure or a
> > > user/management forgetting to do it manually beforehand).
> > >=20
> > > So how important is it that setting F_STANDBY cap doesn't break old=
er
> > > guests? If the idea is to support live migration with VFs then aren=
't
> > > we still dead in the water if the guest boots okay but doesn't have
> > > the requisite functionality to be migrated later? Shouldn't that al=
l
> > > be sorted out as early as possible? Is a very clear QEMU error mess=
age
> > > in this case insufficient?
> > >=20
> > > And if backward compatibility is important, are there alternative
> > > approaches? Like maybe starting off with a dummy MAC and switching =
over
> > > to the duplicate MAC only after F_STANDBY is negotiated? In that ca=
se
> > > we could still warn users/management about it but still have the gu=
est
> > > be otherwise functional.
> >=20
> > Relying on F_STANDBY negotiation to decide whether to activate the VF=
IO
> > device is a bad idea. PCI devices are precious, so if the guest OS do=
es
> > not support this standby feature, we must never add the VFIO device t=
o
> > QEMU in the first place.
> >=20
> > We have the libosinfo project which provides metadata on what feature=
s
> > different guest OS versions support. This can be used to indicate whe=
ther
> > a guest OS version supports the standby NIC concept and thus avoid ne=
eding
> > to allocate PCI devices to guests that will never use them.
> >=20
> > F_STANDBY is still useful as a flag to inform the guest OS that it sh=
ould
> > pair up NICs with identical MACs, as opposed to configuring them sepa=
rately.
> > It shouldn't be used to show/hide the device though, we should simply=
 never
> > add the 2nd device if we know it won't be used by a given guest OS ve=
rsion.
>=20
> The two mechanisms are not exclusive.  Not wasting a PCI device
> if the guest OS won't use it is a good idea.  Making the guest
> behave gracefully even when an older driver is loaded is also
> useful.

I'm not convinced it is useful enough to justify playing games in qdev
with dynamically hiding devices. This adds complexity to the code which
will make it harder to maintain and debug at runtime.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
