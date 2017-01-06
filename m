Received: from eggs.gnu.org ([2001:4830:134:3::10]:44415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cPYZw-0002Mi-UX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cPYZw-0002kn-9i
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:45:25 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cPYZw-0002fu-0V
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:45:24 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Jan 2017 17:45:14 +0000
Message-Id: <1483724714-5469-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] lm32: milkymist-tmu2: fix another integer
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Michael Walle <michael@walle.cc>

Don't truncate the multiplication and do a 64 bit one instead
because the result is stored in a 64 bit variable.

This fixes a similar coverity warning to commit 237a8650d640,
in a similar way, and is the other half of the fix for
coverity CID 1167561.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/milkymist-tmu2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 5c666f9..920374b 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -257,7 +257,7 @@ static void tmu2_start(MilkymistTMU2State *s)
     glColor4f(m, m, m, (float)(s->regs[R_ALPHA] + 1) / 64.0f);
 
     /* Read the QEMU dest. framebuffer into the OpenGL framebuffer */
-    fb_len = 2 * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
+    fb_len = 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
     fb = cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 0);
     if (fb == NULL) {
         glDeleteTextures(1, &texture);
-- 
2.7.4
