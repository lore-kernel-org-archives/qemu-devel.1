Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaI2-0006h3-Kq
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaHI-0006Qa-VY
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:42:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eoaHI-0006PP-DY
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:42:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LJd2SB118914
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:42:07 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9cprphp7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:54 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 14:41:52 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 14:35:41 -0500
In-Reply-To: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1519241752-28083-3-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 02/13] s390-ccw: refactor eckd_block_num to
 use CHS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

Add new cylinder/head/sector struct. Use it to calculate
eckd block numbers instead of a BootMapPointer (which used
eckd chs anyway).

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 28 ++++++++++++++--------------
 pc-bios/s390-ccw/bootmap.h |  8 ++++++--
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index a4eaf24..9534f56 100644
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
index 486c0f3..b361084 100644
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
2.7.4
