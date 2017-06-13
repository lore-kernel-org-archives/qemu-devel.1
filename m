Received: from eggs.gnu.org ([2001:4830:134:3::10]:49143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlyy-0002sc-DQ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlyt-0001HD-R5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dKlyt-0001Gp-Lt
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Jun 2017 14:35:30 +0100
Message-Id: <20170613133531.24671-2-stefanha@redhat.com>
In-Reply-To: <20170613133531.24671-1-stefanha@redhat.com>
References: <20170613133531.24671-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] monitor: add handle_hmp_command trace event
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

It is often useful to correlate QEMU-internal events with monitor
commands that caused them.  Trace the full HMP command being executed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170605104216.22429-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor.c    | 2 ++
 trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/monitor.c b/monitor.c
index 1e63ace..11de403 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3088,6 +3088,8 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
     QDict *qdict;
     const mon_cmd_t *cmd;
 
+    trace_handle_hmp_command(mon, cmdline);
+
     cmd = monitor_parse_command(mon, &cmdline, mon->cmd_table);
     if (!cmd) {
         return;
diff --git a/trace-events b/trace-events
index b496be9..6fe7818 100644
--- a/trace-events
+++ b/trace-events
@@ -45,6 +45,7 @@ qemu_system_powerdown_request(void) ""
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
+handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
 
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-- 
2.9.4
