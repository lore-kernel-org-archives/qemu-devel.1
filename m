Received: from eggs.gnu.org ([2001:4830:134:3::10]:57072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNnG-0000HY-2w
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNnE-0005Nc-VX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:58:42 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 13:58:04 +0100
Message-Id: <20180301125830.24377-2-cohuck@redhat.com>
In-Reply-To: <20180301125830.24377-1-cohuck@redhat.com>
References: <20180301125830.24377-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 01/27] s390-ccw: refactor boot map table code
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

Some ECKD bootmap code was using structs designed for SCSI.
Even though this works, it confuses readability. Add a new
BootMapTable struct to assist with readability in bootmap
entry code. Also:

- replace ScsiMbr in ECKD code with appropriate structs
- fix read_block messages to reflect BootMapTable
- fixup ipl_scsi to use BootMapTable (referred to as Program Table)
- defined value for maximum table entries

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 60 +++++++++++++++++++++-------------------------
 pc-bios/s390-ccw/bootmap.h | 11 ++++++++-
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 67a6123ed4..a4eaf24c8d 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -182,24 +182,24 @@ static block_number_t load_eckd_segments(block_number_t blk, uint64_t *address)
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
-    IPL_assert(loadparm < 31, "loadparm value greater than"
+    IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(mbr_block_nr, sec, "Cannot read MBR");
+    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
 
-    block_nr = eckd_block_num((void *)&(bte->blockptr[loadparm]));
-    IPL_assert(block_nr != -1, "No Boot Map");
+    block_nr = eckd_block_num(&bmt->entry[loadparm]);
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
+    bmt_block_nr = eckd_block_num(&mbr->blockptr);
 
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
+    bmt_block_nr = eckd_block_num((void *)&bip->bp.ipl.bm_ptr.eckd.bptr);
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
@@ -449,10 +451,8 @@ static void zipl_run(ScsiBlockPtr *pte)
 static void ipl_scsi(void)
 {
     ScsiMbr *mbr = (void *)sec;
-    uint8_t *ns, *ns_end;
     int program_table_entries = 0;
-    const int pte_len = sizeof(ScsiBlockPtr);
-    ScsiBlockPtr *prog_table_entry = NULL;
+    BootMapTable *prog_table = (void *)sec;
     unsigned int loadparm = get_loadparm_index();
 
     /* Grab the MBR */
@@ -467,34 +467,28 @@ static void ipl_scsi(void)
     debug_print_int("MBR Version", mbr->version_id);
     IPL_check(mbr->version_id == 1,
               "Unknown MBR layout version, assuming version 1");
-    debug_print_int("program table", mbr->blockptr[0].blockno);
-    IPL_assert(mbr->blockptr[0].blockno, "No Program Table");
+    debug_print_int("program table", mbr->pt.blockno);
+    IPL_assert(mbr->pt.blockno, "No Program Table");
 
     /* Parse the program table */
-    read_block(mbr->blockptr[0].blockno, sec,
-               "Error reading Program Table");
-
+    read_block(mbr->pt.blockno, sec, "Error reading Program Table");
     IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
 
-    debug_print_int("loadparm index", loadparm);
-    ns_end = sec + virtio_get_block_size();
-    for (ns = (sec + pte_len); (ns + pte_len) < ns_end; ns += pte_len) {
-        prog_table_entry = (ScsiBlockPtr *)ns;
-        if (!prog_table_entry->blockno) {
+    while (program_table_entries <= MAX_TABLE_ENTRIES) {
+        if (!prog_table->entry[program_table_entries].scsi.blockno) {
             break;
         }
-
         program_table_entries++;
-        if (program_table_entries == loadparm + 1) {
-            break; /* selected entry found */
-        }
     }
 
     debug_print_int("program table entries", program_table_entries);
-
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
-    zipl_run(prog_table_entry); /* no return */
+    debug_print_int("loadparm", loadparm);
+    IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
+               " maximum number of boot entries allowed");
+
+    zipl_run(&prog_table->entry[loadparm].scsi); /* no return */
 }
 
 /***********************************************************************
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index cf99a4c728..486c0f34f1 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -53,6 +53,15 @@ typedef union BootMapPointer {
     ExtEckdBlockPtr xeckd;
 } __attribute__ ((packed)) BootMapPointer;
 
+#define MAX_TABLE_ENTRIES  30
+
+/* aka Program Table */
+typedef struct BootMapTable {
+    uint8_t magic[4];
+    uint8_t reserved[12];
+    BootMapPointer entry[];
+} __attribute__ ((packed)) BootMapTable;
+
 typedef struct ComponentEntry {
     ScsiBlockPtr data;
     uint8_t pad[7];
@@ -70,7 +79,7 @@ typedef struct ScsiMbr {
     uint8_t magic[4];
     uint32_t version_id;
     uint8_t reserved[8];
-    ScsiBlockPtr blockptr[];
+    ScsiBlockPtr pt;   /* block pointer to program table */
 } __attribute__ ((packed)) ScsiMbr;
 
 #define ZIPL_MAGIC              "zIPL"
-- 
2.13.6
