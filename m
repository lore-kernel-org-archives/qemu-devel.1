Received: from eggs.gnu.org ([2001:4830:134:3::10]:50940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkY1-0004nM-Q5
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkY1-0005cF-2e
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:41 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:17:11 +0000
Message-Id: <20181130151712.2312-10-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/10] hw/core/loader.c: Remove load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org

The load_image() function is now no longer used anywhere, so
we can remove it completely. (Use load_image_size() or
g_file_get_contents() instead.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index aa0b3fc8679..180d891b19c 100644
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
2.19.1
