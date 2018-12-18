Received: from eggs.gnu.org ([2001:4830:134:3::10]:46617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRi-0002s0-55
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRh-0005zA-4Y
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:21:54 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55520)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRg-0005ye-Nk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:21:53 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 18 Dec 2018 14:21:54 +0300
Message-ID: <20181218112154.11727.4557.stgit@pasha-VirtualBox>
In-Reply-To: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 10/20] replay: introduce info hmp/qmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch introduces 'info replay' monitor command and
corresponding qmp request.
These commands request the current record/replay mode, replay log file name,
and the execution step (number or recorded/replayed instructions).
User may use step number for replay_seek/replay_break commands and
for controlling the execution of replay.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

v2:
 - renamed info_replay qmp into query-replay (suggested by Eric Blake)
v7:
 - added empty line (suggested by Markus Armbruster)
---
 hmp-commands-info.hx      |   14 ++++++++++++++
 hmp.h                     |    1 +
 qapi/misc.json            |   35 +++++++++++++++++++++++++++++++++++
 replay/Makefile.objs      |    3 ++-
 replay/replay-debugging.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 replay/replay-debugging.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cbee8b9..9f2f35e 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -918,6 +918,20 @@ STEXI
 Show SEV information.
 ETEXI
 
+    {
+        .name       = "replay",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show parameters of the record/replay",
+        .cmd        = hmp_info_replay,
+    },
+
+STEXI
+@item info replay
+@findex info replay
+Display the current record/replay mode and the currently executing step.
+ETEXI
+
 STEXI
 @end table
 ETEXI
diff --git a/hmp.h b/hmp.h
index 5f1addc..d792149 100644
--- a/hmp.h
+++ b/hmp.h
@@ -148,5 +148,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_info_replay(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/misc.json b/qapi/misc.json
index 8325e0d..e47aea6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3113,6 +3113,41 @@
   'data': [ 'none', 'record', 'play' ] }
 
 ##
+# @ReplayInfo:
+#
+# Status of the record/replay mode.
+#
+# @mode: current mode.
+#
+# @filename: name of the record/replay log file.
+#
+# @step: current step number.
+#
+# Since: 4.0
+#
+##
+{ 'struct': 'ReplayInfo',
+  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'step': 'int' } }
+
+##
+# @query-replay:
+#
+# Retrieves the status of the execution record/replay.
+#
+# Returns: structure with the properties of the record/replay.
+#
+# Since: 4.0
+#
+# Example:
+#
+# -> { "execute": "query-replay" }
+# <- { "return": { "mode": "play", "filename": "log.rr", "step": 220414 } }
+#
+##
+{ 'command': 'query-replay',
+  'returns': 'ReplayInfo' }
+
+##
 # @xen-load-devices-state:
 #
 # Load the state of all devices from file. The RAM and the block devices
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
index cee6539..6694e3e 100644
--- a/replay/Makefile.objs
+++ b/replay/Makefile.objs
@@ -6,4 +6,5 @@ common-obj-y += replay-input.o
 common-obj-y += replay-char.o
 common-obj-y += replay-snapshot.o
 common-obj-y += replay-net.o
-common-obj-y += replay-audio.o
\ No newline at end of file
+common-obj-y += replay-audio.o
+common-obj-y += replay-debugging.o
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
new file mode 100644
index 0000000..1d7e75d
--- /dev/null
+++ b/replay/replay-debugging.c
@@ -0,0 +1,42 @@
+/*
+ * replay-debugging.c
+ *
+ * Copyright (c) 2010-2018 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "sysemu/replay.h"
+#include "replay-internal.h"
+#include "hmp.h"
+#include "monitor/monitor.h"
+#include "qapi/qapi-commands-misc.h"
+
+void hmp_info_replay(Monitor *mon, const QDict *qdict)
+{
+    if (replay_mode == REPLAY_MODE_NONE) {
+        monitor_printf(mon, "No record/replay\n");
+    } else {
+        monitor_printf(mon, "%s execution '%s': current step = %"PRId64"\n",
+            replay_mode == REPLAY_MODE_RECORD ? "Recording" : "Replaying",
+            replay_get_filename(), replay_get_current_step());
+    }
+}
+
+ReplayInfo *qmp_query_replay(Error **errp)
+{
+    ReplayInfo *retval = g_new0(ReplayInfo, 1);
+
+    retval->mode = replay_mode;
+    if (replay_get_filename()) {
+        retval->filename = g_strdup(replay_get_filename());
+        retval->has_filename = true;
+    }
+    retval->step = replay_get_current_step();
+    return retval;
+}
