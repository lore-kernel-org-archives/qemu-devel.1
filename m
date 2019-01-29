Received: from eggs.gnu.org ([209.51.188.92]:54370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1goYqM-00045F-00
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1goYqL-00079R-5C
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:14:45 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:52218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1goYqK-00074c-MX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:14:45 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Tue, 29 Jan 2019 20:14:02 +0100
Message-Id: <20190129191402.29539-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/hppa: fix PSW Q bit behaviour to match
 hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

PA-RISC specification says: "Setting the PSW Q-bit, PSW{28}, to 1
with this instruction, if it was not already 1, is an undefined
operation." However, at least HP-UX 10.20 sets the Q bit from 0 to 1
with the SSM instruction. Tested this both on HP9000/712 and
HP9000/785/C3750, both machines set the Q bit from 0 to 1 without
exception. This makes HP-UX 10.20 progress a little bit further.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/op_helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 912e8d5be4..3adcfd8976 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -665,11 +665,6 @@ void HELPER(reset)(CPUHPPAState *env)
 target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
 {
     target_ulong psw = env->psw;
-    /* ??? On second reading this condition simply seems
-       to be undefined rather than a diagnosed trap.  */
-    if (nsm & ~psw & PSW_Q) {
-        hppa_dynamic_excp(env, EXCP_ILL, GETPC());
-    }
     env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
     return psw & PSW_SM;
 }
-- 
2.20.1
