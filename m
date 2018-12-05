Received: from eggs.gnu.org ([2001:4830:134:3::10]:50889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUe2N-0005jM-4W
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUe2I-0006GV-0V
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:44:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35772
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gUe2H-0006GC-Qw
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:44:45 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5KiYGe104626
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 15:44:45 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p6nx504wb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 15:44:45 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 5 Dec 2018 20:44:44 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <154404147264.6063.14869520867110106084@sif>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
	<154404147264.6063.14869520867110106084@sif>
Date: Wed, 05 Dec 2018 14:44:38 -0600
Message-Id: <154404267804.6063.6272296350458255377@sif>
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Quoting Michael Roth (2018-12-05 14:24:32)
> Quoting Daniel P. Berrang=C3=A9 (2018-12-05 11:18:18)
> > On Thu, Oct 25, 2018 at 05:06:29PM +0300, Sameeh Jubran wrote:
> > > From: Sameeh Jubran <sjubran@redhat.com>
> > > =

> > > Hi all,
> > > =

> > > Background:
> > > =

> > > There has been a few attempts to implement the standby feature for vf=
io
> > > assigned devices which aims to enable the migration of such devices. =
This
> > > is another attempt.
> > > =

> > > The series implements an infrastructure for hiding devices from the b=
us
> > > upon boot. What it does is the following:
> > > =

> > > * In the first patch the infrastructure for hiding the device is added
> > >   for the qbus and qdev APIs. A "hidden" boolean is added to the devi=
ce
> > >   state and it is set based on a callback to the standby device which
> > >   registers itself for handling the assessment: "should the primary d=
evice
> > >   be hidden?" by cross validating the ids of the devices.
> > > =

> > > * In the second patch the virtio-net uses the API to hide the vfio
> > >   device and unhides it when the feature is acked.
> > =

> > IIUC, the general idea is that we want to provide a pair of associated =
NIC
> > devices to the guest, one emulated, one physical PCI device. The guest =
would
> > put them in a bonded pair. Before migration the PCI device is unplugged=
 & a
> > new PCI device plugged on target after migration. The guest traffic con=
tinues
> > without interuption due to the emulate device.
> > =

> > This kind of conceptual approach can already be implemented today by ma=
nagement
> > apps. The only hard problem that exists today is how the guest OS can f=
igure
> > out that a particular pair of devices it has are intended to be used to=
gether. =

> > =

> > With this series, IIUC, the virtio-net device is getting a given proper=
ty which
> > defines the qdev ID of the associated VFIO device. When the guest OS ac=
tivates
> > the virtio-net device and acknowledges the STANDBY feature bit, qdev th=
en
> > unhides the associated VFIO device.
> > =

> > AFAICT the guest has to infer that the device which suddenly appears is=
 the one
> > associated with the virtio-net device it just initialized, for purposes=
 of
> > setting up the NIC bonding. There doesn't appear to be any explicit ass=
ocation
> > between the devices exposed to the guest.
> > =

> > This feels pretty fragile for a guest needing to match up devices when =
there
> > are many pairs of devices exposed to a single guest.
> =

> The impression I get from linux.git:Documentation/networking/net_failover=
.rst =

> is that the matching is done based on the primary/standby NICs having
> the same MAC address. In theory you pass both to a guest and based on
> MAC it essentially does automatic, and if you additionally add STANDBY
> it'll know to use a virtio-net device specifically for failover.
> =

> None of this requires any sort of hiding/plugging of devices from
> QEMU/libvirt (except for the VFIO unplug we'd need to initiate live migra=
tion
> and the VFIO hotplug on the other end to switch back over).
> =

> That simplifies things greatly, but also introduces the problem of how
> an older guest will handle seeing 2 NICs with the same MAC, which IIUC
> is why this series is looking at hotplugging the VFIO device only after
> we confirm STANDBY is supported by the virtio-net device, and why it's
> being done transparent to management.
> =

> > =

> > Unless I'm mis-reading the patches, it looks like the VFIO device alway=
s has
> > to be available at the time QEMU is started. There's no way to boot a g=
uest
> > and then later hotplug a VFIO device to accelerate the existing virtio-=
net NIC.
> > Or similarly after migration there might not be any VFIO device availab=
le
> > initially when QEMU is started to accept the incoming migration. So it =
might
> > need to run in degraded mode for an extended period of time until one b=
ecomes
> > available for hotplugging. The use of qdev IDs makes this troublesome, =
as the
> > qdev ID of the future VFIO device would need to be decided upfront befo=
re it
> > even exists.
> =

> > =

> > So overall I'm not really a fan of the dynamic hiding/unhiding of devic=
es. I
> > would much prefer to see some way to expose an explicit relationship be=
tween
> > the devices to the guest.
> =

> If we place the burden of determining whether the guest supports STANDBY
> on the part of users/management, a lot of this complexity goes away. For
> instance, one possible implementation is to simply fail migration and say
> "sorry your VFIO device is still there" if the VFIO device is still around
> at the start of migration (whether due to unplug failure or a
> user/management forgetting to do it manually beforehand).
> =

> So how important is it that setting F_STANDBY cap doesn't break older
> guests? If the idea is to support live migration with VFs then aren't
> we still dead in the water if the guest boots okay but doesn't have
> the requisite functionality to be migrated later? Shouldn't that all

Well, I guess that's not really the scenario with this approach. Instead
they'd run with degraded network performance but could still at least be
migrated.
