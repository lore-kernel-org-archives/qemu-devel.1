Received: from eggs.gnu.org ([2001:4830:134:3::10]:51676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sarna@skytechnology.pl>) id 1ek5N1-0001Gl-9c
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sarna@skytechnology.pl>) id 1ek5My-0005M4-4M
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:53:27 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:45128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sarna@skytechnology.pl>)
	id 1ek5Mx-0005LM-T8
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:53:24 -0500
Received: by mail-lf0-x241.google.com with SMTP id x196so10362299lfd.12
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 01:53:23 -0800 (PST)
From: Piotr Sarna <sarna@skytechnology.pl>
Date: Fri,  9 Feb 2018 10:53:12 +0100
Message-Id: <1518169992-19288-1-git-send-email-sarna@skytechnology.pl>
Subject: [Qemu-devel] [PATCH v2] block: unify blocksize types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, Piotr Sarna <sarna@skytechnology.pl>

BlockSizes structure used in block size probing has uint32_t types
for logical and physical sizes. These fields are wrongfully assigned
to uint16_t in BlockConf, which results, among other errors,
in assigning 0 instead of 65536 (which will be the case in at least
future LizardFS block device driver among other things).

This commit makes BlockConf's physical_block_size and logical_block_size
fields uint32_t to avoid inconsistencies.

Signed-off-by: Piotr Sarna <sarna@skytechnology.pl>
---
 hw/core/qdev-properties.c    | 10 +++++-----
 include/hw/block/block.h     |  4 ++--
 include/hw/qdev-properties.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5bbc2d9..1400ba5 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -731,14 +731,14 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
     Error *local_err = NULL;
     const int64_t min = 512;
-    const int64_t max = 32768;
+    const int64_t max = 2147483648;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
 
-    visit_type_uint16(v, name, &value, &local_err);
+    visit_type_uint32(v, name, &value, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -762,9 +762,9 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_blocksize = {
-    .name  = "uint16",
-    .description = "A power of two between 512 and 32768",
-    .get   = get_uint16,
+    .name  = "uint32",
+    .description = "A power of two between 512 and 2147483648",
+    .get   = get_uint32,
     .set   = set_blocksize,
     .set_default_value = set_default_value_uint,
 };
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 64b9298..c9e6e27 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -17,8 +17,8 @@
 
 typedef struct BlockConf {
     BlockBackend *blk;
-    uint16_t physical_block_size;
-    uint16_t logical_block_size;
+    uint32_t physical_block_size;
+    uint32_t logical_block_size;
     uint16_t min_io_size;
     uint32_t opt_io_size;
     int32_t bootindex;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 1d61a35..c68d7bf 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -210,7 +210,7 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
 #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
 #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
-- 
2.7.4
