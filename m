Received: from eggs.gnu.org ([2001:4830:134:3::10]:40468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f1341-0006kb-Ul
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f1340-0007bk-TA
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:51:58 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f1340-0007bU-OC
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:51:56 -0400
Received: by mail-ot0-x241.google.com with SMTP id i28-v6so1282953otf.8
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 21:51:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Mar 2018 12:51:40 +0800
Message-Id: <20180328045140.16462-2-richard.henderson@linaro.org>
In-Reply-To: <20180328045140.16462-1-richard.henderson@linaro.org>
References: <20180328045140.16462-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/1] tcg: Mark muluh_i64 and mulsh_i64 as 64-bit
 ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, peter.maydell@linaro.org

Failure to do so results in the tcg optimizer sign-extending
any constant fold from 32-bits.  This turns out to be visible
in the RISC-V testsuite using a host that emits these opcodes
(e.g. any non-x86_64).

Reported-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
