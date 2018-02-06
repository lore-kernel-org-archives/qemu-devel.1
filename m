Received: from eggs.gnu.org ([2001:4830:134:3::10]:49174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ej0fE-0001oL-DJ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ej0fD-0001CL-KF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:39:48 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Feb 2018 10:39:41 +0000
Message-Id: <20180206103941.13985-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm/translate.c: Fix missing 'break'
 for TT insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The code where we added the TT instruction was accidentally
missing a 'break', which meant that after generating the code
to execute the TT we would fall through to 'goto illegal_op'
and generate code to take an UNDEF insn.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Doh...

 target/arm/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 55826b7e5a..572c4d1cb6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9926,6 +9926,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         tcg_temp_free_i32(addr);
                         tcg_temp_free_i32(op);
                         store_reg(s, rd, ttresp);
+                        break;
                     }
                     goto illegal_op;
                 }
-- 
2.16.1
