Received: from eggs.gnu.org ([2001:4830:134:3::10]:57104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMF-0006fK-Es
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM9-0006FS-RH
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM9-00062Q-C4
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id y16so14055736wrw.3
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:55 +0100
Message-Id: <20181005154910.3099-7-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 06/21] trace: show trace point counts in
 the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Now we have counts for each trace point we can expose them in the
monitor when the user queries what trace points are available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 monitor.c       | 5 +++--
 qapi/trace.json | 3 ++-
 trace/qmp.c     | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index c4677b502b..d8229cd2b0 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1421,9 +1421,10 @@ static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
     }
 
     for (elem = events; elem != NULL; elem = elem->next) {
-        monitor_printf(mon, "%s : state %u\n",
+        monitor_printf(mon, "%s : state %u count %" PRIu64 "\n",
                        elem->value->name,
-                       elem->value->state == TRACE_EVENT_STATE_ENABLED ? 1 : 0);
+                       elem->value->state == TRACE_EVENT_STATE_ENABLED ? 1 : 0,
+                       elem->value->count);
     }
     qapi_free_TraceEventInfoList(events);
 }
diff --git a/qapi/trace.json b/qapi/trace.json
index 799b254a18..b9184b0d18 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -33,6 +33,7 @@
 # @name: Event name.
 # @state: Tracing state.
 # @vcpu: Whether this is a per-vCPU event (since 2.7).
+# @count: Current hits on trace-point (since 3.1).
 #
 # An event is per-vCPU if it has the "vcpu" property in the "trace-events"
 # files.
@@ -40,7 +41,7 @@
 # Since: 2.2
 ##
 { 'struct': 'TraceEventInfo',
-  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool'} }
+  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool', 'count': 'int' } }
 
 ##
 # @trace-event-get-state:
diff --git a/trace/qmp.c b/trace/qmp.c
index ea99b00956..cce8198091 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -102,6 +102,7 @@ TraceEventInfoList *qmp_trace_event_get_state(const char *name,
         elem->value = g_new(TraceEventInfo, 1);
         elem->value->vcpu = is_vcpu;
         elem->value->name = g_strdup(trace_event_get_name(ev));
+        elem->value->count = ev->count;
 
         if (!trace_event_get_state_static(ev)) {
             elem->value->state = TRACE_EVENT_STATE_UNAVAILABLE;
-- 
2.17.1
