Received: from eggs.gnu.org ([2001:4830:134:3::10]:35554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePV5c-0003X2-Qr
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePV5a-0005FD-99
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePV5Z-0005EU-VP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:06:22 -0500
Date: Thu, 14 Dec 2017 15:06:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214150609.GQ14433@stefanha-x1.localdomain>
References: <CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<20171213165142-mutt-send-email-mst@kernel.org>
	<CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
	<20171213222102-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tk6xM/wkRlnXD2NA"
Content-Disposition: inline
In-Reply-To: <20171213222102-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>


--tk6xM/wkRlnXD2NA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 10:59:10PM +0200, Michael S. Tsirkin wrote:
> >  * VHOST_USER_SET_VRING_KICK
> >=20
> >    Set up vring kick doorbell (unless bit 8 is set) before sending
> >    VHOST_USER_SET_VRING_KICK to the guest.
>=20
> But guest can't use it, now can it?
>=20
> What guest needs is a mapping to interrupts.
=2E..
> >  * VHOST_USER_SET_VRING_CALL
> >=20
> >    Set up the vring call doorbell (unless bit 8 is set) before sending
> >    VHOST_USER_SET_VRING_CALL to the guest.
>=20
> Same here. what guest needs is mapping from io to notifications,
> right?

The PCI device should contain a BAR with doorbell registers.  I don't
think a fancy mapping is necessary, instead the device spec should
define the BAR layout.

When the guest vhost-user slave receives this message it knows it can
now begin using the doorbell register.

> ---
>=20
> > > I took a quick look and I doubt we can do something that is both
> > > compatible with the existing vhost-user and will make it possible to
> > > extend the protocol without qemu changes. Let's assume I pass a new
> > > message over the vhost-user channel.  How do we know it's safe to pass
> > > it to the guest?
> > >
> > > That's why we gate any protocol change on a feature bit and must parse
> > > all messages.
> >=20
> > QEMU must parse all messages and cannot pass through unknown messages.
> > Think of QEMU vhost-pci as both a vhost-user slave to the other VM and
> > a vhost-user master to the guest.
> >=20
> > QEMU changes are necessary when the vhost protocol is extended.
> > Device interface changes are only necessary if doorbells or shared
> > memory regions are added, any other protocol changes do not change the
> > device interface.
> >=20
> > Stefan
>=20
> I guess you have a different definition of a device interface than
> myself - I consider it an interface change if a feature bit changes :)

The feature bits are defined in the vhost-user protocol specification,
not in the vhost-pci PCI device specification.

For example, imagine we are adding the virtio-net MTU feature to the
protocol:

1. The VHOST_USER_PROTOCOL_F_MTU feature bit is added to the
   vhost-user protocol specification.

2. The VHOST_USER_NET_SET_MTU message is added to the vhost-user
   protocol specification.

As a result of this:

1. No PCI adapter resources (BARs, register layout, etc) change.  This
   is why I say the device interface is unchanged.  The vhost-pci
   specification does not change.

2. QEMU vhost-pci code needs to unmask VHOST_USER_PROTOCOL_F_MTU and
   pass through VHOST_USER_NET_SET_MTU.

Stefan

--tk6xM/wkRlnXD2NA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMpNhAAoJEJykq7OBq3PI/wwH/iBTkCWQiv35gmzHwr+SHQP5
VIM0g6LudC3rXpZ/hrNpo9rlLaCD7HgYTRlwZyfGr7J6afNdW8sKfkJd6rqKyDCr
QnFf1UqPu6GQZKZ9ux48m0tDG3Yo8kWxAUS5k+w7JLPWnQCsRdlD+vTWylZS4jbR
glxUd5+hOl1JdCAQFeyCs8fLtKHKKVwS7k0ioXo4q+EtCiZEmAe1hll5w2EkYMwC
TR9Zki6S5N7FUf/P+nKOOgQY3aQd+s3UGwKqZ76I1daUYxwkRPhcEBf3H7JhWpI2
SAqIRmyUrmtx/ZD9FIN+BVaID8BxhhLkXz5zRI+BdnXSjZ7SZLfqN9YjLbAOYsM=
=MqIi
-----END PGP SIGNATURE-----

--tk6xM/wkRlnXD2NA--
