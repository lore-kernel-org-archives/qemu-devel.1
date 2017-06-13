Received: from eggs.gnu.org ([2001:4830:134:3::10]:49167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlyz-0002uI-S5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlyv-0001Jf-UV
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dKlyv-0001Ib-OO
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Jun 2017 14:35:31 +0100
Message-Id: <20170613133531.24671-3-stefanha@redhat.com>
In-Reply-To: <20170613133531.24671-1-stefanha@redhat.com>
References: <20170613133531.24671-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] monitor: resurrect handle_qmp_command trace
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Commit 104fc3027960dd2aa9d310936a6cb201c60e1088 ("qmp: Drop duplicated
QMP command object checks") removed the call to
trace_handle_qmp_command() while eliminating code duplication.

This patch brings the trace event back so QEMU-internal trace events can
be correlated with the QMP commands that caused them.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170605104216.22429-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor.c    | 5 +++++
 trace-events | 1 +
 2 files changed, 6 insertions(+)

diff --git a/monitor.c b/monitor.c
index 11de403..fcf4fad 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3809,6 +3809,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     QDict *qdict = NULL;
     Monitor *mon = cur_mon;
     Error *err = NULL;
+    QString *req_json;
 
     req = json_parser_parse_err(tokens, NULL, &err);
     if (!req && !err) {
@@ -3826,6 +3827,10 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         qdict_del(qdict, "id");
     } /* else will fail qmp_dispatch() */
 
+    req_json = qobject_to_json(req);
+    trace_handle_qmp_command(mon, qstring_get_str(req_json));
+    qobject_decref(QOBJECT(req_json));
+
     rsp = qmp_dispatch(cur_mon->qmp.commands, req);
 
     if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
diff --git a/trace-events b/trace-events
index 6fe7818..fd83087 100644
--- a/trace-events
+++ b/trace-events
@@ -46,6 +46,7 @@ monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
 handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
+handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
 
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-- 
2.9.4
