Received: from eggs.gnu.org ([209.51.188.92]:46020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBJhR-0007Ml-8h
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBJhO-0006zO-O3
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33687 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hBJhO-0006wg-50
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:34 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue,  2 Apr 2019 15:43:22 +0200
Message-Id: <1554212605-16457-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 2/5] target/mips: Fix MSA instructions
 ST.<B|H|W|D> on big endian host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Fix the case when the host is a big endian machine, and change
the approach toward ST.<B|H|W|D> instruction helpers.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/op_helper.c | 188 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 168 insertions(+), 20 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 45be406..d94909a 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -4565,31 +4565,179 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
 #endif
 }
 
-#define MSA_ST_DF(DF, TYPE, ST_INSN, ...)                               \
-void helper_msa_st_ ## TYPE(CPUMIPSState *env, uint32_t wd,             \
-                            target_ulong addr)                          \
-{                                                                       \
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
-    int mmu_idx = cpu_mmu_index(env, false);				\
-    int i;                                                              \
-    MEMOP_IDX(DF)                                                       \
-    ensure_writable_pages(env, addr, mmu_idx, GETPC());                 \
-    for (i = 0; i < DF_ELEMENTS(DF); i++) {                             \
-        ST_INSN(env, addr + (i << DF), pwd->TYPE[i], ##__VA_ARGS__);    \
-    }                                                                   \
+void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
+                     target_ulong addr)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    MEMOP_IDX(DF_BYTE)
+#if !defined(CONFIG_USER_ONLY)
+#if !defined(HOST_WORDS_BIGENDIAN)
+    helper_ret_stb_mmu(env, addr + (0  << DF_BYTE), pwd->b[0],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (1  << DF_BYTE), pwd->b[1],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (2  << DF_BYTE), pwd->b[2],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (3  << DF_BYTE), pwd->b[3],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (4  << DF_BYTE), pwd->b[4],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (5  << DF_BYTE), pwd->b[5],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (6  << DF_BYTE), pwd->b[6],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (7  << DF_BYTE), pwd->b[7],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (8  << DF_BYTE), pwd->b[8],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (9  << DF_BYTE), pwd->b[9],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (10 << DF_BYTE), pwd->b[10], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (11 << DF_BYTE), pwd->b[11], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (12 << DF_BYTE), pwd->b[12], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (13 << DF_BYTE), pwd->b[13], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (14 << DF_BYTE), pwd->b[14], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (15 << DF_BYTE), pwd->b[15], oi, GETPC());
+#else
+    helper_ret_stb_mmu(env, addr + (7  << DF_BYTE), pwd->b[0],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (6  << DF_BYTE), pwd->b[1],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (5  << DF_BYTE), pwd->b[2],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (4  << DF_BYTE), pwd->b[3],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (3  << DF_BYTE), pwd->b[4],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (2  << DF_BYTE), pwd->b[5],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (1  << DF_BYTE), pwd->b[6],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (0  << DF_BYTE), pwd->b[7],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (15 << DF_BYTE), pwd->b[8],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (14 << DF_BYTE), pwd->b[9],  oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (13 << DF_BYTE), pwd->b[10], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (12 << DF_BYTE), pwd->b[11], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (11 << DF_BYTE), pwd->b[12], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (10 << DF_BYTE), pwd->b[13], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (9  << DF_BYTE), pwd->b[14], oi, GETPC());
+    helper_ret_stb_mmu(env, addr + (8  << DF_BYTE), pwd->b[15], oi, GETPC());
+#endif
+#else
+#if !defined(HOST_WORDS_BIGENDIAN)
+    cpu_stb_data(env, addr + (0  << DF_BYTE), pwd->b[0]);
+    cpu_stb_data(env, addr + (1  << DF_BYTE), pwd->b[1]);
+    cpu_stb_data(env, addr + (2  << DF_BYTE), pwd->b[2]);
+    cpu_stb_data(env, addr + (3  << DF_BYTE), pwd->b[3]);
+    cpu_stb_data(env, addr + (4  << DF_BYTE), pwd->b[4]);
+    cpu_stb_data(env, addr + (5  << DF_BYTE), pwd->b[5]);
+    cpu_stb_data(env, addr + (6  << DF_BYTE), pwd->b[6]);
+    cpu_stb_data(env, addr + (7  << DF_BYTE), pwd->b[7]);
+    cpu_stb_data(env, addr + (8  << DF_BYTE), pwd->b[8]);
+    cpu_stb_data(env, addr + (9  << DF_BYTE), pwd->b[9]);
+    cpu_stb_data(env, addr + (10 << DF_BYTE), pwd->b[10]);
+    cpu_stb_data(env, addr + (11 << DF_BYTE), pwd->b[11]);
+    cpu_stb_data(env, addr + (12 << DF_BYTE), pwd->b[12]);
+    cpu_stb_data(env, addr + (13 << DF_BYTE), pwd->b[13]);
+    cpu_stb_data(env, addr + (14 << DF_BYTE), pwd->b[14]);
+    cpu_stb_data(env, addr + (15 << DF_BYTE), pwd->b[15]);
+#else
+    cpu_stb_data(env, addr + (7  << DF_BYTE), pwd->b[0]);
+    cpu_stb_data(env, addr + (6  << DF_BYTE), pwd->b[1]);
+    cpu_stb_data(env, addr + (5  << DF_BYTE), pwd->b[2]);
+    cpu_stb_data(env, addr + (4  << DF_BYTE), pwd->b[3]);
+    cpu_stb_data(env, addr + (3  << DF_BYTE), pwd->b[4]);
+    cpu_stb_data(env, addr + (2  << DF_BYTE), pwd->b[5]);
+    cpu_stb_data(env, addr + (1  << DF_BYTE), pwd->b[6]);
+    cpu_stb_data(env, addr + (0  << DF_BYTE), pwd->b[7]);
+    cpu_stb_data(env, addr + (15 << DF_BYTE), pwd->b[8]);
+    cpu_stb_data(env, addr + (14 << DF_BYTE), pwd->b[9]);
+    cpu_stb_data(env, addr + (13 << DF_BYTE), pwd->b[10]);
+    cpu_stb_data(env, addr + (12 << DF_BYTE), pwd->b[11]);
+    cpu_stb_data(env, addr + (11 << DF_BYTE), pwd->b[12]);
+    cpu_stb_data(env, addr + (10 << DF_BYTE), pwd->b[13]);
+    cpu_stb_data(env, addr + (9  << DF_BYTE), pwd->b[14]);
+    cpu_stb_data(env, addr + (8  << DF_BYTE), pwd->b[15]);
+#endif
+#endif
+}
+
+void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
+                     target_ulong addr)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    MEMOP_IDX(DF_HALF)
+#if !defined(CONFIG_USER_ONLY)
+#if !defined(HOST_WORDS_BIGENDIAN)
+    helper_ret_stw_mmu(env, addr + (0 << DF_HALF), pwd->h[0], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (1 << DF_HALF), pwd->h[1], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (2 << DF_HALF), pwd->h[2], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (3 << DF_HALF), pwd->h[3], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (4 << DF_HALF), pwd->h[4], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (5 << DF_HALF), pwd->h[5], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (6 << DF_HALF), pwd->h[6], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (7 << DF_HALF), pwd->h[7], oi, GETPC());
+#else
+    helper_ret_stw_mmu(env, addr + (3 << DF_HALF), pwd->h[0], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (2 << DF_HALF), pwd->h[1], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (1 << DF_HALF), pwd->h[2], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (0 << DF_HALF), pwd->h[3], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (7 << DF_HALF), pwd->h[4], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (6 << DF_HALF), pwd->h[5], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (5 << DF_HALF), pwd->h[6], oi, GETPC());
+    helper_ret_stw_mmu(env, addr + (4 << DF_HALF), pwd->h[7], oi, GETPC());
+#endif
+#else
+#if !defined(HOST_WORDS_BIGENDIAN)
+    cpu_stw_data(env, addr + (0 << DF_HALF), pwd->h[0]);
+    cpu_stw_data(env, addr + (1 << DF_HALF), pwd->h[1]);
+    cpu_stw_data(env, addr + (2 << DF_HALF), pwd->h[2]);
+    cpu_stw_data(env, addr + (3 << DF_HALF), pwd->h[3]);
+    cpu_stw_data(env, addr + (4 << DF_HALF), pwd->h[4]);
+    cpu_stw_data(env, addr + (5 << DF_HALF), pwd->h[5]);
+    cpu_stw_data(env, addr + (6 << DF_HALF), pwd->h[6]);
+    cpu_stw_data(env, addr + (7 << DF_HALF), pwd->h[7]);
+#else
+    cpu_stw_data(env, addr + (3 << DF_HALF), pwd->h[0]);
+    cpu_stw_data(env, addr + (2 << DF_HALF), pwd->h[1]);
+    cpu_stw_data(env, addr + (1 << DF_HALF), pwd->h[2]);
+    cpu_stw_data(env, addr + (0 << DF_HALF), pwd->h[3]);
+    cpu_stw_data(env, addr + (7 << DF_HALF), pwd->h[4]);
+    cpu_stw_data(env, addr + (6 << DF_HALF), pwd->h[5]);
+    cpu_stw_data(env, addr + (5 << DF_HALF), pwd->h[6]);
+    cpu_stw_data(env, addr + (4 << DF_HALF), pwd->h[7]);
+#endif
+#endif
 }
 
