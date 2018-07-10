Received: from eggs.gnu.org ([2001:4830:134:3::10]:49018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcwj0-0003NS-QI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcwix-0001Dg-IZ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:46:54 -0400
Received: from mail-sn1nam02on0096.outbound.protection.outlook.com
	([104.47.36.96]:17842
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcwix-0001D5-4t
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:46:51 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 17:46:46 +0000
Message-ID: <BN7PR08MB4868ACBA9971F25F947B8833C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-13-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/33] target/mips: Implement emulation
 of nanoMIPS ROTX instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 12/33] target/mips: Implement emulation of nanoMIPS RO=
TX instruction
>
> From: Matthew Fortune <matthew.fortune@mips.com>
>
> Added a helper for ROTX based on the pseudocode from the
> architecture spec. This instraction was not present in previous

instraction -> instruction

(this was my fault, since I wrote this commit message for v2)

> MIPS instruction sets.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/helper.h    |  2 ++
>  target/mips/op_helper.c | 94 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/mips/translate.c | 15 ++++++++
>  3 files changed, 111 insertions(+)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

... with a hint that, in future, an inline implementation should be conside=
red.

> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 5f49234..b2a780a 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -40,6 +40,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
>  #endif
>
> +DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
> +
>  #ifndef CONFIG_USER_ONLY
>  /* CP0 helpers */
>  DEF_HELPER_1(mfc0_mvpcontrol, tl, env)
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 0b2663b..b3eef9f 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -249,6 +249,100 @@ target_ulong helper_bitswap(target_ulong rt)
>      return (int32_t)bitswap(rt);
>  }
>
> +target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shift=
x,
> +                        uint32_t stripe)
> +{
> +    int i;
> +    uint64_t tmp0 =3D ((uint64_t)rs) << 32 | ((uint64_t)rs & 0xffffffff)=
;
> +    uint64_t tmp1 =3D tmp0;
> +    for (i =3D 0; i <=3D 46; i++) {
> +        int s;
> +        if (i & 0x8) {
> +            s =3D shift;
> +        } else {
> +            s =3D shiftx;
> +        }
> +
> +        if (stripe !=3D 0 && !(i & 0x4)) {
> +            s =3D ~s;
> +        }
> +        if (s & 0x10) {
> +            if (tmp0 & (1LL << (i + 16))) {
> +                tmp1 |=3D 1LL << i;
> +            } else {
> +                tmp1 &=3D ~(1LL << i);
> +            }
> +        }
> +    }
> +
> +    uint64_t tmp2 =3D tmp1;
> +    for (i =3D 0; i <=3D 38; i++) {
> +        int s;
> +        if (i & 0x4) {
> +            s =3D shift;
> +        } else {
> +            s =3D shiftx;
> +        }
> +
> +        if (s & 0x8) {
> +            if (tmp1 & (1LL << (i + 8))) {
> +                tmp2 |=3D 1LL << i;
> +            } else {
> +                tmp2 &=3D ~(1LL << i);
> +            }
> +        }
> +    }
> +
> +    uint64_t tmp3 =3D tmp2;
> +    for (i =3D 0; i <=3D 34; i++) {
> +        int s;
> +        if (i & 0x2) {
> +            s =3D shift;
> +        } else {
> +            s =3D shiftx;
> +        }
> +        if (s & 0x4) {
> +            if (tmp2 & (1LL << (i + 4))) {
> +                tmp3 |=3D 1LL << i;
> +            } else {
> +                tmp3 &=3D ~(1LL << i);
> +            }
> +        }
> +    }
> +
> +    uint64_t tmp4 =3D tmp3;
> +    for (i =3D 0; i <=3D 32; i++) {
> +        int s;
> +        if (i & 0x1) {
> +            s =3D shift;
> +        } else {
> +            s =3D shiftx;
> +        }
> +        if (s & 0x2) {
> +            if (tmp3 & (1LL << (i + 2))) {
> +                tmp4 |=3D 1LL << i;
> +            } else {
> +                tmp4 &=3D ~(1LL << i);
> +            }
> +        }
> +    }
> +
> +    uint64_t tmp5 =3D tmp4;
> +    for (i =3D 0; i <=3D 31; i++) {
> +        int s;
> +        s =3D shift;
> +        if (s & 0x1) {
> +            if (tmp4 & (1LL << (i + 1))) {
> +                tmp5 |=3D 1LL << i;
> +            } else {
> +                tmp5 &=3D ~(1LL << i);
> +            }
> +        }
> +    }
> +
> +    return (int64_t)(int32_t)(uint32_t)tmp5;
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>
>  static inline hwaddr do_translate_address(CPUMIPSState *env,
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 0a37f5a..944b40b 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -17437,6 +17437,21 @@ static int decode_nanomips_32_48_opc(CPUMIPSStat=
e *env, > DisasContext *ctx)
>          }
>              break;
>          case NM_P_ROTX:
> +            if (rt !=3D 0) {
> +                TCGv t0 =3D tcg_temp_new();
> +                TCGv_i32 shift =3D tcg_const_i32(extract32(ctx->opcode, =
0, 5));
> +                TCGv_i32 shiftx =3D tcg_const_i32(extract32(ctx->opcode,=
 7, 4)
> +                                                << 1);
> +                TCGv_i32 stripe =3D tcg_const_i32((ctx->opcode >> 6) & 1=
);
> +
> +                gen_load_gpr(t0, rs);
> +                gen_helper_rotx(cpu_gpr[rt], t0, shift, shiftx, stripe);
> +                tcg_temp_free(t0);
> +
> +                tcg_temp_free_i32(shift);
> +                tcg_temp_free_i32(shiftx);
> +                tcg_temp_free_i32(stripe);
> +            }
>              break;
>          case NM_P_INS:
>              switch (((ctx->opcode >> 10) & 2) | ((ctx->opcode >> 5) & 1)=
) {
> --
> 2.7.4
>
>
