Received: from eggs.gnu.org ([2001:4830:134:3::10]:53974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0FE-0007Kl-Aa
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0F9-0008Ss-9q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:30:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cW0F9-0008Sg-33
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:30:35 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so34234132wmi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:30:34 -0800 (PST)
Date: Tue, 24 Jan 2017 12:30:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124123031.GC17221@stefanha-x1.localdomain>
References: <20170120170757.30308-1-pbonzini@redhat.com>
	<20170120170757.30308-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <20170120170757.30308-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] virtio: use address_space_map/unmap to
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 06:07:53PM +0100, Paolo Bonzini wrote:
> @@ -455,10 +455,18 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsig=
ned int *in_bytes,
>              goto err;
>          }
> =20
> -        desc_pa =3D vq->vring.desc;
> -        vring_desc_read(vdev, &desc, desc_pa, i);
> +        len =3D max * sizeof(VRingDesc);
> +        desc_ptr =3D address_space_map(vdev->dma_as, vq->vring.desc, &le=
n, false);
> +        if (len < max * sizeof(VRingDesc)) {
> +            virtio_error(vdev, "Cannot map descriptor ring");
> +            goto err;
> +        }
> +
> +        vring_desc_read(vdev, &desc, desc_ptr, i);
> =20
>          if (desc.flags & VRING_DESC_F_INDIRECT) {
> +            address_space_unmap(vdev->dma_as, desc_ptr, len, false, 0);

Missing "dest_ptr =3D NULL" to prevent double unmap if the next goto err
is taken.

> @@ -689,18 +706,33 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>      }
> =20
>      i =3D head;
> -    vring_desc_read(vdev, &desc, desc_pa, i);
> +
> +    len =3D max * sizeof(VRingDesc);
> +    desc_ptr =3D address_space_map(vdev->dma_as, vq->vring.desc, &len, f=
alse);
> +    if (len < max * sizeof(VRingDesc)) {
> +        virtio_error(vdev, "Cannot map descriptor ring");
> +        return NULL;

desc_ptr still needs to be unmapped if non-NULL.  The same applies
below in virtqueue_pop().

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYh0jnAAoJEJykq7OBq3PIc+4IAL5OQ91QAdzlG8qL22m1LyJ0
aZ9WrF+Bvv7f8Dt9388I+9pYxpe6rocquZsUFyl2BlphteMyxjRLQ77LzR+sjcix
5biIQ+IJ558lw6xRsepVI9CWkh1mRnf3X8aWzLQdh/3vdP6WmnCimGAaplEC8Sem
psHLw4hLcxTPP0kh6VSDploZxGc0pyQJOW2jvMObuQ2agzuXA/SNTMeNrheF8QJZ
H8FiZUzkYJMvGyOvC9tvOsqYJDrxsRoOLuJOBNhu860n853eHTaCvEwwxwg5s0lC
EG/IJau6/RbzVsNwhCK7gCesl2ww1Bllzgu/WLa/OGeFALGfJeYE3olMGJFOnWE=
=GQt4
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
