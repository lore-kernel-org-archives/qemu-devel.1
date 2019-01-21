Received: from eggs.gnu.org ([209.51.188.92]:52119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyy-0005Am-O1
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyv-0004vi-98
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyj-0004fl-6v
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:27 -0500
Received: by mail-wm1-x32a.google.com with SMTP id y8so11692103wmi.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:07:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:17 +0100
Message-Id: <1548093980-43088-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/49] hw/core/loader.c: Read as long as
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
