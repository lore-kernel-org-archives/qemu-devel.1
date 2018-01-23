Received: from eggs.gnu.org ([2001:4830:134:3::10]:53623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3I6-0003pv-18
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3I2-0006NK-S8
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ee3I2-0006Mn-Iu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:22 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NIO2pi013919
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:21 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fp9fxt69u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:20 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 11:27:19 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 13:26:44 -0500
In-Reply-To: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516732013-18272-2-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 01/10] s390-ccw: refactor boot map table code
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

- replace ScsiMbr in ECKD code with BootMapTable
- fix read_block messages to reflect BMT
- reduce ipl_scsi code with BMT struct

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 58 ++++++++++++++++------------------------------
 pc-bios/s390-ccw/bootmap.h |  9 ++++++-
 2 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 67a6123..6b6c915 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -182,13 +182,13 @@ static block_number_t load_eckd_segments(block_number_t blk, uint64_t *address)
     return block_nr;
 }
 
-static void run_eckd_boot_script(block_number_t mbr_block_nr)
+static void run_eckd_boot_script(block_number_t bmt_block_nr)
 {
     int i;
     unsigned int loadparm = get_loadparm_index();
     block_number_t block_nr;
     uint64_t address;
-    ScsiMbr *bte = (void *)sec; /* Eckd bootmap table entry */
+    BootMapTable *bmt = (void *)sec;
     BootMapScript *bms = (void *)sec;
 
     debug_print_int("loadparm", loadparm);
@@ -196,10 +196,10 @@ static void run_eckd_boot_script(block_number_t mbr_block_nr)
                " maximum number of boot entries allowed");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(mbr_block_nr, sec, "Cannot read MBR");
+    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
 
-    block_nr = eckd_block_num((void *)&(bte->blockptr[loadparm]));
-    IPL_assert(block_nr != -1, "No Boot Map");
+    block_nr = eckd_block_num((void *)&(bmt->bte[loadparm]));
+    IPL_assert(block_nr != -1, "Cannot find Boot Map Table Entry");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(block_nr, sec, "Cannot read Boot Map Script");
@@ -223,7 +223,7 @@ static void ipl_eckd_cdl(void)
     XEckdMbr *mbr;
     Ipl2 *ipl2 = (void *)sec;
     IplVolumeLabel *vlbl = (void *)sec;
-    block_number_t block_nr;
+    block_number_t bmt_block_nr;
 
     /* we have just read the block #0 and recognized it as "IPL1" */
     sclp_print("CDL\n");
@@ -238,8 +238,8 @@ static void ipl_eckd_cdl(void)
     IPL_assert(mbr->dev_type == DEV_TYPE_ECKD,
                "Non-ECKD device type in zIPL section of IPL2 record.");
 
-    /* save pointer to Boot Script */
-    block_nr = eckd_block_num((void *)&(mbr->blockptr));
+    /* save pointer to Boot Map Table */
+    bmt_block_nr = eckd_block_num((void *)&(mbr->blockptr));
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(2, vlbl, "Cannot read Volume Label at block 2");
@@ -249,7 +249,7 @@ static void ipl_eckd_cdl(void)
                "Invalid magic of volser block");
     print_volser(vlbl->f.volser);
 
-    run_eckd_boot_script(block_nr);
+    run_eckd_boot_script(bmt_block_nr);
     /* no return */
 }
 
@@ -280,7 +280,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
 
 static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
-    block_number_t block_nr;
+    block_number_t bmt_block_nr;
     BootInfo *bip = (void *)(sec + 0x70); /* BootInfo is MBR for LDL */
 
     if (mode != ECKD_LDL_UNLABELED) {
@@ -299,8 +299,10 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     }
     verify_boot_info(bip);
 
-    block_nr = eckd_block_num((void *)&(bip->bp.ipl.bm_ptr.eckd.bptr));
-    run_eckd_boot_script(block_nr);
+    /* save pointer to Boot Map Table */
+    bmt_block_nr = eckd_block_num((void *)&(bip->bp.ipl.bm_ptr.eckd.bptr));
+
+    run_eckd_boot_script(bmt_block_nr);
     /* no return */
 }
 
@@ -325,7 +327,7 @@ static void print_eckd_msg(void)
 
 static void ipl_eckd(void)
 {
-    ScsiMbr *mbr = (void *)sec;
+    XEckdMbr *mbr = (void *)sec;
     LDL_VTOC *vlbl = (void *)sec;
 
     print_eckd_msg();
@@ -449,10 +451,7 @@ static void zipl_run(ScsiBlockPtr *pte)
 static void ipl_scsi(void)
 {
     ScsiMbr *mbr = (void *)sec;
-    uint8_t *ns, *ns_end;
-    int program_table_entries = 0;
-    const int pte_len = sizeof(ScsiBlockPtr);
-    ScsiBlockPtr *prog_table_entry = NULL;
+    BootMapTable *bmt = (void *)sec;
     unsigned int loadparm = get_loadparm_index();
 
     /* Grab the MBR */
@@ -467,34 +466,17 @@ static void ipl_scsi(void)
     debug_print_int("MBR Version", mbr->version_id);
     IPL_check(mbr->version_id == 1,
               "Unknown MBR layout version, assuming version 1");
-    debug_print_int("program table", mbr->blockptr[0].blockno);
-    IPL_assert(mbr->blockptr[0].blockno, "No Program Table");
+    debug_print_int("program table", mbr->bmt.blockno);
+    IPL_assert(mbr->bmt.blockno, "No Program Table");
 
     /* Parse the program table */
-    read_block(mbr->blockptr[0].blockno, sec,
-               "Error reading Program Table");
+    read_block(mbr->bmt.blockno, sec, "Error reading Program Table");
 
     IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
 
     debug_print_int("loadparm index", loadparm);
-    ns_end = sec + virtio_get_block_size();
-    for (ns = (sec + pte_len); (ns + pte_len) < ns_end; ns += pte_len) {
-        prog_table_entry = (ScsiBlockPtr *)ns;
-        if (!prog_table_entry->blockno) {
-            break;
-        }
-
-        program_table_entries++;
-        if (program_table_entries == loadparm + 1) {
-            break; /* selected entry found */
-        }
-    }
-
-    debug_print_int("program table entries", program_table_entries);
-
-    IPL_assert(program_table_entries != 0, "Empty Program Table");
 
-    zipl_run(prog_table_entry); /* no return */
+    zipl_run(&bmt->bte[loadparm].scsi); /* no return */
 }
 
 /***********************************************************************
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index cf99a4c..77d56db 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -53,6 +53,13 @@ typedef union BootMapPointer {
     ExtEckdBlockPtr xeckd;
 } __attribute__ ((packed)) BootMapPointer;
 
+/* aka Program Table */
+typedef struct BootMapTable {
+    uint8_t magic[4];
+    uint8_t reserved[12];
+    BootMapPointer bte[];
+} __attribute__ ((packed)) BootMapTable;
+
 typedef struct ComponentEntry {
     ScsiBlockPtr data;
     uint8_t pad[7];
@@ -70,7 +77,7 @@ typedef struct ScsiMbr {
     uint8_t magic[4];
     uint32_t version_id;
     uint8_t reserved[8];
-    ScsiBlockPtr blockptr[];
+    ScsiBlockPtr bmt;
 } __attribute__ ((packed)) ScsiMbr;
 
 #define ZIPL_MAGIC              "zIPL"
-- 
2.7.4
