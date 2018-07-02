Received: from eggs.gnu.org ([2001:4830:134:3::10]:53310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fa0iA-0007d9-Ds
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fa0i6-0006f6-Eq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:25:54 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fa0i6-0006eV-7G
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:25:50 -0400
Received: by mail-wm0-x241.google.com with SMTP id v16-v6so9495073wmv.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:25:50 -0700 (PDT)
Date: Mon, 2 Jul 2018 16:25:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702152542.GL2155@stefanha-x1.localdomain>
References: <20180702063725.8087-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Content-Disposition: inline
In-Reply-To: <20180702063725.8087-1-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] virtio-rng: process pending requests
 when driver is ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org, slopezpa@redhat.com, stefanha@redhat.com


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 12:07:25PM +0530, Pankaj Gupta wrote:
>  virtio-rng device causing old guest kernels(2.6.32) to hang on latest qe=
mu.
>  The driver attempts to read from the virtio-rng device too early in it's
>  initialization. Qemu detects guest is not ready and returns, resulting in
>  hang.
>=20
>  Fix is to handle pending request when guest is running and driver status=
 is
>  set to 'VIRTIO_CONFIG_S_DRIVER_OK'.
>=20
> Reported-by: Sergio lopez <slopezpa@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
> v3->v4: Added signed-off & reported-by tags again.
> v2->v3: Add comment to explain virtio-rng early status update (Stefan)
> v1->v2: Update new status value early only for virtio-rng (Stefan)
>=20
>  hw/virtio/virtio-rng.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index 289bbcac03..0b586bd750 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -156,6 +156,24 @@ static void check_rate_limit(void *opaque)
>      vrng->activate_timer =3D true;
>  }
> =20
> +static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
> +{
> +    VirtIORNG *vrng =3D VIRTIO_RNG(vdev);
> +
> +    if (!vdev->vm_running) {
> +        return;
> +    }
> +    /* Set device status in VirtIODevice object. Its used in 'is_guest_r=
eady'

s/Its/It's/

Can be fixed when merging.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOkP2AAoJEJykq7OBq3PIUQMH/2PXpOkXDKDr+Qbg7vKY+O14
YF5lIfgxFc8C1Px6nEh5n/TsTezUyCUkQQDMRx6JgixwExaL9BUB+k5iIUaQwIgC
WC/CUNZeanBjomRTk9ElEzYCGSy5dUMvttgJUFTT44u5Me3cP6QXsM9Z0wecXmJO
HqIVEJQ8IeIim3FmvpF0bW/3OxXyN8ujyGoYZ/NT6rt+9WEDAbFy2Gl7U9TFy088
3fUJ7k3//hGxibih6C6qxeJgeRxsUA20J7N/lR4HIEkBoDOe3p0cH5Gy3uXD51o+
+mS+B68mHS6oRQTlK/kom3UBToeiCv8ATrTaEEF7bBuqg42bEc7MQC77LPufAmE=
=WE6W
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--
