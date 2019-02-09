Received: from eggs.gnu.org ([209.51.188.92]:42600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJUd-0007T7-62
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJUc-0000l3-Hl
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:51 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJUZ-0000XT-A0
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:49 -0500
Received: by mail-pg1-x52d.google.com with SMTP id z10so2416782pgp.7
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:39:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:47 -0800
Message-Id: <20190209033847.9014-13-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 12/12] target/arm: Add missing clear_tail
 calls
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

Fortunately, the functions affected are so far only called from SVE,
so there is no tail to be cleared.  But as we convert more of AdvSIMD
to gvec, this will matter.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vec_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 10f17e4b5c..dfc635cf9a 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -638,6 +638,7 @@ void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)  \
     for (i = 0; i < oprsz / sizeof(TYPE); i++) {                  \
         d[i] = FUNC(n[i], stat);                                  \
     }                                                             \
+    clear_tail(d, oprsz, simd_maxsz(desc));                       \
 }
 
 DO_2OP(gvec_frecpe_h, helper_recpe_f16, float16)
@@ -688,6 +689,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
     for (i = 0; i < oprsz / sizeof(TYPE); i++) {                           \
         d[i] = FUNC(n[i], m[i], stat);                                     \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_3OP(gvec_fadd_h, float16_add, float16)
-- 
2.17.2
