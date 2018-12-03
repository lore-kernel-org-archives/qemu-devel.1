Received: from eggs.gnu.org ([2001:4830:134:3::10]:33747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gTpNt-00021Z-Ii
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gTpNr-0000gj-SO
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gTpNr-0000gE-KX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:39 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Mon,  3 Dec 2018 22:48:50 +0800
Message-Id: <1543848532-12604-3-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH for-4.0 v3 2/4] refactor load_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philip.li@intel.com, zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>

Don't expect read(2) can always read as many as it's told.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/core/loader.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index fa41842..9cbceab 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -77,21 +77,20 @@ int64_t get_image_size(const char *filename)
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
