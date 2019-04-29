Received: from eggs.gnu.org ([209.51.188.92]:55792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hL62b-0006c4-69
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hL62Y-0008Sa-GD
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:09:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hL62Y-0008R0-5m
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:09:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3TD4b28093327
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:09:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s60w0tt73-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:09:46 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 29 Apr 2019 14:09:45 +0100
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Mon, 29 Apr 2019 09:09:41 -0400
Message-Id: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] s390-bios: Skip bootmap signature entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Newer versions of zipl have the ability to write signature entries to the boot
script for secure boot. We don't yet support secure boot, but we need to skip
over signature entries while reading the boot script in order to maintain our
ability to boot guest operating systems that have a secure bootloader.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
 pc-bios/s390-ccw/bootmap.h | 10 ++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 7aef65a..d13b7cb 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -254,7 +254,14 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(block_nr, sec, "Cannot read Boot Map Script");
 
-    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD; i++) {
+    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
+                bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
+
+        /* We don't support secure boot yet, so we skip signature entries */
+        if (bms->entry[i].type == BOOT_SCRIPT_SIGNATURE) {
+            continue;
+        }
+
         address = bms->entry[i].address.load_address;
         block_nr = eckd_block_num(&bms->entry[i].blkptr.xeckd.bptr.chs);
 
@@ -489,7 +496,15 @@ static void zipl_run(ScsiBlockPtr *pte)
 
     /* Load image(s) into RAM */
     entry = (ComponentEntry *)(&header[1]);
-    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD) {
+    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
+           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
+
+        /* We don't support secure boot yet, so we skip signature entries */
+        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
+            entry++;
+            continue;
+        }
+
         zipl_load_segment(entry);
 
         entry++;
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index a085212..94f53a5 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -98,8 +98,9 @@ typedef struct ScsiMbr {
 #define ZIPL_COMP_HEADER_IPL    0x00
 #define ZIPL_COMP_HEADER_DUMP   0x01
 
-#define ZIPL_COMP_ENTRY_LOAD    0x02
-#define ZIPL_COMP_ENTRY_EXEC    0x01
+#define ZIPL_COMP_ENTRY_EXEC      0x01
+#define ZIPL_COMP_ENTRY_LOAD      0x02
+#define ZIPL_COMP_ENTRY_SIGNATURE 0x03
 
 typedef struct XEckdMbr {
     uint8_t magic[4];   /* == "xIPL"        */
@@ -117,8 +118,9 @@ typedef struct BootMapScriptEntry {
     BootMapPointer blkptr;
     uint8_t pad[7];
     uint8_t type;   /* == BOOT_SCRIPT_* */
-#define BOOT_SCRIPT_EXEC 0x01
-#define BOOT_SCRIPT_LOAD 0x02
+#define BOOT_SCRIPT_EXEC      0x01
+#define BOOT_SCRIPT_LOAD      0x02
+#define BOOT_SCRIPT_SIGNATURE 0x03
     union {
         uint64_t load_address;
         uint64_t load_psw;
-- 
2.7.4
