Received: from eggs.gnu.org ([2001:4830:134:3::10]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmkeP-0000Dt-VU
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmkeL-00086G-Er
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:54:41 -0400
Received: from mail-bl2nam02on0096.outbound.protection.outlook.com
	([104.47.38.96]:45824
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fmkeK-000836-Ve
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:54:37 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 6 Aug 2018 18:54:31 +0000
Message-ID: <BN7PR08MB486892F21D9ABF19237CFB19C6200@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-43-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-43-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 42/80] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 6, 2018 7:00 PM
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 4.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 378 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 378 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 8c33d14..9c8d1f4 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -17202,6 +17202,380 @@ static void gen_pool32axf_1_nanomips_insn(Disas=
Context *ctx, uint32_t opc,
>      tcg_temp_free(v0_t);
>  }
>=20


> +        case NM_MADDU:
> +            {
> +                int acc =3D extract32(ctx->opcode, 14, 2);
> +
> +                TCGv_i64 t2 =3D tcg_temp_new_i64();
> +                TCGv_i64 t3 =3D tcg_temp_new_i64();
> +
> +                gen_load_gpr(t0, rs);
> +                gen_load_gpr(t1, rt);
> +
> +                check_dsp(ctx);
> +                tcg_gen_ext32u_tl(t0, t0);
> +                tcg_gen_ext32u_tl(t1, t1);
> +                tcg_gen_extu_tl_i64(t2, t0);
> +                tcg_gen_extu_tl_i64(t3, t1);
> +                tcg_gen_mul_i64(t2, t2, t3);
> +                tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
> +                tcg_gen_add_i64(t2, t2, t3);
> +                tcg_temp_free_i64(t3);
> +                gen_move_low32(cpu_LO[acc], t2);
> +                gen_move_high32(cpu_HI[acc], t2);
> +                tcg_temp_free_i64(t2);
> +            }
> +            break;
=20
check_dsp() should be as early as possible in this and other similar code s=
egments.
=20
> +        case NM_MULTU:
> +            {
> +                int acc =3D extract32(ctx->opcode, 14, 2);
> +
> +                TCGv_i32 t2 =3D tcg_temp_new_i32();
> +                TCGv_i32 t3 =3D tcg_temp_new_i32();
> +
> +                gen_load_gpr(t0, rs);
> +                gen_load_gpr(t1, rt);
> +
> +                check_dsp(ctx);
> +                tcg_gen_trunc_tl_i32(t2, t0);
> +                tcg_gen_trunc_tl_i32(t3, t1);
> +                tcg_gen_mulu2_i32(t2, t3, t2, t3);
> +                tcg_gen_ext_i32_tl(cpu_LO[acc], t2);
> +                tcg_gen_ext_i32_tl(cpu_HI[acc], t3);
> +                tcg_temp_free_i32(t2);
> +                tcg_temp_free_i32(t3);
> +            }
> +            break;
=20
 Same.
=20
> +        case NM_MSUB:
> +            {
> +                int acc =3D extract32(ctx->opcode, 14, 2);
> +
> +                TCGv_i64 t2 =3D tcg_temp_new_i64();
> +                TCGv_i64 t3 =3D tcg_temp_new_i64();
> +
> +                gen_load_gpr(t0, rs);
> +                gen_load_gpr(t1, rt);
> +
> +                check_dsp(ctx);
> +                tcg_gen_ext_tl_i64(t2, t0);
> +                tcg_gen_ext_tl_i64(t3, t1);
> +                tcg_gen_mul_i64(t2, t2, t3);
> +                tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
> +                tcg_gen_sub_i64(t2, t3, t2);
> +                tcg_temp_free_i64(t3);
> +                gen_move_low32(cpu_LO[acc], t2);
> +                gen_move_high32(cpu_HI[acc], t2);
> +                tcg_temp_free_i64(t2);
> +            }
> +            break;
=20
 Same.
=20
> +        case NM_MSUBU:
> +            {
> +                int acc =3D extract32(ctx->opcode, 14, 2);
> +
> +                TCGv_i64 t2 =3D tcg_temp_new_i64();
> +                TCGv_i64 t3 =3D tcg_temp_new_i64();
> +
> +                gen_load_gpr(t0, rs);
> +                gen_load_gpr(t1, rt);
> +
> +                check_dsp(ctx);
> +                tcg_gen_ext32u_tl(t0, t0);
> +                tcg_gen_ext32u_tl(t1, t1);
> +                tcg_gen_extu_tl_i64(t2, t0);
> +                tcg_gen_extu_tl_i64(t3, t1);
> +                tcg_gen_mul_i64(t2, t2, t3);
> +                tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
> +                tcg_gen_sub_i64(t2, t3, t2);
> +                tcg_temp_free_i64(t3);
> +                gen_move_low32(cpu_LO[acc], t2);
> +                gen_move_high32(cpu_HI[acc], t2);
> +                tcg_temp_free_i64(t2);
> +            }
> +            break;
=20
 Same.
=20