+void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
+                     target_ulong addr)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    MEMOP_IDX(DF_WORD)
 #if !defined(CONFIG_USER_ONLY)
-MSA_ST_DF(DF_BYTE,   b, helper_ret_stb_mmu, oi, GETPC())
-MSA_ST_DF(DF_HALF,   h, helper_ret_stw_mmu, oi, GETPC())
-MSA_ST_DF(DF_WORD,   w, helper_ret_stl_mmu, oi, GETPC())
-MSA_ST_DF(DF_DOUBLE, d, helper_ret_stq_mmu, oi, GETPC())
+#if !defined(HOST_WORDS_BIGENDIAN)
+    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(), pwd->w[0]);
+    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(), pwd->w[1]);
+    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(), pwd->w[2]);
+    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(), pwd->w[3]);
 #else
-MSA_ST_DF(DF_BYTE,   b, cpu_stb_data)
-MSA_ST_DF(DF_HALF,   h, cpu_stw_data)
-MSA_ST_DF(DF_WORD,   w, cpu_stl_data)
-MSA_ST_DF(DF_DOUBLE, d, cpu_stq_data)
+    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(), pwd->w[0]);
+    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(), pwd->w[1]);
+    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(), pwd->w[2]);
+    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(), pwd->w[3]);
 #endif
