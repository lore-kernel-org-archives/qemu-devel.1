Received: from eggs.gnu.org ([2001:4830:134:3::10]:41195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb9my-0001D5-Hx
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb9mw-0004AC-NU
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:36 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fb9mw-00049e-IH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:34 -0400
Received: by mail-pl0-x244.google.com with SMTP id z9-v6so1690254plo.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 12:19:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  5 Jul 2018 12:19:28 -0700
Message-Id: <20180705191929.30773-2-richard.henderson@linaro.org>
In-Reply-To: <20180705191929.30773-1-richard.henderson@linaro.org>
References: <20180705191929.30773-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] tcg: Restrict check_size_impl to multiples
 of the line size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Normally this is automatic in the size restrictions that are placed
on vector sizes coming from the implementation.  However, for the
legitimate size tuple [oprsz=8, maxsz=32], we need to clear the final
24 bytes of the vector register.  Without this check, do_dup selects
TCG_TYPE_V128 and clears only 16 bytes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 22db1590d5..61c25f5784 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -287,8 +287,11 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
    in units of LNSZ.  This limits the expansion of inline code.  */
 static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
 {
-    uint32_t lnct = oprsz / lnsz;
-    return lnct >= 1 && lnct <= MAX_UNROLL;
+    if (oprsz % lnsz == 0) {
+        uint32_t lnct = oprsz / lnsz;
+        return lnct >= 1 && lnct <= MAX_UNROLL;
+    }
+    return false;
 }
 
 static void expand_clr(uint32_t dofs, uint32_t maxsz);
-- 
2.17.1
