Received: from eggs.gnu.org ([209.51.188.92]:34413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qay-0004H6-AV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007WY-7E
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:34601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007V1-TP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:56 +0100
Message-Id: <20190311191602.25796-6-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/11] target/hppa: remove PSW I/R/Q bit check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

HP ODE use rfi to set the Q bit, and i don't see anything in the
documentation that this is forbidden. So remove it.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/op_helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a05681d480..a55a5dfc02 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -678,11 +678,6 @@ target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
 
 void HELPER(rfi)(CPUHPPAState *env)
 {
-    /* ??? On second reading this condition simply seems
-       to be undefined rather than a diagnosed trap.  */
-    if (env->psw & (PSW_I | PSW_R | PSW_Q)) {
-        helper_excp(env, EXCP_ILL);
-    }
     env->iasq_f = (uint64_t)env->cr[CR_IIASQ] << 32;
     env->iasq_b = (uint64_t)env->cr_back[0] << 32;
     env->iaoq_f = env->cr[CR_IIAOQ];
-- 
2.20.1
