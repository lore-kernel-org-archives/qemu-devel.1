Received: from eggs.gnu.org ([2001:4830:134:3::10]:43974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqus-0000ig-CH
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqur-0003sI-6b
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:42 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqur-0003rp-1m
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:41 -0500
Received: by mail-qt0-x241.google.com with SMTP id m59so3854437qte.11
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:49:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:49:23 -0300
Message-Id: <20180103214925.16677-3-f4bug@amsat.org>
In-Reply-To: <20180103214925.16677-1-f4bug@amsat.org>
References: <20180103214925.16677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 2/4] libqos: add a sdbus API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/libqos/sdbus.h   | 45 ++++++++++++++++++++++++++++++
 tests/libqos/sdbus.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |  1 +
 3 files changed, 120 insertions(+)
 create mode 100644 tests/libqos/sdbus.h
 create mode 100644 tests/libqos/sdbus.c

diff --git a/tests/libqos/sdbus.h b/tests/libqos/sdbus.h
new file mode 100644
index 0000000000..2057faf176
--- /dev/null
+++ b/tests/libqos/sdbus.h
@@ -0,0 +1,45 @@
+/*
+ * SD/MMC Bus libqos
+ *
+ * Copyright (c) 2017 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef LIBQOS_SDBUS_H
+#define LIBQOS_SDBUS_H
+
+enum NCmd {
+    GO_IDLE_STATE       =  0,
+    ALL_SEND_CID        =  2,
+    SEND_RELATIVE_ADDR  =  3,
+    SELECT_CARD         =  7,
+    SEND_IF_COND        =  8,
+    SEND_CSD            =  9,
+};
+
+enum ACmd {
+    SEND_STATUS         = 13,
+    SEND_OP_COND        = 41,
+    SEND_SCR            = 51,
+};
+
+typedef struct SDBusAdapter SDBusAdapter;
+struct SDBusAdapter {
+
+    ssize_t (*do_command)(SDBusAdapter *adapter, enum NCmd cmd, uint32_t arg,
+                          uint8_t **response);
+    void (*write_byte)(SDBusAdapter *adapter, uint8_t value);
+    uint8_t (*read_byte)(SDBusAdapter *adapter);
+};
+
+ssize_t sdbus_do_cmd(SDBusAdapter *adapter, enum NCmd cmd, uint32_t arg,
+                     uint8_t **response);
+ssize_t sdbus_do_acmd(SDBusAdapter *adapter, enum ACmd acmd, uint32_t arg,
+                      uint16_t address, uint8_t **response);
+void sdbus_write_byte(SDBusAdapter *adapter, uint8_t value);
+uint8_t sdbus_read_byte(SDBusAdapter *adapter);
+
+SDBusAdapter *qmp_sdbus_create(const char *bus_name);
+
+#endif
diff --git a/tests/libqos/sdbus.c b/tests/libqos/sdbus.c
new file mode 100644
index 0000000000..15f38c2bb8
--- /dev/null
+++ b/tests/libqos/sdbus.c
@@ -0,0 +1,74 @@
+/*
+ * QTest SD/MMC Bus driver
+ *
+ * Copyright (c) 2017 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "libqos/sdbus.h"
+#include "libqtest.h"
+#include "qemu-common.h"
+
+static bool verbose;
+#define DPRINTF(fmt, ...)                           \
+    do {                                            \
+        if (verbose) {                              \
+            fprintf(stderr, fmt, ## __VA_ARGS__);   \
+        }                                           \
+    } while (0)
+
+static ssize_t do_cmd(SDBusAdapter *adapter, enum NCmd cmd, uint32_t arg,
+                      uint8_t **response, bool is_app_cmd)
+{
+    const char *s_cmd = is_app_cmd ? "ACMD" : "CMD";
+    ssize_t sz;
+
+    verbose = !!getenv("V");
+    if (verbose && !is_app_cmd && (cmd == 55)) {
+        verbose = false;
+    }
+
+    DPRINTF("-> %s%02u (0x%08x)\n", s_cmd, cmd, arg);
+    sz = adapter->do_command(adapter, cmd, arg, response);
+    if (response) {
+        if (sz < 0) {
+            DPRINTF("<- %s%02u (len: %ld)\n", s_cmd, cmd, sz);
+        } else if (verbose) {
+            char *pfx = g_strdup_printf("<- %s%02u (len: %ld)", s_cmd, cmd, sz);
+
+            qemu_hexdump((const char *)*response, stderr, pfx, sz);
+            g_free(pfx);
+        }
+    } else {
+        DPRINTF("<- %s%02u\n", s_cmd, cmd);
+    }
+
+    return sz;
+}
+
+ssize_t sdbus_do_cmd(SDBusAdapter *adapter, enum NCmd cmd, uint32_t arg,
+                     uint8_t **response)
+{
+    return do_cmd(adapter, cmd, arg, response, false);
+}
+
+ssize_t sdbus_do_acmd(SDBusAdapter *adapter, enum ACmd acmd, uint32_t arg,
+                      uint16_t address, uint8_t **response)
+{
+    do_cmd(adapter, 55, address << 16, NULL, false);
+    // TODO check rv?
+
+    return do_cmd(adapter, acmd, arg, response, true);
+}
+
+void sdbus_write_byte(SDBusAdapter *adapter, uint8_t value)
+{
+    adapter->write_byte(adapter, value);
+}
+
+uint8_t sdbus_read_byte(SDBusAdapter *adapter)
+{
+    return adapter->read_byte(adapter);
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index cd18ab4519..c22925d4db 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -715,6 +715,7 @@ tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-obj-y)
 
 libqos-obj-y = tests/libqos/pci.o tests/libqos/fw_cfg.o tests/libqos/malloc.o
 libqos-obj-y += tests/libqos/i2c.o tests/libqos/libqos.o
+libqos-obj-y += tests/libqos/sdbus.o
 libqos-spapr-obj-y = $(libqos-obj-y) tests/libqos/malloc-spapr.o
 libqos-spapr-obj-y += tests/libqos/libqos-spapr.o
 libqos-spapr-obj-y += tests/libqos/rtas.o
-- 
2.15.1
