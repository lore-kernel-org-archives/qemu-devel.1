Received: from eggs.gnu.org ([2001:4830:134:3::10]:48227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJF-000512-Mt
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJB-0005cD-LF
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:25 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJB-0005af-9D
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:21 -0400
Received: by mail-pf0-x242.google.com with SMTP id q22so25999695pff.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:41 -0700
Message-Id: <20180509175458.15642-12-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/28] translator: merge max_insns into
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

While at it, use int for both num_insns and max_insns to make
sure we have same-type comparisons.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h  |  8 ++++----
 accel/tcg/translator.c     | 21 ++++++++++-----------
 target/alpha/translate.c   |  6 ++----
 target/arm/translate-a64.c |  8 +++-----
 target/arm/translate.c     |  9 +++------
 target/hppa/translate.c    |  7 ++-----
 target/i386/translate.c    |  5 +----
 target/ppc/translate.c     |  5 ++---
 8 files changed, 27 insertions(+), 42 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index e2dc2a04ae..71e7b2c347 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -58,6 +58,7 @@ typedef enum DisasJumpType {
  *           disassembly).
  * @is_jmp: What instruction to disassemble next.
  * @num_insns: Number of translated instructions (including current).
+ * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
  *
  * Architecture-agnostic disassembly context.
@@ -67,7 +68,8 @@ typedef struct DisasContextBase {
     target_ulong pc_first;
     target_ulong pc_next;
     DisasJumpType is_jmp;
-    unsigned int num_insns;
+    int num_insns;
+    int max_insns;
     bool singlestep_enabled;
 } DisasContextBase;
 
