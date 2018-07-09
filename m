Received: from eggs.gnu.org ([2001:4830:134:3::10]:48194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcl-0007gG-Nc
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcl-00052u-1A
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWck-00052E-Qk
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:42 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcj-0000jd-R4
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:31 +0100
Message-Id: <20180709135435.836-8-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/11] tcg: Restrict check_size_impl to
 multiples of the line size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Normally this is automatic in the size restrictions that are placed
on vector sizes coming from the implementation.  However, for the
legitimate size tuple [oprsz=8, maxsz=32], we need to clear the final
24 bytes of the vector register.  Without this check, do_dup selects
TCG_TYPE_V128 and clears only 16 bytes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180705191929.30773-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/tcg-op-gvec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 22db1590d5d..61c25f57841 100644
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
