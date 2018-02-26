Received: from eggs.gnu.org ([2001:4830:134:3::10]:43948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqGFX-0005FH-5c
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqGFU-0002Za-FY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:43:15 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 26 Feb 2018 11:42:31 +0100
Message-Id: <1519641757-12396-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1519641757-12396-1-git-send-email-thuth@redhat.com>
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL-for-s390x 08/14] s390-ccw: read stage2 boot
 loader data to find menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

Read the stage2 boot loader data block-by-block. We scan the
current block for the string "zIPL" to detect the start of the
boot menu banner. We then load the adjacent blocks (previous
block and next block) to account for the possibility of menu
data spanning multiple blocks.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c  | 94 ++++++++++++++++++++++++++++++++++++++++++---
 pc-bios/s390-ccw/bootmap.h  | 23 ++++++++++-
 pc-bios/s390-ccw/menu.c     | 10 +++++
 pc-bios/s390-ccw/s390-ccw.h |  2 +
 4 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 092fb35..ae93b55 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -83,6 +83,10 @@ static void jump_to_IPL_code(uint64_t address)
 
 static unsigned char _bprs[8*1024]; /* guessed "max" ECKD sector size */
 static const int max_bprs_entries = sizeof(_bprs) / sizeof(ExtEckdBlockPtr);
+static uint8_t _s2[MAX_SECTOR_SIZE * 3] __attribute__((__aligned__(PAGE_SIZE)));
+static void *s2_prev_blk = _s2;
+static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
+static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
 
 static inline void verify_boot_info(BootInfo *bip)
 {
@@ -182,7 +186,77 @@ static block_number_t load_eckd_segments(block_number_t blk, uint64_t *address)
     return block_nr;
 }
 
-static void run_eckd_boot_script(block_number_t bmt_block_nr)
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
+    block_number_t cur_block_nr;
+    block_number_t prev_block_nr = 0;
+    block_number_t next_block_nr = 0;
+    EckdStage1b *s1b = (void *)sec;
+    int banner_offset;
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
+        cur_block_nr = eckd_block_num(&s1b->seek[i].chs);
+
+        if (!cur_block_nr) {
+            break;
+        }
+
+        read_block(cur_block_nr, s2_cur_blk, "Cannot read stage2 boot loader");
+
+        if (find_zipl_boot_menu_banner(&banner_offset)) {
+            /*
+             * Load the adjacent blocks to account for the
+             * possibility of menu data spanning multiple blocks.
+             */
+            if (prev_block_nr) {
+                read_block(prev_block_nr, s2_prev_blk,
+                           "Cannot read stage2 boot loader");
+            }
+
+            if (i + 1 < STAGE2_BLK_CNT_MAX) {
+                next_block_nr = eckd_block_num(&s1b->seek[i + 1].chs);
+            }
+
+            if (next_block_nr) {
+                read_block(next_block_nr, s2_next_blk,
+                           "Cannot read stage2 boot loader");
+            }
+
+            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset);
+        }
+
+        prev_block_nr = cur_block_nr;
+    }
+
+    sclp_print("No zipl boot menu data found. Booting default entry.");
+    return 0;
+}
+
+static void run_eckd_boot_script(block_number_t bmt_block_nr,
+                                 block_number_t s1b_block_nr)
 {
     int i;
     unsigned int loadparm = get_loadparm_index();
@@ -191,6 +265,10 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr)
     BootMapTable *bmt = (void *)sec;
     BootMapScript *bms = (void *)sec;
 
+    if (menu_is_enabled_zipl()) {
+        loadparm = eckd_get_boot_menu_index(s1b_block_nr);
+    }
+
     debug_print_int("loadparm", loadparm);
     IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
@@ -223,7 +301,7 @@ static void ipl_eckd_cdl(void)
     XEckdMbr *mbr;
     EckdCdlIpl2 *ipl2 = (void *)sec;
     IplVolumeLabel *vlbl = (void *)sec;
