Received: from eggs.gnu.org ([2001:4830:134:3::10]:33543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNK3L-0005KJ-Ss
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNK3J-0005cz-9h
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:27:19 -0400
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:33709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNK3J-0005bL-3s
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:27:17 -0400
Received: from player787.ha.ovh.net (unknown [10.109.120.88])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6B894ACA74
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 17:27:15 +0200 (CEST)
References: <20180528152225.7108-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <52cd00d2-866d-fb11-fabd-d5de2b375f06@kaod.org>
Date: Mon, 28 May 2018 17:27:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180528152225.7108-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Andrew Jeffery <andrew@aj.id.au>

On 05/28/2018 05:22 PM, Joel Stanley wrote:
> The ASPEED SoCs contain a single register that returns random data when
> read. This models that register so that guests can use it.
>=20
> The random number data register has a corresponding control register,
> data returns a different number regardless of the state of the enabled
> bit, so the model follows this behaviour.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

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
> +    case RNG_DATA:
> +        s->regs[RNG_DATA] =3D aspeed_scu_get_random();
> +        break;
>      case WAKEUP_EN:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Read of write-only offset 0x%" HWADDR_PRIx =
"\n",
>=20
