Received: from eggs.gnu.org ([2001:4830:134:3::10]:43592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX342-0004jg-4j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 05:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX33z-0004Oy-1c
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 05:47:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eX33y-0004OW-NS
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 05:47:54 -0500
Date: Thu, 4 Jan 2018 10:47:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180104104744.GC10106@stefanha-x1.localdomain>
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<1512291492.2209478.1513854089861.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <1512291492.2209478.1513854089861.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mukawa@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n nikolaev <n.nikolaev@virtualopensystems.com>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 06:01:29AM -0500, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
> > Hi,
> > Vhost-user implementations assume the slave is already running before
> > the master starts.  The slave is required during virtio device
> > initialization (e.g. feature bit negotiation) and so it is simplest to
> > assume that the master is already available and will respond immediately
> > to the VHOST_USER_GET_FEATURES message.
> >=20
> > I have thought about how to let master and slave start in any order.
> > Some approaches involve changes to the VIRTIO specification so that
> > guest drivers can wait until the vhost-user connection is established.
> >=20
> > We can avoid spec changes using PCI hotplug:
> >=20
> > 1. Introduce a new vhost-user object that manages a connection:
> >=20
> >    -chardev ...
> >    -object vhost-user,id=3Dvhost-user0,chardev=3Dchr0
> >=20
> >    Note this object is *not* a NetClient.  It's a resource for managing
> >    a vhost-user connection and can be used with any device type (net,
> >    scsi, blk, etc).
> >=20
> >    This object tries to establish a connection.  When a connection is
> >    established it sends vhost-user protocol messages to fetch
> >    information needed for virtio device initialization (like the number
> >    of virtqueues supported, features bits, etc).  This information is
> >    stashed so that vhost_*() calls later on do not require synchronous
> >    communication with the vhost-user slave.
>=20
> This share similarities with vhost-user-backend I proposed here: https://=
lists.gnu.org/archive/html/qemu-devel/2016-06/msg01014.html
>=20
> (instead of spawning a slave, talk to a chardev - both could eventually c=
o-exist)

Yes, it's similar.  Thanks for the link!

> >=20
> > 2. When the vhost-user connection is established the object emits a QMP
> >    event so management software can hotplug the virtio device:
> >=20
> >    VHOST_USER_CONNECTED source=3Dvhost-user0
> >=20
> > 3. The management software hotplugs the virtio device:
> >=20
> >    (qmp) netdev_add vhost-user,id=3Dnetdev0,vhost-user=3Dvhost-user0
> >    (qmp) device_add virtio-net-pci,netdev=3Dnetdev0
> >=20
> > Advantages of this approach:
> >=20
> >  * Does not require spec changes.
> >  * Can be implemented without vhost-user.c qemu_chr_fe_read/write_all()
> >    calls that hang QEMU until the slave sends data.
> >  * Allows slave to set the number of queues, feature bits, etc via the
> >    vhost-user socket.  It is not necessary to manually specify feature
> >    bitmasks and other slave-specific information on the QEMU
> >    command-line.
> >=20
> > I haven't thought through disconnection but I imagine the vhost-user
> > object would emit a VHOST_USER_DISCONNECTED event so the management
> > software can hot unplug the device.
> >=20
> > Thoughts?
>=20
> I am sorry, I can't think through all the potential issues easily. But th=
at sounds interesting enough to start a proof-of-concept.
>=20
> And we need more tests for vhost-user (including fixing the existing test=
s!)...

I'm not going to prototype this yet, I'm working on virtio-vhost-user
first, but eventually I might get back to -object vhost-user(-backend).

Stefan

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaTgZQAAoJEJykq7OBq3PIZyUH/R88JLA53rBpzLfHnvLGxJu5
o8T9dstw7p2sJFyjWBZthnbLfkFxfgHskl1CAO3AP27aO5GWxP+9HCQPIYYAliCf
E9p03BzrD3S8morpkHb+s4aq05WGj67doM4T25wyMNgJsTaDjtnBpL+bN/Kt7GZT
EHVqN1g3rHX4OTX1N8O2Te+9gNoFr6k7H/KlmUwHolTTy/l7fLOhyfYTNOZ5XP3+
1S4jkQw0ApTZHOCt63M+93Erpfc+D1gvbiVmrbg5xMM8LidBG3NLUFYsJhylLOXT
LJF6NFE4Hq987/U8V9r1g1r4T+LLW5gvl6y7JGqyrh/kk43Eq+WuIE8YcSfUYz0=
=X85V
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
