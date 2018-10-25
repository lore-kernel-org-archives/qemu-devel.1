Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKj-0006ht-5k
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKP-0000C0-I8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKP-00005M-Ap
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:32 -0400
Message-Id: <20181025172057.20414-24-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument to
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/translator.h   | 4 +++-
 accel/tcg/translator.c      | 4 ++--
 target/alpha/translate.c    | 3 ++-
 target/arm/translate-a64.c  | 3 ++-
 target/arm/translate.c      | 6 ++++--
 target/hppa/translate.c     | 3 ++-
 target/i386/translate.c     | 3 ++-
 target/m68k/translate.c     | 3 ++-
 target/mips/translate.c     | 3 ++-
 target/openrisc/translate.c | 3 ++-
 target/ppc/translate.c      | 3 ++-
 target/riscv/translate.c    | 3 ++-
 target/s390x/translate.c    | 3 ++-
 target/sh4/translate.c      | 3 ++-
 target/sparc/translate.c    | 3 ++-
 target/xtensa/translate.c   | 3 ++-
 16 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 71e7b2c347..a28147b3dd 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -20,6 +20,7 @@
 
 
 #include "exec/exec-all.h"
+#include "qemu/plugin.h"
 #include "tcg/tcg.h"
 
 
@@ -112,7 +113,8 @@ typedef struct TranslatorOps {
     void (*insn_start)(DisasContextBase *db, CPUState *cpu);
     bool (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
                              const CPUBreakpoint *bp);
-    void (*translate_insn)(DisasContextBase *db, CPUState *cpu);
+    void (*translate_insn)(DisasContextBase *db, CPUState *cpu,
+                           struct qemu_plugin_insn *plugin_insn);
     void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
     void (*disas_log)(const DisasContextBase *db, CPUState *cpu);
 } TranslatorOps;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index afd0a49ea6..8591e4b72a 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -101,10 +101,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             && (tb_cflags(db->tb) & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
             gen_io_start();
-            ops->translate_insn(db, cpu);
+            ops->translate_insn(db, cpu, NULL);
             gen_io_end();
         } else {
-            ops->translate_insn(db, cpu);
+            ops->translate_insn(db, cpu, NULL);
         }
 
         /* Stop translation if translate_insn so indicated.  */
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 25cd95931d..72a302e102 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2983,7 +2983,8 @@ static bool alpha_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
-static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
+                                    struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUAlphaState *env = cpu->env_ptr;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bb9c4d8ac7..8b1e20dd59 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13937,7 +13937,8 @@ static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
-static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
+                                      struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu->env_ptr;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1b4bacb522..2fd32a2684 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12787,7 +12787,8 @@ static void arm_post_translate_insn(DisasContext *dc)
     translator_loop_temp_check(&dc->base);
 }
 
-static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
+                                  struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu->env_ptr;
@@ -12854,7 +12855,8 @@ static bool thumb_insn_is_unconditional(DisasContext *s, uint32_t insn)
     return false;
 }
 
-static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
+                                    struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu->env_ptr;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index df9179e70f..6c2a7fbc46 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4737,7 +4737,8 @@ static bool hppa_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     return true;
 }
 
-static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
+                                   struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUHPPAState *env = cs->env_ptr;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 83c1ebe491..86e59d7bf7 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8525,7 +8525,8 @@ static bool i386_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     }
 }
 
-static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
+                                   struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong pc_next = disas_insn(dc, cpu);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d55e707cf6..dd7d868b25 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6087,7 +6087,8 @@ static bool m68k_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
-static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
+                                   struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUM68KState *env = cpu->env_ptr;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 544e4dc19c..efafc6e795 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -25349,7 +25349,8 @@ static bool mips_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     return true;
 }
 
-static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
+                                   struct qemu_plugin_insn *plugin_insn)
 {
     CPUMIPSState *env = cs->env_ptr;
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a271cd3903..947330e10a 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1301,7 +1301,8 @@ static bool openrisc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     return true;
 }
 
-static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
+                                       struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2d31b5f7a1..34c3ed0a41 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7545,7 +7545,8 @@ static bool ppc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     return true;
 }
 
-static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
+                                  struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUPPCState *env = cs->env_ptr;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 18d7b6d147..a33cf6802b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1843,7 +1843,8 @@ static bool riscv_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
 }
 
 
-static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
+                                    struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu->env_ptr;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b5bd56b7ee..6ac1a8d821 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6228,7 +6228,8 @@ static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     return true;
 }
 
-static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
+                                    struct qemu_plugin_insn *plugin_insn)
 {
     CPUS390XState *env = cs->env_ptr;
     DisasContext *dc = container_of(dcbase, DisasContext, base);
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ab254b0e8d..ea88d46c04 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2313,7 +2313,8 @@ static bool sh4_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     return true;
 }
 
-static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
+                                  struct qemu_plugin_insn *plugin_insn)
 {
     CPUSH4State *env = cs->env_ptr;
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 74315cdf09..2fa8b68e0a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5894,7 +5894,8 @@ static bool sparc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     return true;
 }
 
-static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
+                                    struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUSPARCState *env = cs->env_ptr;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 46e1338448..14ab1c5ceb 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1146,7 +1146,8 @@ static bool xtensa_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
-static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
+                                     struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUXtensaState *env = cpu->env_ptr;
-- 
2.17.1
