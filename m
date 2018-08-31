Received: from eggs.gnu.org ([2001:4830:134:3::10]:58988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fvjed-000216-U5
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fvjea-0002p1-OW
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:40:03 -0400
Received: from mail-co1nam05on0702.outbound.protection.outlook.com
	([2a01:111:f400:fe50::702]:45792
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fvjea-0002oN-3M
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:40:00 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 31 Aug 2018 13:39:35 +0000
Message-ID: <BN7PR08MB48683D162B911B8944759A86C60F0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180830193019.20104-1-jancraig@amazon.com>,
	<20180830193019.20104-6-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-6-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 5/9] target/mips: Add MXU instruction
 S8LDD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Petar Jovanovic <pjovanovic@wavecomp.com>

Hi, Craig,

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Thursday, August 30, 2018 9:30 PM
>=20
> Subject: [PATCH v4 5/9] target/mips: Add MXU instruction S8LDD

> Adds support for emulating the S8LDD MXU instruction.

> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  v1
>     - initial patch
>  v2
>     - changed bitfield usage to extract32
>     - used deposit_tl instructions instead of shift and bitmask
>  v3
>     - Split gen_mxu function into command specific gen_mxu_<ins> function=
s
>  v4
>     -Add and use MXU_OPTN3_PTN #defines
>     -Add check for MXUEN

>  target/mips/translate.c | 98 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)

> diff --git a/target/mips/translate.c b/target/mips/translate.c

> +    TCGv t0, t1;
> +    TCGLabel *l0;
> +    uint32_t xra, s8, optn3, rb;
> +
> +    t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new();
> +
> +    l0 =3D gen_new_label();
> +
> +    xra =3D extract32(ctx->opcode, 6, 4);
> +    s8 =3D extract32(ctx->opcode, 10, 8);
> +    optn3 =3D extract32(ctx->opcode, 18, 3);
> +    rb =3D extract32(ctx->opcode, 21, 5);
> +
> +    gen_load_mxu_cr(t0);
> +    tcg_gen_andi_tl(t0, t0, MXUEN);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXUEN, l0);
> +
> +    gen_load_gpr(t0, rb);
> +    tcg_gen_addi_tl(t0, t0, (int8_t)s8);

I am not sure if this works as desired, with respect to branching. In order=
 to survive branching, tcg variables must be initialized with tcg_temp_loca=
l_new(), rather than with tcg_tem_new(). Please retest, and amend if needed=
.

Thanks,
Aleksandar=
