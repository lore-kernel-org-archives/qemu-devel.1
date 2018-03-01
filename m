Received: from eggs.gnu.org ([2001:4830:134:3::10]:58731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNrD-00045J-DZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNrA-0007MY-BJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:47 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:01:47 +0100
Message-Id: <20180301130201.24666-14-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 13/27] s390-ccw: interactive boot menu for
 scsi
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

Interactive boot menu for scsi. This follows a similar procedure
as the interactive menu for eckd dasd. An example follows:

    s390x Enumerated Boot Menu.

    3 entries detected. Select from index 0 to 2.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[thuth: Added additional "break;" statement to avoid analyzer warnings]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c              |  2 ++
 pc-bios/s390-ccw/bootmap.c  |  4 ++++
 pc-bios/s390-ccw/main.c     |  1 +
 pc-bios/s390-ccw/menu.c     | 20 ++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |  2 ++
 5 files changed, 29 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index c12e460a7f..798e99aadf 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -247,6 +247,8 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
             return;
         }
         break;
+    case S390_IPL_TYPE_QEMU_SCSI:
+        break;
     default:
         error_report("boot menu is not supported for this device type.");
         return;
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index ae93b552c9..29bfd8c875 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -568,6 +568,10 @@ static void ipl_scsi(void)
     debug_print_int("program table entries", program_table_entries);
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
+    if (menu_is_enabled_enum()) {
+        loadparm = menu_get_enum_boot_index(program_table_entries);
+    }
+
     debug_print_int("loadparm", loadparm);
     IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a7473b0397..9d9f8cf4d3 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -92,6 +92,7 @@ static void menu_setup(void)
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
+    case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
                        qipl.boot_menu_timeout);
         return;
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index ee56939c21..96eec81e84 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -217,6 +217,21 @@ int menu_get_zipl_boot_index(const char *menu_data)
     return get_boot_index(entries - 1); /* subtract 1 to exclude banner */
 }
 
+
+int menu_get_enum_boot_index(int entries)
+{
+    char tmp[4];
+
+    sclp_print("s390x Enumerated Boot Menu.\n\n");
+
+    sclp_print(uitoa(entries, tmp, sizeof(tmp)));
+    sclp_print(" entries detected. Select from boot index 0 to ");
+    sclp_print(uitoa(entries - 1, tmp, sizeof(tmp)));
+    sclp_print(".\n\n");
+
+    return get_boot_index(entries);
+}
+
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
 {
     flag = boot_menu_flag;
@@ -227,3 +242,8 @@ bool menu_is_enabled_zipl(void)
 {
     return flag & (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_ZIPL);
 }
+
+bool menu_is_enabled_enum(void)
+{
+    return flag & QIPL_FLAG_BM_OPTS_CMD;
+}
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index c4ddf9f228..fd18da22c6 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -91,6 +91,8 @@ void zipl_load(void);
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
 int menu_get_zipl_boot_index(const char *menu_data);
 bool menu_is_enabled_zipl(void);
+int menu_get_enum_boot_index(int entries);
+bool menu_is_enabled_enum(void);
 
 static inline void fill_hex(char *out, unsigned char val)
 {
-- 
2.13.6