@@ -76,7 +78,6 @@ typedef struct DisasContextBase {
  * @init_disas_context:
  *      Initialize the target-specific portions of DisasContext struct.
  *      The generic DisasContextBase has already been initialized.
- *      Return max_insns, modified as necessary by db->tb->flags.
  *
  * @tb_start:
  *      Emit any code required before the start of the main loop,
@@ -106,8 +107,7 @@ typedef struct DisasContextBase {
  *      Print instruction disassembly to log.
  */
 typedef struct TranslatorOps {
-    int (*init_disas_context)(DisasContextBase *db, CPUState *cpu,
-                              int max_insns);
+    void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
     void (*tb_start)(DisasContextBase *db, CPUState *cpu);
     void (*insn_start)(DisasContextBase *db, CPUState *cpu);
     bool (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 23c6602cd9..0f9dca9113 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -34,8 +34,6 @@ void translator_loop_temp_check(DisasContextBase *db)
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb)
 {
-    int max_insns;
-
     /* Initialize DisasContext */
     db->tb = tb;
     db->pc_first = tb->pc;
@@ -45,18 +43,18 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     db->singlestep_enabled = cpu->singlestep_enabled;
 
     /* Instruction counting */
-    max_insns = tb_cflags(db->tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
+    db->max_insns = tb_cflags(db->tb) & CF_COUNT_MASK;
+    if (db->max_insns == 0) {
+        db->max_insns = CF_COUNT_MASK;
     }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
+    if (db->max_insns > TCG_MAX_INSNS) {
+        db->max_insns = TCG_MAX_INSNS;
     }
     if (db->singlestep_enabled || singlestep) {
-        max_insns = 1;
+        db->max_insns = 1;
     }
 
-    max_insns = ops->init_disas_context(db, cpu, max_insns);
+    ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
     /* Reset the temp count so that we can identify leaks */
@@ -95,7 +93,8 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
            update db->pc_next and db->is_jmp to indicate what should be
            done next -- either exiting this loop or locate the start of
            the next instruction.  */
-        if (db->num_insns == max_insns && (tb_cflags(db->tb) & CF_LAST_IO)) {
+        if (db->num_insns == db->max_insns
+            && (tb_cflags(db->tb) & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
             gen_io_start();
             ops->translate_insn(db, cpu);
@@ -111,7 +110,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
         /* Stop translation if the output buffer is full,
            or we have executed all of the allowed instructions.  */
-        if (tcg_op_buf_full() || db->num_insns >= max_insns) {
+        if (tcg_op_buf_full() || db->num_insns >= db->max_insns) {
             db->is_jmp = DISAS_TOO_MANY;
             break;
         }
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 73a1b5e63e..15eca71d49 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2919,8 +2919,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     return ret;
 }
 
-static int alpha_tr_init_disas_context(DisasContextBase *dcbase,
-                                       CPUState *cpu, int max_insns)
+static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUAlphaState *env = cpu->env_ptr;
@@ -2959,8 +2958,7 @@ static int alpha_tr_init_disas_context(DisasContextBase *dcbase,
         mask = TARGET_PAGE_MASK;
     }
     bound = -(ctx->base.pc_first | mask) / 4;
-
-    return MIN(max_insns, bound);
+    ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
 }
 
 static void alpha_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6d49f30b4a..1e7c150514 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13224,8 +13224,8 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     free_tmp_a64(s);
 }
 
-static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
-                                         CPUState *cpu, int max_insns)
+static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
+                                          CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu->env_ptr;
@@ -13288,11 +13288,9 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     if (dc->ss_active) {
         bound = 1;
     }
-    max_insns = MIN(max_insns, bound);
+    dc->base.max_insns = MIN(dc->base.max_insns, bound);
 
     init_tmp_a64_array(dc);
-
-    return max_insns;
 }
 
 static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0f6629f745..731cf327a1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12243,8 +12243,7 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
     return !thumb_insn_is_16bit(s, insn);
 }
 
-static int arm_tr_init_disas_context(DisasContextBase *dcbase,
-                                     CPUState *cs, int max_insns)
+static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cs->env_ptr;
@@ -12305,14 +12304,14 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
 
     /* If architectural single step active, limit to 1.  */
     if (is_singlestepping(dc)) {
-        max_insns = 1;
+        dc->base.max_insns = 1;
     }
 
     /* ARM is a fixed-length ISA.  Bound the number of insns to execute
        to those left on the page.  */
     if (!dc->thumb) {
         int bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
-        max_insns = MIN(max_insns, bound);
+        dc->base.max_insns = MIN(dc->base.max_insns, bound);
     }
 
     cpu_F0s = tcg_temp_new_i32();
@@ -12323,8 +12322,6 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
     cpu_V1 = cpu_F1d;
     /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 = tcg_temp_new_i64();
-
-    return max_insns;
 }
 
 static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cdc397308b..5320b217de 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4669,8 +4669,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     return gen_illegal(ctx);
 }
 
-static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
-                                      CPUState *cs, int max_insns)
+static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     int bound;
@@ -4700,14 +4699,12 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
 
     /* Bound the number of instructions by those left on the page.  */
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
-    bound = MIN(max_insns, bound);
+    ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
 
     ctx->ntempr = 0;
     ctx->ntempl = 0;
     memset(ctx->tempr, 0, sizeof(ctx->tempr));
     memset(ctx->templ, 0, sizeof(ctx->templ));
-
-    return bound;
 }
 
 static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index c9ed8dc709..b0f69838f2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8402,8 +8402,7 @@ void tcg_x86_init(void)
     }
 }
 
-static int i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu,
-                                      int max_insns)
+static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUX86State *env = cpu->env_ptr;
@@ -8470,8 +8469,6 @@ static int i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu,
     cpu_ptr0 = tcg_temp_new_ptr();
     cpu_ptr1 = tcg_temp_new_ptr();
     cpu_cc_srcT = tcg_temp_local_new();
-
-    return max_insns;
 }
 
 static void i386_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2a4140f420..7972e6b410 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7215,8 +7215,7 @@ void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
 #endif
 }
 
-static int ppc_tr_init_disas_context(DisasContextBase *dcbase,
-                                     CPUState *cs, int max_insns)
+static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUPPCState *env = cs->env_ptr;
@@ -7281,7 +7280,7 @@ static int ppc_tr_init_disas_context(DisasContextBase *dcbase,
 #endif
 
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
-    return MIN(max_insns, bound);
+    ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
 }
 
 static void ppc_tr_tb_start(DisasContextBase *db, CPUState *cs)
-- 
2.17.0
