Received: from eggs.gnu.org ([2001:4830:134:3::10]:49847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQd4R-0001kd-7u
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQd4L-0006BA-Qo
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:45:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 16:45:09 +0000
Message-Id: <1483980309-30821-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/display/framebuffer.c: Avoid overflow for
 framebuffers > 4GB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Coverity points out that calculating src_len by multiplying
src_width by rows could overflow. This can only happen in
the implausible case of a framebuffer larger than 4GB, but
we may as well fix it, placating Coverity. (CID1005515)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
