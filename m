Received: from eggs.gnu.org ([2001:4830:134:3::10]:54657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOWQg-0001FK-0h
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOWQa-0001Yn-Jl
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53006
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eOWQa-0001YP-CZ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:00 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBMG8IB012183
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 17:19:59 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2esyjk1ag2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 17:19:59 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 11 Dec 2017 17:19:58 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 11 Dec 2017 17:19:19 -0500
In-Reply-To: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1513030760-26245-5-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/5] s390-ccw: interactive boot menu for
 eckd dasd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com

When the boot menu options are present and the guest's
disk has been configured by the zipl tool, then the user
will be presented with an interactive boot menu with
labeled entries. An example of what the menu might look
like:

    zIPL v1.37.1-build-20170714 interactive boot menu.

     0. default (linux-4.13.0)

     1. linux-4.13.0
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

The absence of any boot options on the command line will attempt
to use the zipl loader values.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  |  71 +++++++++++++-
 pc-bios/s390-ccw/bootmap.h  |   2 +
 pc-bios/s390-ccw/main.c     |   3 +
 pc-bios/s390-ccw/menu.c     | 223 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h     |  28 ++++++
 pc-bios/s390-ccw/s390-ccw.h |   2 +
 pc-bios/s390-ccw/sclp.c     |  20 ++++
 pc-bios/s390-ccw/virtio.c   |   2 +-
 9 files changed, 348 insertions(+), 5 deletions(-)
 create mode 100644 pc-bios/s390-ccw/menu.c
 create mode 100644 pc-bios/s390-ccw/menu.h

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 9f7904f..1712c2d 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
 .PHONY : all clean build-all
 
-OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o libc.o
+OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o libc.o menu.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 5546b79..c817cf8 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -13,6 +13,7 @@
 #include "bootmap.h"
 #include "virtio.h"
 #include "bswap.h"
+#include "menu.h"
 
 #ifdef DEBUG
 /* #define DEBUG_FALLBACK */
@@ -83,6 +84,7 @@ static void jump_to_IPL_code(uint64_t address)
 
 static unsigned char _bprs[8*1024]; /* guessed "max" ECKD sector size */
 static const int max_bprs_entries = sizeof(_bprs) / sizeof(ExtEckdBlockPtr);
