Received: from eggs.gnu.org ([209.51.188.92]:52199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvyK-0008Mm-EB
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvyH-0008SB-Cj
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:46 -0500
Received: from mail.ispras.ru ([83.149.199.45]:33568)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvyH-0008Rg-0t
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:45 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Feb 2019 11:20:44 +0300
Message-ID: <154935484469.7509.13604340421487424814.stgit@pasha-VirtualBox>
In-Reply-To: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>
References: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v12 11/25] replay: introduce info hmp/qmp
 command
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
These commands request the current record/replay mode, replay log file
name, and the instruction count (number of recorded/replayed
instructions).  The instruction count can be used with the
replay_seek/replay_break commands added in the next two patches.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>

--

v2:
 - renamed info_replay qmp into query-replay (suggested by Eric Blake)
v7:
 - added empty line (suggested by Markus Armbruster)
v9:
 - changed 'step' parameter name to 'icount'
 - moved json stuff to replay.json and updated the descriptions
   (suggested by Markus Armbruster)
v10:
 - updated descriptions and messages for rr stuff
---
 hmp-commands-info.hx      |   14 ++++++++++++++
 hmp.h                     |    1 +
 qapi/block-core.json      |    3 ++-
 qapi/replay.json          |   39 +++++++++++++++++++++++++++++++++++++++
 replay/Makefile.objs      |    3 ++-
 replay/replay-debugging.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 replay/replay-debugging.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cbee8b944d..7cc0baadba 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -916,6 +916,20 @@ STEXI
 @item info sev
 @findex info sev
 Show SEV information.
+ETEXI
+
+    {
+        .name       = "replay",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show record/replay information",
+        .cmd        = hmp_info_replay,
+    },
+
+STEXI
+@item info replay
+@findex info replay
+Display the record/replay information: mode and the current icount.
 ETEXI
 
 STEXI
diff --git a/hmp.h b/hmp.h
index 5f1addcca2..d792149f24 100644
--- a/hmp.h
+++ b/hmp.h
@@ -148,5 +148,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_info_replay(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 69ec06e8ac..9a6e18f3c9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -28,7 +28,8 @@
 #
 # @icount: Current instruction count. Appears when execution record/replay
 #          is enabled. Used for "time-traveling" to match the moment
-#          in the recorded execution with the snapshots. (since 4.0)
+#          in the recorded execution with the snapshots. This counter may
+#          be obtained through @query-replay command (since 4.0)
 #
 # Since: 1.3
 #
diff --git a/qapi/replay.json b/qapi/replay.json
index 9e13551d20..4206150544 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -24,3 +24,42 @@
 ##
 { 'enum': 'ReplayMode',
   'data': [ 'none', 'record', 'play' ] }
+
+##
+# @ReplayInfo:
+#
+# Record/replay information.
+#
+# @mode: current mode.
+#
+# @filename: name of the record/replay log file.
+#            It is present only in record or replay modes, when the log
+#            is recorded or replayed.
+#
+# @icount: current number of executed instructions.
+#
+# Since: 4.0
+#
+##
+{ 'struct': 'ReplayInfo',
+  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'icount': 'int' } }
+
+##
+# @query-replay:
+#
+# Retrieve the record/replay information.
+# It includes current instruction count which may be used for
+# @replay-break and @replay-seek commands.
+#
+# Returns: record/replay information.
+#
+# Since: 4.0
+#
+# Example:
+#
+# -> { "execute": "query-replay" }
+# <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
+#
+##
+{ 'command': 'query-replay',
+  'returns': 'ReplayInfo' }
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
index cee6539a23..6694e3e2a2 100644
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
index 0000000000..51f1c4d82d
--- /dev/null
+++ b/replay/replay-debugging.c
@@ -0,0 +1,43 @@
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
+#include "qapi/qapi-commands-replay.h"
+
+void hmp_info_replay(Monitor *mon, const QDict *qdict)
+{
+    if (replay_mode == REPLAY_MODE_NONE) {
+        monitor_printf(mon, "Record/replay is not active\n");
+    } else {
+        monitor_printf(mon,
+            "%s execution '%s': instruction count = %"PRId64"\n",
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
+    retval->icount = replay_get_current_step();
+    return retval;
+}