-    block_number_t bmt_block_nr;
+    block_number_t bmt_block_nr, s1b_block_nr;
 
     /* we have just read the block #0 and recognized it as "IPL1" */
     sclp_print("CDL\n");
@@ -241,6 +319,9 @@ static void ipl_eckd_cdl(void)
     /* save pointer to Boot Map Table */
     bmt_block_nr = eckd_block_num(&mbr->blockptr.xeckd.bptr.chs);
 
+    /* save pointer to Stage1b Data */
+    s1b_block_nr = eckd_block_num(&ipl2->stage1.seek[0].chs);
+
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(2, vlbl, "Cannot read Volume Label at block 2");
     IPL_assert(magic_match(vlbl->key, VOL1_MAGIC),
@@ -249,7 +330,7 @@ static void ipl_eckd_cdl(void)
                "Invalid magic of volser block");
     print_volser(vlbl->f.volser);
 
-    run_eckd_boot_script(bmt_block_nr);
+    run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
     /* no return */
 }
 
@@ -280,7 +361,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
 
 static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
-    block_number_t bmt_block_nr;
+    block_number_t bmt_block_nr, s1b_block_nr;
     EckdLdlIpl1 *ipl1 = (void *)sec;
 
     if (mode != ECKD_LDL_UNLABELED) {
@@ -302,7 +383,10 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     /* save pointer to Boot Map Table */
     bmt_block_nr = eckd_block_num(&ipl1->bip.bp.ipl.bm_ptr.eckd.bptr.chs);
 
-    run_eckd_boot_script(bmt_block_nr);
+    /* save pointer to Stage1b Data */
+    s1b_block_nr = eckd_block_num(&ipl1->stage1.seek[0].chs);
+
+    run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
     /* no return */
 }
 
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 4cf7e1e..c636626 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -87,6 +87,7 @@ typedef struct ScsiMbr {
 } __attribute__ ((packed)) ScsiMbr;
 
 #define ZIPL_MAGIC              "zIPL"
+#define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
 #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */
 #define IPL2_MAGIC "\xc9\xd7\xd3\xf2" /* == "IPL2" in EBCDIC */
 #define VOL1_MAGIC "\xe5\xd6\xd3\xf1" /* == "VOL1" in EBCDIC */
@@ -249,15 +250,33 @@ typedef struct EckdCdlIpl1 {
     uint8_t data[24];
 } __attribute__((packed)) EckdCdlIpl1;
 
+typedef struct EckdSeekArg {
+    uint16_t pad;
+    EckdCHS chs;
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
 typedef struct EckdCdlIpl2 {
     uint8_t key[4]; /* == "IPL2" */
-    uint8_t reserved0[88];
+    struct EckdStage1 stage1;
     XEckdMbr mbr;
     uint8_t reserved[24];
 } __attribute__((packed)) EckdCdlIpl2;
 
 typedef struct EckdLdlIpl1 {
-    uint8_t reserved[112];
+    uint8_t reserved[24];
+    struct EckdStage1 stage1;
     BootInfo bip; /* BootInfo is MBR for LDL */
 } __attribute__((packed)) EckdLdlIpl1;
 
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 1ce33dd..c1d242f 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -15,8 +15,18 @@
 static uint8_t flag;
 static uint64_t timeout;
 
+int menu_get_zipl_boot_index(const char *menu_data)
+{
+    return 0; /* implemented next patch */
+}
+
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
 {
     flag = boot_menu_flag;
     timeout = boot_menu_timeout;
 }
+
+bool menu_is_enabled_zipl(void)
+{
+    return flag & QIPL_FLAG_BM_OPTS_CMD;
+}
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 6cfd4b2..c0dd37f 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -86,6 +86,8 @@ void zipl_load(void);
 
 /* menu.c */
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
+int menu_get_zipl_boot_index(const char *menu_data);
+bool menu_is_enabled_zipl(void);
 
 static inline void fill_hex(char *out, unsigned char val)
 {
-- 
1.8.3.1
