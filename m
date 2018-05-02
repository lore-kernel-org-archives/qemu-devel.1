Received: from eggs.gnu.org ([2001:4830:134:3::10]:56922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDspE-0002KK-Hf
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDspA-00052W-Uf
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:33:44 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  2 May 2018 16:33:24 +0200
Message-Id: <1525271609-2142-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1525271609-2142-1-git-send-email-thuth@redhat.com>
References: <1525271609-2142-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 05/10] pc-bios/s390-ccw: fix
 non-sequential boot entries (enum)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

From: Collin Walling <walling@linux.ibm.com>

zIPL boot menu entries can be non-sequential. Let's account
for this issue for the s390 enumerated boot menu. Since we
can no longer print a range of available entries to the
user, we have to present a list of each available entry.

An example of this menu:

  s390-ccw Enumerated Boot Menu.

   [0] default

   [1]
   [2]
   [7]
   [8]
   [9]
  [11]
  [12]

  Please choose:

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c  | 12 +++++++-----
 pc-bios/s390-ccw/menu.c     | 29 ++++++++++++++++++++---------
 pc-bios/s390-ccw/s390-ccw.h |  2 +-
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index b767fa2..e41e715 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -565,6 +565,8 @@ static void ipl_scsi(void)
     int program_table_entries = 0;
     BootMapTable *prog_table = (void *)sec;
     unsigned int loadparm = get_loadparm_index();
+    bool valid_entries[MAX_BOOT_ENTRIES] = {false};
+    size_t i;
 
     /* Grab the MBR */
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -585,18 +587,18 @@ static void ipl_scsi(void)
     read_block(mbr->pt.blockno, sec, "Error reading Program Table");
     IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
 
-    while (program_table_entries < MAX_BOOT_ENTRIES) {
-        if (!prog_table->entry[program_table_entries].scsi.blockno) {
-            break;
+    for (i = 0; i < MAX_BOOT_ENTRIES; i++) {
+        if (prog_table->entry[i].scsi.blockno) {
+            valid_entries[i] = true;
+            program_table_entries++;
         }
-        program_table_entries++;
     }
 
     debug_print_int("program table entries", program_table_entries);
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
     if (menu_is_enabled_enum()) {
-        loadparm = menu_get_enum_boot_index(program_table_entries);
+        loadparm = menu_get_enum_boot_index(valid_entries);
     }
 
     debug_print_int("loadparm", loadparm);
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index aaf5d61..82a4ae6 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -228,19 +228,30 @@ int menu_get_zipl_boot_index(const char *menu_data)
     return get_boot_index(valid_entries);
 }
 
-
-int menu_get_enum_boot_index(int entries)
+int menu_get_enum_boot_index(bool *valid_entries)
 {
-    char tmp[4];
+    char tmp[3];
+    int i;
 
-    sclp_print("s390x Enumerated Boot Menu.\n\n");
+    sclp_print("s390-ccw Enumerated Boot Menu.\n\n");
 
-    sclp_print(uitoa(entries, tmp, sizeof(tmp)));
-    sclp_print(" entries detected. Select from boot index 0 to ");
-    sclp_print(uitoa(entries - 1, tmp, sizeof(tmp)));
-    sclp_print(".\n\n");
+    for (i = 0; i < MAX_BOOT_ENTRIES; i++) {
+        if (valid_entries[i]) {
+            if (i < 10) {
+                sclp_print(" ");
+            }
+            sclp_print("[");
+            sclp_print(uitoa(i, tmp, sizeof(tmp)));
+            sclp_print("]");
+            if (i == 0) {
+                sclp_print(" default\n");
+            }
+            sclp_print("\n");
+        }
+    }
 
-    return get_boot_index(entries);
+    sclp_print("\n");
+    return get_boot_index(valid_entries);
 }
 
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 2c9e601..a1bdb4c 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -91,7 +91,7 @@ void zipl_load(void);
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
 int menu_get_zipl_boot_index(const char *menu_data);
 bool menu_is_enabled_zipl(void);
-int menu_get_enum_boot_index(int entries);
+int menu_get_enum_boot_index(bool *valid_entries);
 bool menu_is_enabled_enum(void);
 
 #define MAX_BOOT_ENTRIES  31
-- 
1.8.3.1
