Received: from eggs.gnu.org ([2001:4830:134:3::10]:34569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfCu-00058e-UX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfCt-00089E-SE
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:22:12 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 27 Feb 2018 14:21:27 +0100
Message-Id: <20180227132150.13847-4-cohuck@redhat.com>
In-Reply-To: <20180227132150.13847-1-cohuck@redhat.com>
References: <20180227132150.13847-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/26] s390-ccw: refactor IPL structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, "Collin L. Walling" <walling@linux.vnet.ibm.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

ECKD DASDs have different IPL structures for CDL and LDL
formats. The current Ipl1 and Ipl2 structs follow the CDL
format, so we prepend "EckdCdl" to them. Boot info for LDL
has been moved to a new struct: EckdLdlIpl1.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 12 ++++++------
 pc-bios/s390-ccw/bootmap.h | 37 +++++++++++++++++++++----------------
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 9534f56060..a94638db2c 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -221,7 +221,7 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr)
 static void ipl_eckd_cdl(void)
 {
     XEckdMbr *mbr;
-    Ipl2 *ipl2 = (void *)sec;
+    EckdCdlIpl2 *ipl2 = (void *)sec;
     IplVolumeLabel *vlbl = (void *)sec;
     block_number_t bmt_block_nr;
 
@@ -231,7 +231,7 @@ static void ipl_eckd_cdl(void)
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(1, ipl2, "Cannot read IPL2 record at block 1");
 
-    mbr = &ipl2->u.x.mbr;
+    mbr = &ipl2->mbr;
     IPL_assert(magic_match(mbr, ZIPL_MAGIC), "No zIPL section in IPL2 record.");
     IPL_assert(block_size_ok(mbr->blockptr.xeckd.bptr.size),
                "Bad block size in zIPL section of IPL2 record.");
@@ -281,7 +281,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
 static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
     block_number_t bmt_block_nr;
-    BootInfo *bip = (void *)(sec + 0x70); /* BootInfo is MBR for LDL */
+    EckdLdlIpl1 *ipl1 = (void *)sec;
 
     if (mode != ECKD_LDL_UNLABELED) {
         print_eckd_ldl_msg(mode);
@@ -292,15 +292,15 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(0, sec, "Cannot read block 0 to grab boot info.");
     if (mode == ECKD_LDL_UNLABELED) {
-        if (!magic_match(bip->magic, ZIPL_MAGIC)) {
+        if (!magic_match(ipl1->bip.magic, ZIPL_MAGIC)) {
             return; /* not applicable layout */
         }
         sclp_print("unlabeled LDL.\n");
     }
-    verify_boot_info(bip);
+    verify_boot_info(&ipl1->bip);
 
     /* save pointer to Boot Map Table */
-    bmt_block_nr = eckd_block_num(&bip->bp.ipl.bm_ptr.eckd.bptr.chs);
+    bmt_block_nr = eckd_block_num(&ipl1->bip.bp.ipl.bm_ptr.eckd.bptr.chs);
 
     run_eckd_boot_script(bmt_block_nr);
     /* no return */
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index b361084073..4bd95cd4d2 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -239,22 +239,27 @@ typedef struct BootInfo {          /* @ 0x70, record #0    */
     } bp;
 } __attribute__ ((packed)) BootInfo; /* see also XEckdMbr   */
 
-typedef struct Ipl1 {
-    unsigned char key[4]; /* == "IPL1" */
-    unsigned char data[24];
-} __attribute__((packed)) Ipl1;
-
-typedef struct Ipl2 {
-    unsigned char key[4]; /* == "IPL2" */
-    union {
-        unsigned char data[144];
-        struct {
-            unsigned char reserved1[92-4];
-            XEckdMbr mbr;
-            unsigned char reserved2[144-(92-4)-sizeof(XEckdMbr)];
-        } x;
-    } u;
-} __attribute__((packed)) Ipl2;
+/*
+ * Structs for IPL
+ */
+#define STAGE2_BLK_CNT_MAX  24 /* Stage 1b can load up to 24 blocks */
+
+typedef struct EckdCdlIpl1 {
+    uint8_t key[4]; /* == "IPL1" */
+    uint8_t data[24];
+} __attribute__((packed)) EckdCdlIpl1;
+
+typedef struct EckdCdlIpl2 {
+    uint8_t key[4]; /* == "IPL2" */
+    uint8_t reserved0[88];
+    XEckdMbr mbr;
+    uint8_t reserved[24];
+} __attribute__((packed)) EckdCdlIpl2;
+
+typedef struct EckdLdlIpl1 {
+    uint8_t reserved[112];
+    BootInfo bip; /* BootInfo is MBR for LDL */
+} __attribute__((packed)) EckdLdlIpl1;
 
 typedef struct IplVolumeLabel {
     unsigned char key[4]; /* == "VOL1" */
-- 
2.13.6
