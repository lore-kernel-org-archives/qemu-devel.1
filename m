Received: from eggs.gnu.org ([2001:4830:134:3::10]:40847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0fam-0004XZ-0T
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0fai-0001Kq-UB
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:48:12 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f0fai-0001KX-NT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:48:08 -0400
Received: by mail-pg0-x243.google.com with SMTP id g8so8099762pgv.7
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 20:48:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Mar 2018 11:47:57 +0800
Message-Id: <20180327034757.3432-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12] tcg: Mark muluh_i64 and mulsh_i64 as
 64-bit ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mjc@sifive.com, patches@groups.riscv.org

Failure to do so results in the tcg optimizer sign-extending
any constant fold from 32-bits.  This turns out to be visible
in the RISC-V testsuite using a host that emits these opcodes
(e.g. any non-x86_64).

Reported-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-opc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index d81a6c4535..e3a43aabb6 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -182,8 +182,8 @@ DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
 DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
 DEF(mulu2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulu2_i64))
 DEF(muls2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muls2_i64))
-DEF(muluh_i64, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh_i64))
-DEF(mulsh_i64, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh_i64))
+DEF(muluh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muluh_i64))
+DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
 
 #define TLADDR_ARGS  (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? 1 : 2)
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
-- 
2.14.3
