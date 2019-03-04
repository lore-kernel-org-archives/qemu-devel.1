Received: from eggs.gnu.org ([209.51.188.92]:35703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0rWJ-00057e-5h
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0rWH-0007BQ-Q0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:36:55 -0500
Received: from mail-eopbgr680093.outbound.protection.outlook.com
	([40.107.68.93]:16692
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h0rWH-0007AU-Iq
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:36:53 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 4 Mar 2019 17:36:51 +0000
Message-ID: <BN6PR2201MB12511044BA7BCD1A16D0EA7EC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1551712405-2530-5-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551712405-2530-5-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 04/13] target/mips: Add emulation of MMI
 instruction PEXCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH v3 04/13] target/mips: Add emulation of MMI instruction P=
EXCH
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Add emulation of MMI instruction PEXCH. The emulation is implemented
> using TCG front end operations directly to achieve better performance.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/translate.c | 97 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 4763e06..9472477 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -24488,6 +24488,99 @@ static void gen_mmi_pcpyud(DisasContext *ctx)
>      }
>  }
>
> +/*
> + *  PEXCH rd, rt
> + *
> + *  Parallel Exchange Center Halfword

The text in the last line should be indented for consistency with previuos\
patches:

 *    Parallel Exchange Center Halfword

> + *
> + *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + *  +-----------+---------+---------+---------+---------+-----------+
> + *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PEXCH  |    MMI3   |
> + *  +-----------+---------+---------+---------+---------+-----------+
> + */
> +static void gen_mmi_pexch(DisasContext *ctx)
> +{
> +    uint32_t pd, rt, rd;
> +    uint32_t opcode;
> +
> +    opcode =3D ctx->opcode;
> +
> +    pd =3D extract32(opcode, 21, 5);
> +    rt =3D extract32(opcode, 16, 5);
> +    rd =3D extract32(opcode, 11, 5);
> +
> +    if (unlikely(pd !=3D 0)) {
> +        generate_exception_end(ctx, EXCP_RI);
> +    } else if (rd =3D=3D 0) {
> +        /* nop */
> +    } else if (rt =3D=3D 0) {
> +        tcg_gen_movi_i64(cpu_gpr[rd], 0);
> +        tcg_gen_movi_i64(cpu_mmr[rd], 0);
> +    } else if (rd =3D=3D rt) {
> +        TCGv_i64 t0 =3D tcg_temp_new();
> +        TCGv_i64 t1 =3D tcg_temp_new();
> +        uint64_t mask0 =3D (1ULL << 16) - 1;
> +        uint64_t mask1 =3D mask0 << 16;
> +        uint64_t mask2 =3D mask1 << 16;

The last line is clearer this way, IMHO:

        uint64_t mask2 =3D mask0 << 32;

> +        uint64_t mask3 =3D (mask2 << 16) | mask0;

...and this line this way:

        uint64_t mask3 =3D (mask0 << 48) | mask0;

> +
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask2);
> +        tcg_gen_shri_i64(t1, t1, 16);
> +
> +        tcg_gen_andi_i64(cpu_gpr[rd], cpu_gpr[rd], mask3);
> +        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t0);
> +        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t1);
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask2);
> +        tcg_gen_shri_i64(t1, t1, 16);
> +
> +        tcg_gen_andi_i64(cpu_mmr[rd], cpu_mmr[rd], mask3);
> +        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t0);
> +        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t1);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    } else {
> +        TCGv_i64 t0 =3D tcg_temp_new();
> +        TCGv_i64 t1 =3D tcg_temp_new();
> +        uint64_t mask0 =3D (1ULL << 16) - 1;
> +        uint64_t mask1 =3D mask0 << 16;
> +        uint64_t mask2 =3D mask1 << 16;
> +        uint64_t mask3 =3D mask2 << 16;

The last two lines are clearer this way:

        uint64_t mask2 =3D mask0 << 32;
        uint64_t mask3 =3D mask0 << 48;

> +
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask3);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask2);
> +        tcg_gen_shri_i64(t1, t1, 16);
> +        tcg_gen_or_i64(t0, t0, t1);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask1);
> +        tcg_gen_shli_i64(t1, t1, 16);
> +        tcg_gen_or_i64(t0, t0, t1);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask0);
> +        tcg_gen_or_i64(t0, t0, t1);
> +
> +        tcg_gen_mov_i64(cpu_gpr[rd], t0);
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask3);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask2);
> +        tcg_gen_shri_i64(t1, t1, 16);
> +        tcg_gen_or_i64(t0, t0, t1);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask1);
> +        tcg_gen_shli_i64(t1, t1, 16);
> +        tcg_gen_or_i64(t0, t0, t1);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask0);
> +        tcg_gen_or_i64(t0, t0, t1);
> +
> +        tcg_gen_mov_i64(cpu_mmr[rd], t0);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    }
> +}
> +
>  #endif
>
>
> @@ -27540,7 +27633,6 @@ static void decode_mmi3(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_3_PDIVUW:     /* TODO: MMI_OPC_3_PDIVUW */
>      case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
>      case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
> -    case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
>      case MMI_OPC_3_PEXCW:      /* TODO: MMI_OPC_3_PEXCW */
>          generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI=
3 */
>          break;
> @@ -27550,6 +27642,9 @@ static void decode_mmi3(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_3_PCPYUD:
>          gen_mmi_pcpyud(ctx);
>          break;
> +    case MMI_OPC_3_PEXCH:
> +        gen_mmi_pexch(ctx);
> +        break;
>      default:
>          MIPS_INVAL("TX79 MMI class MMI3");
>          generate_exception_end(ctx, EXCP_RI);
> --

Apart from minor hints above:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> 2.7.4
>
>

________________________________________
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Sent: Monday, March 4, 2019 4:13:16 PM
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
Subject: [PATCH v3 04/13] target/mips: Add emulation of MMI instruction PEX=
CH

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Add emulation of MMI instruction PEXCH. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 97 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4763e06..9472477 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24488,6 +24488,99 @@ static void gen_mmi_pcpyud(DisasContext *ctx)
     }
 }