+#else
+#if !defined(HOST_WORDS_BIGENDIAN)
+    cpu_stl_data(env, addr + (0 << DF_WORD), pwd->w[0]);
+    cpu_stl_data(env, addr + (1 << DF_WORD), pwd->w[1]);
+    cpu_stl_data(env, addr + (2 << DF_WORD), pwd->w[2]);
+    cpu_stl_data(env, addr + (3 << DF_WORD), pwd->w[3]);
+#else
+    cpu_stl_data(env, addr + (1 << DF_WORD), pwd->w[0]);
+    cpu_stl_data(env, addr + (0 << DF_WORD), pwd->w[1]);
+    cpu_stl_data(env, addr + (3 << DF_WORD), pwd->w[2]);
+    cpu_stl_data(env, addr + (2 << DF_WORD), pwd->w[3]);
+#endif
+#endif
+}
+
+void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
+                     target_ulong addr)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    MEMOP_IDX(DF_DOUBLE)
+#if !defined(CONFIG_USER_ONLY)
+    helper_ret_stq_mmu(env, addr + (0 << DF_DOUBLE), pwd->d[0], oi, GETPC());
+    helper_ret_stq_mmu(env, addr + (1 << DF_DOUBLE), pwd->d[1], oi, GETPC());
+#else
+    cpu_stq_data(env, addr + (0 << DF_DOUBLE), pwd->d[0]);
+    cpu_stq_data(env, addr + (1 << DF_DOUBLE), pwd->d[1]);
+#endif
+}
 
 void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
 {
-- 
2.7.4
