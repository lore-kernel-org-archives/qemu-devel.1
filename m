Received: from eggs.gnu.org ([2001:4830:134:3::10]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1fzqEx-0007iQ-33
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1fzqEt-0006vg-QO
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:30:30 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1fzqEr-0006W8-3o
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:30:26 -0400
From: Sandra Loosemore <sandra@codesourcery.com>
Date: Tue, 11 Sep 2018 14:29:39 -0700
Message-ID: <1536701379-106032-1-git-send-email-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Fix breakpoints in nios2 user-mode emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, crwulff@gmail.com, marex@denx.de, Sandra Loosemore <sandra@codesourcery.com>

Without this patch, QEMU exits immediately when it execution stops at
a breakpoint, instead of reporting it to GDB.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
---
 linux-user/nios2/cpu_loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index dac7a06..a5ae37f 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -71,6 +71,9 @@ void cpu_loop(CPUNios2State *env)
                 gdbsig = TARGET_SIGTRAP;
                 break;
             }
+        case EXCP_DEBUG:
+            gdbsig = TARGET_SIGTRAP;
+            break;
         case 0xaa:
             switch (env->regs[R_PC]) {
             /*case 0x1000:*/  /* TODO:__kuser_helper_version */
-- 
2.8.1
