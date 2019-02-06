Received: from eggs.gnu.org ([209.51.188.92]:45423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKpx-0003mL-OY
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKpx-00009E-1u
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grKpw-00007I-Rq
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id v16so5134663wrn.11
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 02:53:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 10:53:37 +0000
Message-Id: <20190206105337.11559-4-richard.henderson@linaro.org>
In-Reply-To: <20190206105337.11559-1-richard.henderson@linaro.org>
References: <20190206105337.11559-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 3/3] target/hppa: fix PSW Q bit behaviour to
 match hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

PA-RISC specification says: "Setting the PSW Q-bit, PSW{28}, to 1
with this instruction, if it was not already 1, is an undefined
operation." However, at least HP-UX 10.20 sets the Q bit from 0 to 1
with the SSM instruction. Tested this both on HP9000/712 and
HP9000/785/C3750, both machines set the Q bit from 0 to 1 without
exception. This makes HP-UX 10.20 progress a little bit further.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190129191402.29539-1-svens@stackframe.org>
[rth: Add a comment to the code as well.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 912e8d5be4..6bf478e7b0 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -665,11 +665,15 @@ void HELPER(reset)(CPUHPPAState *env)
 target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
 {
     target_ulong psw = env->psw;
-    /* ??? On second reading this condition simply seems
-       to be undefined rather than a diagnosed trap.  */
-    if (nsm & ~psw & PSW_Q) {
-        hppa_dynamic_excp(env, EXCP_ILL, GETPC());
-    }
+    /*
+     * Setting the PSW Q bit to 1, if it was not already 1, is an
+     * undefined operation.
+     *
+     * However, HP-UX 10.20 does this with the SSM instruction.
+     * Tested this on HP9000/712 and HP9000/785/C3750 and both
+     * machines set the Q bit from 0 to 1 without an exception,
+     * so let this go without comment.
+     */
     env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
     return psw & PSW_SM;
 }
-- 
2.17.2
