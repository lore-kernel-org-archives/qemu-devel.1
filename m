Received: from eggs.gnu.org ([2001:4830:134:3::10]:51580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dXVKf-0000Wc-Dt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dXVKe-00011c-NP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:26:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 17:26:34 +0100
Message-Id: <1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10 4/4] bsd-user/main.c: Fix unused
 variable warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

On OpenBSD the compiler warns:
bsd-user/main.c:622:21: warning: variable 'sig' set but not used [-Wunused-but-set-variable]

This is because a lot of the signal delivery code is #if-0'd
out as unused. Reshuffle #ifdefs a bit to silence the warning.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index fa9c012..501e16f 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -619,9 +619,10 @@ void cpu_loop(CPUSPARCState *env)
             break;
         case EXCP_DEBUG:
             {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
+#if 0
+                int sig =
+#endif
+                gdb_handlesig(cs, TARGET_SIGTRAP);
 #if 0
                 if (sig)
                   {
-- 
2.7.4
