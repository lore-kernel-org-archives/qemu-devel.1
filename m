Received: from eggs.gnu.org ([2001:4830:134:3::10]:53219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJOVF-000698-Rz
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJOVC-0005LU-MD
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57674
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJOVC-0005L8-GX
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:34 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vARInBtU018591
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 13:51:32 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2egp8jx3rr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 13:51:31 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 13:51:30 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 13:50:58 -0500
In-Reply-To: <1511808659-8846-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1511808659-8846-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1511808659-8846-4-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 3/4] s390-ccw: interactive boot menu for
 eckd dasd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

When the boot menu options are present and the guest's
disk has been configured by the zipl tool, then the user
will be presented with an interactive boot menu with
labeled entries. An example of what the menu might look
like:

    zIPL v1.37.1-build-20170714 interactive boot menu.

     0. default (default)

     1. default
     2. performance
     3. kvm

    Please choose (default will boot in 10 seconds):

If the user's input is empty or 0, the default zipl entry will
be chosen. If the input is within the range presented by the
menu, then the selection will be booted. Any erroneous input
will cancel the timeout and prompt the user until correct
input is given.

Any value set for loadparm will override all boot menu options.
If loadparm=PROMPT, then the menu prompt will continuously wait
until correct user input is given.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  |  77 +++++++++++++++++++++++++-
 pc-bios/s390-ccw/bootmap.h  |   2 +
 pc-bios/s390-ccw/main.c     |  18 +++++-
 pc-bios/s390-ccw/menu.c     | 108 ++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |   6 ++
 pc-bios/s390-ccw/sclp.c     | 132 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 340 insertions(+), 5 deletions(-)
 create mode 100644 pc-bios/s390-ccw/menu.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 6d0c2ee..f03096b 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
 .PHONY : all clean build-all
 
-OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
+OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o menu.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 5546b79..3aea6e0 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -28,6 +28,7 @@
 
 /* Scratch space */
 static uint8_t sec[MAX_SECTOR_SIZE*4] __attribute__((__aligned__(PAGE_SIZE)));
