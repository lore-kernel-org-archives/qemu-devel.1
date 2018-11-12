Received: from eggs.gnu.org ([2001:4830:134:3::10]:48290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gM699-0000m0-Tf
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gM68G-00064R-MI
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:55:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:61489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gM68G-0005ou-06
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:55:36 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Mon, 12 Nov 2018 15:45:29 +0800
Message-Id: <1542008730-6375-2-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1542008730-6375-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1542008730-6375-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH 2/3] change load_image() reture type to ssize_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhijianx.li@intel.com, philip.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>

This patch allow load_iamge to load >=2G file

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/core/loader.c    | 5 +++--
 include/hw/loader.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index aa0b3fc..0d53229 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -75,9 +75,10 @@ int64_t get_image_size(const char *filename)
 
 /* return the size or -1 if error */
 /* deprecated, because caller does not specify buffer size! */
-int load_image(const char *filename, uint8_t *addr)
+ssize_t load_image(const char *filename, uint8_t *addr)
 {
-    int fd, size;
+    int fd;
+    ssize_t size;
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0)
         return -1;
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 67a0af8..49bb189 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -11,7 +11,7 @@
  * On error, errno is also set as appropriate.
  */
 int64_t get_image_size(const char *filename);
-int load_image(const char *filename, uint8_t *addr); /* deprecated */
+ssize_t load_image(const char *filename, uint8_t *addr); /* deprecated */
 ssize_t load_image_size(const char *filename, void *addr, size_t size);
 
 /**load_image_targphys_as:
-- 
2.7.4
