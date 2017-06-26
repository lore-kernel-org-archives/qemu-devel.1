Received: from eggs.gnu.org ([2001:4830:134:3::10]:57025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7k-0007hG-ID
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7h-0005NB-Bt
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPc7g-0005M6-Vv
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 26 Jun 2017 18:04:35 -0400
Message-Id: <1498514681-3059-2-git-send-email-cota@braap.org>
In-Reply-To: <1498514681-3059-1-git-send-email-cota@braap.org>
References: <1498514681-3059-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/7] exec: [tcg] Refactor flush of per-CPU
 virtual TB cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Desnogues <laurent.desnogues@gmail.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

The function is reused in later patches.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cputlb.c        |  2 +-
 accel/tcg/translate-all.c | 15 ++++++++++-----
 include/exec/exec-all.h   |  6 ++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 743776a..6a2b762 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -118,7 +118,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
 
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
-    memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
+    tb_flush_jmp_cache_all(cpu);
 
     env->vtlb_index = 0;
     env->tlb_flush_addr = -1;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6ad46b..8888dad 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -928,11 +928,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     }
 
     CPU_FOREACH(cpu) {
-        int i;
-
-        for (i = 0; i < TB_JMP_CACHE_SIZE; ++i) {
-            atomic_set(&cpu->tb_jmp_cache[i], NULL);
-        }
+        tb_flush_jmp_cache_all(cpu);
     }
 
     tcg_ctx.tb_ctx.nb_tbs = 0;
@@ -1732,6 +1728,15 @@ void tb_check_watchpoint(CPUState *cpu)
     }
 }
 
+void tb_flush_jmp_cache_all(CPUState *cpu)
+{
+    int i;
+
+    for (i = 0; i < TB_JMP_CACHE_SIZE; ++i) {
+        atomic_set(&cpu->tb_jmp_cache[i], NULL);
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 /* in deterministic execution mode, instructions doing device I/Os
  * must be at the end of the TB.
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 724ec73..b0281b0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -366,6 +366,12 @@ struct TranslationBlock {
 };
 
 void tb_free(TranslationBlock *tb);
+/**
+ * tb_flush_jmp_cache_all:
+ *
+ * Flush the virtual translation block cache.
+ */
+void tb_flush_jmp_cache_all(CPUState *env);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
-- 
2.7.4
