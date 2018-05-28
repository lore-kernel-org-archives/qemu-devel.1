Received: from eggs.gnu.org ([2001:4830:134:3::10]:45174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNKg6-0002NJ-Pw
	for qemu-devel@nongnu.org; Mon, 28 May 2018 12:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNKg5-0004G0-Pj
	for qemu-devel@nongnu.org; Mon, 28 May 2018 12:07:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180528152225.7108-1-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <45bcd928-b328-0a0b-a0a2-6b4c4f0b560e@amsat.org>
Date: Mon, 28 May 2018 13:07:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180528152225.7108-1-joel@jms.id.au>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="QTuJrhHzBXk2Y45fV4J8jFMTiSVIDzHYo"
Subject: Re: [Qemu-devel] [PATCH v2] aspeed_scu: Implement RNG register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QTuJrhHzBXk2Y45fV4J8jFMTiSVIDzHYo
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
Message-ID: <45bcd928-b328-0a0b-a0a2-6b4c4f0b560e@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2] aspeed_scu: Implement RNG register
References: <20180528152225.7108-1-joel@jms.id.au>
In-Reply-To: <20180528152225.7108-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On 05/28/2018 12:22 PM, Joel Stanley wrote:
> The ASPEED SoCs contain a single register that returns random data when=

> read. This models that register so that guests can use it.
>=20
> The random number data register has a corresponding control register,
> data returns a different number regardless of the state of the enabled
> bit, so the model follows this behaviour.

I have been bugging C=C3=A9dric to check specs for the RNG_CTRL register =
and
he sent me the v1 of this patch than I missed:

    >>> may be we could test bit 1 of RNG_CTRL to check if it is enabled
or not.
    >>
    >> The RNG is enabled by default, and I didn't find any software that=

    >> disables it, but it can't hurt to have that check.
    >
    > I did some testing on hardware, and the rng still outputs a differe=
nt
    > number each time I ask for one regardless of the state of the enabl=
ed
    > bit.
    >
    I confirm that the HW doesn't really care about the enabled bit.
    Let's ignore it then ?

Now your comment makes more sens, however I think it would be more
useful to add it in aspeed_scu_read() to make it obvious.

>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  - Remove call to qcrypto_random_init as this is done in main()
> ---
>  hw/misc/aspeed_scu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 5e6d5744eeca..29e58527793b 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -16,6 +16,7 @@
>  #include "qapi/visitor.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> +#include "crypto/random.h"
>  #include "trace.h"
> =20
>  #define TO_REG(offset) ((offset) >> 2)
> @@ -154,6 +155,18 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU=
_NR_REGS] =3D {
>       [BMC_DEV_ID]      =3D 0x00002402U
>  };
> =20
> +static uint32_t aspeed_scu_get_random(void)
> +{
> +    Error *err =3D NULL;
> +    uint32_t num;
> +
> +    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
> +        error_report_err(err);
> +    }
> +
> +    return num;
> +}

This function duplicates bcm2835_rng::get_random_bytes() except it
doesn't exit(), is that on purpose?

What about refactoring, inlining bcm2835_rng::get_random_bytes() in a
new include/hw/misc/rng.h?

(This can be later patch)

> +
>  static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned =
size)
>  {
>      AspeedSCUState *s =3D ASPEED_SCU(opaque);
> @@ -167,6 +180,9 @@ static uint64_t aspeed_scu_read(void *opaque, hwadd=
r offset, unsigned size)
>      }
> =20
>      switch (reg) {

       case RNG_CTRL:
           /* The RNG_DATA returns a different number regardless of
            * the state of the enabled bit in RNG_CTRL,
            * so the model follows this behaviour.
            */
           break;

With a comment:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +    case RNG_DATA:
> +        s->regs[RNG_DATA] =3D aspeed_scu_get_random();
> +        break;
>      case WAKEUP_EN:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Read of write-only offset 0x%" HWADDR_PRIx =
"\n",
>=20


--QTuJrhHzBXk2Y45fV4J8jFMTiSVIDzHYo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsMKSkACgkQ4+MsLN6t
wN7SOg/7Bn5OZMy1MUYoJUXVoa00ki4k/I/S57/4FqosqBXQ9650KqIrUCzqJdlG
F5CAgaGS/zLlNf+6jO/kv24NSn9p99LN0+4kR+C6sDHLtBiND28wbOGgRonsnkJC
HYng9ussjBp6Y5Kid2Y6/0tScHWI4Bg0wc7JBC5s0/WHvYRZZAjeGCW1XquoSB2L
wl/t4ghSG05lduv0oCG9HGevOEXMmFaCxLNhw4KUdJWt3lwSEfUmr9dNV0JUG/V7
/e+ZgraHipQaxJeM79E/eAWfiB5TPTyxHyBFrkas3BHqhtwoxWcIJBSPOIfM/uiH
TdrAGcoKi8vMJ49Eb/OIynN02NfMct++HImbmXKYkZFl1OLGU1afyqgCLOHIPdgh
DAC7AnDLlgpXUPLVlowPy1dq/htBub4wcHT4bp4zcD32/SSWpc4DddulUUC2Qs9d
r0NXXL7MvTBpbvbk8LkPCzSNvAK/GSekU3W9mr934PpQ7DmKsL7nO5WS+ZMM1qLZ
77z3mwakkALXT9cuYngTe9m76/HCuRgKRvrt7eeB1ljVz7igMV8vmk/hk/cdaCIK
ifRtYrA8cXNBb3KhLlCu9wTx3PiL9HdfvMyA0IgZPB/2JA357AMCZU40kfrILepG
lc9r8m0xfYnXSEibNINqnXioxlMw5n6uGkj1EBgXWYFMiggsCSc=
=CGxm
-----END PGP SIGNATURE-----

--QTuJrhHzBXk2Y45fV4J8jFMTiSVIDzHYo--
