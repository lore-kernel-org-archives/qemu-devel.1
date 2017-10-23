Received: from eggs.gnu.org ([2001:4830:134:3::10]:52045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePv-0004xa-AT
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePu-0002B4-9Z
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:27 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:50849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1e6ePu-0002AO-3E
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:26 -0400
Received: by mail-wr0-x243.google.com with SMTP id p96so3876366wrb.7
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:13:26 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Mon, 23 Oct 2017 17:13:07 +0200
Message-Id: <20171023151310.6462-2-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH 1/4] qmp: introduce 'writeconfig' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vadim.galitsyn@profitbricks.com, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Otubo <eduardo.otubo@profitbricks.com>

Add support for `writeconfig' command for QMP monitor.
This is a simple way to keep track of current state of VM
after series of hotplugs and/or hotunplugs of different devices.

Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qapi-schema.json | 18 ++++++++++++++++++
 qmp.c            | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index a9dd043f65..083f8f3258 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3200,3 +3200,21 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @writeconfig:
+#
+# Dump current configuration into specified file
+#
+# @file: pathname of a file to store current configuration
+#
+# Since: 2.11
+#
+# Example:
+#
+# -> { "execute": "writeconfig",
+#      "arguments": { "file": "/tmp/qemu.conf" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'writeconfig', 'data': {'file': 'str'} }
diff --git a/qmp.c b/qmp.c
index e8c303116a..fcb911cabb 100644
--- a/qmp.c
+++ b/qmp.c
@@ -722,3 +722,24 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 
     return mem_info;
 }
+
+void qmp_writeconfig(const char *file, Error **errp)
+{
+    int fd;
+    FILE *fp;
+
+    fd = qemu_open(file,  O_WRONLY | O_CREAT | O_TRUNC, 0600);
+    if (fd != -1) {
+
+        fp = fdopen(fd, "wb");
+        if (fp) {
+            qemu_config_write(fp);
+            fclose(fp);
+            return;
+        }
+
+        qemu_close(fd);
+    }
+
+    error_setg(errp, "cannot write configuration file: '%s'", file);
+}
-- 
2.13.1.394.g41dd433
