Received: from eggs.gnu.org ([209.51.188.92]:48704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1gtxkP-0004tB-5U
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1gtxkN-0003P5-9u
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:50:57 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:58684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1gtxkL-0003Es-VS
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:50:55 -0500
From: Sandra Loosemore <sandra@codesourcery.com>
Date: Wed, 13 Feb 2019 09:50:26 -0700
Message-ID: <1550076626-7202-1-git-send-email-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Fix breakpoint support in Nios II user-mode
 emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu

Nios II user-mode emulation was missing handling for EXCP_DEBUG,
making the gdb stub essentially useless.  This patch adds the missing
piece.  The new code was copied from the existing EXCP_TRAP handling
and is also similar to what other targets (e.g., arm) do with EXCP_DEBUG.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
---
 linux-user/nios2/cpu_loop.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index b96b1aa..5aa1eca 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -73,6 +73,12 @@ void cpu_loop(CPUNios2State *env)
                 queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
                 break;
             }
+        case EXCP_DEBUG:
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case 0xaa:
             switch (env->regs[R_PC]) {
             /*case 0x1000:*/  /* TODO:__kuser_helper_version */
-- 
2.8.1
