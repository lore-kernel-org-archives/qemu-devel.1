Received: from eggs.gnu.org ([2001:4830:134:3::10]:53384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNXP-0003wb-41
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNXM-00072A-Gk
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:22:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNXM-00071u-B3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:22:56 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 895304AE81
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:22:56 +0000 (UTC)
Date: Wed, 25 Jan 2017 13:22:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125132252.GD10664@stefanha-x1.localdomain>
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<20170124180420.12430-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20170124180420.12430-4-pbonzini@redhat.com>
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


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 07:04:15PM +0100, Paolo Bonzini wrote:
> @@ -689,18 +714,34 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>      }
> =20
>      i =3D head;
> -    vring_desc_read(vdev, &desc, desc_pa, i);
> +
> +    len =3D max * sizeof(VRingDesc);
> +    vring_desc_ptr =3D address_space_map(vdev->dma_as, vq->vring.desc, &=
len, false);
> +    if (len < max * sizeof(VRingDesc)) {
> +        virtio_error(vdev, "Cannot map descriptor ring");
> +        return NULL;

Missing address_space_unmap() if vring_desc_ptr is non-NULL.

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKasAAoJEJykq7OBq3PIHW0IAKALozImMucX71wVCIFvEbAm
/UXczReyfbtlLLtdEbzD3tLLnFFMs83QW5J+4Lt3iAx0oBCH6HtWyPe1npzBsYnK
hZuxq9zT/Mz/zLN4nIv5W0fNCm9tP42r0dEsSSDVq1w6IZDn+Mjykcl+am0gpt74
nyBnAf6//UeL70Dg+Cyjw+OVKJ4QQfuXWe3wJWPC+HDMXDr2uh6E3UOVpPUytGhO
/xisz8eTLLZJuBjAo5yyzFwogds8c2rMW87g4G4ZRBcQEv6Gf7+IhIfqd3Ra2Xeq
yWL0xFFOYqtDd138Oie9tTuyK20j4loP8MisYbsCY8VgTOuP8wUsklkdb8u+Des=
=x5Nu
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
