Received: from eggs.gnu.org ([2001:4830:134:3::10]:59382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH37-0005Oq-4g
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH32-00072f-Uj
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55742 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH32-00071W-JG
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:32 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:52:34 +0200
Message-Id: <1534182832-554-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 09/87] target/mips: Add support for
 availability control via bit MT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add a field in hflags for MT bit, and functions check_mt() and
check_cp0_mt().

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  3 ++-
 target/mips/internal.h  |  6 +++++-
 target/mips/translate.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 02ea91e..8a8782b 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -554,7 +554,7 @@ struct CPUMIPSState {
 #define EXCP_INST_NOTAVAIL 0x2 /* No valid instruction word for BadInstr */
     uint32_t hflags;    /* CPU State */
     /* TMASK defines different execution modes */
-#define MIPS_HFLAG_TMASK  0x3F5807FF
+#define MIPS_HFLAG_TMASK  0x7F5807FF
 #define MIPS_HFLAG_MODE   0x00007 /* execution modes                    */
     /* The KSU flags must be the lowest bits in hflags. The flag order
        must be the same as defined for CP0 Status. This allows to use
@@ -606,6 +606,7 @@ struct CPUMIPSState {
 #define MIPS_HFLAG_ITC_CACHE  0x8000000 /* CACHE instr. operates on ITC tag */
 #define MIPS_HFLAG_ERL   0x10000000 /* error level flag */
 #define MIPS_HFLAG_XNP   0x20000000
+#define MIPS_HFLAG_MT    0x40000000
     target_ulong btarget;        /* Jump / branch target               */
     target_ulong bcond;          /* Branch condition (if needed)       */
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 97485da..c0e447b 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -308,7 +308,8 @@ static inline void compute_hflags(CPUMIPSState *env)
                      MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
                      MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
                      MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA | MIPS_HFLAG_FRE |
-                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL | MIPS_HFLAG_XNP);
+                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL | MIPS_HFLAG_XNP |
+                     MIPS_HFLAG_MT);
     if (env->CP0_Status & (1 << CP0St_ERL)) {
         env->hflags |= MIPS_HFLAG_ERL;
     }
@@ -405,6 +406,9 @@ static inline void compute_hflags(CPUMIPSState *env)
     if (env->CP0_Config5 & (1 << CP0C5_XNP)) {
         env->hflags |= MIPS_HFLAG_XNP;
     }
+    if (env->CP0_Config3 & (1 << CP0C3_MT)) {
+        env->hflags |= MIPS_HFLAG_MT;
+    }
 }
 
 void cpu_mips_tlb_flush(CPUMIPSState *env);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 35342e2..b73f434 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1913,6 +1913,35 @@ static inline void check_xnp(DisasContext *ctx)
     }
 }
 
+/*
+ * This code generates a "reserved instruction" exception if the
+ * Config5 MT bit is NOT set.
+ */
+static inline void check_mt(DisasContext *ctx)
+{
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_MT))) {
+        generate_exception_end(ctx, EXCP_RI);
+    }
+}
+
+/*
+ * This code generates a "coprocessor unusable" if CP) is not
+ * available, and, if that is not the case, generates a "reserved
+ * instruction" exception if the Config5 MT bit is NOT set.
+ * This is used for some of instructions in MT ASE.
+ */
+static inline void check_cp0_mt(DisasContext *ctx)
+{
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_CP0))) {
+        generate_exception_err(ctx, EXCP_CpU, 0);
+    } else {
+        if (unlikely(!(ctx->hflags & MIPS_HFLAG_MT))) {
+            generate_exception_err(ctx, EXCP_RI, 0);
+        }
+    }
+}
+
+
 
 /* Define small wrappers for gen_load_fpr* so that we have a uniform
    calling interface for 32 and 64-bit FPRs.  No sense in changing
-- 
2.7.4
