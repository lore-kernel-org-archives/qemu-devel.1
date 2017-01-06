Received: from eggs.gnu.org ([2001:4830:134:3::10]:46255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0006Qb-Qj
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJd-0008M5-LJ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJd-0008LF-Ct
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:01 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:29 +0100
Message-Id: <1483692945-9866-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 01/17] Add wctablet device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Anatoli Huseu1 <avg.tolik@gmail.com>

[ kraxel: adapt to chardev changes ]

Signed-off-by: Anatoli Huseu1 <avg.tolik@gmail.com>
---
 backends/Makefile.objs   |   2 +-
 backends/wctablet.c      | 347 +++++++++++++++++++++++++++++++++++++++++++++++
 docs/qdev-device-use.txt |   2 +-
 qapi-schema.json         |   1 +
 qemu-char.c              |   1 +
 5 files changed, 351 insertions(+), 2 deletions(-)
 create mode 100644 backends/wctablet.c

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 1846998..0e0f156 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -1,7 +1,7 @@
 common-obj-y += rng.o rng-egd.o
 common-obj-$(CONFIG_POSIX) += rng-random.o
 
-common-obj-y += msmouse.o testdev.o
+common-obj-y += msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) += baum.o
 baum.o-cflags := $(SDL_CFLAGS)
 
