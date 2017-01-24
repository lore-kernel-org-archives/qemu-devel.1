Received: from eggs.gnu.org ([2001:4830:134:3::10]:58805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVykY-0004pg-BY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVykU-0006Sk-Dr
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:54 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:22 +0300
Message-Id: <d4628acb08ae6852c23605736d61649df6ef20d2.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 18/31] lm32: milkymist-tmu2: fix another integer
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

Don't truncate the multiplication and do a 64 bit one instead
because the result is stored in a 64 bit variable.

This fixes a similar coverity warning to commit 237a8650d640,
in a similar way, and is the other half of the fix for
coverity CID 1167561.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Michael Walle <michael@walle.cc>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.1.4
