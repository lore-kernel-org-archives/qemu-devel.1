Received: from eggs.gnu.org ([2001:4830:134:3::10]:34760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfDK-0005UH-8u
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfDH-0008OI-22
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:22:38 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 27 Feb 2018 14:21:34 +0100
Message-Id: <20180227132150.13847-11-cohuck@redhat.com>
In-Reply-To: <20180227132150.13847-1-cohuck@redhat.com>
References: <20180227132150.13847-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/26] s390-ccw: read user input for boot index
 via the SCLP console
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

Implements an sclp_read function to capture input from the
console and a wrapper function that handles parsing certain
characters and adding input to a buffer. The input is checked
for any erroneous values and is handled appropriately.

A prompt will persist until input is entered or the timeout
expires (if one was set). Example:

      Please choose (default will boot in 10 seconds):

Correct input will boot the respective boot index. If the
user's input is empty, 0, or if the timeout expires, then
the default zipl entry will be chosen. If the input is
within the range of available boot entries, then the
selection will be booted. Any erroneous input will cancel
the timeout and re-prompt the user.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/menu.c     | 149 +++++++++++++++++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/s390-ccw.h |   2 +
 pc-bios/s390-ccw/sclp.c     |  19 ++++++
 pc-bios/s390-ccw/virtio.c   |   2 +-
 4 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 730d44e36b..b99ff03298 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -12,12 +12,159 @@
 #include "libc.h"
 #include "s390-ccw.h"
 
+#define KEYCODE_NO_INP '\0'
+#define KEYCODE_ESCAPE '\033'
+#define KEYCODE_BACKSP '\177'
+#define KEYCODE_ENTER  '\r'
+
+#define TOD_CLOCK_MILLISECOND   0x3e8000
+
+#define LOW_CORE_EXTERNAL_INT_ADDR   0x86
+#define CLOCK_COMPARATOR_INT         0X1004
+
 static uint8_t flag;
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
+    uint16_t *code = (uint16_t *)LOW_CORE_EXTERNAL_INT_ADDR;
+
+    consume_sclp_int();
+
+    return *code == CLOCK_COMPARATOR_INT;
+}
+
+static int read_prompt(char *buf, size_t len)
+{
+    char inp[2] = {};
+    uint8_t idx = 0;
+    uint64_t time;
+
+    if (timeout) {
+        time = get_clock() + timeout * TOD_CLOCK_MILLISECOND;
+        set_clock_comparator(time);
+        enable_clock_int();
+        timeout = 0;
+    }
+
+    while (!check_clock_int()) {
+
+        sclp_read(inp, 1); /* Process only one character at a time */
+
+        switch (inp[0]) {
+        case KEYCODE_NO_INP:
+        case KEYCODE_ESCAPE:
+            continue;
+        case KEYCODE_BACKSP:
+            if (idx > 0) {
+                buf[--idx] = 0;
+                sclp_print("\b \b");
+            }
+            continue;
+        case KEYCODE_ENTER:
+            disable_clock_int();
+            return idx;
+        default:
+            /* Echo input and add to buffer */
+            if (idx < len) {
+                buf[idx++] = inp[0];
+                sclp_print(inp);
+            }
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
+    char buf[11];
+    int len;
+    int i;
+
+    memset(buf, 0, sizeof(buf));
+
+    len = read_prompt(buf, sizeof(buf) - 1);
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
+    return atoui(buf);
+}
+
+static void boot_menu_prompt(bool retry)
+{
+    char tmp[11];
+
+    if (retry) {
+        sclp_print("\nError: undefined configuration"
+                   "\nPlease choose:\n");
+    } else if (timeout > 0) {
+        sclp_print("Please choose (default will boot in ");
+        sclp_print(uitoa(timeout / 1000, tmp, sizeof(tmp)));
+        sclp_print(" seconds):\n");
+    } else {
+        sclp_print("Please choose:\n");
+    }
+}
+
 static int get_boot_index(int entries)
 {
-    return 0; /* implemented next patch */
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
+    sclp_print(uitoa(boot_index, tmp, sizeof(tmp)));
+
+    return boot_index;
 }
 
 static void zipl_println(const char *data, size_t len)
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index c0dd37f7ba..aeba8b0a99 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -71,6 +71,7 @@ unsigned int get_loadparm_index(void);
 void sclp_print(const char *string);
 void sclp_setup(void);
 void sclp_get_loadparm_ascii(char *loadparm);
+int sclp_read(char *str, size_t count);
 
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
index e6a089889a..a2f25ebd4f 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -119,3 +119,22 @@ void sclp_get_loadparm_ascii(char *loadparm)
         ebcdic_to_ascii((char *) sccb->loadparm, loadparm, 8);
     }
 }
+
+int sclp_read(char *str, size_t count)
+{
+    ReadEventData *sccb = (void *)_sccb;
+    char *buf = (char *)(&sccb->ebh) + 7;
+
+    /* If count exceeds max buffer size, then restrict it to the max size */
+    if (count > SCCB_SIZE - 8) {
+        count = SCCB_SIZE - 8;
+    }
+
+    sccb->h.length = SCCB_SIZE;
+    sccb->h.function_code = SCLP_UNCONDITIONAL_READ;
+
+    sclp_service_call(SCLP_CMD_READ_EVENT_DATA, sccb);
+    memcpy(str, buf, count);
+
+    return sccb->ebh.length - 7;
+}
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index c890a0330b..817e7f56ea 100644
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
2.13.6
