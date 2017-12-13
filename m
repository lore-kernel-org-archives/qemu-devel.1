Received: from eggs.gnu.org ([2001:4830:134:3::10]:60083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLI-0004za-Fl
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLD-0006bI-Dh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:36 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:41817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLD-0006b1-85
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:31 -0500
Received: by mail-qt0-x243.google.com with SMTP id i40so5847400qti.8
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:21:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:00 -0300
Message-Id: <20171213232025.24503-2-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Use Base64 to serialize the binary blobs in JSON.
So far at most 512 bytes will be transfered, which result
in a 684 bytes payload.
Since this command is intented for qtesting, this is acceptable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qapi-schema.json    | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/sd/core.c        | 43 +++++++++++++++++++++++++++++++++++++++++++
 stubs/qmp_sdbus.c   | 11 +++++++++++
 stubs/Makefile.objs |  1 +
 4 files changed, 96 insertions(+)
 create mode 100644 stubs/qmp_sdbus.c

diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a8..9b0fd90fed 100644
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
+# @sdbus-command:
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
+# -> { "execute": "sdbus-command",
+#      "arguments": { "qom-path": "/machine/unattached/device[32]/sd.0",
+#                     "command": 0x01
+#      }
+#    }
+# <- { "return": {'base64': 'A='} }
+#
+##
+{ 'command': 'sdbus-command',
+  'data': { 'qom-path': 'str',
+            'command': 'uint8',
+            '*arg': 'uint64',
+            '*crc': 'uint16' },
+  'returns': 'SDBusCommandResponse'
+}
diff --git a/hw/sd/core.c b/hw/sd/core.c
index da3a7e0efa..c546db2b22 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/sd/sd.h"
 #include "qemu/cutils.h"
+#include "qmp-commands.h"
 #include "sd-internal.h"
 #include "trace.h"
 
@@ -220,3 +221,45 @@ SDBus *sdbus_create_bus(DeviceState *parent, const char *name)
 {
     return SD_BUS(qbus_create(TYPE_SD_BUS, parent, name));
 }
+
+SDBusCommandResponse *qmp_sdbus_command(const char *qom_path,
+                                        uint8_t command,
+                                        bool has_arg, uint64_t arg,
+                                        bool has_crc, uint16_t crc,
+                                        Error **errp)
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
index 0000000000..50f9f1410d
--- /dev/null
+++ b/stubs/qmp_sdbus.c
@@ -0,0 +1,11 @@
+#include "qemu/osdep.h"
+#include "qmp-commands.h"
+#include "hw/sd/sd.h"
+
+SDBusCommandResponse *qmp_sdbus_command(const char *qom_path, uint8_t command,
+                                        bool has_arg, uint64_t arg,
+                                        bool has_crc, uint16_t crc,
+                                        Error **errp)
+{
+    return NULL;
+}
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
