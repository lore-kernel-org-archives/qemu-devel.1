Received: from eggs.gnu.org ([2001:4830:134:3::10]:49613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gVJ7a-0001ES-EP
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gVJ7X-0007Oq-59
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:36:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gVJ7P-0006PC-Hn
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:36:51 -0500
Date: Fri, 7 Dec 2018 14:36:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181207163607.GD7395@habkost.net>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
	<154404147264.6063.14869520867110106084@sif>
	<20181206100618.GF29540@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181206100618.GF29540@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On Thu, Dec 06, 2018 at 10:06:18AM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Dec 05, 2018 at 02:24:32PM -0600, Michael Roth wrote:
> > Quoting Daniel P. Berrang=E9 (2018-12-05 11:18:18)
> > > On Thu, Oct 25, 2018 at 05:06:29PM +0300, Sameeh Jubran wrote:
> > > > From: Sameeh Jubran <sjubran@redhat.com>
> > > >=20
> > > > Hi all,
> > > >=20
> > > > Background:
> > > >=20
> > > > There has been a few attempts to implement the standby feature fo=
r vfio
> > > > assigned devices which aims to enable the migration of such devic=
es. This
> > > > is another attempt.
> > > >=20
> > > > The series implements an infrastructure for hiding devices from t=
he bus
> > > > upon boot. What it does is the following:
> > > >=20
> > > > * In the first patch the infrastructure for hiding the device is =
added
> > > >   for the qbus and qdev APIs. A "hidden" boolean is added to the =
device
> > > >   state and it is set based on a callback to the standby device w=
hich
> > > >   registers itself for handling the assessment: "should the prima=
ry device
> > > >   be hidden?" by cross validating the ids of the devices.
> > > >=20
> > > > * In the second patch the virtio-net uses the API to hide the vfi=
o
> > > >   device and unhides it when the feature is acked.
> > >=20
> > > IIUC, the general idea is that we want to provide a pair of associa=
ted NIC
> > > devices to the guest, one emulated, one physical PCI device. The gu=
est would
> > > put them in a bonded pair. Before migration the PCI device is unplu=
gged & a
> > > new PCI device plugged on target after migration. The guest traffic=
 continues
> > > without interuption due to the emulate device.
> > >=20
> > > This kind of conceptual approach can already be implemented today b=
y management
> > > apps. The only hard problem that exists today is how the guest OS c=
an figure
> > > out that a particular pair of devices it has are intended to be use=
d together.=20
> > >=20
> > > With this series, IIUC, the virtio-net device is getting a given pr=
operty which
> > > defines the qdev ID of the associated VFIO device. When the guest O=
S activates
> > > the virtio-net device and acknowledges the STANDBY feature bit, qde=
v then
> > > unhides the associated VFIO device.
> > >=20
> > > AFAICT the guest has to infer that the device which suddenly appear=
s is the one
> > > associated with the virtio-net device it just initialized, for purp=
oses of
> > > setting up the NIC bonding. There doesn't appear to be any explicit=
 assocation
> > > between the devices exposed to the guest.
> > >=20
> > > This feels pretty fragile for a guest needing to match up devices w=
hen there
> > > are many pairs of devices exposed to a single guest.
> >=20
> > The impression I get from linux.git:Documentation/networking/net_fail=
over.rst=20
> > is that the matching is done based on the primary/standby NICs having
> > the same MAC address. In theory you pass both to a guest and based on
> > MAC it essentially does automatic, and if you additionally add STANDB=
Y
> > it'll know to use a virtio-net device specifically for failover.
> >=20
> > None of this requires any sort of hiding/plugging of devices from
> > QEMU/libvirt (except for the VFIO unplug we'd need to initiate live m=
igration
> > and the VFIO hotplug on the other end to switch back over).
> >=20
> > That simplifies things greatly, but also introduces the problem of ho=
w
> > an older guest will handle seeing 2 NICs with the same MAC, which IIU=
C
> > is why this series is looking at hotplugging the VFIO device only aft=
er
> > we confirm STANDBY is supported by the virtio-net device, and why it'=
s
> > being done transparent to management.
> >
> > >=20
> > > Unless I'm mis-reading the patches, it looks like the VFIO device a=
lways has
> > > to be available at the time QEMU is started. There's no way to boot=
 a guest
> > > and then later hotplug a VFIO device to accelerate the existing vir=
tio-net NIC.
> > > Or similarly after migration there might not be any VFIO device ava=
ilable
> > > initially when QEMU is started to accept the incoming migration. So=
 it might
> > > need to run in degraded mode for an extended period of time until o=
ne becomes
> > > available for hotplugging. The use of qdev IDs makes this troubleso=
me, as the
> > > qdev ID of the future VFIO device would need to be decided upfront =
before it
> > > even exists.
> >=20
> > >=20
> > > So overall I'm not really a fan of the dynamic hiding/unhiding of d=
evices. I
> > > would much prefer to see some way to expose an explicit relationshi=
p between
> > > the devices to the guest.
> >=20
> > If we place the burden of determining whether the guest supports STAN=
DBY
> > on the part of users/management, a lot of this complexity goes away. =
For
> > instance, one possible implementation is to simply fail migration and=
 say
> > "sorry your VFIO device is still there" if the VFIO device is still a=
round
> > at the start of migration (whether due to unplug failure or a
> > user/management forgetting to do it manually beforehand).
> >=20
> > So how important is it that setting F_STANDBY cap doesn't break older
> > guests? If the idea is to support live migration with VFs then aren't
> > we still dead in the water if the guest boots okay but doesn't have
> > the requisite functionality to be migrated later? Shouldn't that all
> > be sorted out as early as possible? Is a very clear QEMU error messag=
e
> > in this case insufficient?
> >=20
> > And if backward compatibility is important, are there alternative
> > approaches? Like maybe starting off with a dummy MAC and switching ov=
er
> > to the duplicate MAC only after F_STANDBY is negotiated? In that case
> > we could still warn users/management about it but still have the gues=
t
> > be otherwise functional.
>=20
> Relying on F_STANDBY negotiation to decide whether to activate the VFIO
> device is a bad idea. PCI devices are precious, so if the guest OS does
> not support this standby feature, we must never add the VFIO device to
> QEMU in the first place.
>=20
> We have the libosinfo project which provides metadata on what features
> different guest OS versions support. This can be used to indicate wheth=
er
> a guest OS version supports the standby NIC concept and thus avoid need=
ing
> to allocate PCI devices to guests that will never use them.
>=20
> F_STANDBY is still useful as a flag to inform the guest OS that it shou=
ld
> pair up NICs with identical MACs, as opposed to configuring them separa=
tely.
> It shouldn't be used to show/hide the device though, we should simply n=
ever
> add the 2nd device if we know it won't be used by a given guest OS vers=
ion.

The two mechanisms are not exclusive.  Not wasting a PCI device
if the guest OS won't use it is a good idea.  Making the guest
behave gracefully even when an older driver is loaded is also
useful.

--=20
Eduardo
