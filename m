Received: from eggs.gnu.org ([2001:4830:134:3::10]:36412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dOOEZ-0003Ta-DE
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dOOEV-0001le-Ge
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:47 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dOOEV-0001lK-9N
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:43 -0400
Received: by mail-wr0-f172.google.com with SMTP id k67so64664095wrc.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:02:43 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri, 23 Jun 2017 15:02:36 +0200
Message-Id: <0d9a013bd8f1ac8211758a0f9b0d35ba0a2eec3d.1498222907.git.tgolembi@redhat.com>
In-Reply-To: <cover.1498222907.git.tgolembi@redhat.com>
References: <cover.1498222907.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 2/3] qemu-ga: add simple event reporting memory
 statistics
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

work in progress

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/main.c          | 19 ++++++++++++++++---
 qga/qapi-event.json | 16 ++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index f16abb5cbb..a9586e7513 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -695,16 +695,29 @@ static gboolean monitoring_cb(gpointer data)
     GAState *s = (GAState *)data;
 
     g_assert(s->channel);
-    g_warning("monitoring!");
 
     if (!ga_channel_client_attached(s->channel)) {
         goto ok;
     }
 
-    /* TODO: call something */
+    /* Fire an event */
+    qapi_event_send_guest_heartbeat(12345, &err);
+    if (err) {
+        goto fail;
+    }
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
     goto ok;
 
-/*fail:*/
+fail:
     g_assert(err);
     g_warning("%s", error_get_pretty(err));
     error_free(err);
diff --git a/qga/qapi-event.json b/qga/qapi-event.json
index 9c14e4609e..3d48ddb214 100644
--- a/qga/qapi-event.json
+++ b/qga/qapi-event.json
@@ -1,2 +1,18 @@
 # *-*- Mode: Python -*-*
 
+##
+# @GUEST_HEARTBEAT:
+#
+# Mostrly returns memory statistics. TODO
+#
+# @free-ram: Amount of free memory in kB
+#
+# Since: 2.10
+#
+# Example:
+#
+# <- { "event": "GUEST_HEARTBEAT", "data": { "free-ram": "12345" },
+#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#
+##
+{ 'event': 'GUEST_HEARTBEAT', 'data': { 'free-ram': 'size' } }
-- 
2.13.1
