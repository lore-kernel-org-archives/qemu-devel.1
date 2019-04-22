Received: from eggs.gnu.org ([209.51.188.92]:40247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0L-0000Wm-VN
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0J-00026y-Vl
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47110)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0I-000260-BL
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:54 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Mon, 22 Apr 2019 14:20:53 +0300
Message-ID: <155593205323.21079.896262494235573420.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.1 13/24] replay: implement replay-seek
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

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
the execution to the specified instruction count.
The command automatically loads nearest snapshot and replays the execution
to find the desired instruction count.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>

--

v2:
 - renamed replay_seek qmp command into replay-seek
   (suggested by Eric Blake)
v7:
 - small fixes related to Markus Armbruster's review
v9:
 - changed 'step' parameter name to 'icount'
 - moved json stuff to replay.json and updated the description
   (suggested by Markus Armbruster)
v10:
 - updated the descriptions
---
 hmp-commands.hx           |   19 +++++++++
 hmp.h                     |    1 
 qapi/replay.json          |   20 ++++++++++
 replay/replay-debugging.c |   92 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1eb07e7bcc..88a2d32110 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1945,6 +1945,25 @@ STEXI
 @findex replay_delete_break
 Remove replay breakpoint which was previously set with replay_break.
 The command is ignored when there are no replay breakpoints.
+ETEXI
+
+    {
+        .name       = "replay_seek",
+        .args_type  = "icount:i",
+        .params     = "icount",
+        .help       = "replay execution to the specified instruction count",
+        .cmd        = hmp_replay_seek,
+    },
+
+STEXI
+@item replay_seek @var{icount}
+@findex replay_seek
+Automatically proceed to the instruction count @var{icount}, when
+replaying the execution. The command automatically loads nearest
+snapshot and replays the execution to find the desired instruction.
+When there is no preceding snapshot or the execution is not replayed,
+then the command fails.
+icount for the reference may be observed with 'info replay' command.
 ETEXI
 
     {
diff --git a/hmp.h b/hmp.h
index c3e7354dd3..c67a911f2e 100644
--- a/hmp.h
+++ b/hmp.h
@@ -153,5 +153,6 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
 void hmp_replay_break(Monitor *mon, const QDict *qdict);
 void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
+void hmp_replay_seek(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/replay.json b/qapi/replay.json
index 425e053e4d..aa768d496c 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -99,3 +99,23 @@
 #
 ##
 { 'command': 'replay-delete-break' }
+
+##
+# @replay-seek:
+#
+# Automatically proceed to the instruction count @icount, when
+# replaying the execution. The command automatically loads nearest
+# snapshot and replays the execution to find the desired instruction.
+# When there is no preceding snapshot or the execution is not replayed,
+# then the command fails.
+# icount for the reference may be obtained with @query-replay command.
+#
+# @icount: target instruction count
+#
+# Since: 4.1
+#
+# Example:
+#
+# -> { "execute": "replay-seek", "data": { "icount": 220414 } }
+##
+{ 'command': 'replay-seek', 'data': { 'icount': 'int' } }
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index a94685e437..e3821ab1ba 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -18,6 +18,8 @@
 #include "qapi/qapi-commands-replay.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/timer.h"
+#include "block/snapshot.h"
+#include "migration/snapshot.h"
 
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
@@ -127,3 +129,93 @@ void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
         return;
     }
 }
+
+static char *replay_find_nearest_snapshot(int64_t icount,
+                                          int64_t *snapshot_icount)
+{
+    BlockDriverState *bs;
+    QEMUSnapshotInfo *sn_tab;
+    QEMUSnapshotInfo *nearest = NULL;
+    char *ret = NULL;
+    int nb_sns, i;
+    AioContext *aio_context;
+
+    *snapshot_icount = -1;
+
+    bs = bdrv_all_find_vmstate_bs();
+    if (!bs) {
+        goto fail;
+    }
+    aio_context = bdrv_get_aio_context(bs);
+
+    aio_context_acquire(aio_context);
+    nb_sns = bdrv_snapshot_list(bs, &sn_tab);
+    aio_context_release(aio_context);
+
+    for (i = 0; i < nb_sns; i++) {
+        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs) == 0) {
+            if (sn_tab[i].icount != -1ULL
+                && sn_tab[i].icount <= icount
+                && (!nearest || nearest->icount < sn_tab[i].icount)) {
+                nearest = &sn_tab[i];
+            }
+        }
+    }
+    if (nearest) {
+        ret = g_strdup(nearest->name);
+        *snapshot_icount = nearest->icount;
+    }
+    g_free(sn_tab);
+
+fail:
+    return ret;
+}
+
+static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **errp)
+{
+    char *snapshot = NULL;
+    int64_t snapshot_icount;
+
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        error_setg(errp, "replay must be enabled to seek");
+        return;
+    }
+    if (!replay_snapshot) {
+        error_setg(errp, "snapshotting is disabled");
+        return;
+    }
+
+    snapshot = replay_find_nearest_snapshot(icount, &snapshot_icount);
+    if (snapshot) {
+        if (icount < replay_get_current_step()
+            || replay_get_current_step() < snapshot_icount) {
+            vm_stop(RUN_STATE_RESTORE_VM);
+            load_snapshot(snapshot, errp);
+        }
+        g_free(snapshot);
+    }
+    if (replay_get_current_step() <= icount) {
+        replay_break(icount, callback, NULL);
+        vm_start();
+    } else {
+        error_setg(errp, "cannot seek to the specified instruction count");
+    }
+}
+
+void qmp_replay_seek(int64_t icount, Error **errp)
+{
+    replay_seek(icount, replay_stop_vm, errp);
+}
+
+void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+{
+    int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
+    Error *err = NULL;
+
+    qmp_replay_seek(icount, &err);
+    if (err) {
+        error_report_err(err);
+        error_free(err);
+        return;
+    }
+}
