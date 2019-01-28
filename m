Received: from eggs.gnu.org ([209.51.188.92]:41176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNd-00039G-GL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNc-0000Xg-6W
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNb-0000RK-V0
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id n190so15061143wmd.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:46 +0000
Message-Id: <20190128181047.20781-26-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/26] accel/tcg: Add cluster number to TCG TB
 hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Include the cluster number in the hash we use to look
up TBs. This is important because a TB that is valid
for one cluster at a given physical address and set
of CPU flags is not necessarily valid for another:
the two clusters may have different views of physical
memory, or may have different CPU features (eg FPU
present or absent).

We put the cluster number in the high 8 bits of the
TB cflags. This gives us up to 256 clusters, which should
be enough for anybody. If we ever need more, or need
more bits in cflags for other purposes, we could make
tb_hash_func() take more data (and expand qemu_xxhash7()
to qemu_xxhash8()).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20190121152218.9592-4-peter.maydell@linaro.org
---
 include/exec/exec-all.h   | 4 +++-
 accel/tcg/cpu-exec.c      | 3 +++
 accel/tcg/translate-all.c | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 815e5b1e838..aa7b81aaf01 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -351,9 +351,11 @@ struct TranslationBlock {
 #define CF_USE_ICOUNT  0x00020000
 #define CF_INVALID     0x00040000 /* TB is stale. Set with @jmp_lock held */
 #define CF_PARALLEL    0x00080000 /* Generate code for a parallel context */
+#define CF_CLUSTER_MASK 0xff000000 /* Top 8 bits are cluster ID */
+#define CF_CLUSTER_SHIFT 24
 /* cflags' mask for hashing/comparison */
 #define CF_HASH_MASK   \
-    (CF_COUNT_MASK | CF_LAST_IO | CF_USE_ICOUNT | CF_PARALLEL)
+    (CF_COUNT_MASK | CF_LAST_IO | CF_USE_ICOUNT | CF_PARALLEL | CF_CLUSTER_MASK)
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 870027d4359..6c4a33262f5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -325,6 +325,9 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     struct tb_desc desc;
     uint32_t h;
 
+    cf_mask &= ~CF_CLUSTER_MASK;
+    cf_mask |= cpu->cluster_index << CF_CLUSTER_SHIFT;
+
     desc.env = (CPUArchState *)cpu->env_ptr;
     desc.cs_base = cs_base;
     desc.flags = flags;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8cb8c8870e6..7364e8a071f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1688,6 +1688,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         cflags |= CF_NOCACHE | 1;
     }
 
+    cflags &= ~CF_CLUSTER_MASK;
+    cflags |= cpu->cluster_index << CF_CLUSTER_SHIFT;
+
  buffer_overflow:
     tb = tb_alloc(pc);
     if (unlikely(!tb)) {
-- 
2.20.1