+static uint8_t stage2[STAGE2_MAX_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
 static inline void verify_boot_info(BootInfo *bip)
 {
@@ -182,7 +184,57 @@ static block_number_t load_eckd_segments(block_number_t blk, uint64_t *address)
     return block_nr;
 }
 
-static void run_eckd_boot_script(block_number_t mbr_block_nr)
+static void read_stage2(block_number_t s1b_block_nr)
+{
+    block_number_t s2_block_nr;
+    EckdStage1b *s1b = (void *)sec;
+    int i;
+
+    /* Get Stage1b data */
+    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
+    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader.");
+
+    /* Get Stage2 data */
+    memset(stage2, FREE_SPACE_FILLER, sizeof(stage2));
+
+    for (i = 0; i < STAGE2_MAX_SIZE / MAX_SECTOR_SIZE; i++) {
+        s2_block_nr = eckd_block_num((void *)&(s1b->seek[i].cyl));
+
+        if (!s2_block_nr) {
+            break;
+        }
+
+        read_block(s2_block_nr, (stage2 + MAX_SECTOR_SIZE * i),
+                   "Error reading Stage2 data");
+    }
+}
+
+static bool find_zipl_boot_menu_data(block_number_t s1b_block_nr,
+                                     ZiplParms *zipl_parms)
+{
+    int offset;
+    void *s2_offset;
+
+    read_stage2(s1b_block_nr);
+
+    /* Menu banner starts with "zIPL" */
+    for (offset = 0; offset < STAGE2_MAX_SIZE - 4; offset++) {
+        s2_offset = stage2 + offset;
+
+        if (magic_match(s2_offset, ZIPL_MAGIC_EBCDIC)) {
+            zipl_parms->flag = *(uint16_t *)(s2_offset - 140);
+            zipl_parms->timeout = *(uint16_t *)(s2_offset - 138);
+            zipl_parms->menu_start = offset;
+            return true;
+        }
+    }
+
+    sclp_print("No zipl boot menu data found. Booting default entry.");
+    return false;
+}
+
+static void run_eckd_boot_script(block_number_t mbr_block_nr,
+                                 block_number_t s1b_block_nr)
 {
     int i;
     unsigned int loadparm = get_loadparm_index();
@@ -190,6 +242,12 @@ static void run_eckd_boot_script(block_number_t mbr_block_nr)
     uint64_t address;
     ScsiMbr *bte = (void *)sec; /* Eckd bootmap table entry */
     BootMapScript *bms = (void *)sec;
+    ZiplParms zipl_parms;
+
+    if (menu_check_flags(BOOT_MENU_FLAG_BOOT_OPTS | BOOT_MENU_FLAG_ZIPL_OPTS)
+        && find_zipl_boot_menu_data(s1b_block_nr, &zipl_parms)) {
+        loadparm = menu_get_zipl_boot_index(stage2, zipl_parms);
+    }
 
     debug_print_int("loadparm", loadparm);
     IPL_assert(loadparm < 31, "loadparm value greater than"
@@ -224,6 +282,7 @@ static void ipl_eckd_cdl(void)
     EckdCdlIpl2 *ipl2 = (void *)sec;
     IplVolumeLabel *vlbl = (void *)sec;
     block_number_t mbr_block_nr;
+    block_number_t s1b_block_nr;
 
     /* we have just read the block #0 and recognized it as "IPL1" */
     sclp_print("CDL\n");
@@ -241,6 +300,9 @@ static void ipl_eckd_cdl(void)
     /* save pointer to Boot Script */
     mbr_block_nr = eckd_block_num((void *)&(mbr->blockptr));
 
+    /* save pointer to Stage1b Data */
+    s1b_block_nr = eckd_block_num((void *)&(ipl2->stage1.seek[0].cyl));
+
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(2, vlbl, "Cannot read Volume Label at block 2");
     IPL_assert(magic_match(vlbl->key, VOL1_MAGIC),
@@ -249,7 +311,7 @@ static void ipl_eckd_cdl(void)
                "Invalid magic of volser block");
     print_volser(vlbl->f.volser);
 
-    run_eckd_boot_script(mbr_block_nr);
+    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
     /* no return */
 }
 
@@ -281,6 +343,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
 static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
     block_number_t mbr_block_nr;
+    block_number_t s1b_block_nr;
     EckdLdlIpl1 *ipl1 = (void *)sec;
 
     if (mode != ECKD_LDL_UNLABELED) {
@@ -302,7 +365,9 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     mbr_block_nr =
         eckd_block_num((void *)&(ipl1->boot_info.bp.ipl.bm_ptr.eckd.bptr));
 
-    run_eckd_boot_script(mbr_block_nr);
+    s1b_block_nr = eckd_block_num((void *)&(ipl1->stage1.seek[0].cyl));
+
+    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
     /* no return */
 }
 
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index b700d08..8089402 100644
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
index a8ef120..fb0ef92 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -11,6 +11,7 @@
 #include "libc.h"
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "menu.h"
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
@@ -101,6 +102,8 @@ static void virtio_setup(void)
             blk_schid.ssid = iplb.ccw.ssid & 0x3;
             debug_print_int("ssid ", blk_schid.ssid);
             found = find_dev(&schib, dev_no);
+            menu_set_parms(iplb.ccw.boot_menu_flags,
+                           iplb.ccw.boot_menu_timeout);
             break;
         case S390_IPL_TYPE_QEMU_SCSI:
             vdev->scsi_device_selected = true;
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
new file mode 100644
index 0000000..d707afb
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.c
@@ -0,0 +1,223 @@
+/*
+ * QEMU S390 Interactive Boot Menu
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
+#include "menu.h"
+
+#define KEYCODE_NO_INP '\0'
+#define KEYCODE_ESCAPE '\033'
+#define KEYCODE_BACKSP '\177'
+#define KEYCODE_ENTER  '\r'
+
+static uint8_t flags;
+static uint64_t timeout;
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
+static inline void set_clock_comparator(uint64_t time)
+{
+    asm volatile("sckc %0" : : "Q" (time));
+}
+
+static inline bool check_clock_int(void)
+{
+    uint16_t code = *(uint16_t *)0x86;
+
+    consume_sclp_int();
+
+    return code == 0x1004;
+}
+
+static int read_prompt(char *buf, size_t len)
+{
+    char inp[2];
+    uint8_t idx = 0;
+    uint64_t time;
+
+    if (timeout) {
+        time = get_clock() + (timeout << 32);
+        set_clock_comparator(time);
+        enable_clock_int();
+    }
+
+    inp[1] = '\0';
+
+    while (!check_clock_int()) {
+
+        /* Process only one character at a time */
+        sclp_read(inp, 1);
+
+        switch (inp[0]) {
+        case KEYCODE_NO_INP:
+        case KEYCODE_ESCAPE:
+            continue;
+        case KEYCODE_BACKSP:
+            if (idx > 0) {
+                /* Remove last character */
+                buf[idx - 1] = ' ';
+                sclp_print("\r");
+                sclp_print(buf);
+
+                idx--;
+
+                /* Reset cursor */
+                buf[idx] = 0;
+                sclp_print("\r");
+                sclp_print(buf);
+            }
+            continue;
+        case KEYCODE_ENTER:
+            disable_clock_int();
+            return idx;
+        }
+
+        /* Echo input and add to buffer */
+        if (idx < len) {
+            buf[idx] = inp[0];
+            sclp_print(inp);
+            idx++;
+        }
+    }
+
+    disable_clock_int();
+    *buf = NULL;
+
+    return 0;
+}
+
+static int get_index(void)
+{
+    char buf[10];
+    int len;
+    int i;
+
+    memset(buf, 0, sizeof(buf));
+
+    len = read_prompt(buf, sizeof(buf));
+
+    if (len == 0) {
+        return 0;
+    }
+
+    for (i = 0; i < len; i++) {
+        if (!isdigit(buf[i])) {
+            return -1;
+        }
+    }
+
+    return atoi(buf);
+}
+
+static int get_boot_index(int entries)
+{
+    char tmp[6];
+    int boot_index;
+
+    /* Prompt User */
+    if (timeout > 0) {
+        sclp_print("Please choose (default will boot in ");
+        sclp_print(itostr(timeout, tmp, sizeof(tmp)));
+        sclp_print(" seconds):\n");
+    } else {
+        sclp_print("Please choose:\n");
+    }
+
+    /* Get Menu Choice */
+    boot_index = get_index();
+
+    timeout = 0;
+
+    while (boot_index < 0 || boot_index >= entries) {
+        sclp_print("\nError: undefined configuration"
+                   "\nPlease choose:\n");
+        boot_index = get_index();
+    }
+
+    sclp_print("\nBooting entry #");
+    sclp_print(itostr(boot_index, tmp, sizeof(tmp)));
+
+    return boot_index;
+}
+
+static void zipl_println(const char *data, size_t len)
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
+int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms)
+{
+    const char *data = stage2 + zipl_parms.menu_start;
+    size_t len;
+    int ct;
+
+    if (flags & BOOT_MENU_FLAG_ZIPL_OPTS) {
+        if (zipl_parms.flag) {
+            timeout = zipl_parms.timeout;
+        } else {
+            return 0; /* Boot default */
+        }
+    }
+
+    /* Print and count all menu items, including the banner */
+    for (ct = 0; *data; ct++) {
+        len = strlen(data);
+        zipl_println(data, len);
+        data += len + 1;
+
+        if (ct < 2) {
+            sclp_print("\n");
+        }
+    }
+
+    sclp_print("\n");
+
+    return get_boot_index(ct - 1);
+}
+
+void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
+{
+    flags = boot_menu_flag;
+    timeout = boot_menu_timeout;
+}
+
+int menu_check_flags(uint8_t check_flags)
+{
+    return flags & check_flags;
+}
diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
new file mode 100644
index 0000000..a8727fa
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU S390 Interactive Boot Menu
+ *
+ * Copyright 2017 IBM Corp.
+ * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef MENU_H
+#define MENU_H
+
+#define BOOT_MENU_FLAG_BOOT_OPTS 0x80
+#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
+
+typedef struct ZiplParms {
+    unsigned short flag;
+    unsigned short timeout;
+    unsigned long long menu_start;
+} ZiplParms;
+
+void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
+bool menu_check_flags(uint8_t check_flags);
+int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms);
+
+#endif /* MENU_H */
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 25d4d21..df4bc88 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -71,6 +71,7 @@ unsigned int get_loadparm_index(void);
 void sclp_print(const char *string);
 void sclp_setup(void);
 void sclp_get_loadparm_ascii(char *loadparm);