+/*
+ *  PEXCH rd, rt
+ *
+ *  Parallel Exchange Center Halfword
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PEXCH  |    MMI3   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+static void gen_mmi_pexch(DisasContext *ctx)
+{
+    uint32_t pd, rt, rd;
+    uint32_t opcode;
+
+    opcode =3D ctx->opcode;
+
+    pd =3D extract32(opcode, 21, 5);
+    rt =3D extract32(opcode, 16, 5);
+    rd =3D extract32(opcode, 11, 5);
+
+    if (unlikely(pd !=3D 0)) {
+        generate_exception_end(ctx, EXCP_RI);
+    } else if (rd =3D=3D 0) {
+        /* nop */
+    } else if (rt =3D=3D 0) {
+        tcg_gen_movi_i64(cpu_gpr[rd], 0);
+        tcg_gen_movi_i64(cpu_mmr[rd], 0);
+    } else if (rd =3D=3D rt) {
+        TCGv_i64 t0 =3D tcg_temp_new();
+        TCGv_i64 t1 =3D tcg_temp_new();
+        uint64_t mask0 =3D (1ULL << 16) - 1;
+        uint64_t mask1 =3D mask0 << 16;
+        uint64_t mask2 =3D mask1 << 16;
+        uint64_t mask3 =3D (mask2 << 16) | mask0;
+
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask2);
+        tcg_gen_shri_i64(t1, t1, 16);
+
+        tcg_gen_andi_i64(cpu_gpr[rd], cpu_gpr[rd], mask3);
+        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t0);
+        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t1);
+
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask2);
+        tcg_gen_shri_i64(t1, t1, 16);
+
+        tcg_gen_andi_i64(cpu_mmr[rd], cpu_mmr[rd], mask3);
+        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t0);
+        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t1);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+    } else {
+        TCGv_i64 t0 =3D tcg_temp_new();
+        TCGv_i64 t1 =3D tcg_temp_new();
+        uint64_t mask0 =3D (1ULL << 16) - 1;
+        uint64_t mask1 =3D mask0 << 16;
+        uint64_t mask2 =3D mask1 << 16;
+        uint64_t mask3 =3D mask2 << 16;
+
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask3);
+        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask2);
+        tcg_gen_shri_i64(t1, t1, 16);
+        tcg_gen_or_i64(t0, t0, t1);
+        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask1);
+        tcg_gen_shli_i64(t1, t1, 16);
+        tcg_gen_or_i64(t0, t0, t1);
+        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask0);
+        tcg_gen_or_i64(t0, t0, t1);
+
+        tcg_gen_mov_i64(cpu_gpr[rd], t0);
+
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask3);
+        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask2);
+        tcg_gen_shri_i64(t1, t1, 16);
+        tcg_gen_or_i64(t0, t0, t1);
+        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask1);
+        tcg_gen_shli_i64(t1, t1, 16);
+        tcg_gen_or_i64(t0, t0, t1);
+        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask0);
+        tcg_gen_or_i64(t0, t0, t1);
+
+        tcg_gen_mov_i64(cpu_mmr[rd], t0);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+    }
+}
+
 #endif


@@ -27540,7 +27633,6 @@ static void decode_mmi3(CPUMIPSState *env, DisasCon=
text *ctx)
     case MMI_OPC_3_PDIVUW:     /* TODO: MMI_OPC_3_PDIVUW */
     case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
     case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
-    case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
     case MMI_OPC_3_PEXCW:      /* TODO: MMI_OPC_3_PEXCW */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI3 =
*/
         break;
@@ -27550,6 +27642,9 @@ static void decode_mmi3(CPUMIPSState *env, DisasCon=
text *ctx)
     case MMI_OPC_3_PCPYUD:
         gen_mmi_pcpyud(ctx);
         break;
+    case MMI_OPC_3_PEXCH:
+        gen_mmi_pexch(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI3");
         generate_exception_end(ctx, EXCP_RI);
--
2.7.4
