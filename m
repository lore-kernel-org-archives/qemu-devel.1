Received: from eggs.gnu.org ([2001:4830:134:3::10]:36076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRQ9-0000uu-RM
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRQ4-0001aW-A3
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:17:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGRQ4-0001aP-3c
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:17:32 -0500
Date: Mon, 12 Dec 2016 14:17:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212141728.GI4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] virtio: use MemoryRegionCache to
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
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 12:18:54PM +0100, Paolo Bonzini wrote:
> @@ -430,41 +431,42 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsig=
ned int *in_bytes,
>                                 unsigned int *out_bytes,
>                                 unsigned max_in_bytes, unsigned max_out_b=
ytes)
>  {
> -    unsigned int idx;
> +    VirtIODevice *vdev =3D vq->vdev;
> +    unsigned int max, idx;
>      unsigned int total_bufs, in_total, out_total;
> -    void *desc_ptr =3D NULL;
> -    hwaddr len =3D 0;
> +    MemoryRegionCache *desc_cache =3D NULL;
> +    MemoryRegionCache vring_desc_cache;
> +    MemoryRegionCache indirect_desc_cache;
> +    int64_t len =3D 0;
>      int rc;
> =20
> +    rcu_read_lock();

Please document the purpose of the rcu_read_lock() in virtio code.

Also, do the goto err cases call rcu_read_unlock()?

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTrF4AAoJEJykq7OBq3PIJWQH/2E+wJcm/aJb+Td+sH8mWlzq
i05O3aEE3Xm0lGbtdd+jMYTECcAL8NxmBA177SCzY1Q+yD7VR6bpayhUa7BOuYhQ
9KYg8jvOKFqRuGGfZQIuNjgpHCAnGkgdPkDFHsKjHG/KQMLA7JjHXT2O4fwwyxRq
OAmbkUalUV/j/OIe7mEDyJCbWTnydIs1aGL5dYHg7J4ZjGZlo0+mpa8e8SHnBpOM
qd+EXcsGj87MnJ2Ou7xYgYLQktwr6TZkRSxLxgIwm7q7Q7DMQUrVYZjgL23yiaR5
PxtGz8tvLBpMaiUs6mDS3yx9OdGo5ihwHKKgwK0a/YhSp+R7pP+xkUtvyBHNMCQ=
=QGwd
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
