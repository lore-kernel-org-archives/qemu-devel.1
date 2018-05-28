Received: from eggs.gnu.org ([2001:4830:134:3::10]:34534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fNCMT-0004y6-QB
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fNCMQ-0007dj-FS
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:14:33 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46844)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fNCMQ-0007cV-2J
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:14:30 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Mon, 28 May 2018 10:14:30 +0300
Message-ID: <20180528071430.9424.63769.stgit@pasha-VirtualBox>
In-Reply-To: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
References: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 10/19] replay: implement replay-seek command
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
the execution to the specified step.
The commands automatically loads nearest snapshot and replay the execution
to find the desired step.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2:
 - renamed replay_seek qmp command into replay-seek
   (suggested by Eric Blake)
---
 hmp-commands.hx           |   15 ++++++++
 hmp.h                     |    1 +
 qapi/misc.json            |   16 ++++++++
 replay/replay-debugging.c |   89 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index a6d3f12..3bd418e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1864,6 +1864,21 @@ Execution stops when the specified step is reached.
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
index c6b8e37..52ad7b9 100644
--- a/hmp.h
+++ b/hmp.h
@@ -148,5 +148,6 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
 void hmp_replay_break(Monitor *mon, const QDict *qdict);
+void hmp_replay_seek(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/misc.json b/qapi/misc.json
index b02e776..5f2604c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3150,6 +3150,22 @@
 { 'command': 'replay-break', 'data': { 'step': 'int' } }
 
 ##
+# @replay-seek:
+#
+# Automatically proceeds to the specified step, when replaying
+# the execution.
+#
+# @step: destination execution step
+#
+# Since: 3.0
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
index 819017e..8d6c03d 100644
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
@@ -94,3 +96,90 @@ void hmp_replay_break(Monitor *mon, const QDict *qdict)
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
+static void replay_seek(int64_t step, Error **errp, QEMUTimerCB callback)
+{
+    char *snapshot = NULL;
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        error_setg(errp, "replay must be enabled to seek");
+        return;
+    }
+    if (!replay_snapshot) {
+        error_setg(errp, "snapshotting is disabled");
+        return;
+    }
+    int64_t snapshot_step = -1;
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
+    replay_seek(step, errp, replay_stop_vm);
+}
+
+void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+{
+    int64_t step = qdict_get_try_int(qdict, "step", -1LL);
+    Error *err = NULL;
+
+    qmp_replay_seek(step, &err);
+    if (err) {
+        monitor_printf(mon, "replay_seek error: %s\n", error_get_pretty(err));
+        error_free(err);
+        return;
+    }
+}
