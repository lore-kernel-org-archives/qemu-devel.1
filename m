Received: from eggs.gnu.org ([209.51.188.92]:36331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gb-0002Zh-Im
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GZ-00045Y-IU
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:17 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GV-0003y1-N1
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id x10so4692994wrs.8
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:46 +0100
Message-Id: <1549390526-24246-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 36/76] hw/core/loader.c: Read as long as
 possible in load_image_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Richard Henderson <richard.henderson@linaro.org>, Stefano Garzarella <sgarzare@redhat.com>

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Don't expect read(2) can always read as many as it's told.

CC: Richard Henderson <richard.henderson@linaro.org>
CC: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/loader.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 3a000d5..fe5cb24 100644
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
1.8.3.1
