Received: from eggs.gnu.org ([2001:4830:134:3::10]:40559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuS-0005a5-Sv
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuR-0006BW-Rs
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:56 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:22 +0100
Message-Id: <20180308180423.941-11-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/11] pc-bios/s390-ccw: Move string arrays from
 bootmap header to .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

bootmap.h can currently only be included once - otherwise the linker
complains about multiple definitions of the "magic" strings. It's a
bad style to define string arrays in header files, so let's better
move these to the bootmap.c file instead where they are used.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1520317081-5341-1-git-send-email-thuth@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 20 ++++++++++++++++++++
 pc-bios/s390-ccw/bootmap.h | 19 -------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 29bfd8c875..fc2a9fe33b 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -37,6 +37,26 @@ typedef struct ResetInfo {
 
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
index c636626f1a..07eb600b00 100644
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
2.13.6
