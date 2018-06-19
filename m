Received: from eggs.gnu.org ([2001:4830:134:3::10]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9IG-0005OD-2N
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9IC-0003it-Ur
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV9IC-0003i6-PI
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:00 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Jun 2018 13:34:22 +0800
Message-Id: <20180619053426.13065-4-peterx@redhat.com>
In-Reply-To: <20180619053426.13065-1-peterx@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/7] monitor: flush qmp responses when CLOSED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Previously we clean up the queues when we got CLOSED event.  It was used
to make sure we won't send leftover replies/events of a old client to a
new client which makes perfect sense. However this will also drop the
replies/events even if the output port of the previous chardev backend
is still open, which can lead to missing of the last replies/events.
Now this patch does an extra operation to flush the response queue
before cleaning up.

In most cases, a QMP session will be based on a bidirectional channel (a
TCP port, for example, we read/write to the same socket handle), so in
port and out port of the backend chardev are fundamentally the same
port. In these cases, it does not really matter much on whether we'll
flush the response queue since flushing will fail anyway.  However there
can be cases where in & out ports of the QMP monitor's backend chardev
are separated.  Here is an example:

  cat $QMP_COMMANDS | qemu -qmp stdio ... | filter_commands

In this case, the backend is fd-typed, and it is connected to stdio
where in port is stdin and out port is stdout.  Now if we drop all the
events on the response queue then filter_command process might miss some
events that it might expect.  The thing is that, when stdin closes,
stdout might still be there alive!

In practice, I encountered SHUTDOWN event missing when running test with
iotest 087 with Out-Of-Band enabled.  Here is one of the ways that this
can happen (after "quit" command is executed and QEMU quits the main
loop):

1. [main thread] QEMU queues a SHUTDOWN event into response queue.

2. "cat" terminates (to distinguish it from the animal, I quote it).

3. [monitor iothread] QEMU's monitor iothread reads EOF from stdin.

4. [monitor iothread] QEMU's monitor iothread calls the CLOSED event
   hook for the monitor, which will destroy the response queue of the
   monitor, then the SHUTDOWN event is dropped.

5. [main thread] QEMU's main thread cleans up the monitors in
   monitor_cleanup().  When trying to flush pending responses, it sees
   nothing.  SHUTDOWN is lost forever.

Note that before the monitor iothread was introduced, step [4]/[5] could
never happen since the main loop was the only place to detect the EOF
event of stdin and run the CLOSED event hooks.  Now things can happen in
parallel in the iothread.

Without this patch, iotest 087 will have ~10% chance to miss the
SHUTDOWN event and fail when with Out-Of-Band enabled (the output is
manually touched up to suite line width requirement):

--- /home/peterx/git/qemu/tests/qemu-iotests/087.out
+++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad
@@ -8,7 +8,6 @@
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "'node-name' must be
  specified for the root node"}}
 {"return": {}}
-{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
- "event": "SHUTDOWN", "data": {"guest": false}}

 === Duplicate ID ===
@@ -53,7 +52,6 @@
 {"return": {}}
 {"return": {}}
 {"return": {}}

-{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
- "event": "SHUTDOWN", "data": {"guest": false}}

This patch fixes the problem.

Fixes: 6d2d563f8c ("qmp: cleanup qmp queues properly", 2018-03-27)
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index d4a463f707..c9a02ee40c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -512,6 +512,27 @@ struct QMPResponse {
 };
 typedef struct QMPResponse QMPResponse;
 
+static QObject *monitor_qmp_response_pop_one(Monitor *mon)
+{
+    QObject *data;
+
+    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    data = g_queue_pop_head(mon->qmp.qmp_responses);
+    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+
+    return data;
+}
+
+static void monitor_qmp_response_flush(Monitor *mon)
+{
+    QObject *data;
+
+    while ((data = monitor_qmp_response_pop_one(mon))) {
+        monitor_json_emitter_raw(mon, data);
+        qobject_unref(data);
+    }
+}
+
 /*
  * Pop a QMPResponse from any monitor's response queue into @response.
  * Return false if all the queues are empty; else true.
@@ -523,9 +544,7 @@ static bool monitor_qmp_response_pop_any(QMPResponse *response)
 
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
-        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        data = g_queue_pop_head(mon->qmp.qmp_responses);
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+        data = monitor_qmp_response_pop_one(mon);
         if (data) {
             response->mon = mon;
             response->data = data;
@@ -4364,6 +4383,14 @@ static void monitor_qmp_event(void *opaque, int event)
         mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
+        /*
+         * Note: this is only useful when the output of the chardev
+         * backend is still open.  For example, when the backend is
+         * stdio, it's possible that stdout is still open when stdin
+         * is closed.  After all, CHR_EVENT_CLOSED event is currently
+         * only bound to stdin.
+         */
+        monitor_qmp_response_flush(mon);
         monitor_qmp_cleanup_queues(mon);
         json_message_parser_destroy(&mon->qmp.parser);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
-- 
2.17.1
