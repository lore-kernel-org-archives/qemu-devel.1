Received: from eggs.gnu.org ([209.51.188.92]:40071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWzs-0008Li-Pn
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWzr-0001iz-9B
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:28 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46990)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWzq-0001hS-Tm
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:27 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Mon, 22 Apr 2019 14:20:24 +0300
Message-ID: <155593202476.21079.15142315088762977727.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.1 08/24] migration: introduce icount
 field for snapshots
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

Saving icount as a parameters of the snapshot allows navigation between
them in the execution replay scenario.
This information can be used for finding a specific snapshot for proceeding
the recorded execution to the specific moment of the time.
E.g., 'reverse step' action (introduced in one of the following patches)
needs to load the nearest snapshot which is prior to the current moment
of time .

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>

--

v2:
 - made icount in SnapshotInfo optional (suggested by Eric Blake)
v7:
 - added more comments for icount member (suggested by Markus Armbruster)
v9:
 - updated icount comment
v10:
 - updated icount comment again
---
 block/qapi.c             |   18 ++++++++++++++----
 block/qcow2-snapshot.c   |    2 ++
 blockdev.c               |   10 ++++++++++
 include/block/snapshot.h |    1 +
 migration/savevm.c       |    5 +++++
 qapi/block-core.json     |    7 ++++++-
 qapi/block.json          |    3 ++-
 7 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 21edab34fc..d2cdd99946 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -212,6 +212,8 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
         info->date_nsec     = sn_tab[i].date_nsec;
         info->vm_clock_sec  = sn_tab[i].vm_clock_nsec / 1000000000;
         info->vm_clock_nsec = sn_tab[i].vm_clock_nsec % 1000000000;
+        info->icount        = sn_tab[i].icount;
+        info->has_icount    = sn_tab[i].icount != -1ULL;
 
         info_list = g_new0(SnapshotInfoList, 1);
         info_list->value = info;
@@ -664,14 +666,15 @@ void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
                         QEMUSnapshotInfo *sn)
 {
     char buf1[128], date_buf[128], clock_buf[128];
+    char icount_buf[128] = {0};
     struct tm tm;
     time_t ti;
     int64_t secs;
 
     if (!sn) {
         func_fprintf(f,
-                     "%-10s%-20s%7s%20s%15s",
-                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
+                     "%-10s%-18s%7s%20s%13s%11s",
+                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
     } else {
         ti = sn->date_sec;
         localtime_r(&ti, &tm);
@@ -684,13 +687,18 @@ void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
                  (int)((secs / 60) % 60),
                  (int)(secs % 60),
                  (int)((sn->vm_clock_nsec / 1000000) % 1000));
+        if (sn->icount != -1ULL) {
+            snprintf(icount_buf, sizeof(icount_buf),
+                "%"PRId64, sn->icount);
+        }
         func_fprintf(f,
-                     "%-10s%-20s%7s%20s%15s",
+                     "%-10s%-18s%7s%20s%13s%11s",
                      sn->id_str, sn->name,
                      get_human_readable_size(buf1, sizeof(buf1),
                                              sn->vm_state_size),
                      date_buf,
-                     clock_buf);
+                     clock_buf,
+                     icount_buf);
     }
 }
 
@@ -858,6 +866,8 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
                 .date_nsec = elem->value->date_nsec,
                 .vm_clock_nsec = elem->value->vm_clock_sec * 1000000000ULL +
                                  elem->value->vm_clock_nsec,
+                .icount = elem->value->has_icount ?
+                          elem->value->icount : -1ULL,
             };
 
             pstrcpy(sn.id_str, sizeof(sn.id_str), elem->value->id);
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 52b535425a..e358a7581c 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -378,6 +378,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
     sn->date_sec = sn_info->date_sec;
     sn->date_nsec = sn_info->date_nsec;
     sn->vm_clock_nsec = sn_info->vm_clock_nsec;
+    sn->icount = sn_info->icount;
 
     /* Allocate the L1 table of the snapshot and copy the current one there. */
     l1_table_offset = qcow2_alloc_clusters(bs, s->l1_size * sizeof(uint64_t));
@@ -709,6 +710,7 @@ int qcow2_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
         sn_info->date_sec = sn->date_sec;
         sn_info->date_nsec = sn->date_nsec;
         sn_info->vm_clock_nsec = sn->vm_clock_nsec;
+        sn_info->icount = sn->icount;
     }
     *psn_tab = sn_tab;
     return s->nb_snapshots;
diff --git a/blockdev.c b/blockdev.c
index 4775a07d93..7265ef0525 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -57,6 +57,7 @@
 #include "block/trace.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
+#include "sysemu/replay.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/throttle-options.h"
@@ -1241,6 +1242,10 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     info->vm_state_size = sn.vm_state_size;
     info->vm_clock_nsec = sn.vm_clock_nsec % 1000000000;
     info->vm_clock_sec = sn.vm_clock_nsec / 1000000000;
+    if (sn.icount != -1ULL) {
+        info->icount = sn.icount;
+        info->has_icount = true;
+    }
 
     return info;
 
@@ -1448,6 +1453,11 @@ static void internal_snapshot_prepare(BlkActionState *common,
     sn->date_sec = tv.tv_sec;
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (replay_mode != REPLAY_MODE_NONE) {
+        sn->icount = replay_get_current_step();
+    } else {
+        sn->icount = -1ULL;
+    }
 
     ret1 = bdrv_snapshot_create(bs, sn);
     if (ret1 < 0) {
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index b5d5084a12..deeb24c22c 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -42,6 +42,7 @@ typedef struct QEMUSnapshotInfo {
     uint32_t date_sec; /* UTC date of the snapshot */
     uint32_t date_nsec;
     uint64_t vm_clock_nsec; /* VM clock relative to boot */
+    uint64_t icount; /* record/replay step */
 } QEMUSnapshotInfo;
 
 int bdrv_snapshot_find(BlockDriverState *bs, QEMUSnapshotInfo *sn_info,
diff --git a/migration/savevm.c b/migration/savevm.c
index 34bcad3807..51ab224d25 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2596,6 +2596,11 @@ int save_snapshot(const char *name, Error **errp)
     sn->date_sec = tv.tv_sec;
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (replay_mode != REPLAY_MODE_NONE) {
+        sn->icount = replay_get_current_step();
+    } else {
+        sn->icount = -1ULL;
+    }
 
     if (name) {
         ret = bdrv_snapshot_find(bs, old_sn, name);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..f9b3d45819 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -26,13 +26,18 @@
 #
 # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
 #
+# @icount: Current instruction count. Appears when execution record/replay
+#          is enabled. Used for "time-traveling" to match the moment
+#          in the recorded execution with the snapshots. (since 4.1)
+#
 # Since: 1.3
 #
 ##
 { 'struct': 'SnapshotInfo',
   'data': { 'id': 'str', 'name': 'str', 'vm-state-size': 'int',
             'date-sec': 'int', 'date-nsec': 'int',
-            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
+            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int',
+            '*icount': 'int' } }
 
 ##
 # @ImageInfoSpecificQCow2EncryptionBase:
diff --git a/qapi/block.json b/qapi/block.json
index 145c268bb6..f389bb6f1a 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -176,7 +176,8 @@
 #                    "date-sec": 1000012,
 #                    "date-nsec": 10,
 #                    "vm-clock-sec": 100,
-#                    "vm-clock-nsec": 20
+#                    "vm-clock-nsec": 20,
+#                    "icount": 220414
 #      }
 #    }
 #
