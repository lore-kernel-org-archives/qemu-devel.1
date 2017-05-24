Received: from eggs.gnu.org ([2001:4830:134:3::10]:49785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dDSM8-0002fx-HN
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dDSM5-0006KQ-9k
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1dDSM5-0006K1-3J
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:13:21 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed, 24 May 2017 11:13:15 +0200
Message-Id: <20170524091315.20284-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH] load_uboot_image: don't assume a full header
 read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com

Don't allow load_uboot_image() to proceed when less bytes than
header-size was read.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/core/loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index bf17b42cbec2..f72930ca4a41 100644
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
2.9.4
