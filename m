Received: from eggs.gnu.org ([2001:4830:134:3::10]:58912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5Xyb-0001L7-Ff
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5Xya-0001qT-5H
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5XyZ-0001q9-Sd
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYIX7030955
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:22 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6q0n54e9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:22 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:20 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:36:01 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-10-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 09/12] pc-bios/s390-ccw: add boot entry
 selection for ECKD DASD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.vnet.ibm.com>, Eugene Dvurechenski <jno@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

1. change a bit definition of ScsiMbr to allow an array of pointers
2. add loadparm fetch to boot script processing
3. apply loadparm index to boot entry selection, if any

Initial patch from Eugene (jno) Dvurechenski.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 16 +++++++++++-----
 pc-bios/s390-ccw/bootmap.h |  2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index e39e67e07b..e974350b6f 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -183,15 +183,21 @@ static block_number_t load_eckd_segments(block_number_t blk, uint64_t *address)
 static void run_eckd_boot_script(block_number_t mbr_block_nr)
 {
     int i;
+    unsigned int loadparm = get_loadparm_index();
     block_number_t block_nr;
     uint64_t address;
-    ScsiMbr *scsi_mbr = (void *)sec;
+    ScsiMbr *bte = (void *)sec; /* Eckd bootmap table entry */
     BootMapScript *bms = (void *)sec;
 
+    debug_print_int("loadparm", loadparm);
+    IPL_assert(loadparm < 31, "loadparm value greater than"
+               " maximum number of boot entries allowed");
+
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(mbr_block_nr, sec, "Cannot read MBR");
 
-    block_nr = eckd_block_num((void *)&(scsi_mbr->blockptr));
+    block_nr = eckd_block_num((void *)&(bte->blockptr[loadparm]));
+    IPL_assert(block_nr != -1, "No Boot Map");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(block_nr, sec, "Cannot read Boot Map Script");
@@ -459,11 +465,11 @@ static void ipl_scsi(void)
     debug_print_int("MBR Version", mbr->version_id);
     IPL_check(mbr->version_id == 1,
               "Unknown MBR layout version, assuming version 1");
-    debug_print_int("program table", mbr->blockptr.blockno);
-    IPL_assert(mbr->blockptr.blockno, "No Program Table");
+    debug_print_int("program table", mbr->blockptr[0].blockno);
+    IPL_assert(mbr->blockptr[0].blockno, "No Program Table");
 
     /* Parse the program table */
-    read_block(mbr->blockptr.blockno, sec,
+    read_block(mbr->blockptr[0].blockno, sec,
                "Error reading Program Table");
 
     IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 9073de2238..7f367820f3 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -70,7 +70,7 @@ typedef struct ScsiMbr {
     uint8_t magic[4];
     uint32_t version_id;
     uint8_t reserved[8];
-    ScsiBlockPtr blockptr;
+    ScsiBlockPtr blockptr[];
 } __attribute__ ((packed)) ScsiMbr;
 
 #define ZIPL_MAGIC              "zIPL"
-- 
2.11.0
