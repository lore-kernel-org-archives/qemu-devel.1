Received: from eggs.gnu.org ([2001:4830:134:3::10]:49320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gveitmic@redhat.com>) id 1cfy7y-0007d5-PZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 19:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gveitmic@redhat.com>) id 1cfy7t-0001UD-QR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 19:16:22 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gveitmic@redhat.com>) id 1cfy7t-0001U0-N0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 19:16:17 -0500
Received: by mail-yw0-f182.google.com with SMTP id l19so57133197ywc.2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 16:16:16 -0800 (PST)
MIME-Version: 1.0
From: Germano Veit Michel <germano@redhat.com>
Date: Tue, 21 Feb 2017 10:16:15 +1000
Message-ID: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH V2] migration: expose qemu_announce_self() via
 qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Jose Quintela Carreira <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

qemu_announce_self() is triggered by qemu at the end of migrations
to update the network regarding the path to the guest l2addr.

however it is also useful when there is a network change such as
an active bond slave swap. Essentially, it's the same as a migration
from a network perspective - the guest moves to a different point
in the network topology.

this exposes the function via qmp.

Signed-off-by: Germano Veit Michel <germano@redhat.com>
---
 include/migration/vmstate.h |  5 +++++
 migration/savevm.c          | 30 +++++++++++++++++++-----------
 qapi-schema.json            | 18 ++++++++++++++++++
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 63e7b02..a08715c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1042,6 +1042,11 @@ int64_t self_announce_delay(int round)
     return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
 }

+struct AnnounceRound {
+    QEMUTimer *timer;
+    int count;
+};
+
 void dump_vmstate_json_to_file(FILE *out_fp);

 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 5ecd264..44e196b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -118,29 +118,37 @@ static void qemu_announce_self_iter(NICState
*nic, void *opaque)
     qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
 }

-
 static void qemu_announce_self_once(void *opaque)
 {
-    static int count = SELF_ANNOUNCE_ROUNDS;
-    QEMUTimer *timer = *(QEMUTimer **)opaque;
+    struct AnnounceRound *round = opaque;

     qemu_foreach_nic(qemu_announce_self_iter, NULL);

-    if (--count) {
+    round->count--;
+    if (round->count) {
         /* delay 50ms, 150ms, 250ms, ... */
-        timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
-                  self_announce_delay(count));
+        timer_mod(round->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                  self_announce_delay(round->count));
     } else {
-            timer_del(timer);
-            timer_free(timer);
+            timer_del(round->timer);
+            timer_free(round->timer);
+            g_free(round);
     }
 }

 void qemu_announce_self(void)
 {
-    static QEMUTimer *timer;
-    timer = timer_new_ms(QEMU_CLOCK_REALTIME, qemu_announce_self_once, &timer);
-    qemu_announce_self_once(&timer);
+    struct AnnounceRound *round = g_malloc(sizeof(struct AnnounceRound));
+    if (!round)
+        return;
+    round->count = SELF_ANNOUNCE_ROUNDS;
+    round->timer = timer_new_ms(QEMU_CLOCK_REALTIME,
qemu_announce_self_once, round);
+    qemu_announce_self_once(round);
+}
+
+void qmp_announce_self(Error **errp)
+{
+    qemu_announce_self();
 }

 /***********************************************************/
diff --git a/qapi-schema.json b/qapi-schema.json
index baa0d26..0d9bffd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6080,3 +6080,21 @@
 #
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
+
+##
+# @announce-self:
+#
+# Trigger generation of broadcast RARP frames to update network switches.
+# This can be useful when network bonds fail-over the active slave.
+#
+# Arguments: None.
+#
+# Example:
+#
+# -> { "execute": "announce-self" }
+# <- { "return": {} }
+#
+# Since: 2.9
+##
+{ 'command': 'announce-self' }
+
-- 
2.9.3
