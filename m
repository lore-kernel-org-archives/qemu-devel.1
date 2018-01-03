Received: from eggs.gnu.org ([2001:4830:134:3::10]:43907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqup-0000gl-6u
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqun-0003oc-R8
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:39 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:46729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqun-0003oH-Ls
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:37 -0500
Received: by mail-qk0-x242.google.com with SMTP id b132so3325037qkc.13
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:49:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:49:22 -0300
Message-Id: <20180103214925.16677-2-f4bug@amsat.org>
In-Reply-To: <20180103214925.16677-1-f4bug@amsat.org>
References: <20180103214925.16677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access a
 SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use Base64 to serialize the binary blobs in JSON.
So far at most 512 bytes will be transfered, which result
in a 684 bytes payload.
Since this command is intented for qtesting, it is acceptable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qapi-schema.json    | 41 +++++++++++++++++++++++++++++++++
 hw/sd/sdbus-qmp.c   | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/qmp_sdbus.c   | 12 ++++++++++
 hw/sd/Makefile.objs |  2 +-
 stubs/Makefile.objs |  1 +
 5 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 hw/sd/sdbus-qmp.c
 create mode 100644 stubs/qmp_sdbus.c

diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a8..be26e8cd34 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3200,3 +3200,44 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @SDBusCommandResponse:
+#
+# SD Bus command response.
+#
+# @base64: the command response encoded as a Base64 string, if any (optional)
+#
+# Since: 2.11
+##
+{ 'struct': 'SDBusCommandResponse', 'data': {'*base64': 'str'} }
+
+##
+# @x-debug-sdbus-command:
+#
+# Execute a command on a SD Bus return the response (if any).
+#
+# @qom-path: the SD Bus path
+# @command: the SD protocol command to execute in the bus
+# @arg: a 64-bit command argument (optional)
+# @crc: the command/argument CRC (optional)
+#
+# Returns: the response of the command encoded as a Base64 string
+#
+# Since: 2.11
+#
+# -> { "execute": "x-debug-sdbus-command",
+#      "arguments": { "qom-path": "/machine/unattached/device[32]/sd.0",
+#                     "command": 0x01
+#      }
+#    }
+# <- { "return": {'base64': 'A='} }
+#
+##
+{ 'command': 'x-debug-sdbus-command',
+  'data': { 'qom-path': 'str',
+            'command': 'uint8',
+            '*arg': 'uint64',
+            '*crc': 'uint16' },
+  'returns': 'SDBusCommandResponse'
+}
diff --git a/hw/sd/sdbus-qmp.c b/hw/sd/sdbus-qmp.c
new file mode 100644
index 0000000000..8c4b6f2aee
--- /dev/null
+++ b/hw/sd/sdbus-qmp.c
@@ -0,0 +1,65 @@
+/*
+ * SD card bus QMP debugging interface (for QTesting).
+ *
+ * Copyright (c) 2017 ?
+ *
+ * Author:
+ *  Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "hw/sd/sd.h"
+#include "qmp-commands.h"
+
+SDBusCommandResponse *qmp_x_debug_sdbus_command(const char *qom_path,
+                                                uint8_t command,
+                                                bool has_arg, uint64_t arg,
+                                                bool has_crc, uint16_t crc,
+                                                Error **errp)
+{
+    uint8_t response[16 + 1];
+    SDBusCommandResponse *res;
+    bool ambiguous = false;
+    Object *obj;
+    SDBus *sdbus;
+    int sz;
+
+    obj = object_resolve_path(qom_path, &ambiguous);
+    if (obj == NULL) {
+        if (ambiguous) {
+            error_setg(errp, "Path '%s' is ambiguous", qom_path);
+        } else {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                      "Device '%s' not found", qom_path);
+        }
+        return NULL;
+    }
+    sdbus = (SDBus *)object_dynamic_cast(obj, TYPE_SD_BUS);
+    if (sdbus == NULL) {
+        error_set(errp, ERROR_CLASS_GENERIC_ERROR,
+                  "Device '%s' not a sd-bus", qom_path);
+        return NULL;
+    }
+
+    res = g_new0(SDBusCommandResponse, 1);
+    sz = sdbus_do_command(sdbus,
+                          &(SDRequest){ command, arg, has_crc ? crc : -1 },
+                          response);
+    if (sz > 0) {
+        res->has_base64 = true;
+        res->base64 = g_base64_encode(response, sz);
+    }
+
+    return res;
+}
diff --git a/stubs/qmp_sdbus.c b/stubs/qmp_sdbus.c
new file mode 100644
index 0000000000..d9bd75ec71
--- /dev/null
+++ b/stubs/qmp_sdbus.c
@@ -0,0 +1,12 @@
+#include "qemu/osdep.h"
+#include "qmp-commands.h"
+#include "hw/sd/sd.h"
+
+SDBusCommandResponse *qmp_x_debug_sdbus_command(const char *qom_path,
+                                                uint8_t command,
+                                                bool has_arg, uint64_t arg,
+                                                bool has_crc, uint16_t crc,
+                                                Error **errp)
+{
+    return NULL;
+}
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index c2b7664264..3a70477bba 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_PL181) += pl181.o
 common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
-common-obj-$(CONFIG_SD) += sd.o core.o
+common-obj-$(CONFIG_SD) += sd.o core.o sdbus-qmp.o
 common-obj-$(CONFIG_SDHCI) += sdhci.o
 
 obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 8cfe34328a..a46cb3b992 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -35,6 +35,7 @@ stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_WIN32) += fd-register.o
 stub-obj-y += qmp_pc_dimm.o
+stub-obj-y += qmp_sdbus.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
-- 
2.15.1
