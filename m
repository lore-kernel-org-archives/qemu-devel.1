Received: from eggs.gnu.org ([2001:4830:134:3::10]:33771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIg-0008Fp-4P
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIf-0000ji-2Z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:48 -0400
Message-Id: <1493106839-10438-3-git-send-email-cota@braap.org>
In-Reply-To: <1493106839-10438-1-git-send-email-cota@braap.org>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 02/13] exec-all: inline tb_from_jmp_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

The inline improves performance, as shown in upcoming commits' logs.

This commit is kept separate to ease review, since the inclusion
of tb-hash.h might be controversial. The problem here, which was
introduced before this commit, is that tb_hash_func() depends on
page_addr_t: this defeats the original purpose of tb-hash.h,
which was to be self-contained and CPU-agnostic.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpu-exec.c              | 19 -------------------
 include/exec/exec-all.h | 24 +++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index b4adf16..63a56d0 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -309,25 +309,6 @@ static bool tb_cmp(const void *p, const void *d)
     return false;
 }
 
-TranslationBlock *tb_from_jmp_cache(CPUArchState *env, target_ulong vaddr)
-{
-    CPUState *cpu = ENV_GET_CPU(env);
-    TranslationBlock *tb;
-    target_ulong cs_base, pc;
-    uint32_t flags;
-
-    if (unlikely(atomic_read(&cpu->exit_request))) {
-        return NULL;
-    }
-    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(vaddr)]);
-    if (likely(tb && tb->pc == vaddr && tb->cs_base == cs_base &&
-               tb->flags == flags)) {
-        return tb;
-    }
-    return NULL;
-}
-
 static TranslationBlock *tb_htable_lookup(CPUState *cpu,
                                           target_ulong pc,
                                           target_ulong cs_base,
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 18b80bc..bd76987 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -367,7 +367,29 @@ struct TranslationBlock {
 void tb_free(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
-TranslationBlock *tb_from_jmp_cache(CPUArchState *env, target_ulong vaddr);
+
+/* tb_hash_func() in tb-hash.h needs tb_page_addr_t, defined above */
+#include "tb-hash.h"
+
+static inline
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
 
 #if defined(USE_DIRECT_JUMP)
 
-- 
2.7.4
