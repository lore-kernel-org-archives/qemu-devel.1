Received: from eggs.gnu.org ([209.51.188.92]:55768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ghsgb-0004EB-43
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ghseI-0000vS-7x
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:58:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:51739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1ghseH-0000kA-W1
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:58:42 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Fri, 11 Jan 2019 16:57:49 +0800
Message-Id: <1547197071-14504-3-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1547197071-14504-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1547197071-14504-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH v5 2/4] hw/core/loader.c: Read as long as
 possible in load_image_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philmd@redhat.com, zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Richard Henderson <richard.henderson@linaro.org>, Stefano Garzarella <sgarzare@redhat.com>

Don't expect read(2) can always read as many as it's told.

CC: Richard Henderson <richard.henderson@linaro.org>
CC: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

---
V5: update subject and add reviewed-by tag (Stefano Garzarella)
V4: add reviewed-by tag
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
