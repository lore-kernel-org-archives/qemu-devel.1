Received: from eggs.gnu.org ([2001:4830:134:3::10]:45274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxoU-0001g2-En
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxoQ-0005j1-G8
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:54:54 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:29 +0300
Message-Id: <05a23aeae1dc56b7f26c1a348fd6d31790f6baa6.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 25/31] hw/display/framebuffer.c: Avoid overflow
 for framebuffers > 4GB
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

Coverity points out that calculating src_len by multiplying
src_width by rows could overflow. This can only happen in
the implausible case of a framebuffer larger than 4GB, but
we may as well fix it, placating Coverity. (CID1005515)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/display/framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/framebuffer.c b/hw/display/framebuffer.c
index df51358..25aa46c 100644
--- a/hw/display/framebuffer.c
+++ b/hw/display/framebuffer.c
@@ -78,7 +78,7 @@ void framebuffer_update_display(
 
     i = *first_row;
     *first_row = -1;
-    src_len = src_width * rows;
+    src_len = (hwaddr)src_width * rows;
 
     mem = mem_section->mr;
     if (!mem) {
-- 
2.1.4
