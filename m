Received: from eggs.gnu.org ([2001:4830:134:3::10]:59734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGT7Q-0002gH-C7
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGT7K-0007gU-Ng
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGT7K-0007fi-HV
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:06:18 -0500
Date: Mon, 12 Dec 2016 16:06:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212160615.GK4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x1F0m3RQhDZyj8sd"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/11] virtio: use VRingMemoryRegionCaches
 for descriptor ring
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


--x1F0m3RQhDZyj8sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 12:18:56PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/virtio.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4f355b4..702da0b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -484,18 +484,16 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsig=
ned int *in_bytes,
>      unsigned int max, idx;
>      unsigned int total_bufs, in_total, out_total;
>      MemoryRegionCache *desc_cache =3D NULL;
> -    MemoryRegionCache vring_desc_cache;
>      MemoryRegionCache indirect_desc_cache;
> +    VRingMemoryRegionCaches *caches;
>      int64_t len =3D 0;
>      int rc;
> =20
>      rcu_read_lock();
>      idx =3D vq->last_avail_idx;
>      max =3D vq->vring.num;
> -    len =3D address_space_cache_init(&vring_desc_cache, &address_space_m=
emory,
> -                                   vq->vring.desc, max * sizeof(VRingDes=
c),
> -                                   false);
> -    if (len < max * sizeof(VRingDesc)) {
> +    caches =3D atomic_rcu_read(&vq->vring.caches);

Now the rcu_read_lock() above makes sense :).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x1F0m3RQhDZyj8sd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTsr3AAoJEJykq7OBq3PIhywH/0R0AMcjFMvgVE0MhhnCeCkY
0FPo8/RfG0HYOrxNUR/+IdcQbV3jm1JWTH+FbmF7IUsfr52jbs/7dbOjEsDk6jBU
Dtx6YqyWzdlkeZXjaNZaV9nWkVXXJwqcWee4NaYSHilZmNb5W2SIEBdCNnWhScNM
co9OT4hIUL9xS3MCqvjoW3rwgpmkLFBUHDho/ip/EGcNDGRugdFuPqTvTCwK4g+l
2DaTeSP0zsDvG79fXn1E3GA4uKjNJAVdnrBH+q2ZZT4A0gU3l+ZYH2iCGTPMLpy+
oHMWOsb727ueu39ZwJN+ynjuZ03lSOUScjSgAKSWidIJPF9nhc1SVMmD1VzrH5s=
=Qai9
-----END PGP SIGNATURE-----

--x1F0m3RQhDZyj8sd--
