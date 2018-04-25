Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fBJoW-0001P0-Bw
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fBJoS-0003RN-Hs
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:46:24 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42378)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fBJoS-0003PP-4d
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:46:20 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Apr 2018 15:46:08 +0300
Message-ID: <20180425124608.17182.4528.stgit@pasha-VirtualBox>
In-Reply-To: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 06/17] migration: introduce icount field
 for snapshots
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

Saving icount as a parameters of the snapshot allows navigation between
them in the execution replay scenario.
This information can be used for finding a specific snapshot for rewinding
the recorded execution to the specific moment of the time.
E.g., 'reverse step' action needs to load the nearest snapshot which is
prior to the current moment of time .

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 block/qapi.c             |   11 +++++++----
 blockdev.c               |    3 +++
 include/block/snapshot.h |    1 +
 migration/savevm.c       |    1 +
 qapi/block-core.json     |    5 ++++-
 qapi/block.json          |    3 ++-
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 04c6fc6..b51a23a 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -210,6 +210,7 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
         info->date_nsec     = sn_tab[i].date_nsec;
         info->vm_clock_sec  = sn_tab[i].vm_clock_nsec / 1000000000;
         info->vm_clock_nsec = sn_tab[i].vm_clock_nsec % 1000000000;
+        info->icount        = sn_tab[i].icount;
 
         info_list = g_new0(SnapshotInfoList, 1);
         info_list->value = info;
@@ -654,8 +655,8 @@ void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
 
     if (!sn) {
         func_fprintf(f,
-                     "%-10s%-20s%7s%20s%15s",
-                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
+                     "%-10s%-18s%7s%20s%13s%11s",
+                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
     } else {
         ti = sn->date_sec;
         localtime_r(&ti, &tm);
@@ -669,12 +670,13 @@ void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
                  (int)(secs % 60),
                  (int)((sn->vm_clock_nsec / 1000000) % 1000));
         func_fprintf(f,
-                     "%-10s%-20s%7s%20s%15s",
+                     "%-10s%-18s%7s%20s%13s%11"PRId64,
                      sn->id_str, sn->name,
                      get_human_readable_size(buf1, sizeof(buf1),
                                              sn->vm_state_size),
                      date_buf,
-                     clock_buf);
+                     clock_buf,
+                     sn->icount);
     }
 }
 
@@ -842,6 +844,7 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
                 .date_nsec = elem->value->date_nsec,
                 .vm_clock_nsec = elem->value->vm_clock_sec * 1000000000ULL +
                                  elem->value->vm_clock_nsec,
+                .icount = elem->value->icount,
             };
 
             pstrcpy(sn.id_str, sizeof(sn.id_str), elem->value->id);
diff --git a/blockdev.c b/blockdev.c
index c31bf3d..6771b79 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -56,6 +56,7 @@
 #include "block/trace.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
+#include "sysemu/replay.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/throttle-options.h"
@@ -1348,6 +1349,7 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     info->vm_state_size = sn.vm_state_size;
     info->vm_clock_nsec = sn.vm_clock_nsec % 1000000000;
     info->vm_clock_sec = sn.vm_clock_nsec / 1000000000;
+    info->icount = sn.icount;
 
     return info;
 
@@ -1556,6 +1558,7 @@ static void internal_snapshot_prepare(BlkActionState *common,
     sn->date_sec = tv.tv_sec;
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    sn->icount = replay_get_current_step();
 
     ret1 = bdrv_snapshot_create(bs, sn);
     if (ret1 < 0) {
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index f73d109..c9c8975 100644
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
index e2be02a..6ca67fb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2270,6 +2270,7 @@ int save_snapshot(const char *name, Error **errp)
     sn->date_sec = tv.tv_sec;
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    sn->icount = replay_get_current_step();
 
     if (name) {
         ret = bdrv_snapshot_find(bs, old_sn, name);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c50517b..675b24e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -25,13 +25,16 @@
 #
 # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
 #
+# @icount: current instruction count for execution record/replay
+#
 # Since: 1.3
 #
 ##
 { 'struct': 'SnapshotInfo',
   'data': { 'id': 'str', 'name': 'str', 'vm-state-size': 'int',
             'date-sec': 'int', 'date-nsec': 'int',
-            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
+            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int',
+            'icount': 'int' } }
 
 ##
 # @ImageInfoSpecificQCow2EncryptionBase:
diff --git a/qapi/block.json b/qapi/block.json
index c694524..2f364f7 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -148,7 +148,8 @@
 #                    "date-sec": 1000012,
 #                    "date-nsec": 10,
 #                    "vm-clock-sec": 100,
-#                    "vm-clock-nsec": 20
+#                    "vm-clock-nsec": 20,
+#                    "icount": 220414
 #      }
 #    }
 #