+static uint8_t s2_area[STAGE2_MAX_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
 typedef struct ResetInfo {
     uint32_t ipl_mask;
@@ -182,7 +183,66 @@ static block_number_t load_eckd_segments(block_number_t blk, uint64_t *address)
     return block_nr;
 }
 
-static void run_eckd_boot_script(block_number_t mbr_block_nr)
+static block_number_t chs(const BootEckdSeekarg seek)
+{
+    /* we cannot have a sector of 0 */
+    if (seek.sec == 0) {
+        return 0;
+    }
+
+    const uint64_t sectors = virtio_get_sectors();
+    const uint64_t heads = virtio_get_heads();
+
+    return (seek.cyl * heads + seek.head) * sectors + (seek.sec - 1);
+}
+
+static void read_stage2(block_number_t s1b_block_nr, void **stage2_data)
+{
+    block_number_t s2_block_nr;
+    BootEckdStage1b *s1b = (void *)sec;
+    int i;
+
+    /* Get Stage1b data */
+    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
+    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader.");
+
+    /* Get Stage2 data */
+    *stage2_data = (void *)s2_area;
+    memset(s2_area, FREE_SPACE_FILLER, sizeof(s2_area));
+
+    for (i = 0; i < STAGE2_MAX_SIZE / MAX_SECTOR_SIZE; i++) {
+        s2_block_nr = chs(s1b->seek[i]);
+        if (!s2_block_nr) {
+            break;
+        }
+        read_block(s2_block_nr, (*stage2_data + MAX_SECTOR_SIZE * i),
+                   "Error reading Stage2 data");
+    }
+}
+
+static int zipl_boot_menu(block_number_t s1b_block_nr)
+{
+    void *stage2_data, *menu_offset;
+
+    read_stage2(s1b_block_nr, &stage2_data);
+    menu_offset = stage2_data;
+
+    /* Menu banner starts with "zIPL" */
+    while (menu_offset < stage2_data + STAGE2_MAX_SIZE - 4) {
+        if (magic_match(menu_offset, ZIPL_MAGIC_EBCDIC)) {
+            return menu_get_zipl_boot_index(menu_offset);
+        }
+        menu_offset++;
+    }
+
+    panic("\n! No menu data found !\n");
+
+    /* should not reach here */
+    return 0;
+}
+
+static void run_eckd_boot_script(block_number_t mbr_block_nr,
+                                 block_number_t s1b_block_nr)
 {
     int i;
     unsigned int loadparm = get_loadparm_index();
@@ -191,6 +251,10 @@ static void run_eckd_boot_script(block_number_t mbr_block_nr)
     ScsiMbr *bte = (void *)sec; /* Eckd bootmap table entry */
     BootMapScript *bms = (void *)sec;
 
+    if (menu_is_enabled()) {
+        loadparm = zipl_boot_menu(s1b_block_nr);
+    }
+
     debug_print_int("loadparm", loadparm);
     IPL_assert(loadparm < 31, "loadparm value greater than"
                " maximum number of boot entries allowed");
@@ -224,6 +288,7 @@ static void ipl_eckd_cdl(void)
     EckdCdlIpl2 *ipl2 = (void *)sec;
     IplVolumeLabel *vlbl = (void *)sec;
     block_number_t mbr_block_nr;
+    block_number_t s1b_block_nr;
 
     /* we have just read the block #0 and recognized it as "IPL1" */
     sclp_print("CDL\n");
@@ -241,6 +306,9 @@ static void ipl_eckd_cdl(void)
     /* save pointer to Boot Script */
     mbr_block_nr = eckd_block_num((void *)&(mbr->blockptr));
 
+    /* save pointer to Stage1b Data */
+    s1b_block_nr = chs(ipl2->stage1.seek[0]);
+
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(2, vlbl, "Cannot read Volume Label at block 2");
     IPL_assert(magic_match(vlbl->key, VOL1_MAGIC),
@@ -249,7 +317,7 @@ static void ipl_eckd_cdl(void)
                "Invalid magic of volser block");
     print_volser(vlbl->f.volser);
 
-    run_eckd_boot_script(mbr_block_nr);
+    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
     /* no return */
 }
 
@@ -281,6 +349,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
 static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
     block_number_t mbr_block_nr;
+    block_number_t s1b_block_nr;
     EckdLdlIpl1 *ipl1 = (void *)sec;
 
     if (mode != ECKD_LDL_UNLABELED) {
@@ -302,7 +371,9 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     mbr_block_nr =
         eckd_block_num((void *)&(ipl1->boot_info.bp.ipl.bm_ptr.eckd.bptr));
 
-    run_eckd_boot_script(mbr_block_nr);
+    s1b_block_nr = chs(ipl1->stage1.seek[0]);
+
+    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
     /* no return */
 }
 
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index a2b4695..005be6c 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -74,6 +74,7 @@ typedef struct ScsiMbr {
 } __attribute__ ((packed)) ScsiMbr;
 
 #define ZIPL_MAGIC              "zIPL"
+#define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
 #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */
 #define IPL2_MAGIC "\xc9\xd7\xd3\xf2" /* == "IPL2" in EBCDIC */
 #define VOL1_MAGIC "\xe5\xd6\xd3\xf1" /* == "VOL1" in EBCDIC */
@@ -229,6 +230,7 @@ typedef struct BootInfo {          /* @ 0x70, record #0    */
 /*
  * Structs for IPL
  */
+#define STAGE2_MAX_SIZE     0x3000
 #define STAGE2_BLK_CNT_MAX  24 /* Stage 1b can load up to 24 blocks */
 
 typedef struct EckdCdlIpl1 {
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a8ef120..fd2b16f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -12,6 +12,9 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 
+#define LOADPARM_EMPTY  "........"
+#define LOADPARM_PROMPT "PROMPT  "
+
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
@@ -73,6 +76,16 @@ static bool find_dev(Schib *schib, int dev_no)
     return false;
 }
 
+static void set_boot_menu(uint8_t boot_menu_enabled,
+                          uint16_t boot_menu_timeout)
+{
+    if (memcmp(loadparm, LOADPARM_EMPTY, 8) == 0 && boot_menu_enabled) {
+        menu_enable(boot_menu_timeout);
+    } else if (memcmp(loadparm, LOADPARM_PROMPT, 8) == 0) {
+        menu_enable(0);
+    }
+}
+
 static void virtio_setup(void)
 {
     Schib schib;
@@ -101,6 +114,8 @@ static void virtio_setup(void)
             blk_schid.ssid = iplb.ccw.ssid & 0x3;
             debug_print_int("ssid ", blk_schid.ssid);
             found = find_dev(&schib, dev_no);
+            set_boot_menu(iplb.ccw.boot_menu_enabled,
+                          iplb.ccw.boot_menu_timeout);
             break;
         case S390_IPL_TYPE_QEMU_SCSI:
             vdev->scsi_device_selected = true;
@@ -109,6 +124,8 @@ static void virtio_setup(void)
             vdev->selected_scsi_device.lun = iplb.scsi.lun;
             blk_schid.ssid = iplb.scsi.ssid & 0x3;
             found = find_dev(&schib, iplb.scsi.devno);
+            set_boot_menu(iplb.scsi.boot_menu_enabled,
+                          iplb.scsi.boot_menu_timeout);
             break;
         default:
             panic("List-directed IPL not supported yet!\n");
@@ -122,7 +139,6 @@ static void virtio_setup(void)
             }
         }
     }
