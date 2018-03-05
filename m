Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esvj1-0001Cy-Ae
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esviy-0002l6-Mg
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:24:43 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  5 Mar 2018 20:24:26 +0100
Message-Id: <1520277866-4360-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] pc-bios/s390-ccw: Move string arrays from
 bootmap header to .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

bootmap.h currently can only be included once - otherwise the
linker complains about multiple definitions of the "magic" strings.
It's a bad style to define string arrays in header files, so let's
better move these to the bootmap.c file instead where they are used.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 22 ++++++++++++++++++++++
 pc-bios/s390-ccw/bootmap.h | 19 -------------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 29bfd8c..5e0be54 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -37,6 +37,28 @@ typedef struct ResetInfo {
 
 static ResetInfo save;
 
+const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
+                                  "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
+
+/*
+ * Match two CCWs located after PSW and eight filler bytes.
+ * From libmagic and arch/s390/kernel/head.S.
+ */
+const uint8_t linux_s390_magic[] = "\x02\x00\x00\x18\x60\x00\x00\x50\x02\x00"
+                                   "\x00\x68\x60\x00\x00\x50\x40\x40\x40\x40"
+                                   "\x40\x40\x40\x40";
+
+static const uint8_t vol_desc_magic[] = "CD001";
+
+static inline bool is_iso_vd_valid(IsoVolDesc *vd)
+{
+    const uint8_t vol_desc_magic[] = "CD001";
+
+    return !memcmp(&vd->ident[0], vol_desc_magic, 5) &&
+           vd->version == 0x1 &&
+           vd->type <= VOL_DESC_TYPE_PARTITION;
+}
+
 static void jump_to_IPL_2(void)
 {
     ResetInfo *current = 0;
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index c636626..07eb600 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -375,9 +375,6 @@ static inline void read_iso_boot_image(uint32_t block_offset, void *load_addr,
                "Failed to read boot image!");
 }
 
-const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
-                                  "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
-
 #define ISO9660_MAX_DIR_DEPTH 8
 
 typedef struct IsoDirHdr {
@@ -430,20 +427,12 @@ typedef struct IsoVolDesc {
     } vd;
 } __attribute__((packed)) IsoVolDesc;
 
-const uint8_t vol_desc_magic[] = "CD001";
 #define VOL_DESC_TYPE_BOOT 0
 #define VOL_DESC_TYPE_PRIMARY 1
 #define VOL_DESC_TYPE_SUPPLEMENT 2
 #define VOL_DESC_TYPE_PARTITION 3
 #define VOL_DESC_TERMINATOR 255
 
-static inline bool is_iso_vd_valid(IsoVolDesc *vd)
-{
-    return !memcmp(&vd->ident[0], vol_desc_magic, 5) &&
-           vd->version == 0x1 &&
-           vd->type <= VOL_DESC_TYPE_PARTITION;
-}
-
 typedef struct IsoBcValid {
     uint8_t platform_id;
     uint16_t reserved;
@@ -468,14 +457,6 @@ typedef struct IsoBcHdr {
     uint8_t id[28];
 } __attribute__((packed)) IsoBcHdr;
 
-/*
- * Match two CCWs located after PSW and eight filler bytes.
- * From libmagic and arch/s390/kernel/head.S.
- */
-const uint8_t linux_s390_magic[] = "\x02\x00\x00\x18\x60\x00\x00\x50\x02\x00"
-                                   "\x00\x68\x60\x00\x00\x50\x40\x40\x40\x40"
-                                   "\x40\x40\x40\x40";
-
 typedef struct IsoBcEntry {
     uint8_t id;
     union {
-- 
1.8.3.1
