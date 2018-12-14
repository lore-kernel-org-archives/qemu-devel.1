Received: from eggs.gnu.org ([2001:4830:134:3::10]:38444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofq-0000Cu-F0
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofm-0004T8-8i
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:42 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofm-0004Rv-0r
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:38 -0500
Received: by mail-wr1-x429.google.com with SMTP id x10so5660893wrs.8
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.33
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:07 +0000
Message-Id: <20181214144214.1260-16-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/22] hw/core/loader.c: Remove load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The load_image() function is now no longer used anywhere, so
we can remove it completely. (Use load_image_size() or
g_file_get_contents() instead.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20181130151712.2312-10-peter.maydell@linaro.org
---
 include/hw/loader.h |  1 -
 hw/core/loader.c    | 25 -------------------------
 2 files changed, 26 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 67a0af84ac3..3766559bc24 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -11,7 +11,6 @@
  * On error, errno is also set as appropriate.
  */
 int64_t get_image_size(const char *filename);
-int load_image(const char *filename, uint8_t *addr); /* deprecated */
 ssize_t load_image_size(const char *filename, void *addr, size_t size);
 
 /**load_image_targphys_as:
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 66a616608af..fa41842280a 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -73,31 +73,6 @@ int64_t get_image_size(const char *filename)
     return size;
 }
 
-/* return the size or -1 if error */
-/* deprecated, because caller does not specify buffer size! */
-int load_image(const char *filename, uint8_t *addr)
-{
-    int fd, size;
-    fd = open(filename, O_RDONLY | O_BINARY);
-    if (fd < 0)
-        return -1;
-    size = lseek(fd, 0, SEEK_END);
-    if (size == -1) {
-        fprintf(stderr, "file %-20s: get size error: %s\n",
-                filename, strerror(errno));
-        close(fd);
-        return -1;
-    }
-
-    lseek(fd, 0, SEEK_SET);
-    if (read(fd, addr, size) != size) {
-        close(fd);
-        return -1;
-    }
-    close(fd);
-    return size;
-}
-
 /* return the size or -1 if error */
 ssize_t load_image_size(const char *filename, void *addr, size_t size)
 {
-- 
2.19.2