-
     IPL_assert(found, "No virtio device found");
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
new file mode 100644
index 0000000..0bd0be6
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.c
@@ -0,0 +1,108 @@
+/*
+ * QEMU S390 Boot Menu
+ *
+ * Copyright 2017 IBM Corp.
+ * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "libc.h"
+#include "s390-ccw.h"
+
+static bool enabled;
+static uint64_t timeout;
+
+static int menu_read_index(uint64_t timeout)
+{
+    char *inp;
+    int len;
+    int i;
+
+    len = sclp_read(&inp, timeout);
+
+    if (len == 0) {
+        return 0;
+    }
+
+    for (i = 0; i < len; i++) {
+        if (!isdigit(inp[i])) {
+            return -1;
+        }
+    }
+
+    return atoi(inp);
+}
+
+static int menu_get_boot_index(int entries)
+{
+    char tmp[4];
+    int boot_index;
+
+    /* Prompt User */
+    if (timeout > 0) {
+        sclp_print("Please choose (default will boot in ");
+        sclp_print(itostr(timeout / 1000, tmp));
+        sclp_print(" seconds):\n");
+    } else {
+        sclp_print("Please choose:\n");
+    }
+
+    /* Get Menu Choice */
+    boot_index = menu_read_index(timeout);
+
+    while (boot_index < 0 || boot_index >= entries) {
+        sclp_print("\nError: undefined configuration"
+                   "\nPlease choose:\n");
+        boot_index = menu_read_index(0);
+    }
+
+    sclp_print("\nBooting entry #");
+    sclp_print(itostr(boot_index, tmp));
+
+    return boot_index;
+}
+
+static void menu_println(const char *data, size_t len)
+{
+    char buf[len + 1];
+
+    ebcdic_to_ascii(data, buf, len);
+    buf[len] = '\n';
+    buf[len + 1] = '\0';
+
+    sclp_print(buf);
+}
+
+int menu_get_zipl_boot_index(const char *data)
+{
+    size_t len;
+    int i;
+
+    /* Print all menu items, including the banner */
+    for (i = 0; *data != '\0'; i++) {
+        len = strlen(data);
+        menu_println(data, len);
+        if (i < 2) {
+            sclp_print("\n");
+        }
+        data += len + 1;
+    }
+
+    sclp_print("\n");
+
+    return menu_get_boot_index(i - 1);
+}
+
+void menu_enable(uint16_t boot_menu_timeout)
+{
+    timeout = boot_menu_timeout;
+    enabled = true;
+}
+
+bool menu_is_enabled(void)
+{
+    return enabled;
+}
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 25d4d21..3a9c873 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -71,6 +71,7 @@ unsigned int get_loadparm_index(void);
 void sclp_print(const char *string);
 void sclp_setup(void);
 void sclp_get_loadparm_ascii(char *loadparm);
+int sclp_read(char **buf_ptr, uint64_t timeout);
 
 /* virtio.c */
 unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
@@ -84,6 +85,11 @@ ulong get_second(void);
 /* bootmap.c */
 void zipl_load(void);
 
