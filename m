Received: from eggs.gnu.org ([209.51.188.92]:43100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grEvz-0001TR-Sm
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grEvy-0007Tl-Ru
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grEvx-0007Mu-PZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:38 -0500
Received: by mail-wm1-x334.google.com with SMTP id d15so1064307wmb.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 20:35:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 04:35:16 +0000
Message-Id: <20190206043516.11462-3-richard.henderson@linaro.org>
In-Reply-To: <20190206043516.11462-1-richard.henderson@linaro.org>
References: <20190206043516.11462-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/2] accel/tcg: Consider cluster index in
 tb_lookup__cpu_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Peter Maydell <peter.maydell@linaro.org>

In commit f7b78602fdc6c6e4be we added the CPU cluster number to the
cflags field of the TB hash; this included adding it to the value
kept in tb->cflags, since we pass that field directly into the hash
calculation in some places. Unfortunately we forgot to check whether
other parts of the code were doing comparisons against tb->cflags
that would need to be updated.

It turns out that there is exactly one such place: the
tb_lookup__cpu_state() function checks whether the TB it has
found in the tb_jmp_cache has a tb->cflags matching the cf_mask
that is passed in. The tb->cflags has the cluster_index in it
but the cf_mask does not.

Hoist the "add cluster index to the cf_mask" code up from
tb_htable_lookup() to tb_lookup__cpu_state() so it can be considered
in the "did this TB match in the jmp cache" condition, as well as
when we do the full hash lookup by physical PC, flags, etc.
(tb_htable_lookup() is only called from tb_lookup__cpu_state(),
so this change doesn't require any further knock-on changes.)

Fixes: f7b78602fdc6c6e4be ("accel/tcg: Add cluster number to TCG TB hash")
Tested-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Reported-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190205151810.571-1-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tb-lookup.h | 4 ++++
 accel/tcg/cpu-exec.c     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 492cb68289..26921b6daf 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -28,6 +28,10 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, target_ulong *cs_base,
     cpu_get_tb_cpu_state(env, pc, cs_base, flags);
     hash = tb_jmp_cache_hash_func(*pc);
     tb = atomic_rcu_read(&cpu->tb_jmp_cache[hash]);
+
+    cf_mask &= ~CF_CLUSTER_MASK;
+    cf_mask |= cpu->cluster_index << CF_CLUSTER_SHIFT;
+
     if (likely(tb &&
                tb->pc == *pc &&
                tb->cs_base == *cs_base &&
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 7cf1292546..60d87d5a19 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -325,9 +325,6 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     struct tb_desc desc;
     uint32_t h;
 
-    cf_mask &= ~CF_CLUSTER_MASK;
-    cf_mask |= cpu->cluster_index << CF_CLUSTER_SHIFT;
-
     desc.env = (CPUArchState *)cpu->env_ptr;
     desc.cs_base = cs_base;
     desc.flags = flags;
-- 
2.17.2
