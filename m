Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emWXm-0002wJ-Ei
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emWXi-0002U6-FI
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:18:38 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1emWXi-0002Tt-8E
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:18:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 15 Feb 2018 22:18:24 -0500
Message-Id: <1518751105-17211-2-git-send-email-cota@braap.org>
In-Reply-To: <1518751105-17211-1-git-send-email-cota@braap.org>
References: <1518751105-17211-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/2] translator: pass max_insns to tb_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

sh4 will need it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translator.c     | 2 +-
 include/exec/translator.h  | 3 ++-
 target/alpha/translate.c   | 3 ++-
 target/arm/translate-a64.c | 4 +++-
 target/arm/translate.c     | 4 +++-
 target/hppa/translate.c    | 4 +++-
 target/i386/translate.c    | 3 ++-
 7 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 23c6602..4ab6f8d 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -64,7 +64,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
     /* Start translating.  */
     gen_tb_start(db->tb);
-    ops->tb_start(db, cpu);
+    max_insns = ops->tb_start(db, cpu, max_insns);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
     while (true) {
diff --git a/include/exec/translator.h b/include/exec/translator.h
index e2dc2a0..0182ada 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -81,6 +81,7 @@ typedef struct DisasContextBase {
  * @tb_start:
  *      Emit any code required before the start of the main loop,
  *      after the generic gen_tb_start().
+ *      Return max_insns, modified if necessary.
  *
  * @insn_start:
  *      Emit the tcg_gen_insn_start opcode.
@@ -108,7 +109,7 @@ typedef struct DisasContextBase {
 typedef struct TranslatorOps {
     int (*init_disas_context)(DisasContextBase *db, CPUState *cpu,
                               int max_insns);
-    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
+    int (*tb_start)(DisasContextBase *db, CPUState *cpu, int max_insns);
     void (*insn_start)(DisasContextBase *db, CPUState *cpu);
     bool (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
                              const CPUBreakpoint *bp);
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 73a1b5e..b603dbd 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2963,8 +2963,9 @@ static int alpha_tr_init_disas_context(DisasContextBase *dcbase,
     return MIN(max_insns, bound);
 }
 
-static void alpha_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+static int alpha_tr_tb_start(DisasContextBase *db, CPUState *cpu, int max_insns)
 {
+    return max_insns;
 }
 
 static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1c88539..7aa47ee 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12080,9 +12080,11 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     return max_insns;
 }
 
-static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+static int aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu,
+                               int max_insns)
 {
     tcg_clear_temp_count();
+    return max_insns;
 }
 
 static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1270022..bdee04e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12060,7 +12060,8 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
     return max_insns;
 }
 
-static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
+static int arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu,
+                           int max_insns)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
@@ -12102,6 +12103,7 @@ static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
         store_cpu_field(tmp, condexec_bits);
     }
     tcg_clear_temp_count();
+    return max_insns;
 }
 
 static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b4b74a8..c816ad1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4726,7 +4726,8 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
     return bound;
 }
 
-static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
+static int hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs,
+                            int max_insns)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
@@ -4738,6 +4739,7 @@ static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
         ctx->psw_n_nonzero = true;
     }
     ctx->null_lab = NULL;
+    return max_insns;
 }
 
 static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0135415..7527e8d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8472,8 +8472,9 @@ static int i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu,
     return max_insns;
 }
 
-static void i386_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+static int i386_tr_tb_start(DisasContextBase *db, CPUState *cpu, int max_insns)
 {
+    return max_insns;
 }
 
 static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.7.4
