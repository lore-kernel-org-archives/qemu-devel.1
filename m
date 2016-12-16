Received: from eggs.gnu.org ([2001:4830:134:3::10]:58987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHphn-0005oE-1t
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHphj-0002Fi-Ot
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:25:34 -0500
Date: Fri, 16 Dec 2016 10:25:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161216102528.GB4129@stefanha-x1.localdomain>
References: <20161215154330.700-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20161215154330.700-1-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 04:43:30PM +0100, Halil Pasic wrote:
> Correct recalculation of vring->inuse after migration for
> the corner case where the avail_idx has already wrapped
> but used_idx not yet.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Fixes: bccdef6b ("virtio: recalculate vq->inuse after migration")
> CC: qemu-stable@nongnu.org
> ---
>=20
> I think we could also change the type of inuse to uint16_t.
> Would this be considered a good idea?

VRing.num is unsigned int.  I would use the same type as num since this
is a size, not an index.

> ---
>  hw/virtio/virtio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 1af2de2..089c6f6 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1855,9 +1855,12 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, i=
nt version_id)
>              /*
>               * Some devices migrate VirtQueueElements that have been pop=
ped
>               * from the avail ring but not yet returned to the used ring.
> +             * Cast to uint16_t is OK because max ring size is 0x8000. T=
hus
> +             * no the size of largest array indexable by an integral type
> +             * can not be represented by the same type problem.

I think it would be safe up to max ring size UINT16_MAX - 1 (we need
that extra value to distinguish between empty and full avail rings)?

The last sentence is hard to understand due to the double negative.  I
think you are saying "Since max ring size < UINT16_MAX it's safe to use
uint16_t to represent the size of the ring".

>               */
> -            vdev->vq[i].inuse =3D vdev->vq[i].last_avail_idx -
> -                                vdev->vq[i].used_idx;
> +            vdev->vq[i].inuse =3D (uint16_t)(vdev->vq[i].last_avail_idx -
> +                                vdev->vq[i].used_idx);
>              if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {
>                  error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "
>                               "used_idx 0x%x",
> --=20
> 2.8.4
>=20
>=20

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYU8EYAAoJEJykq7OBq3PIqbEH+weLtd244y38tZUmxLz8g+rI
JjNNHmhF822BjvNzRhsZESIgWzBHqlPYPJabHQeu09/zNZAexq1EjkSG3SQj92Xw
myaSm5JwqMYQ7LGxyKtoHdQNnVTFuS+ADcbgMnnJnJU0bVu9+mVCROK9Sp9I+k/q
3C0oO0LUH1bMyyB37ViLH7xjn9bJYRoBHS+gWLrX3OzYsbPzNuBuPDnSK1/IZ27j
lR2vGqfAFcZgGTmFCggbnqBKDZW+f0DeOZJzWTYc7v9dCpL4F/WlJdcWeo38Pila
jCO7Vrw2spsUKGW6ZjGnBAhocO2iFS3d3vrnzJ27PAYVB6vZQODF7b6rhHpT9+o=
=iyay
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
