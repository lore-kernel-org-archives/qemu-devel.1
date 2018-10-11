Received: from eggs.gnu.org ([2001:4830:134:3::10]:52697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ5D-000638-D3
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ5A-0007hI-C8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:24:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52577 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gAZ59-0007J0-Ot
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:24:44 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 11 Oct 2018 13:22:09 +0200
Message-Id: <1539256947-22807-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 04/22] target/mips: Add CPO PWBase register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Yongbok Kim <yongbok.kim@mips.com>

Add PWBase register (CP0 Register 5, Select 5).

The PWBase register contains the Page Table Base virtual address.

This register is required for the hardware page walker feature. It
exists only if Config3 PW bit is set to 1.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/machine.c   |  1 +
 target/mips/translate.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 28af4d1..c8999a8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -289,6 +289,7 @@ struct CPUMIPSState {
 #define CP0SC2_XR       56
 #define CP0SC2_XR_MASK  (0xFFULL << CP0SC2_XR)
 #define CP0SC2_MASK     (CP0SC_1GMASK | (CP0SC_1GMASK << 16) | CP0SC2_XR_MASK)
+    target_ulong CP0_PWBase;
     int32_t CP0_Wired;
     int32_t CP0_SRSConf0_rw_bitmask;
     int32_t CP0_SRSConf0;
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 5ba78ac..86702c6 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -256,6 +256,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_SegCtl1, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_SegCtl2, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_PWBase, MIPSCPU),
         VMSTATE_INT32(env.CP0_Wired, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf0, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf1, MIPSCPU),
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ab16cdb..7af9a21 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1929,6 +1929,17 @@ static inline void check_xnp(DisasContext *ctx)
 
 /*
  * This code generates a "reserved instruction" exception if the
+ * Config3 PW bit is NOT set.
+ */
+static inline void check_pw(DisasContext *ctx)
+{
+    if (unlikely(!(ctx->CP0_Config3 & (1 << CP0C3_PW)))) {
+        generate_exception_end(ctx, EXCP_RI);
+    }
+}
+
+/*
+ * This code generates a "reserved instruction" exception if the
  * Config3 MT bit is NOT set.
  */
 static inline void check_mt(DisasContext *ctx)
@@ -5537,6 +5548,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_ext32s_tl(arg, arg);
             rn = "SegCtl2";
             break;
+        case 5:
+            check_pw(ctx);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWBase));
+            rn = "PWBase";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6238,6 +6254,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_segctl2(cpu_env, arg);
             rn = "SegCtl2";
             break;
+        case 5:
+            check_pw(ctx);
+            gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_PWBase));
+            rn = "PWBase";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6948,6 +6969,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl2));
             rn = "SegCtl2";
             break;
+        case 5:
+            check_pw(ctx);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWBase));
+            rn = "PWBase";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7631,6 +7657,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_segctl2(cpu_env, arg);
             rn = "SegCtl2";
             break;
+        case 5:
+            check_pw(ctx);
+            tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWBase));
+            rn = "PWBase";
+            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.7.4
