Received: from eggs.gnu.org ([2001:4830:134:3::10]:58383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNqj-0003bm-6I
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNqf-00074u-2n
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:17 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:01:36 +0100
Message-Id: <20180301130201.24666-3-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 02/27] s390-ccw: refactor eckd_block_num to
 use CHS
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

Add new cylinder/head/sector struct. Use it to calculate
eckd block numbers instead of a BootMapPointer (which used
eckd chs anyway).

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 28 ++++++++++++++--------------
 pc-bios/s390-ccw/bootmap.h |  8 ++++++--
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index a4eaf24c8d..9534f56060 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -95,32 +95,32 @@ static inline void verify_boot_info(BootInfo *bip)
                "Bad block size in zIPL section of the 1st record.");
 }
 
-static block_number_t eckd_block_num(BootMapPointer *p)
+static block_number_t eckd_block_num(EckdCHS *chs)
 {
     const uint64_t sectors = virtio_get_sectors();
     const uint64_t heads = virtio_get_heads();
-    const uint64_t cylinder = p->eckd.cylinder
-                            + ((p->eckd.head & 0xfff0) << 12);
-    const uint64_t head = p->eckd.head & 0x000f;
+    const uint64_t cylinder = chs->cylinder
+                            + ((chs->head & 0xfff0) << 12);
+    const uint64_t head = chs->head & 0x000f;
     const block_number_t block = sectors * heads * cylinder
                                + sectors * head
-                               + p->eckd.sector
+                               + chs->sector
                                - 1; /* block nr starts with zero */
     return block;
 }
 
 static bool eckd_valid_address(BootMapPointer *p)
 {
-    const uint64_t head = p->eckd.head & 0x000f;
+    const uint64_t head = p->eckd.chs.head & 0x000f;
 
     if (head >= virtio_get_heads()
-        ||  p->eckd.sector > virtio_get_sectors()
-        ||  p->eckd.sector <= 0) {
+        ||  p->eckd.chs.sector > virtio_get_sectors()
+        ||  p->eckd.chs.sector <= 0) {
         return false;
     }
 
     if (!virtio_guessed_disk_nature() &&
-        eckd_block_num(p) >= virtio_get_blocks()) {
+        eckd_block_num(&p->eckd.chs) >= virtio_get_blocks()) {
         return false;
     }
 
@@ -140,7 +140,7 @@ static block_number_t load_eckd_segments(block_number_t blk, uint64_t *address)
     do {
         more_data = false;
         for (j = 0;; j++) {
-            block_nr = eckd_block_num((void *)&(bprs[j].xeckd));
+            block_nr = eckd_block_num(&bprs[j].xeckd.bptr.chs);
             if (is_null_block_number(block_nr)) { /* end of chunk */
                 break;
             }
@@ -198,7 +198,7 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr)
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
 
-    block_nr = eckd_block_num(&bmt->entry[loadparm]);
+    block_nr = eckd_block_num(&bmt->entry[loadparm].xeckd.bptr.chs);
     IPL_assert(block_nr != -1, "Cannot find Boot Map Table Entry");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -206,7 +206,7 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr)
 
     for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD; i++) {
         address = bms->entry[i].address.load_address;
-        block_nr = eckd_block_num(&(bms->entry[i].blkptr));
+        block_nr = eckd_block_num(&bms->entry[i].blkptr.xeckd.bptr.chs);
 
         do {
             block_nr = load_eckd_segments(block_nr, &address);
@@ -239,7 +239,7 @@ static void ipl_eckd_cdl(void)
                "Non-ECKD device type in zIPL section of IPL2 record.");
 
     /* save pointer to Boot Map Table */
-    bmt_block_nr = eckd_block_num(&mbr->blockptr);
+    bmt_block_nr = eckd_block_num(&mbr->blockptr.xeckd.bptr.chs);
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(2, vlbl, "Cannot read Volume Label at block 2");
@@ -300,7 +300,7 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     verify_boot_info(bip);
 
     /* save pointer to Boot Map Table */
-    bmt_block_nr = eckd_block_num((void *)&bip->bp.ipl.bm_ptr.eckd.bptr);
+    bmt_block_nr = eckd_block_num(&bip->bp.ipl.bm_ptr.eckd.bptr.chs);
 
     run_eckd_boot_script(bmt_block_nr);
     /* no return */
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 486c0f34f1..b361084073 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -32,10 +32,14 @@ typedef struct FbaBlockPtr {
     uint16_t blockct;
 } __attribute__ ((packed)) FbaBlockPtr;
 
-typedef struct EckdBlockPtr {
-    uint16_t cylinder; /* cylinder/head/sector is an address of the block */
+typedef struct EckdCHS {
+    uint16_t cylinder;
     uint16_t head;
     uint8_t sector;
+} __attribute__ ((packed)) EckdCHS;
+
+typedef struct EckdBlockPtr {
+    EckdCHS chs; /* cylinder/head/sector is an address of the block */
     uint16_t size;
     uint8_t count; /* (size_in_blocks-1);
                     * it's 0 for TablePtr, ScriptPtr, and SectionPtr */
-- 
2.13.6
