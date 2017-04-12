Received: from eggs.gnu.org ([2001:4830:134:3::10]:41194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6ux-00082L-Lk
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uw-0006Qj-Qb
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:21 -0400
Message-Id: <1491959850-30756-2-git-send-email-cota@braap.org>
In-Reply-To: <1491959850-30756-1-git-send-email-cota@braap.org>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 01/10] exec-all: add tb_from_jmp_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

This paves the way for upcoming changes.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpu-exec.c              | 19 +++++++++++++++++++
 include/exec/exec-all.h |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 748cb66..ce9750a 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -309,6 +309,25 @@ static bool tb_cmp(const void *p, const void *d)
     return false;
 }
 
+TranslationBlock *tb_from_jmp_cache(CPUArchState *env, target_ulong vaddr)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+    TranslationBlock *tb;
+    target_ulong cs_base, pc;
+    uint32_t flags;
+
+    if (unlikely(atomic_read(&cpu->exit_request))) {
+        return NULL;
+    }
+    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(vaddr)]);
+    if (likely(tb && tb->pc == vaddr && tb->cs_base == cs_base &&
+               tb->flags == flags)) {
+        return tb;
+    }
+    return NULL;
+}
+
 static TranslationBlock *tb_htable_lookup(CPUState *cpu,
                                           target_ulong pc,
                                           target_ulong cs_base,
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bcde1e6..18b80bc 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -56,7 +56,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                               target_ulong pc, target_ulong cs_base,
                               uint32_t flags,
                               int cflags);
-
 void QEMU_NORETURN cpu_loop_exit(CPUState *cpu);
 void QEMU_NORETURN cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 void QEMU_NORETURN cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
@@ -368,6 +367,7 @@ struct TranslationBlock {
 void tb_free(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
+TranslationBlock *tb_from_jmp_cache(CPUArchState *env, target_ulong vaddr);
 
 #if defined(USE_DIRECT_JUMP)
 
-- 
2.7.4
