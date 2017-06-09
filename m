Received: from eggs.gnu.org ([2001:4830:134:3::10]:51677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9cC-0000Y2-4B
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9c8-000695-T9
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJ9c8-00068K-DL
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  8 Jun 2017 22:25:16 -0400
Message-Id: <1496975122-16999-2-git-send-email-cota@braap.org>
In-Reply-To: <1496975122-16999-1-git-send-email-cota@braap.org>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 1/7] exec: [tcg] Refactor flush of per-CPU
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
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

The function is reused in later patches.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cputlb.c                |  2 +-
 include/exec/exec-all.h |  6 ++++++
 translate-all.c         | 15 ++++++++++-----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 743776a..6a2b762 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -118,7 +118,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
 
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
-    memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
+    tb_flush_jmp_cache_all(cpu);
 
     env->vtlb_index = 0;
     env->tlb_flush_addr = -1;
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
diff --git a/translate-all.c b/translate-all.c
index 966747a..8a5dc19 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -931,11 +931,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
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
@@ -1733,6 +1729,15 @@ void tb_check_watchpoint(CPUState *cpu)
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
-- 
2.7.4
