Received: from eggs.gnu.org ([2001:4830:134:3::10]:42208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUqTn-0007an-I2
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUqTi-0001gQ-JV
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:01:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gUqTi-0001g8-7k
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:01:54 -0500
Date: Thu, 6 Dec 2018 10:01:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206100146.GE29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
	<154404147264.6063.14869520867110106084@sif>
	<20181205154201-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205154201-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Dec 05, 2018 at 03:57:14PM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 05, 2018 at 02:24:32PM -0600, Michael Roth wrote:
> > Quoting Daniel P. Berrang=C3=A9 (2018-12-05 11:18:18)
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
>=20
> It's a bit different. What happens is that migration just doesn't
> finish. Same as it sometimes doesn't when guest dirties too much memory=
.
> Upper layers usually handle that in a way similar to what you describe.
> If it's desirable that the reason for migration not finishing is
> reported to user, we can add that information for sure. Though most
> users likely won't care.

Users absolutely *do* care why migration is not finishing. A migration th=
at
does not finish is a major problem for mgmt apps in many case of the use
cases for migration. Especially important when evacuating VMs from a host
in order to do a software upgrade or replace faulty hardware. As mentione=
d
previously, they will also often serialize migrations to prevent eh netwo=
rk
being overutilized, so a migration that runs indefinitely will stall
evacuation of additional VMs too.  Predictable execution of migration and
clear error reporting/handling are critical features. IMHO this is the ke=
y
reason VFIO unplug/plug needs to be done explicitly by the mgmt app, so i=
t
can be in control over when each part of the process takes place.

> > So how important is it that setting F_STANDBY cap doesn't break older
> > guests? If the idea is to support live migration with VFs then aren't
> > we still dead in the water if the guest boots okay but doesn't have
> > the requisite functionality to be migrated later?
>=20
> No because such legacy guest will never see the PT device at all.  So i=
t
> can migrate.

PCI devices are a precious finite resource. If a guest is not going to us=
e
it, we must never add the VFIO device to QEMU in the first place. Adding =
a
PCI device that is never activated wastes precious resources, preventing
other guests that need PCI devices from being launched on the host.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
