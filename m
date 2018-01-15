Received: from eggs.gnu.org ([2001:4830:134:3::10]:57474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sx-00058h-C2
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sv-0002Jb-RO
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eb7sv-0002Hz-Is
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FGdbD9030760
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:19 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fgxducncq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:18 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 09:45:18 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:44:24 -0500
In-Reply-To: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516034665-27606-8-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 7/8] s390-ccw: interactive boot menu for
 eckd dasd (read input)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

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

--- Specific notes regarding this patch ---

Implements an sclp_read function to capture input from the
console, and a wrapper function in that handles parsing
certain characters and adding input to a buffer. The input
is checked for any erroneous values and is handled
appropriately. A correct value will boot the respective
boot menu entry.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/menu.c     | 160 +++++++++++++++++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/s390-ccw.h |   2 +
 pc-bios/s390-ccw/sclp.c     |  20 ++++++
 pc-bios/s390-ccw/virtio.c   |   2 +-
 4 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 30470b3..c219b7f 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -12,9 +12,167 @@
 #include "menu.h"
 #include "s390-ccw.h"
 
+#define KEYCODE_NO_INP '\0'
+#define KEYCODE_ESCAPE '\033'
+#define KEYCODE_BACKSP '\177'
+#define KEYCODE_ENTER  '\r'
+
 static uint8_t flags;
 static uint64_t timeout;
 
+static inline void enable_clock_int(void)
+{
+    uint64_t tmp = 0;
+
+    asm volatile(
+        "stctg      0,0,%0\n"
+        "oi         6+%0, 0x8\n"
+        "lctlg      0,0,%0"
+        : : "Q" (tmp) : "memory"
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
+        : : "Q" (tmp) : "memory"
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
+    uint16_t *code = (uint16_t *)0x86;
+
+    consume_sclp_int();
+
+    return *code == 0x1004;
+}
+
+static int read_prompt(char *buf, size_t len)
+{
+    char inp[2] = {};
+    uint8_t idx = 0;
+    uint64_t time;
+
+    if (timeout) {
+        time = get_clock() + (timeout << 32);
+        set_clock_comparator(time);
+        enable_clock_int();
+        timeout = 0;
+    }
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
+    *buf = 0;
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
+    /* If no input, boot default */
+    if (len == 0) {
+        return 0;
+    }
+
+    /* Check for erroneous input */
+    for (i = 0; i < len; i++) {
+        if (!isdigit(buf[i])) {
+            return -1;
+        }
+    }
+
+    return atoi(buf);
+}
+
+static void boot_menu_prompt(bool retry)
+{
+    char tmp[6];
+
+    if (retry) {
+        sclp_print("\nError: undefined configuration"
+                   "\nPlease choose:\n");
+    } else if (timeout > 0) {
+        sclp_print("Please choose (default will boot in ");
+        sclp_print(itostr(timeout, tmp, sizeof(tmp)));
+        sclp_print(" seconds):\n");
+    } else {
+        sclp_print("Please choose:\n");
+    }
+}
+
+static int get_boot_index(int entries)
+{
+    int boot_index;
+    bool retry = false;
+    char tmp[5];
+
+    do {
+        boot_menu_prompt(retry);
+        boot_index = get_index();
+        retry = true;
+    } while (boot_index < 0 || boot_index >= entries);
+
+    sclp_print("\nBooting entry #");
+    sclp_print(itostr(boot_index, tmp, sizeof(tmp)));
+
+    return boot_index;
+}
+
 static void zipl_println(const char *data, size_t len)
 {
     char buf[len + 1];
@@ -53,7 +211,7 @@ int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms)
 
     sclp_print("\n");
 
-    return 0; /* return user input next patch */
+    return get_boot_index(ct - 1);
 }
 
 void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
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
