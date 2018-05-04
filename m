Received: from eggs.gnu.org ([2001:4830:134:3::10]:34138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV63-0004Pb-AU
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV60-0007HE-HB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:39 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:06 +0200
Message-Id: <20180504072514.8450-8-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] pc-bios/s390-ccw: rename
 MAX_TABLE_ENTRIES to MAX_BOOT_ENTRIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

From: Collin Walling <walling@linux.ibm.com>

The MAX_TABLE_ENTRIES constant has a name that is too generic. As we
want to declare a limit for boot menu entries, let's rename it to a more
fitting MAX_BOOT_ENTRIES and set its value to 31 (30 boot entries and
1 default entry). Also we move it from bootmap.h to s390-ccw.h to make
it available for menu.c in a later patch.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c  | 6 +++---
 pc-bios/s390-ccw/bootmap.h  | 2 --
 pc-bios/s390-ccw/s390-ccw.h | 2 ++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 9287b7a70f..b767fa2afc 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -297,7 +297,7 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
     }
 
     debug_print_int("loadparm", loadparm);
-    IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
+    IPL_assert(loadparm < MAX_BOOT_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -585,7 +585,7 @@ static void ipl_scsi(void)
     read_block(mbr->pt.blockno, sec, "Error reading Program Table");
     IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
 
-    while (program_table_entries <= MAX_TABLE_ENTRIES) {
+    while (program_table_entries < MAX_BOOT_ENTRIES) {
         if (!prog_table->entry[program_table_entries].scsi.blockno) {
             break;
         }
@@ -600,7 +600,7 @@ static void ipl_scsi(void)
     }
 
     debug_print_int("loadparm", loadparm);
-    IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
+    IPL_assert(loadparm < MAX_BOOT_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
 
     zipl_run(&prog_table->entry[loadparm].scsi); /* no return */
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 07eb600b00..732c1112ce 100644
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
index fd18da22c6..2c9e6017b7 100644
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
2.14.3
