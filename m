Received: from eggs.gnu.org ([2001:4830:134:3::10]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cdwbm-0007Dz-Oe
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cdwbj-0004wm-MA
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:46 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cdwbj-0004vX-FO
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:43 -0500
Received: by mail-wm0-x231.google.com with SMTP id c85so37896068wmi.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 02:14:42 -0800 (PST)
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Date: Wed, 15 Feb 2017 11:14:26 +0100
Message-Id: <20170215101427.23736-2-eduardo.otubo@profitbricks.com>
In-Reply-To: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
References: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
Subject: [Qemu-devel] [PATCH 1/2] qmp/hmp: add writeconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com, Eduardo Otubo <eduardo.otubo@profitbricks.com>

This patch adds support for the command `writeconfig' on the QMP and HMP
consoles. This is a simple way to keep track of current state of VM
after series of hotplugs and/or hotunplugs of different devices:

  (qemu) writeconfig qemu.conf

Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
---
 hmp-commands.hx  | 14 ++++++++++++++
 hmp.c            |  9 +++++++++
 hmp.h            |  1 +
 qapi-schema.json | 20 ++++++++++++++++++++
 ui/console.c     | 14 ++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 88192817b2..ac562192bb 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -252,6 +252,20 @@ Password: ********
 ETEXI
 
     {
+        .name       = "writeconfig",
+        .args_type  = "filename:F",
+        .params     = "filename",
+        .help       = "write config file",
+        .cmd       = hmp_writeconfig,
+    },
+
+STEXI
+@item writeconfig @var{filename}
+@findex writeconfig
+Write config file @var{filename}.
+ETEXI
+
+    {
         .name       = "screendump",
         .args_type  = "filename:F",
         .params     = "filename",
diff --git a/hmp.c b/hmp.c
index 2bc4f062bb..4f2b8a10d2 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1913,6 +1913,15 @@ err_out:
     goto out;
 }
 
+void hmp_writeconfig(Monitor *mon, const QDict *qdict)
+{
+    const char *filename = qdict_get_str(qdict, "filename");
+    Error *err = NULL;
+
+    qmp_writeconfig(filename, &err);
+    hmp_handle_error(mon, &err);
+}
+
 void hmp_screendump(Monitor *mon, const QDict *qdict)
 {
     const char *filename = qdict_get_str(qdict, "filename");
diff --git a/hmp.h b/hmp.h
index 05daf7cd5c..63d44fe50f 100644
--- a/hmp.h
+++ b/hmp.h
@@ -94,6 +94,7 @@ void hmp_getfd(Monitor *mon, const QDict *qdict);
 void hmp_closefd(Monitor *mon, const QDict *qdict);
 void hmp_sendkey(Monitor *mon, const QDict *qdict);
 void hmp_screendump(Monitor *mon, const QDict *qdict);
+void hmp_writeconfig(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
diff --git a/qapi-schema.json b/qapi-schema.json
index 5edb08d621..c19b1ff3df 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4696,6 +4696,26 @@
   'data': { 'keys': ['KeyValue'], '*hold-time': 'int' } }
 
 ##
+# @writeconfig:
+#
+# Write config to file.
+#
+# @filename: the path of a new file to store the current config
+#
+# Returns: Nothing on success
+#
+# Since: 2.7.0
+#
+# Example:
+#
+# -> { "execute": "writeconfig",
+#      "arguments": { "filename": "/tmp/qemu.conf" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'writeconfig', 'data': {'filename': 'str'} }
+
+##
 # @screendump:
 #
 # Write a PPM of the VGA screen to a file.
diff --git a/ui/console.c b/ui/console.c
index 49d0740b40..d2e3d753a8 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -30,6 +30,7 @@
 #include "sysemu/char.h"
 #include "trace.h"
 #include "exec/memory.h"
+#include "qemu/config-file.h"
 
 #define DEFAULT_BACKSCROLL 512
 #define CONSOLE_CURSOR_PERIOD 500
@@ -342,6 +343,19 @@ write_err:
     goto out;
 }
 
+void qmp_writeconfig(const char *filename, Error **errp)
+{
+    if (filename == NULL) {
+        error_setg(errp, "You must specify a filename.");
+        return;
+    }
+
+    FILE *fp;
+    fp = fopen(filename, "w");
+    qemu_config_write(fp);
+    fclose(fp);
+}
+
 void qmp_screendump(const char *filename, Error **errp)
 {
     QemuConsole *con = qemu_console_lookup_by_index(0);
-- 
2.11.0
