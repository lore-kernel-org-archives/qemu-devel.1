Received: from eggs.gnu.org ([2001:4830:134:3::10]:43281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWV-0002l6-0r
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWT-0004lA-QD
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWT-0004kl-Ii
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWS-0001JU-JP
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:44 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:06 +0000
Message-Id: <20180302110640.28004-6-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/39] loader: Add new load_ramdisk_as()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a function load_ramdisk_as() which behaves like the existing
load_ramdisk() but allows the caller to specify the AddressSpace
to use. This matches the pattern we have already for various
other loader functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-2-peter.maydell@linaro.org
---
 include/hw/loader.h | 12 +++++++++++-
 hw/core/loader.c    |  8 +++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 5edbe02b1c..2504cc2259 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -162,16 +162,26 @@ int load_uimage(const char *filename, hwaddr *ep,
                 void *translate_opaque);
 
 /**
- * load_ramdisk:
+ * load_ramdisk_as:
  * @filename: Path to the ramdisk image
  * @addr: Memory address to load the ramdisk to
  * @max_sz: Maximum allowed ramdisk size (for non-u-boot ramdisks)
+ * @as: The AddressSpace to load the ELF to. The value of address_space_memory
+ *      is used if nothing is supplied here.
  *
  * Load a ramdisk image with U-Boot header to the specified memory
  * address.
  *
  * Returns the size of the loaded image on success, -1 otherwise.
  */
+int load_ramdisk_as(const char *filename, hwaddr addr, uint64_t max_sz,
+                    AddressSpace *as);
+
+/**
+ * load_ramdisk:
+ * Same as load_ramdisk_as(), but doesn't allow the caller to specify
+ * an AddressSpace.
+ */
 int load_ramdisk(const char *filename, hwaddr addr, uint64_t max_sz);
 
 ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src, size_t srclen);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index c08f130461..76b244c508 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -729,9 +729,15 @@ int load_uimage_as(const char *filename, hwaddr *ep, hwaddr *loadaddr,
 
 /* Load a ramdisk.  */
 int load_ramdisk(const char *filename, hwaddr addr, uint64_t max_sz)
+{
+    return load_ramdisk_as(filename, addr, max_sz, NULL);
+}
+
+int load_ramdisk_as(const char *filename, hwaddr addr, uint64_t max_sz,
+                    AddressSpace *as)
 {
     return load_uboot_image(filename, NULL, &addr, NULL, IH_TYPE_RAMDISK,
-                            NULL, NULL, NULL);
+                            NULL, NULL, as);
 }
 
 /* Load a gzip-compressed kernel to a dynamically allocated buffer. */
-- 
2.16.2