diff --git a/backends/wctablet.c b/backends/wctablet.c
new file mode 100644
index 0000000..0aee6fe
--- /dev/null
+++ b/backends/wctablet.c
@@ -0,0 +1,347 @@
+/*
+ * QEMU Wacome serial tablet emulation
+ *
+ * Copyright (c) 2008 Lubomir Rintel
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <time.h>
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/char.h"
+#include "ui/console.h"
+#include "ui/input.h"
+
+
+#define DEBUG_WCTABLET_MOUSE
+
+#ifdef DEBUG_WCTABLET_MOUSE
+#define DPRINTF(fmt, ...) \
+do { fprintf(stderr, fmt , ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+do {} while (0)
+#endif
+
+#define WC_COMMANDS_COUNT 30
+
+#define WC_BUSY_STATE 1
+#define WC_BUSY_WITH_CODES 3
+#define WC_WAITING_STATE 2
+#define WC_OUTPUT_BUF_MAX_LEN 512
+#define WC_COMMAND_MAX_LEN 60
+
+#define WC_L7(n) ((n) & 127)
+#define WC_M7(n) (((n) >> 7) & 127)
+#define WC_H2(n) ((n) >> 14)
+
+#define WC_L4(n) ((n) & 15)
+#define WC_H4(n) (((n) >> 4) & 15)
+
+// Avaliable commands
+uint8_t wctablet_commands[WC_COMMANDS_COUNT][7] = {
+    {0x0a, 0x53, 0x50, 0x0a, 0},                // \nSP\n
+    {0x7e, 0x23, 0},                            // ~#
+    {0x0a, 0x54, 0x45, 0x0a, 0},                // \nTE\n
+    {0x52, 0x45, 0x0a, 0},                      // RE\n
+    {0x41, 0x53, 0x31, 0x0a, 0},                // AS1\n
+    {0x49, 0x43, 0x31, 0x0a, 0},                // IC1\n
+    {0x4f, 0x43, 0x31, 0x0a, 0},                // OC1\n
+    {0x49, 0x54, 0x88, 0x88, 0},                // IT3\r
+    {0x53, 0x55, 0x88, 0x88, 0},                // SU3\n
+    {0x50, 0x48, 0x31, 0x0a, 0},                // PH1\n
+    {0x0d, 0x53, 0x54, 0x0d, 0},                // \rST\n
+    {0x0d, 0x53, 0x50, 0x0d, 0},                // \rSP\r
+    {0x54, 0x45, 0x0d, 0},                      // TE\r
+    {0x53, 0x50, 0x88, 0},                      // SP\n
+    {0x23, 0x41, 0x4c, 0x31, 0x0d, 0},          // #AL1\r
+    {0x53, 0x54, 0x88, 0},                      // ST\n
+    {0x0d, 0x54, 0x53, 0x88, 0xd, 0},           // \rTS&\r
+    {0x0d, 0x0a, 0x53, 0x50, 0x0d, 0x0a, 0},    // \r\nSP\r\n
+    {0x7e, 0x23, 0x0d, 0}                       // ~#\r
+};
+
+// Char strings with avaliable commands
+char wctablet_commands_names[WC_COMMANDS_COUNT][12] = {
+    "\\nSP\\n",
+    "~#",
+    "\\nTE\\n",
+    "RE\\n",
+    "AS1\\n",
+    "IC1\\n",
+    "OC1\\n",
+    "IT3\\r",
+    "SU3\\n",
+    "PH1\\n",
+    "\\rST\\n",
+    "\\rSP\\r",
+    "TE\\r",
+    "SP\\n",
+    "#AL1\\r",
+    "ST\\n",
+    "\\rTS&\\r",
+    "\\r\\nSP\\r\\n",
+    "~#\\r"
+};
+
+// Model string and config string
+uint8_t *WC_MODEL_STRING = (uint8_t *) "~#CT-0045R,V1.3-5,";
+size_t WC_MODEL_STRING_LENGTH = 18;
+uint8_t *WC_CONFIG_STRING = (uint8_t *) "96,N,8,0";
+size_t WC_CONFIG_STRING_LENGTH = 8;
+uint8_t WC_FULL_CONFIG_STRING[61] = {
+    0x5c, 0x39, 0x36, 0x2c, 0x4e, 0x2c, 0x38, 0x2c,
+    0x31, 0x28, 0x01, 0x24, 0x57, 0x41, 0x43, 0x30,
+    0x30, 0x34, 0x35, 0x5c, 0x5c, 0x50, 0x45, 0x4e, 0x5c,
+    0x57, 0x41, 0x43, 0x30, 0x30, 0x30, 0x30, 0x5c,
+    0x54, 0x61, 0x62, 0x6c, 0x65, 0x74, 0x0d, 0x0a,
+    0x43, 0x54, 0x2d, 0x30, 0x30, 0x34, 0x35, 0x52,
+    0x2c, 0x56, 0x31, 0x2e, 0x33, 0x2d, 0x35, 0x0d,
+    0x0a, 0x45, 0x37, 0x29
+};
+size_t WC_FULL_CONFIG_STRING_LENGTH = 61;
+int count = 0;
+int COMMON_SPEAD = 900 * 1000;
+
+
+// This structure is used to save private info for Wacom Tablet.
+typedef struct {
+    struct QEMUTimer *transmit_timer;
+    /* QEMU timer */
+    uint64_t transmit_time;
+    /* time to transmit a char in ticks */
+    uint8_t query[100];
+    int query_index;
+    /* Query string from serial */
+    uint8_t outbuf[WC_OUTPUT_BUF_MAX_LEN];
+    int outlen;
+    /* Command to be sent to serial port */
+} TabletState;
+
+static int wctablet_memcmp(uint8_t *a1, uint8_t *a2, int count)
+{
+    int i;
+
+    for (i = 0; i < count; i++) {
+        if (a1[i] != a2[i] && a2[i] != 0x88) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int wctablet_check_command(uint8_t *arr, int count)
+{
+    int i;
+
+    for (i = 0; i < WC_COMMANDS_COUNT; i++) {
+        if (wctablet_memcmp(arr, wctablet_commands[i], count) == 0 &&
+            wctablet_commands[i][count] == 0) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+static void wctablet_event(void *opaque, int x,
+                           int y, int dz, int buttons_state)
+{
+    CharDriverState *chr = (CharDriverState *) opaque;
+    TabletState *tablet = (TabletState *) chr->opaque;
+    uint8_t codes[8] = { 0xe0, 0, 0, 0, 0, 0, 0 };
+    // uint8_t codes[8] = { 0xa0, 0x0e, 0x06, 0x00, 0x13, 0x3b, 0x00 };
+    // uint8_t codes[8] = { 0xe0, 0x05, 0x6a, 0x00, 0x06, 0x64, 0x40 };
+    // uint8_t codes[8] = { 0xa0, 0x1c, 0x29, 0x00, 0x19, 0x1c, 0x00 };
+
+    DPRINTF("x= %d; y= %d; buttons=%x\n", x, y, buttons_state);
+    int newX = x * 0.1537;
+    int nexY = y * 0.1152;
+
+    codes[0] = codes[0] | WC_H2(newX);
+    codes[1] = codes[1] | WC_M7(newX);
+    codes[2] = codes[2] | WC_L7(newX);
+
+    codes[3] = codes[3] | WC_H2(nexY);
+    codes[4] = codes[4] | WC_M7(nexY);
+    codes[5] = codes[5] | WC_L7(nexY);
+
+    if (buttons_state == 0x01) {
+        codes[0] = 0xa0;
+    }
+
+    if (tablet->outlen + 7 < WC_OUTPUT_BUF_MAX_LEN) {
+        memcpy(tablet->outbuf + tablet->outlen, codes, 7);
+        tablet->outlen += 7;
+    }
+}
+
+static void wctablet_handler(void *opaque)
+{
+    CharDriverState *chr = (CharDriverState *) opaque;
+    TabletState *tablet = (TabletState *) chr->opaque;
+    int len, canWrite; // , i;
+
+    canWrite = qemu_chr_be_can_write(chr);
+    len = canWrite;
+    if (len > tablet->outlen) {
+        len = tablet->outlen;
+    }
+
+    if (len) {
+        // DPRINTF("-------- Write %2d: ", canWrite);
+        // for (i = 0; i < len; i++) {
+        //     DPRINTF(" %02x", tablet->outbuf[i]);
+        // }
+        // DPRINTF("\n");
+
+        qemu_chr_be_write(chr, tablet->outbuf, len);
+        tablet->outlen -= len;
+        if (tablet->outlen) {
+            memmove(tablet->outbuf, tablet->outbuf + len, tablet->outlen);
+        }
+    }
+
+    timer_mod(tablet->transmit_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + tablet->transmit_time);
+}
+
+static int wctablet_chr_write (struct CharDriverState *s,
+                               const uint8_t *buf, int len)
+{
+    TabletState *tablet = (TabletState *) s->opaque;
+    uint8_t c = buf[0];
+    uint8_t input;
+
+    if (c == 0x40) {
+        return len;
+    }
+
+    tablet->query[tablet->query_index++] = c;
+
+    // DPRINTF("Receive: %.2x\n", c);
+
+    int comm = wctablet_check_command(tablet->query, tablet->query_index);
+
+    if (comm == 1) {
+        count++;
+    }
+
+    if (comm != -1) {
+        if (comm == 1 && count == 2) {
+            memcpy(tablet->outbuf + tablet->outlen, WC_MODEL_STRING, WC_MODEL_STRING_LENGTH);
+            tablet->outlen += WC_MODEL_STRING_LENGTH;
+        }
+
+        if (comm == 3) {
+            memcpy(tablet->outbuf + tablet->outlen, WC_CONFIG_STRING, WC_CONFIG_STRING_LENGTH);
+            tablet->outlen += WC_CONFIG_STRING_LENGTH;
+        }
+
+        if (comm == 18) {
+            memcpy(tablet->outbuf + tablet->outlen, WC_FULL_CONFIG_STRING, WC_FULL_CONFIG_STRING_LENGTH);
+            tablet->outlen += WC_FULL_CONFIG_STRING_LENGTH;
+        }
+
+        if (comm == 16) {
+            input = tablet->query[3];
+            uint8_t codes[7] = {
+                0xa3,
+                0x88,
+                0x88,
+                0x03,
+                0x7f,
+                0x7f,
+                0x00
+            };
+            codes[1] = ((input & 0x80) == 0) ? 0x7e : 0x7f;
+            codes[2] = ( ( ( WC_H4(input) & 0x7 ) ^ 0x5) << 4 ) | (WC_L4(input) ^ 0x7);
+
+            memcpy(tablet->outbuf + tablet->outlen, codes, 7);
+            tablet->outlen += 7;
+        }
+
+        // DPRINTF("-------- Command: %s\n", wctablet_commands_names[comm]);
+
+        tablet->query_index = 0;
+    }
+
+    return len;
+}
+
+static void wctablet_chr_free(struct CharDriverState *chr)
+{
+    g_free (chr->opaque);
+    g_free (chr);
+}
+
+static CharDriverState *qemu_chr_open_wctablet(const char *id,
+                                              ChardevBackend *backend,
+                                              ChardevReturn *ret,
+                                              bool *be_opened,
+                                              Error **errp)
+{
+    ChardevCommon *common = backend->u.wctablet.data;
+    CharDriverState *chr;
+    TabletState *tablet;
+
+    chr = qemu_chr_alloc(common, errp);
+    tablet = g_malloc0(sizeof(TabletState));
+    if (!chr) {
+        return NULL;
+    }
+    chr->chr_write = wctablet_chr_write;
+    chr->chr_free = wctablet_chr_free;
+    *be_opened = true;
+
+    /* create a new QEMU's timer with wctablet_handler() as timeout handler. */
+    tablet->transmit_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                       (QEMUTimerCB *) wctablet_handler, chr);
+
+    tablet->transmit_time = COMMON_SPEAD;
+
+    timer_mod(tablet->transmit_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + tablet->transmit_time);
+
+
+    /* init state machine */
+    memcpy(tablet->outbuf, WC_FULL_CONFIG_STRING, WC_FULL_CONFIG_STRING_LENGTH);
+    tablet->outlen = WC_FULL_CONFIG_STRING_LENGTH;
+    tablet->query_index = 0;
+
+    chr->opaque = tablet;
+
+    qemu_add_mouse_event_handler(wctablet_event, chr, 1,
+                                 "QEMU Wacome Pen Tablet");
+
+    return chr;
+}
+
+static void register_types(void)
+{
+    register_char_driver("wctablet", CHARDEV_BACKEND_KIND_WCTABLET, NULL,
+                         qemu_chr_open_wctablet);
+}
+
+type_init(register_types);
diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 136d271..b059405 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -200,7 +200,7 @@ LEGACY-CHARDEV translates to -chardev HOST-OPTS... as follows:
 
 * null becomes -chardev null
 
-* pty, msmouse, braille, stdio likewise
+* pty, msmouse, wctablet, braille, stdio likewise
 
 * vc:WIDTHxHEIGHT becomes -chardev vc,width=WIDTH,height=HEIGHT
 
diff --git a/qapi-schema.json b/qapi-schema.json
index a0d3b5d..40e76ad 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3879,6 +3879,7 @@
                                        'null'   : 'ChardevCommon',
                                        'mux'    : 'ChardevMux',
                                        'msmouse': 'ChardevCommon',
+                                       'wctablet' : 'ChardevCommon',
                                        'braille': 'ChardevCommon',
                                        'testdev': 'ChardevCommon',
                                        'stdio'  : 'ChardevStdio',
diff --git a/qemu-char.c b/qemu-char.c
index 2c9940c..162df2f 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3734,6 +3734,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
     if (strcmp(filename, "null")    == 0 ||
         strcmp(filename, "pty")     == 0 ||
         strcmp(filename, "msmouse") == 0 ||
+        strcmp(filename, "wctablet") == 0 ||
         strcmp(filename, "braille") == 0 ||
         strcmp(filename, "testdev") == 0 ||
         strcmp(filename, "stdio")   == 0) {
-- 
1.8.3.1
