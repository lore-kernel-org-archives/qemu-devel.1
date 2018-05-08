Received: from eggs.gnu.org ([2001:4830:134:3::10]:59547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KJ-0006eD-CA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KF-0008AY-HD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:51 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fG4KF-00089z-Af
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:47 -0400
Received: by mail-pf0-x244.google.com with SMTP id f20so15325092pfn.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:14:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  8 May 2018 08:14:32 -0700
Message-Id: <20180508151437.4232-6-richard.henderson@linaro.org>
In-Reply-To: <20180508151437.4232-1-richard.henderson@linaro.org>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 05/10] tcg: Use GEN_ATOMIC_HELPER_FN for
 opposite endian atomic add
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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h | 49 ++++++-------------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 2489dd3ec1..3f41ef2782 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -229,48 +229,6 @@ GEN_ATOMIC_HELPER(xor_fetch)
 
 #undef GEN_ATOMIC_HELPER
 
-/* Note that for addition, we need to use a separate cmpxchg loop instead
-   of bswaps for the reverse-host-endian helpers.  */
-ABI_TYPE ATOMIC_NAME(fetch_add)(CPUArchState *env, target_ulong addr,
-                         ABI_TYPE val EXTRA_ARGS)
-{
-    ATOMIC_MMU_DECLS;
-    DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    DATA_TYPE ldo, ldn, ret, sto;
-
-    ldo = atomic_read__nocheck(haddr);
-    while (1) {
-        ret = BSWAP(ldo);
-        sto = BSWAP(ret + val);
-        ldn = atomic_cmpxchg__nocheck(haddr, ldo, sto);
-        if (ldn == ldo) {
-            ATOMIC_MMU_CLEANUP;
-            return ret;
-        }
-        ldo = ldn;
-    }
-}
-
-ABI_TYPE ATOMIC_NAME(add_fetch)(CPUArchState *env, target_ulong addr,
-                         ABI_TYPE val EXTRA_ARGS)
-{
-    ATOMIC_MMU_DECLS;
-    DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    DATA_TYPE ldo, ldn, ret, sto;
-
-    ldo = atomic_read__nocheck(haddr);
-    while (1) {
-        ret = BSWAP(ldo) + val;
-        sto = BSWAP(ret);
-        ldn = atomic_cmpxchg__nocheck(haddr, ldo, sto);
-        if (ldn == ldo) {
-            ATOMIC_MMU_CLEANUP;
-            return ret;
-        }
-        ldo = ldn;
-    }
-}
-
 /* These helpers are, as a whole, full barriers.  Within the helper,
  * the leading barrier is explicit and the trailing barrier is within
  * cmpxchg primitive.
@@ -302,6 +260,13 @@ GEN_ATOMIC_HELPER_FN(umin_fetch, MIN,  DATA_TYPE, new)
 GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
 GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 
+/* Note that for addition, we need to use a separate cmpxchg loop instead
+   of bswaps for the reverse-host-endian helpers.  */
+#define ADD(X, Y)   (X + Y)
+GEN_ATOMIC_HELPER_FN(fetch_add, ADD, DATA_TYPE, old)
+GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
+#undef ADD
+
 #undef GEN_ATOMIC_HELPER_FN
 #endif /* DATA_SIZE >= 16 */
 
-- 
2.17.0
