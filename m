Received: from eggs.gnu.org ([2001:4830:134:3::10]:57424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7su-00052g-Bg
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sp-000294-UJ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eb7sp-00027P-Jz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FGgT6N146179
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:14 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fgucuw7bn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:14 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 09:45:13 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:44:22 -0500
In-Reply-To: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516034665-27606-6-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 5/8] s390-ccw: interactive boot menu for
 eckd dasd (read stage2 data)
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

Read the stage2 boot loader data block-by-block. We scan the
current block for the string "zIPL" to detect the start of the
boot menu banner. We then load the adjacent blocks (previous
block and next block) to account for the possibility of menu
data spanning multiple blocks.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 112 +++++++++++++++++++++++++++++++++++++++++++--
 pc-bios/s390-ccw/bootmap.h |   1 +
 pc-bios/s390-ccw/menu.h    |  10 ++++
 3 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 29915e4..fb8ff80 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -13,6 +13,7 @@
 #include "bootmap.h"
 #include "virtio.h"
 #include "bswap.h"
+#include "menu.h"
 
 #ifdef DEBUG
 /* #define DEBUG_FALLBACK */
@@ -83,6 +84,10 @@ static void jump_to_IPL_code(uint64_t address)
 
 static unsigned char _bprs[8*1024]; /* guessed "max" ECKD sector size */
 static const int max_bprs_entries = sizeof(_bprs) / sizeof(ExtEckdBlockPtr);
+static uint8_t _s2[MAX_SECTOR_SIZE * 4] __attribute__((__aligned__(PAGE_SIZE)));
+static void *s2_prev_blk = _s2;
+static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
+static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
 
 static inline void verify_boot_info(BootInfo *bip)
 {
@@ -182,7 +187,94 @@ static block_number_t load_eckd_segments(block_number_t blk, uint64_t *address)
     return block_nr;
 }
 
