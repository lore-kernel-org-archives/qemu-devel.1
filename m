Received: from eggs.gnu.org ([2001:4830:134:3::10]:32904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f5umF-000140-Ej
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f5um9-0000M4-P0
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f5um9-0000LG-GM
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3AEwdu5060692
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 11:01:36 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h8ts16y9v-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 11:01:34 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 10 Apr 2018 09:01:33 -0600
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 10 Apr 2018 11:01:23 -0400
In-Reply-To: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
Message-Id: <1523372486-13190-2-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 1/4] pc-bios/s390-ccw: rename MAX_TABLE_ENTRIES
 to MAX_BOOT_ENTRIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, borntraeger@de.ibm.com
Cc: gor@linux.ibm.com, frankja@linux.ibm.com

The MAX_TABLE_ENTRIES constant has a name that is too generic. As we
want to declare a limit for boot menu entries, let's rename it to a more
fitting MAX_BOOT_ENTRIES and set its value to 31 (30 boot entries and
1 default entry). Also we move it from bootmap.h to s390-ccw.h to make
it available for menu.c in a later patch.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  | 6 +++---
 pc-bios/s390-ccw/bootmap.h  | 2 --
 pc-bios/s390-ccw/s390-ccw.h | 2 ++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index fc2a9fe..2f79346 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -290,7 +290,7 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
     }
 
     debug_print_int("loadparm", loadparm);
-    IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
+    IPL_assert(loadparm < MAX_BOOT_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -578,7 +578,7 @@ static void ipl_scsi(void)
     read_block(mbr->pt.blockno, sec, "Error reading Program Table");
     IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
 
-    while (program_table_entries <= MAX_TABLE_ENTRIES) {
+    while (program_table_entries < MAX_BOOT_ENTRIES) {
         if (!prog_table->entry[program_table_entries].scsi.blockno) {
             break;
         }
@@ -593,7 +593,7 @@ static void ipl_scsi(void)
     }
 
     debug_print_int("loadparm", loadparm);
-    IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
+    IPL_assert(loadparm < MAX_BOOT_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
 
     zipl_run(&prog_table->entry[loadparm].scsi); /* no return */
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 07eb600..732c111 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -57,8 +57,6 @@ typedef union BootMapPointer {
     ExtEckdBlockPtr xeckd;
 } __attribute__ ((packed)) BootMapPointer;
 
-#define MAX_TABLE_ENTRIES  30
-
 /* aka Program Table */
 typedef struct BootMapTable {
     uint8_t magic[4];
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index fd18da2..2c9e601 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -94,6 +94,8 @@ bool menu_is_enabled_zipl(void);
 int menu_get_enum_boot_index(int entries);
 bool menu_is_enabled_enum(void);
 
+#define MAX_BOOT_ENTRIES  31
+
 static inline void fill_hex(char *out, unsigned char val)
 {
     const char hex[] = "0123456789abcdef";
-- 
2.7.4
