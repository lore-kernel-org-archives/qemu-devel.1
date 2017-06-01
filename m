Received: from eggs.gnu.org ([2001:4830:134:3::10]:35246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcZ-00017F-B8
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcY-0006Bx-0V
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcX-0006AO-Oh
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:49 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcL-0007NZ-NO
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:10 +0100
Message-Id: <1496337035-30213-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/27] load_uboot_image: don't assume a full
 header read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Don't allow load_uboot_image() to proceed when less bytes than
header-size was read.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20170524091315.20284-1-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index bf17b42..f72930c 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -611,8 +611,9 @@ static int load_uboot_image(const char *filename, hwaddr *ep, hwaddr *loadaddr,
         return -1;
 
     size = read(fd, hdr, sizeof(uboot_image_header_t));
-    if (size < 0)
+    if (size < sizeof(uboot_image_header_t)) {
         goto out;
+    }
 
     bswap_uboot_header(hdr);
 
-- 
2.7.4
