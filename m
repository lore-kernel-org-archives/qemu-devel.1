Received: from eggs.gnu.org ([2001:4830:134:3::10]:40356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY7a9-0005Mk-7u
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY7a6-0003Rp-4k
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:21:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fY7a5-0003RW-UV
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:21:46 -0400
Date: Wed, 27 Jun 2018 11:21:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627102142.GB5955@stefanha-x1.localdomain>
References: <20180627082248.14921-1-pagupta@redhat.com>
	<20180627082248.14921-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20180627082248.14921-3-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: Set status early in
 VirtIODevice parent object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org, slopezpa@redhat.com


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 01:52:48PM +0530, Pankaj Gupta wrote:
>  To process pending requests for driver status 'VIRTIO_CONFIG_S_DRIVER_OK=
',
>  virtio-rng 'set_status' calls 'is_guest_ready' function. This checks if=
=20
>  virtqueue is ready and status is set to 'VIRTIO_CONFIG_S_DRIVER_OK'.=20
>=20
>  This call is made before new status is updated in VirtIODevice parent ob=
ject=20
>  and calling function uses old status value.
>=20
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  hw/virtio/virtio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d4e4d98b59..37dc59a686 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1154,10 +1154,11 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t=
 val)
>              }
>          }
>      }
> +    vdev->status =3D val;
> +
>      if (k->set_status) {
>          k->set_status(vdev, val);
>      }
> -    vdev->status =3D val;

This breaks existing ->set_status() callbacks that rely on vdev->status
containing the old value.  Have you audited them?

For example, virtio_net_set_status -> virtio_net_vnet_endian_status uses
vdev->status!

It may be easier to modify virtio-rng.c so that the old status value
isn't used.

Stefan

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM2U2AAoJEJykq7OBq3PIOb4IAMHuSDMVK883dE9kAz20hq0x
VelGOBzyuX8VPEUB82qDp8gelNbOOBUmN90O4qx+ziXLB/axRubHwzKLlGDBeNcA
RnF3Oh32B7A2aQh0jpGY6zzRPyb7DjbMD3ngAtLz7vDnyiQcF9s/UdMrLgqW0NsP
6whH8rL5SVDTO3JP3ZPJdRYRmbC7aJxPbzspKyLEyxmT1bi2kHy5EGmy2yhWpzbi
qz/02kFCd1t0s2voIDznk6AjEPcgp5z8Ij2jKjE1PQjW3lSSCq51YPsF/zJyFiqg
MyF9eyQrX8ajWKrWmEX6VH8XGTZn66I8ZTyuiwGfoAOe0uf6/eCPFb2u+kqs3YE=
=zViY
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
