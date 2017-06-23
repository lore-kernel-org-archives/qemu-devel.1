Received: from eggs.gnu.org ([2001:4830:134:3::10]:36428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dOOEa-0003Tw-HW
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dOOEW-0001m2-Di
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:48 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dOOEW-0001lo-7r
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:44 -0400
Received: by mail-wr0-f170.google.com with SMTP id r103so65098022wrb.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:02:44 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri, 23 Jun 2017 15:02:37 +0200
Message-Id: <56b491683542b03a5d4b6c1bf805eda8e06404ec.1498222907.git.tgolembi@redhat.com>
In-Reply-To: <cover.1498222907.git.tgolembi@redhat.com>
References: <cover.1498222907.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 3/3] qemu-ga: add support for periodic command
 runner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

This adds a support for periodicaly triggering arbitrary command
reporting its output.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/main.c          | 26 ++++++++++++++++++++++++++
 qga/qapi-event.json | 17 +++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/qga/main.c b/qga/main.c
index a9586e7513..612a6646e4 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -715,6 +715,32 @@ static gboolean monitoring_cb(gpointer data)
             g_warning("error sending event: %s", strerror(-ret));
         }
     }
+
+    /* Run arbitrary command */
+    const char *command = "guest-get-users";
+    QDict *args = qdict_new();
+
+    QmpCommand *cmd = qmp_find_command(&ga_commands, command);
+    g_assert(cmd);
+    g_assert(cmd->fn);
+    QObject *ret;
+    qmp_marshal_guest_get_users(args, &ret, &err);
+    QDECREF(args);
+    if (err) {
+        goto fail;
+    }
+    qapi_event_send_guest_monitor_command(command, ret, &err);
+
+    if (queued_event) {
+        int ret;
+        ret = send_response(s, QOBJECT(queued_event));
+        QDECREF(queued_event);
+        queued_event = NULL;
+        if (ret < 0) {
+            g_warning("error sending event: %s", strerror(-ret));
+        }
+    }
+
     goto ok;
 
 fail:
diff --git a/qga/qapi-event.json b/qga/qapi-event.json
index 3d48ddb214..e31ea0f0e9 100644
--- a/qga/qapi-event.json
+++ b/qga/qapi-event.json
@@ -16,3 +16,20 @@
 #
 ##
 { 'event': 'GUEST_HEARTBEAT', 'data': { 'free-ram': 'size' } }
+
+##
+# @GUEST_MONITOR_COMMAND:
+#
+# Run periodicaly arbitrary command and return it's result.
+#
+# @command: The executed command.
+# @return: Returned value.
+#
+# Since: 2.10
+#
+# Example:
+#
+# TODO
+#
+##
+{ 'event': 'GUEST_MONITOR_COMMAND', 'data': { 'command': 'str', 'return': 'any' } }
-- 
2.13.1
