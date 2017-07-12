Received: from eggs.gnu.org ([2001:4830:134:3::10]:46431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVENI-0005zE-QJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVENF-0008V6-J4
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:56:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVENF-0008UO-CS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:56:01 -0400
Date: Wed, 12 Jul 2017 10:55:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712095556.GC6923@stefanha-x1.localdomain>
References: <20170712080538.28010-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20170712080538.28010-1-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: enhance virtio_error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, casasfernando@hotmail.com


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 10:05:38AM +0200, Ladi Prosek wrote:
> Output like "Virtqueue size exceeded" is not much useful in identifying t=
he
> culprit. This commit adds virtio device name and queue index to all error
> messages in virtio.c to improve debuggability.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio.c | 74 +++++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 46 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 464947f..5040f26 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -143,7 +143,7 @@ static void virtio_init_region_cache(VirtIODevice *vd=
ev, int n)
>      len =3D address_space_cache_init(&new->desc, vdev->dma_as,
>                                     addr, size, false);
>      if (len < size) {
> -        virtio_error(vdev, "Cannot map desc");
> +        virtio_error(vdev, "%s queue %u: Cannot map desc", vdev->name, n=
);

Good idea!

Please build the identifying information into virtio_error() to avoid
code duplication.

It probably makes sense to add a virtqueue_error(VirtIOQueue *vq, fmt,
=2E..) function.  That way the virtqueue number printing doesn't need to
be duplicated.

vdev->name specifies the device type ("virtio-net", "virtio-9p") but
does not uniquely identify the device instance.  If a guest has multiple
virtio-net devices then the error message will not identify the device
instance.  I think you can use DEVICE(vdev)->id instead to get the
unique -device virtio-net-pci,id=3Dvnet0 identifier.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZfIsAAoJEJykq7OBq3PI89sH/2tXa/YNNFHmABI9Pk7AOOBF
YCUHsPqW9ge2A9ZT6KpDP2pio0F2f7vP+wKgVbnAhTMANWhclPu/S9Ssr+YoXH0T
DF4xDKNMhwCTmtyRNcN3JvASxe3MBqlRRYTNi7E+gmGxdWlL4kV6H8jqE925LFvC
8MJfuKTmDQ7fenNlGePJvZoOtSnLIA00fcI+f+r0rX+f8taXhhNWDxeiZGA5o2GG
CURSWBrz3sEZjG5ypuzzXZpf/79ht2HjwqDoGzsTg8N1raA57Z4R4KhBqLLzTeyk
cloUYSWejyOlD4kmw1im+27YJu6aednXdSFBPCCDCg86QG9ERMcu0RwzFAS+PiY=
=EUSf
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
