Received: from eggs.gnu.org ([2001:4830:134:3::10]:60528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flYFI-0008QT-NE
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flYFF-0005xC-J8
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:27:48 -0400
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com
	([104.47.38.104]:53711
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flYFF-0005vp-89
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:27:45 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 11:27:41 +0000
Message-ID: <BN7PR08MB4868C5558566BB9316932D09C6230@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1533219424-7627-41-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-41-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 40/77] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Sent: Thursday, August 2, 2018 4:16 PM
> Subject: [PATCH v6 40/77] target/mips: Add emulation of DSP ASE for nanoM=
IPS - part 3
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 3.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 186 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 186 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 06707ac..3f41728 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16869,13 +16869,197 @@ static void gen_pool32a0_nanomips_insn(CPUMIPS=
State *env, DisasContext *ctx)
>      }
>  }
>=20

> +    case NM_POOL32AXF_1_0:
> +        switch (extract32(ctx->opcode, 12, 2)) {
> +        case NM_MFHI:
> +            gen_HILO(ctx, OPC_MFHI, v2 >> 3, ret);
> +            break;
> +        case NM_MFLO:
> +            gen_HILO(ctx, OPC_MFLO, v2 >> 3, ret);
> +            break;
> +        case NM_MTHI:
> +            gen_HILO(ctx, OPC_MTHI, v2 >> 3, v1);
> +            break;
> +        case NM_MTLO:
> +            gen_HILO(ctx, OPC_MTLO, v2 >> 3, v1);
> +            break;
> +        }
> +        break;

Missing availability control (check_dsp() or similar), here and in many oth=
er places in this patch.


> +    case NM_POOL32AXF_1_1:
> +        switch (extract32(ctx->opcode, 12, 2)) {
> +        case NM_MTHLIP:
> +            tcg_gen_movi_tl(t0, v2);
> +            gen_helper_mthlip(t0, v0_t, cpu_env);
> +            break;
> +        case NM_SHILOV:
> +            tcg_gen_movi_tl(t0, v2 >> 3);
> +            gen_helper_shilo(t0, v0_t, cpu_env);
> +            break;
> +        }
> +        break;

Missing default case, availability control.

> +    case NM_POOL32AXF_1_3:
> +        imm =3D extract32(ctx->opcode, 14, 7);
> +        switch (extract32(ctx->opcode, 12, 2)) {
> +        case NM_RDDSP:
> +            tcg_gen_movi_tl(t0, imm);
> +            gen_helper_rddsp(t0, t0, cpu_env);
> +            gen_store_gpr(t0, ret);
> +            break;
> +        case NM_WRDSP:
> +            gen_load_gpr(t0, ret);
> +            tcg_gen_movi_tl(t1, imm);
> +            gen_helper_wrdsp(t0, t1, cpu_env);
> +            break;
> +        case NM_EXTP:
> +            tcg_gen_movi_tl(t0, v2 >> 3);
> +            tcg_gen_movi_tl(t1, v1);
> +            gen_helper_extp(t0, t0, t1, cpu_env);
> +            gen_store_gpr(t0, ret);
> +            break;
> +        case NM_EXTPDP:
> +            tcg_gen_movi_tl(t0, v2 >> 3);
> +            tcg_gen_movi_tl(t1, v1);
> +            gen_helper_extpdp(t0, t0, t1, cpu_env);
> +            gen_store_gpr(t0, ret);
> +            break;
> +        }
> +        break;

Missing availability control.

> +    case NM_POOL32AXF_1_5:
> +        {
> +            opc =3D extract32(ctx->opcode, 12, 2);
> +            gen_pool32axf_1_5_nanomips_insn(ctx, opc, ret, v1, v2);
> +        }
> +        break;

Missing availability control, spurious indentation.

> +    case NM_POOL32AXF_1_7:
> +        tcg_gen_movi_tl(t0, v2 >> 3);
> +        tcg_gen_movi_tl(t1, v1);
> +        switch (extract32(ctx->opcode, 12, 2)) {
> +        case NM_EXTR_W:
> +            gen_helper_extr_w(t0, t0, t1, cpu_env);
> +            gen_store_gpr(t0, ret);
> +            break;
> +        case NM_EXTR_R_W:
> +            gen_helper_extr_r_w(t0, t0, t1, cpu_env);
> +            gen_store_gpr(t0, ret);
> +            break;
> +        case NM_EXTR_RS_W:
> +            gen_helper_extr_rs_w(t0, t0, t1, cpu_env);
> +            gen_store_gpr(t0, ret);
> +            break;
> +        case NM_EXTR_S_H:
> +            gen_helper_extr_s_h(t0, t0, t1, cpu_env);
> +            gen_store_gpr(t0, ret);
> +            break;
> +        }
> +        break;

Missing availability control.

Aleksandar M.=
