Received: from eggs.gnu.org ([2001:4830:134:3::10]:46458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5y-0001Wz-7z
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5w-0007S2-Uy
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5w-00073I-LU
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5T-0003ly-Db
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 15:00:04 +0100
Message-Id: <20181008140004.12612-34-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/33] hw/display/bcm2835_fb: Silence Coverity
 warning about multiply overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Coverity complains (CID 1395628) that the multiply in the calculation
of the framebuffer base is performed as 32x32 but then used in a
context that takes a 64-bit hwaddr. This can't actually ever
overflow the 32-bit result, because of the constraints placed on
the s->config values in bcm2835_fb_validate_config(). But we
can placate Coverity anyway, by explicitly casting one of the
inputs to a hwaddr, so the whole expression is calculated with
64-bit arithmetic.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20181005133012.26490-1-peter.maydell@linaro.org
---
 hw/display/bcm2835_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index d534d00a65f..599863e4e17 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -190,7 +190,7 @@ static void fb_update_display(void *opaque)
     }
 
     if (s->invalidate) {
-        hwaddr base = s->config.base + xoff + yoff * src_width;
+        hwaddr base = s->config.base + xoff + (hwaddr)yoff * src_width;
         framebuffer_update_memory_section(&s->fbsection, s->dma_mr,
                                           base,
                                           s->config.yres, src_width);
-- 
2.19.0
