Received: from eggs.gnu.org ([2001:4830:134:3::10]:42892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etx1B-0008O1-LB
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etx1A-0005Te-Rt
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:59:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1etx1A-0005QS-Ky
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:59:40 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  8 Mar 2018 14:47:33 +0000
Message-Id: <20180308144733.25615-3-peter.maydell@linaro.org>
In-Reply-To: <20180308144733.25615-1-peter.maydell@linaro.org>
References: <20180308144733.25615-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: Remove the unused "not
 implemented" signal handling stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Now we've dropped unicore32, all of the architectures we support
for linux-user implement the signal handling routines. The
dummy "just print a message" versions are unimplemented, so we
can drop them entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
IMHO signal handling support is too important to allow a
hypothetical new architecture target to silently get away
without implementing it. For initial development it's easy
enough to stub out the per-architecture functions, and then
we will have a clear view of which targets (if any) don't
have the signal handling implemented yet, and the missing
feature will show up in code review.
---
 linux-user/signal.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index bd85dcde17..1f7b5e398e 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -6572,32 +6572,7 @@ long do_rt_sigreturn(CPUArchState *env)
 }
 
 #else
-
-static void setup_frame(int sig, struct target_sigaction *ka,
-                        target_sigset_t *set, CPUArchState *env)
-{
-    fprintf(stderr, "setup_frame: not implemented\n");
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUArchState *env)
-{
-    fprintf(stderr, "setup_rt_frame: not implemented\n");
-}
-
-long do_sigreturn(CPUArchState *env)
-{
-    fprintf(stderr, "do_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
-long do_rt_sigreturn(CPUArchState *env)
-{
-    fprintf(stderr, "do_rt_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
+#error Target needs to add support for signal handling
 #endif
 
 static void handle_pending_signal(CPUArchState *cpu_env, int sig,
-- 
2.16.2