+void sclp_read(char *str, size_t len);
 
 /* virtio.c */
 unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
@@ -79,6 +80,7 @@ bool virtio_is_supported(SubChannelId schid);
 void virtio_blk_setup_device(SubChannelId schid);
 int virtio_read(ulong sector, void *load_addr);
 int enable_mss_facility(void);
+u64 get_clock(void);
 ulong get_second(void);
 
 /* bootmap.c */
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index 486fce1..5e4a78b 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -101,3 +101,23 @@ void sclp_get_loadparm_ascii(char *loadparm)
         ebcdic_to_ascii((char *) sccb->loadparm, loadparm, 8);
     }
 }
+
+void sclp_read(char *str, size_t len)
+{
+    ReadEventData *sccb = (void *)_sccb;
+    char *buf = (char *)(&sccb->ebh) + 7;
+
+    /* Len should not exceed the maximum size of the event buffer */
+    if (len > SCCB_SIZE - 8) {
+        len = SCCB_SIZE - 8;
+    }
+
+    sccb->h.length = SCCB_SIZE;
+    sccb->h.function_code = SCLP_UNCONDITIONAL_READ;
+    sccb->ebh.length = sizeof(EventBufferHeader);
+    sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
+    sccb->ebh.flags = 0;
+
+    sclp_service_call(SCLP_CMD_READ_EVENT_DATA, sccb);
+    memcpy(str, buf, len);
+}
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index c890a03..817e7f5 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -176,7 +176,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
     }
 }
 
-static u64 get_clock(void)
+u64 get_clock(void)
 {
     u64 r;
 
-- 
2.7.4
