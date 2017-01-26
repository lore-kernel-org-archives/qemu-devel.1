Received: from eggs.gnu.org ([2001:4830:134:3::10]:43148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWnoD-0007Is-61
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWno8-0000SM-83
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:26:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWno8-0000SI-23
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:26:00 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 066977FE92
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 17:26:00 +0000 (UTC)
Date: Thu, 26 Jan 2017 17:25:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170126172555.GC27101@stefanha-x1.localdomain>
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<20170124180420.12430-4-pbonzini@redhat.com>
	<20170125132252.GD10664@stefanha-x1.localdomain>
	<8f336403-087e-7d54-342d-67d7e7ed0f67@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <8f336403-087e-7d54-342d-67d7e7ed0f67@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] virtio: use address_space_map/unmap to
 access descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 03:04:43PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 25/01/2017 14:22, Stefan Hajnoczi wrote:
> > On Tue, Jan 24, 2017 at 07:04:15PM +0100, Paolo Bonzini wrote:
> >> @@ -689,18 +714,34 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
> >>      }
> >> =20
> >>      i =3D head;
> >> -    vring_desc_read(vdev, &desc, desc_pa, i);
> >> +
> >> +    len =3D max * sizeof(VRingDesc);
> >> +    vring_desc_ptr =3D address_space_map(vdev->dma_as, vq->vring.desc=
, &len, false);
> >> +    if (len < max * sizeof(VRingDesc)) {
> >> +        virtio_error(vdev, "Cannot map descriptor ring");
> >> +        return NULL;
> >=20
> > Missing address_space_unmap() if vring_desc_ptr is non-NULL.
> >=20
>=20
> Will send v3 with just

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYijEjAAoJEJykq7OBq3PIL14IAJbQjbDkqgfwwavl/i2/G+zP
c0b+RZOE+22RuBH+8NxACRR9yul+8xdQeCb0ni8YJ/Yix8VsJcr7WykzNzlWDW/3
vz50iZB3G8MeoJv9tPzcSRNpiTcplGbM7jGq+6mRtH42pNnX4e53XfZNW0Kkt0E+
jsd5ufI1A0IQQGvyeVP3r9RoSB/m7yxVAqkI0oC/HslvYftA+pHYJ3qGUCDLnKiT
1+L5XV6OUfjDBieHyqH9Qd4nWDSLoZoP2xxbnTBnDrhWlVRV8GXD6ivNfOP9HK0V
aBttWqnepb/ATtoyleSlJEKrMeiBZJpCYmCezjG4/lY9iDsLIYEQdK5LuFQPeeE=
=kaG4
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