-static void run_eckd_boot_script(block_number_t mbr_block_nr)
+static ZiplParms get_zipl_parms(int offset)
+{
+    ZiplParms zipl_parms = {
+        .flag = *(uint16_t *)(s2_cur_blk + offset - ZIPL_FLAG_OFFSET),
+        .timeout = *(uint16_t *)(s2_cur_blk + offset - ZIPL_TIMEOUT_OFFSET),
+        .menu_start = offset,
+    };
+
+    return zipl_parms;
+}
+
+static bool find_zipl_boot_menu_banner(int *offset)
+{
+    int i;
+
+    /* Menu banner starts with "zIPL" */
+    for (i = 0; i < virtio_get_block_size() - 4; i++) {
+        if (magic_match(s2_cur_blk + i, ZIPL_MAGIC_EBCDIC)) {
+            *offset = i;
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
+{
+    block_number_t cur_block_nr, prev_block_nr, next_block_nr;
+    EckdStage1b *s1b = (void *)sec;
+    ZiplParms zipl_parms;
+    bool found = false;
+    int offset;
+    int i;
+
+    /* Get Stage1b data */
+    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
+    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader");
+
+    memset(_s2, FREE_SPACE_FILLER, sizeof(_s2));
+
+    /* Get Stage2 data */
+    for (i = 0; i < STAGE2_BLK_CNT_MAX; i++) {
+        cur_block_nr = eckd_block_num((void *)&s1b->seek[i].cyl);
+
+        if (!cur_block_nr) {
+            break;
+        }
+
+        read_block(cur_block_nr, s2_cur_blk, "Cannot read stage2 boot loader");
+
+        if (find_zipl_boot_menu_banner(&offset)) {
+            /* Load the adjacent blocks to account for the
+             * possibility of menu data spanning multiple blocks.
+             */
+            if (prev_block_nr) {
+                read_block(prev_block_nr, s2_prev_blk,
+                           "Cannot read stage2 boot loader");
+            }
+
+            if (i + 1 < STAGE2_BLK_CNT_MAX) {
+                next_block_nr = eckd_block_num((void *)&s1b->seek[i + 1].cyl);
+            }
+
+            if (next_block_nr) {
+                read_block(next_block_nr, s2_next_blk,
+                           "Cannot read stage2 boot loader");
+            }
+
+            zipl_parms = get_zipl_parms(offset);
+            found = true;
+            break;
+        }
+
+        prev_block_nr = cur_block_nr;
+    }
+
+    if (!found) {
+        sclp_print("No zipl boot menu data found. Booting default entry.");
+        return 0;
+    }
+
+    zipl_parms.menu_start++; /* make compiler happy -- does nothing vital */
+    return 0; /* implemented next patch */
+}
+
+static void run_eckd_boot_script(block_number_t mbr_block_nr,
+                                 block_number_t s1b_block_nr)
 {
     int i;
     unsigned int loadparm = get_loadparm_index();
@@ -191,6 +283,10 @@ static void run_eckd_boot_script(block_number_t mbr_block_nr)
     ScsiMbr *bte = (void *)sec; /* Eckd bootmap table entry */
     BootMapScript *bms = (void *)sec;
 
+    if (menu_check_flags(BOOT_MENU_FLAG_BOOT_OPTS | BOOT_MENU_FLAG_ZIPL_OPTS)) {
+        loadparm = eckd_get_boot_menu_index(s1b_block_nr);
+    }
+
     debug_print_int("loadparm", loadparm);
     IPL_assert(loadparm < 31, "loadparm value greater than"
                " maximum number of boot entries allowed");
@@ -223,7 +319,7 @@ static void ipl_eckd_cdl(void)
     XEckdMbr *mbr;
     EckdCdlIpl2 *ipl2 = (void *)sec;
     IplVolumeLabel *vlbl = (void *)sec;
-    block_number_t mbr_block_nr;
+    block_number_t mbr_block_nr, s1b_block_nr;
 
     /* we have just read the block #0 and recognized it as "IPL1" */
     sclp_print("CDL\n");
@@ -249,7 +345,10 @@ static void ipl_eckd_cdl(void)
     /* save pointer to Boot Script */
     mbr_block_nr = eckd_block_num((void *)&mbr->blockptr);
 
-    run_eckd_boot_script(mbr_block_nr);
+    /* save pointer to Stage1b Data */
+    s1b_block_nr = eckd_block_num((void *)&ipl2->stage1.seek[0].cyl);
+
+    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
     /* no return */
 }
 
@@ -280,7 +379,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
 
 static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
-    block_number_t mbr_block_nr;
+    block_number_t mbr_block_nr, s1b_block_nr;
     EckdLdlIpl1 *ipl1 = (void *)sec;
 
     if (mode != ECKD_LDL_UNLABELED) {
@@ -303,7 +402,10 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     mbr_block_nr =
         eckd_block_num((void *)&ipl1->boot_info.bp.ipl.bm_ptr.eckd.bptr);
 
-    run_eckd_boot_script(mbr_block_nr);
+    /* save pointer to Stage1b Data */
+    s1b_block_nr = eckd_block_num((void *)&ipl1->stage1.seek[0].cyl);
+
+    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
     /* no return */
 }
 
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index df956f2..56445f2 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -74,6 +74,7 @@ typedef struct ScsiMbr {
 } __attribute__ ((packed)) ScsiMbr;
 
 #define ZIPL_MAGIC              "zIPL"
+#define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
 #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */
 #define IPL2_MAGIC "\xc9\xd7\xd3\xf2" /* == "IPL2" in EBCDIC */
 #define VOL1_MAGIC "\xe5\xd6\xd3\xf1" /* == "VOL1" in EBCDIC */
diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
index 04b1db1..3a8a487 100644
--- a/pc-bios/s390-ccw/menu.h
+++ b/pc-bios/s390-ccw/menu.h
@@ -17,6 +17,16 @@
 #define BOOT_MENU_FLAG_BOOT_OPTS 0x80
 #define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
 
+/* Offsets from zipl fields to zipl banner start */
+#define ZIPL_TIMEOUT_OFFSET 138
+#define ZIPL_FLAG_OFFSET    140
+
+typedef struct ZiplParms {
+    uint16_t flag;
+    uint16_t timeout;
+    uint64_t menu_start;
+} ZiplParms;
+
 void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
 bool menu_check_flags(uint8_t check_flags);
 
-- 
2.7.4
