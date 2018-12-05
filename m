Received: from eggs.gnu.org ([2001:4830:134:3::10]:57704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUeEX-0006UV-Ry
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUeET-0007nM-OO
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:57:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gUeET-0007ml-DX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:57:21 -0500
Date: Wed, 5 Dec 2018 15:57:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181205154201-mutt-send-email-mst@kernel.org>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
	<154404147264.6063.14869520867110106084@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Dec 05, 2018 at 02:24:32PM -0600, Michael Roth wrote:
> Quoting Daniel P. Berrang=E9 (2018-12-05 11:18:18)
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

Exactly, thanks for the summary.

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

It's a bit different. What happens is that migration just doesn't
finish. Same as it sometimes doesn't when guest dirties too much memory.
Upper layers usually handle that in a way similar to what you describe.
If it's desirable that the reason for migration not finishing is
reported to user, we can add that information for sure. Though most
users likely won't care.

> So how important is it that setting F_STANDBY cap doesn't break older
> guests? If the idea is to support live migration with VFs then aren't
> we still dead in the water if the guest boots okay but doesn't have
> the requisite functionality to be migrated later?

No because such legacy guest will never see the PT device at all.  So it
can migrate.

> Shouldn't that all
> be sorted out as early as possible? Is a very clear QEMU error message
> in this case insufficient?
>=20
> And if backward compatibility is important, are there alternative
> approaches? Like maybe starting off with a dummy MAC and switching over
> to the duplicate MAC only after F_STANDBY is negotiated? In that case
> we could still warn users/management about it but still have the guest
> be otherwise functional.
>=20
> >=20
> > > Disclaimers:
> > >=20
> > > * I have only scratch tested this and from qemu side, it seems to b=
e
> > >   working.
> > > * This is an RFC so it lacks some proper error handling in few case=
s
> > >   and proper resource freeing. I wanted to get some feedback first
> > >   before it is finalized.
> > >=20
> > > Command line example:
> > >=20
> > > /home/sameeh/Builds/failover/qemu/x86_64-softmmu/qemu-system-x86_64=
 \
> > > -netdev tap,id=3Dhostnet0,script=3Dworld_bridge_standalone.sh,downs=
cript=3Dno,ifname=3Dcc1_71 \
> > > -netdev tap,vhost=3Don,id=3Dhostnet1,script=3Dworld_bridge_standalo=
ne.sh,downscript=3Dno,ifname=3Dcc1_72,queues=3D4 \
> > > -device virtio-net,host_mtu=3D1500,netdev=3Dhostnet1,id=3Dcc1_72,ve=
ctors=3D10,mq=3Don,primary=3Dcc1_71 \
> > > -device e1000,netdev=3Dhostnet0,id=3Dcc1_71,standby=3Dcc1_72 \
> > >=20
> > > Migration support:
> > >=20
> > > Pre migration or during setup phase of the migration we should send=
 an
> > > unplug request to the guest to unplug the primary device. I haven't=
 had
> > > the chance to implement that part yet but should do soon. Do you kn=
ow
> > > what's the best approach to do so? I wanted to have a callback to t=
he
> > > virtio-net device which tries to send an unplug request to the gues=
t and
> > > if succeeds then the migration continues. It needs to handle the ca=
se where
> > > the migration fails and then it has to replug the primary device ba=
ck.
> >=20
> > Having QEMU do this internally gets into a world of pain when you hav=
e
> > multiple devices in the guest.
> >=20
> > Consider if we have 2 pairs of devices. We unplug one VFIO device, bu=
t
> > unplugging the second VFIO device fails, thus we try to replug the fi=
rst
> > VFIO device but this now fails too. We don't even get as far as start=
ing
> > the migration before we have to return an error.
> >=20
> > The mgmt app will just see that the migration failed, but it will not
> > be sure which devices are now actually exposed to the guest OS correc=
tly.
> >=20
> > The similar problem hits if we started the migration data stream, but
> > then had to abort and so need to tear try to replug in the source but
> > failed for some reasons.
> >=20
> > Doing the VFIO device plugging/unplugging explicitly from the mgmt ap=
p
> > gives that mgmt app direct information about which devices have been
> > successfully made available to the guest at all time, becuase the mgm=
t
> > app can see the errors from each step of the process.  Trying to do
> > this inside QEMU doesn't achieve anything the mgmt app can't already
> > do, but it obscures what happens during failures.  The same applies a=
t
> > the libvirt level too, which is why mgmt apps today will do the VFIO
> > unplug/replug either side of migration themselves.
> >=20
> >=20
> > Regards,
> > Daniel
> > --=20
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dbe=
rrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berran=
ge.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dbe=
rrange :|
> >=20
