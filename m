Received: from eggs.gnu.org ([209.51.188.92]:39394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0rpb-0007Hl-T9
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0rpa-0000CZ-Le
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:56:51 -0500
Received: from mail-eopbgr810118.outbound.protection.outlook.com
	([40.107.81.118]:58881
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h0rpa-0000BR-8e
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:56:50 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 4 Mar 2019 17:56:47 +0000
Message-ID: <BN6PR2201MB125160A7F940511C9376D487C6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1551712405-2530-6-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551712405-2530-6-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 05/13] target/mips: Add emulation of MMI
 instruction PEXCW
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
> Subject: [PATCH v3 05/13] target/mips: Add emulation of MMI instruction P=
EXCW
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Add emulation of MMI instruction PEXCW. The emulation is implemented
> using TCG front end operations directly to achieve better performance.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/translate.c | 73 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 9472477..64eb10c 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -24581,6 +24581,75 @@ static void gen_mmi_pexch(DisasContext *ctx)
>      }
>  }
>
> +/*
> + *  PEXCW rd, rt
> + *
> + *  Parallel Exchange Center Word
> + *
> + *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + *  +-----------+---------+---------+---------+---------+-----------+
> + *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PEXCW  |    MMI3   |
> + *  +-----------+---------+---------+---------+---------+-----------+
> + */
> +
> +static void gen_mmi_pexcw(DisasContext *ctx)
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
> +    } else if (rt =3D=3D rd) {
> +        TCGv_i64 t0 =3D tcg_temp_new();
> +        TCGv_i64 t1 =3D tcg_temp_new();
> +        uint64_t mask0 =3D (1ULL << 32) - 1;
> +        uint64_t mask1 =3D mask0 << 32;
> +
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
> +        tcg_gen_shri_i64(t0, t0, 32);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask0);
> +        tcg_gen_shli_i64(t1, t1, 32);
> +
> +        tcg_gen_andi_i64(cpu_mmr[rd], cpu_mmr[rd], mask1);
> +        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t0);
> +
> +        tcg_gen_andi_i64(cpu_gpr[rd], cpu_gpr[rd], mask0);
> +        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t1);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    } else {

Yes, this block works only for the case rt =3D=3D rd...

> +        TCGv_i64 t0 =3D tcg_temp_new();
> +        TCGv_i64 t1 =3D tcg_temp_new();
> +        uint64_t mask0 =3D (1ULL << 32) - 1;
> +        uint64_t mask1 =3D mask0 << 32;
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask1);
> +        tcg_gen_shri_i64(t1, t1, 32);
> +        tcg_gen_or_i64(cpu_mmr[rd], t0, t1);
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);
> +        tcg_gen_shli_i64(t0, t0, 32);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask0);
> +        tcg_gen_or_i64(cpu_gpr[rd], t0, t1);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    }

... while this block works only for the case rt !=3D rd.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> +}
> +
>  #endif
>
>
> @@ -27633,7 +27702,6 @@ static void decode_mmi3(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_3_PDIVUW:     /* TODO: MMI_OPC_3_PDIVUW */
>      case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
>      case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
> -    case MMI_OPC_3_PEXCW:      /* TODO: MMI_OPC_3_PEXCW */
>          generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI=
3 */
>          break;
>      case MMI_OPC_3_PCPYH:
> @@ -27645,6 +27713,9 @@ static void decode_mmi3(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_3_PEXCH:
>          gen_mmi_pexch(ctx);
>          break;
> +    case MMI_OPC_3_PEXCW:
> +        gen_mmi_pexcw(ctx);
> +        break;
>      default:
>          MIPS_INVAL("TX79 MMI class MMI3");
>          generate_exception_end(ctx, EXCP_RI);
> --
> 2.7.4


________________________________________
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Sent: Monday, March 4, 2019 4:13:17 PM
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
Subject: [PATCH v3 05/13] target/mips: Add emulation of MMI instruction PEX=
CW

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Add emulation of MMI instruction PEXCW. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 73 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9472477..64eb10c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24581,6 +24581,75 @@ static void gen_mmi_pexch(DisasContext *ctx)
     }
 }

+/*
+ *  PEXCW rd, rt
+ *
+ *  Parallel Exchange Center Word
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PEXCW  |    MMI3   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+
+static void gen_mmi_pexcw(DisasContext *ctx)
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
+    } else if (rt =3D=3D rd) {
+        TCGv_i64 t0 =3D tcg_temp_new();
+        TCGv_i64 t1 =3D tcg_temp_new();
+        uint64_t mask0 =3D (1ULL << 32) - 1;
+        uint64_t mask1 =3D mask0 << 32;
+
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
+        tcg_gen_shri_i64(t0, t0, 32);
+        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask0);
+        tcg_gen_shli_i64(t1, t1, 32);
+
+        tcg_gen_andi_i64(cpu_mmr[rd], cpu_mmr[rd], mask1);
+        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t0);
+
+        tcg_gen_andi_i64(cpu_gpr[rd], cpu_gpr[rd], mask0);
+        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t1);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+    } else {
+        TCGv_i64 t0 =3D tcg_temp_new();
+        TCGv_i64 t1 =3D tcg_temp_new();
+        uint64_t mask0 =3D (1ULL << 32) - 1;
+        uint64_t mask1 =3D mask0 << 32;
+
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
+        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask1);
+        tcg_gen_shri_i64(t1, t1, 32);
+        tcg_gen_or_i64(cpu_mmr[rd], t0, t1);
+
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);
+        tcg_gen_shli_i64(t0, t0, 32);
+        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask0);
+        tcg_gen_or_i64(cpu_gpr[rd], t0, t1);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+    }
+}
+
 #endif


@@ -27633,7 +27702,6 @@ static void decode_mmi3(CPUMIPSState *env, DisasCon=
text *ctx)
     case MMI_OPC_3_PDIVUW:     /* TODO: MMI_OPC_3_PDIVUW */
     case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
     case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
-    case MMI_OPC_3_PEXCW:      /* TODO: MMI_OPC_3_PEXCW */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI3 =
*/
         break;
     case MMI_OPC_3_PCPYH:
@@ -27645,6 +27713,9 @@ static void decode_mmi3(CPUMIPSState *env, DisasCon=
text *ctx)
     case MMI_OPC_3_PEXCH:
         gen_mmi_pexch(ctx);
         break;
+    case MMI_OPC_3_PEXCW:
+        gen_mmi_pexcw(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI3");
         generate_exception_end(ctx, EXCP_RI);
--
2.7.4
