Received: from eggs.gnu.org ([209.51.188.92]:33378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ghCit-0003tG-Mu
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ghCis-0001nc-1v
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:12:39 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37288)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ghCiq-0001m3-DM
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:12:37 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 09 Jan 2019 15:12:35 +0300
Message-ID: <154703595509.13472.7357387659078524086.stgit@pasha-VirtualBox>
In-Reply-To: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v9 13/21] replay: implement replay-seek command
 to proceed to the desired step
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

This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
the execution to the specified step.
The command automatically loads nearest snapshot and replay the execution
to find the desired step.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

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
---
 hmp-commands.hx           |   19 +++++++++
 hmp.h                     |    1 
 qapi/replay.json          |   20 ++++++++++
 replay/replay-debugging.c |   91 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 6d04c02..2839acc 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1924,6 +1924,25 @@ The command is ignored when there are no replay breakpoints.
 ETEXI
 
     {
+        .name       = "replay_seek",
+        .args_type  = "icount:i",
+        .params     = "icount",
+        .help       = "rewinds replay to the step specified by icount",
+        .cmd        = hmp_replay_seek,
+    },
+
+STEXI
+@item replay_seek @var{icount}
+@findex replay_seek
+Automatically proceeds to the step specified by @var{icount}, when
+replaying the execution. The command automatically loads nearest
+snapshot and replay the execution to find the desired step.
+When there is no preceding snapshot or the execution is not replayed,
+then the command is ignored.
+icount for the reference may be observed with 'info replay' command.
+ETEXI
+
+    {
         .name       = "info",
         .args_type  = "item:s?",
         .params     = "[subcommand]",
diff --git a/hmp.h b/hmp.h
index c9b9b4f..d6e1d7e 100644
--- a/hmp.h
+++ b/hmp.h
@@ -151,5 +151,6 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
 void hmp_replay_break(Monitor *mon, const QDict *qdict);
 void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
+void hmp_replay_seek(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/replay.json b/qapi/replay.json
index a63219c..7390f88 100644
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
+# Automatically proceeds to the step specified by @icount when replaying
+# the execution. The command automatically loads nearest
+# snapshot and replay the execution to find the desired step.
+# When there is no preceding snapshot or the execution is not replayed,
+# then the command is ignored.
+# icount for the reference may be obtained with @query-replay command.
+#
+# @icount: destination execution step
+#
+# Since: 4.0
+#
+# Example:
+#
+# -> { "execute": "replay-seek", "data": { "icount": 220414 } }
+##
+{ 'command': 'replay-seek', 'data': { 'icount': 'int' } }
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 8ee64b2..39848dc 100644
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
@@ -125,3 +127,92 @@ void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
         return;
     }
 }
+
+static char *replay_find_nearest_snapshot(int64_t step, int64_t* snapshot_step)
+{
+    BlockDriverState *bs;
+    QEMUSnapshotInfo *sn_tab;
+    QEMUSnapshotInfo *nearest = NULL;
+    char *ret = NULL;
+    int nb_sns, i;
+    AioContext *aio_context;
+
+    *snapshot_step = -1;
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
+                && sn_tab[i].icount <= step
+                && (!nearest || nearest->icount < sn_tab[i].icount)) {
+                nearest = &sn_tab[i];
+            }
+        }
+    }
+    if (nearest) {
+        ret = g_strdup(nearest->name);
+        *snapshot_step = nearest->icount;
+    }
+    g_free(sn_tab);
+
+fail:
+    return ret;
+}
+
+static void replay_seek(int64_t step, QEMUTimerCB callback, Error **errp)
+{
+    char *snapshot = NULL;
+    int64_t snapshot_step;
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
+    snapshot = replay_find_nearest_snapshot(step, &snapshot_step);
+    if (snapshot) {
+        if (step < replay_get_current_step()
+            || replay_get_current_step() < snapshot_step) {
+            vm_stop(RUN_STATE_RESTORE_VM);
+            load_snapshot(snapshot, errp);
+        }
+        g_free(snapshot);
+    }
+    if (replay_get_current_step() <= step) {
+        replay_break(step, callback, NULL);
+        vm_start();
+    } else {
+        error_setg(errp, "cannot seek to the specified step");
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
+    int64_t step = qdict_get_try_int(qdict, "icount", -1LL);
+    Error *err = NULL;
+
+    qmp_replay_seek(step, &err);
+    if (err) {
+        error_report_err(err);
+        error_free(err);
+        return;
+    }
+}
