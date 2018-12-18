Received: from eggs.gnu.org ([2001:4830:134:3::10]:46744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRx-00032L-AS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRv-00069t-9f
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55590)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRt-00066z-6Z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:05 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 18 Dec 2018 14:22:05 +0300
Message-ID: <20181218112205.11727.18637.stgit@pasha-VirtualBox>
In-Reply-To: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 12/20] replay: implement replay-seek command
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
The commands automatically loads nearest snapshot and replay the execution
to find the desired step.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2:
 - renamed replay_seek qmp command into replay-seek
   (suggested by Eric Blake)
v7:
 - small fixes related to Markus Armbruster's review
---
 hmp-commands.hx           |   15 +++++++
 hmp.h                     |    1 
 qapi/misc.json            |   16 ++++++++
 replay/replay-debugging.c |   91 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index cbe0d6f..36d801e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1919,6 +1919,21 @@ Removes replay breakpoint which was previously set with replay_break.
 ETEXI
 
     {
+        .name       = "replay_seek",
+        .args_type  = "step:i",
+        .params     = "step",
+        .help       = "rewinds replay to the specified step",
+        .cmd        = hmp_replay_seek,
+    },
+
+STEXI
+@item replay_seek @var{step}
+@findex replay_seek
+Automatically proceeds to the specified step, when replaying
+the execution.
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 0bcb547..9989706 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3179,6 +3179,22 @@
 { 'command': 'replay-delete-break' }
 
 ##
+# @replay-seek:
+#
+# Automatically proceeds to the specified step when replaying
+# the execution.
+#
+# @step: destination execution step
+#
+# Since: 4.0
+#
+# Example:
+#
+# -> { "execute": "replay-seek", "data": { "step": 220414 } }
+##
+{ 'command': 'replay-seek', 'data': { 'step': 'int' } }
+
+##
 # @xen-load-devices-state:
 #
 # Load the state of all devices from file. The RAM and the block devices
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 207d6e0..d744106 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -18,6 +18,8 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/timer.h"
+#include "block/snapshot.h"
+#include "migration/snapshot.h"
 
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
@@ -124,3 +126,92 @@ void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
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
+void qmp_replay_seek(int64_t step, Error **errp)
+{
+    replay_seek(step, replay_stop_vm, errp);
+}
+
+void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+{
+    int64_t step = qdict_get_try_int(qdict, "step", -1LL);
+    Error *err = NULL;
+
+    qmp_replay_seek(step, &err);
+    if (err) {
+        error_report_err(err);
+        error_free(err);
+        return;
+    }
+}
