Received: from eggs.gnu.org ([2001:4830:134:3::10]:53792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimpc-00026c-Tj
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimpY-0005AD-0K
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:53:36 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimpX-00059R-Qv
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:53:31 -0500
Received: by mail-qt0-x244.google.com with SMTP id x27so41137365qtm.12
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:53:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
	<20180203103727.26457-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ede27bd5-033e-ef2d-d8e6-bf6956a2bd80@amsat.org>
Date: Mon, 5 Feb 2018 16:53:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180203103727.26457-3-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="sNNx1rBH5F5kmeiJmwrdjglIVeeKgiI1n"
Subject: Re: [Qemu-devel] [PATCH 02/10] cuda: don't allow writes to port
 output pins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, lvivier@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sNNx1rBH5F5kmeiJmwrdjglIVeeKgiI1n
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 lvivier@redhat.com
Message-ID: <ede27bd5-033e-ef2d-d8e6-bf6956a2bd80@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 02/10] cuda: don't allow writes to port
 output pins
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
 <20180203103727.26457-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2018 07:37 AM, Mark Cave-Ayland wrote:
> Use the direction registers as a mask to ensure that only input pins ar=
e
> updated upon write.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/cuda.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 23b7e0f5b0..7214e7adcb 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -359,11 +359,11 @@ static void cuda_write(void *opaque, hwaddr addr,=
 uint64_t val, unsigned size)
> =20
>      switch(addr) {
>      case CUDA_REG_B:
> -        s->b =3D val;
> +        s->b =3D (s->b & ~s->dirb) | (val & s->dirb);

I personally find it easier to read in 2 lines (&=3D~, |=3D)

It might be useful to log invalid guest values:

           if (val & ~s->dirb) {
               GUEST_ERROR();
               val &=3D s->dirb;
           }
           s->b |=3D val;

>          cuda_update(s);
>          break;
>      case CUDA_REG_A:
> -        s->a =3D val;
> +        s->a =3D (s->a & ~s->dira) | (val & s->dira);

Ditto.

Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>          break;
>      case CUDA_REG_DIRB:
>          s->dirb =3D val;
>=20


--sNNx1rBH5F5kmeiJmwrdjglIVeeKgiI1n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4tjUACgkQ4+MsLN6t
wN5BIQ//WnjmEM1rdDy/+J2D3ivzjbNSEMJdSyQiPek7W+evRDtWXqR/fuLbC2iW
xvY/dUxkT+wnvG33mK1b1SmCQFJidbeoYTr8jf/0A84IPpxLQLGxxZbV3lB3d0oA
3eh33YrdpoCPYWAJPpmaFFO9P41u0Q/YsRt7OIYA7c59qfjCALmCbc98wvxh9IBZ
+ppdzXDBhm9tbJWYKGKEL/4Fnac7X9W5mgMquSUstyqKpQyHhHPseh8u2qQhzI6+
5UpN6X28Gx85sdPIpBU313fy+NKrFxonU2PjEMQ7FbeYKDM5dPI+Acq3bQPS0yl8
oLDuc7YTLhWcz8zYyg9NVlaJOe9QbPRhnKuZ5OF+OjaUTMQfLLnd/eYKiKJ4eiMn
CP/IPbiVqOk6gfssA65ajgUhKnyzl/cQagHZxBulPR173iEomcdBAZLJiFroKCIP
a8cZbKB9tEno269AHHeK6OSZt4r0aF9JZXipqbXZ4qV3ff9iS/x+FNjltxm5IzXn
95ticMu5CjXi1tQmJq0xwKRPCjGEs1i+0mESeTMv59UsoOntkJ+7pKdj1hp+cAHi
+Rmy6tn9IDxFe5Gt/ulmogVrgln4oMCj7kBBlo2vPuxt5MrroBBMXrO53dC3Cowu
lKo1ppImKHhUvx7jbwV/oQD006BiiF7kQ5eIE3rZlCGpwWs6fFA=
=pROd
-----END PGP SIGNATURE-----

--sNNx1rBH5F5kmeiJmwrdjglIVeeKgiI1n--
