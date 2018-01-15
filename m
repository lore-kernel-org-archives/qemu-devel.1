Received: from eggs.gnu.org ([2001:4830:134:3::10]:57322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7so-0004wK-Rc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sk-000239-Ot
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33210
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eb7sk-00022n-Jc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FGfFKO132173
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:08 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fgvs6sw0c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:08 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 09:45:07 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:44:19 -0500
In-Reply-To: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516034665-27606-3-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/8] s390-ccw: ipl structs for eckd cdl/ldl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

ECKD DASDs have different IPL structures for CDL and LDL
formats. The current Ipl1 and Ipl2 structs follow the CDL
format, so we prepend "EckdCdl" to them. Boot info for LDL
has been moved to a new struct: EckdLdlIpl1.

Also introduce structs for IPL stages 1 and 1b and for
disk geometry.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 29 +++++++++++++-----------
 pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 6f8e30f..29915e4 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -221,9 +221,9 @@ static void run_eckd_boot_script(block_number_t mbr_block_nr)
 static void ipl_eckd_cdl(void)
 {
     XEckdMbr *mbr;
-    Ipl2 *ipl2 = (void *)sec;
+    EckdCdlIpl2 *ipl2 = (void *)sec;
     IplVolumeLabel *vlbl = (void *)sec;
-    block_number_t block_nr;
+    block_number_t mbr_block_nr;
 
     /* we have just read the block #0 and recognized it as "IPL1" */
     sclp_print("CDL\n");
@@ -231,16 +231,13 @@ static void ipl_eckd_cdl(void)
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(1, ipl2, "Cannot read IPL2 record at block 1");
 
-    mbr = &ipl2->u.x.mbr;
+    mbr = &ipl2->mbr;
     IPL_assert(magic_match(mbr, ZIPL_MAGIC), "No zIPL section in IPL2 record.");
     IPL_assert(block_size_ok(mbr->blockptr.xeckd.bptr.size),
                "Bad block size in zIPL section of IPL2 record.");
     IPL_assert(mbr->dev_type == DEV_TYPE_ECKD,
                "Non-ECKD device type in zIPL section of IPL2 record.");
 
-    /* save pointer to Boot Script */
-    block_nr = eckd_block_num((void *)&(mbr->blockptr));
-
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(2, vlbl, "Cannot read Volume Label at block 2");
     IPL_assert(magic_match(vlbl->key, VOL1_MAGIC),
@@ -249,7 +246,10 @@ static void ipl_eckd_cdl(void)
                "Invalid magic of volser block");
     print_volser(vlbl->f.volser);
 
-    run_eckd_boot_script(block_nr);
+    /* save pointer to Boot Script */
+    mbr_block_nr = eckd_block_num((void *)&mbr->blockptr);
+
+    run_eckd_boot_script(mbr_block_nr);
     /* no return */
 }
 
@@ -280,8 +280,8 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
 
 static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
-    block_number_t block_nr;
-    BootInfo *bip = (void *)(sec + 0x70); /* BootInfo is MBR for LDL */
+    block_number_t mbr_block_nr;
+    EckdLdlIpl1 *ipl1 = (void *)sec;
 
     if (mode != ECKD_LDL_UNLABELED) {
         print_eckd_ldl_msg(mode);
@@ -292,15 +292,18 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(0, sec, "Cannot read block 0 to grab boot info.");
     if (mode == ECKD_LDL_UNLABELED) {
-        if (!magic_match(bip->magic, ZIPL_MAGIC)) {
+        if (!magic_match(ipl1->boot_info.magic, ZIPL_MAGIC)) {
             return; /* not applicable layout */
         }
         sclp_print("unlabeled LDL.\n");
     }
-    verify_boot_info(bip);
+    verify_boot_info(&ipl1->boot_info);
+
+    /* save pointer to Boot Script */
+    mbr_block_nr =
+        eckd_block_num((void *)&ipl1->boot_info.bp.ipl.bm_ptr.eckd.bptr);
 
-    block_nr = eckd_block_num((void *)&(bip->bp.ipl.bm_ptr.eckd.bptr));
-    run_eckd_boot_script(block_nr);
+    run_eckd_boot_script(mbr_block_nr);
     /* no return */
 }
 
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 4980838..df956f2 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -226,22 +226,47 @@ typedef struct BootInfo {          /* @ 0x70, record #0    */
     } bp;
 } __attribute__ ((packed)) BootInfo; /* see also XEckdMbr   */
 
-typedef struct Ipl1 {
-    unsigned char key[4]; /* == "IPL1" */
-    unsigned char data[24];
-} __attribute__((packed)) Ipl1;
+/*
+ * Structs for IPL
+ */
+#define STAGE2_BLK_CNT_MAX  24 /* Stage 1b can load up to 24 blocks */
 
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
+typedef struct EckdCdlIpl1 {
+    uint8_t key[4]; /* == "IPL1" */
+    uint8_t data[24];
+} __attribute__((packed)) EckdCdlIpl1;
+
+typedef struct EckdSeekArg {
+    uint16_t pad;
+    uint16_t cyl;
+    uint16_t head;
+    uint8_t sec;
+    uint8_t pad2;
+} __attribute__ ((packed)) EckdSeekArg;
+
+typedef struct EckdStage1b {
+    uint8_t reserved[32 * STAGE2_BLK_CNT_MAX];
+    struct EckdSeekArg seek[STAGE2_BLK_CNT_MAX];
+    uint8_t unused[64];
+} __attribute__ ((packed)) EckdStage1b;
+
+typedef struct EckdStage1 {
+    uint8_t reserved[72];
+    struct EckdSeekArg seek[2];
+} __attribute__ ((packed)) EckdStage1;
+
+typedef struct EckdCdlIpl2 {
+    uint8_t key[4]; /* == "IPL2" */
+    struct EckdStage1 stage1;
+    XEckdMbr mbr;
+    uint8_t reserved[24];
+} __attribute__((packed)) EckdCdlIpl2;
+
+typedef struct EckdLdlIpl1 {
+    uint8_t reserved[24];
+    struct EckdStage1 stage1;
+    BootInfo boot_info; /* BootInfo is MBR for LDL */
+} __attribute__((packed)) EckdLdlIpl1;
 
 typedef struct IplVolumeLabel {
     unsigned char key[4]; /* == "VOL1" */
-- 
2.7.4
