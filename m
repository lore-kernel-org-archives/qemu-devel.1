Received: from eggs.gnu.org ([208.118.235.92]:44234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRgjt-0001cY-SC
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRgjp-0003gj-55
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:57:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRgjo-0003fU-P2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:56:56 -0500
Date: Wed, 20 Dec 2017 15:56:45 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171220155645.GB12566@stefanha-x1.localdomain>
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<20171220064548.GB3735@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20171220064548.GB3735@lemon>
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n.nikolaev@virtualopensystems.com, Wei Wang <wei.w.wang@intel.com>, mukawa@igel.co.jp, marcandre.lureau@redhat.com


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 02:45:48PM +0800, Fam Zheng wrote:
> On Tue, 12/19 16:21, Stefan Hajnoczi wrote:
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
>=20
> Why cannot the management software start the slave then hot plug chardev +
> netdev + virtio-net-pci? That way we don't need the vhost-user connected =
event.

There's an advantage to keeping the vhost-user object in QEMU:

In Step 1 the vhost-user object pre-initializes the vhost-user slave to
avoid synchronous vhost_*() calls during hotplug (e.g.
vhost_set_owner(), vhost_get_features()).  When vhost_dev_init() and
other code gets called it won't be necessary to block anymore.  This
makes the vhost-user master robust against slaves that respond slowly or
are malicious.

It's messy to do pre-init outside QEMU and then pass the necessary state
in.

Stefan

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOog9AAoJEJykq7OBq3PIvcIIALrItS8uzTv3wc//b/jkR+Rv
fHzR+tYpBmla0ZqYVn+5yY61z7H3gm0sTAlbkwT9SzQiq3/p4yXkx/mhv+cbxfO8
L9oNymT8gy3jNfbsE2GaToEEYPG3TlbzkaZze7jDZLwIjWK1URLDypeoKr7rBwgk
hyXQdAehNWq1wB9+m0+dWXrdcHLZBZOvG88knmguW1zSdpdli0il+vJooKgjn4hD
CORIN44qdrTBKrvjS/DaijqHe5VxdbMAd3NYx3zvKLTvj12oE5DluiylQe512sXF
QmpKnjzE7n7HgvBTS0S7OApwoSHMyC6BXc2ZxyWkZOUjI1yy6iweALRhwUYlroc=
=FiH3
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
