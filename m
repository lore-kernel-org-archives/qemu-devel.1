Received: from eggs.gnu.org ([2001:4830:134:3::10]:44682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dHpT1-0001YU-6v
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dHpT0-0000e7-Fz
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:42:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dHpT0-0000do-9f
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:42:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37CDFC0587CC
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 10:42:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  5 Jun 2017 11:42:15 +0100
Message-Id: <20170605104216.22429-2-stefanha@redhat.com>
In-Reply-To: <20170605104216.22429-1-stefanha@redhat.com>
References: <20170605104216.22429-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] monitor: add handle_hmp_command trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

It is often useful to correlate QEMU-internal events with monitor
commands that caused them.  Trace the full HMP command being executed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor.c    | 2 ++
 trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/monitor.c b/monitor.c
index baa73c9..1e78d86 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3085,6 +3085,8 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
     QDict *qdict;
     const mon_cmd_t *cmd;
 
+    trace_handle_hmp_command(mon, cmdline);
+
     cmd = monitor_parse_command(mon, &cmdline, mon->cmd_table);
     if (!cmd) {
         return;
diff --git a/trace-events b/trace-events
index 433865f..2de6bec 100644
--- a/trace-events
+++ b/trace-events
@@ -52,6 +52,7 @@ spice_vmc_event(int event) "spice vmc event %d"
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
+handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
 
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-- 
2.9.4