+/* menu.c */
+void menu_enable(uint16_t boot_menu_timeout);
+int menu_is_enabled(void);
+int menu_get_zipl_boot_index(const char *data);
+
 static inline void fill_hex(char *out, unsigned char val)
 {
     const char hex[] = "0123456789abcdef";
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index e6a0898..bbd206e 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -12,6 +12,11 @@
 #include "s390-ccw.h"
 #include "sclp.h"
 
+#define KEYCODE_NO_INP '\0'
+#define KEYCODE_ARROWS '\033'
+#define KEYCODE_BACKSP '\177'
+#define KEYCODE_ENTER  '\r'
+
 long write(int fd, const void *str, size_t len);
 
 static char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
@@ -119,3 +124,130 @@ void sclp_get_loadparm_ascii(char *loadparm)
         ebcdic_to_ascii((char *) sccb->loadparm, loadparm, 8);
     }
 }
+
+static void read(char **str)
+{
+    ReadEventData *sccb = (void *)_sccb;
+    *str = (char *)(&sccb->ebh) + 7;
+
+    sccb->h.length = SCCB_SIZE;
+    sccb->h.function_code = SCLP_UNCONDITIONAL_READ;
+    sccb->ebh.length = sizeof(EventBufferHeader);
+    sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
+    sccb->ebh.flags = 0;
+
+    sclp_service_call(SCLP_CMD_READ_EVENT_DATA, sccb);
+}
+
+static inline void enable_clock_int(void)
+{
+    uint64_t tmp = 0;
+
+    asm volatile(
+        "stctg      0,0,%0\n"
+        "oi         6+%0, 0x8\n"
+        "lctlg      0,0,%0"
+        : : "Q" (tmp)
+    );
+}
+
+static inline void disable_clock_int(void)
+{
+    uint64_t tmp = 0;
+
+    asm volatile(
+        "stctg      0,0,%0\n"
+        "ni         6+%0, 0xf7\n"
+        "lctlg      0,0,%0"
+        : : "Q" (tmp)
+    );
+}
+
+static inline bool check_clock_int(void)
+{
+    uint16_t code;
+
+    consume_sclp_int();
+
+    asm volatile(
+        "lh         1, 0x86(0,0)\n"
+        "sth        1, %0"
+        : "=r" (code)
+    );
+
+    return code == 0x1004;
+}
+
+static inline void set_clock_comparator(uint64_t time)
+{
+    asm volatile("sckc %0" : : "Q" (time));
+}
+
+/* sclp_read
+ *
+ * Reads user input from the sclp console into a buffer. The buffer
+ * is set and the length is returned only if the enter key was detected.
+ *
+ * @param buf_ptr - a pointer to the buffer
+ *
+ * @param timeout - time (in milliseconds) to wait before abruptly
+ *                  ending user-input read loop. if 0, then loop
+ *                  until an enter key is detected
+ *
+ * @return - the length of the data in the buffer
+ */
+int sclp_read(char **buf_ptr, uint64_t timeout)
+{
+    char *inp = NULL;
+    char buf[255];
+    uint8_t len = 0;
+    uint64_t seconds;
+
+    memset(buf, 0, sizeof(buf));
+
+    if (timeout) {
+        seconds = get_second() + timeout / 1000;
+        set_clock_comparator((seconds * 1000000) << 12);
+        enable_clock_int();
+    }
+
+    while (!check_clock_int()) {
+        read(&inp);
+
+        switch (inp[0]) {
+        case KEYCODE_NO_INP:
+        case KEYCODE_ARROWS:
+            continue;
+        case KEYCODE_BACKSP:
+            if (len > 0) {
+                len--;
+
+                /* Remove last character */
+                buf[len] = ' ';
+                write(1, "\r", 1);
+                write(1, buf, len + 1);
+
+                /* Reset cursor */
+                buf[len] = 0;
+                write(1, "\r", 1);
+                write(1, buf, len);
+            }
+            continue;
+        case KEYCODE_ENTER:
+            disable_clock_int();
+
+            *buf_ptr = buf;
+            return len;
+        }
+
+        /* Echo input and add to buffer */
+        if (len < sizeof(buf)) {
+            buf[len] = inp[0];
+            len++;
+            write(1, inp, 1);
+        }
+    }
+
+    disable_clock_int();
+    return 0;
+}
-- 
2.7.4
