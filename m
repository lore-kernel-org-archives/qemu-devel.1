Received: from eggs.gnu.org ([2001:4830:134:3::10]:49888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gPHtq-0005lo-6r
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gPHtp-0002pl-CG
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:12715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gPHtm-0002gn-0P
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:51 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Wed, 21 Nov 2018 10:06:04 +0800
Message-Id: <1542765966-20244-4-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1542765966-20244-3-git-send-email-lizhijian@cn.fujitsu.com>
References: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-3-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH v2 3/5] refactor load_image/load_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <zhijianx.li@intel.com>, Philip Li <philip.li@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Don't expect read(2) can always read as many as it's told.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/core/loader.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 0d53229..5f891e2 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -78,7 +78,7 @@ int64_t get_image_size(const char *filename)
 ssize_t load_image(const char *filename, uint8_t *addr)
 {
     int fd;
-    ssize_t size;
+    ssize_t size, r = 0, l = 0;
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0)
         return -1;
@@ -91,11 +91,16 @@ ssize_t load_image(const char *filename, uint8_t *addr)
     }
 
     lseek(fd, 0, SEEK_SET);
-    if (read(fd, addr, size) != size) {
-        close(fd);
-        return -1;
+    while ((r = read(fd, addr + l, size - l)) > 0 ) {
+        l += r;
     }
     close(fd);
+
+    if (l != size) {
+        fprintf(stderr, "expect read %ld, actual read %ld\n", size, l);
+        return -1;
+    }
+
     return size;
 }
 
@@ -103,21 +108,20 @@ ssize_t load_image(const char *filename, uint8_t *addr)
 ssize_t load_image_size(const char *filename, void *addr, size_t size)
 {
     int fd;
-    ssize_t actsize;
+    ssize_t actsize, l = 0;
 
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0) {
         return -1;
     }
 
-    actsize = read(fd, addr, size);
-    if (actsize < 0) {
-        close(fd);
-        return -1;
+    while ((actsize = read(fd, addr + l, size - l)) > 0) {
+        l += actsize;
     }
+
     close(fd);
 
-    return actsize;
+    return actsize < 0 ? -1 : l;
 }
 
 /* read()-like version */
-- 
2.7.4
