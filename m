Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43296C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE54821D46
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE54821D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDUe-0002Ho-NZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kNDO2-0002Z9-EN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:01:36 -0400
Received: from mail.ispras.ru ([83.149.199.84]:35098)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kNDNy-0002cI-RL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:01:34 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id E990740F9AAE;
 Tue, 29 Sep 2020 11:01:27 +0000 (UTC)
Subject: [PATCH v6 04/14] migration: introduce icount field for snapshots
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 29 Sep 2020 14:01:27 +0300
Message-ID: <160137728764.31007.2320315782013180847.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
References: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 07:01:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, wrampazz@redhat.com, pavel.dovgalyuk@ispras.ru,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Saving icount as a parameters of the snapshot allows navigation between
them in the execution replay scenario.
This information can be used for finding a specific snapshot for proceeding
the recorded execution to the specific moment of the time.
E.g., 'reverse step' action (introduced in one of the following patches)
needs to load the nearest snapshot which is prior to the current moment
of time.
This patch also updates snapshot test which verifies qemu monitor output.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>

--

v4 changes:
 - squashed format update with test output update
---
 block/qapi.c               |   18 +++++++++++++----
 block/qcow2-snapshot.c     |    2 ++
 blockdev.c                 |   10 +++++++++
 include/block/snapshot.h   |    1 +
 migration/savevm.c         |    5 +++++
 qapi/block-core.json       |   10 +++++++--
 stubs/replay.c             |    5 +++++
 tests/qemu-iotests/267.out |   48 ++++++++++++++++++++++----------------------
 8 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index f423ece98c..1086ee0c76 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -230,6 +230,8 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
         info->date_nsec     = sn_tab[i].date_nsec;
         info->vm_clock_sec  = sn_tab[i].vm_clock_nsec / 1000000000;
         info->vm_clock_nsec = sn_tab[i].vm_clock_nsec % 1000000000;
+        info->icount        = sn_tab[i].icount;
+        info->has_icount    = sn_tab[i].icount != -1ULL;
 
         info_list = g_new0(SnapshotInfoList, 1);
         info_list->value = info;
@@ -694,14 +696,15 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
 void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
 {
     char date_buf[128], clock_buf[128];
+    char icount_buf[128] = {0};
     struct tm tm;
     time_t ti;
     int64_t secs;
     char *sizing = NULL;
 
     if (!sn) {
-        qemu_printf("%-10s%-20s%11s%20s%15s",
-                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
+        qemu_printf("%-10s%-18s%7s%20s%13s%11s",
+                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
     } else {
         ti = sn->date_sec;
         localtime_r(&ti, &tm);
@@ -715,11 +718,16 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
                  (int)(secs % 60),
                  (int)((sn->vm_clock_nsec / 1000000) % 1000));
         sizing = size_to_str(sn->vm_state_size);
-        qemu_printf("%-10s%-20s%11s%20s%15s",
+        if (sn->icount != -1ULL) {
+            snprintf(icount_buf, sizeof(icount_buf),
+                "%"PRId64, sn->icount);
+        }
+        qemu_printf("%-10s%-18s%7s%20s%13s%11s",
                     sn->id_str, sn->name,
                     sizing,
                     date_buf,
-                    clock_buf);
+                    clock_buf,
+                    icount_buf);
     }
     g_free(sizing);
 }
@@ -881,6 +889,8 @@ void bdrv_image_info_dump(ImageInfo *info)
                 .date_nsec = elem->value->date_nsec,
                 .vm_clock_nsec = elem->value->vm_clock_sec * 1000000000ULL +
                                  elem->value->vm_clock_nsec,
+                .icount = elem->value->has_icount ?
+                          elem->value->icount : -1ULL,
             };
 
             pstrcpy(sn.id_str, sizeof(sn.id_str), elem->value->id);
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index d68b25e0c5..2e98c7f4b6 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -663,6 +663,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
     sn->date_sec = sn_info->date_sec;
     sn->date_nsec = sn_info->date_nsec;
     sn->vm_clock_nsec = sn_info->vm_clock_nsec;
+    sn->icount = sn_info->icount;
     sn->extra_data_size = sizeof(QCowSnapshotExtraData);
 
     /* Allocate the L1 table of the snapshot and copy the current one there. */
@@ -1007,6 +1008,7 @@ int qcow2_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
         sn_info->date_sec = sn->date_sec;
         sn_info->date_nsec = sn->date_nsec;
         sn_info->vm_clock_nsec = sn->vm_clock_nsec;
+        sn_info->icount = sn->icount;
     }
     *psn_tab = sn_tab;
     return s->nb_snapshots;
diff --git a/blockdev.c b/blockdev.c
index bebd3ba1c3..a6ae475dac 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -59,6 +59,7 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
 #include "sysemu/runstate.h"
+#include "sysemu/replay.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/main-loop.h"
@@ -1190,6 +1191,10 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     info->vm_state_size = sn.vm_state_size;
     info->vm_clock_nsec = sn.vm_clock_nsec % 1000000000;
     info->vm_clock_sec = sn.vm_clock_nsec / 1000000000;
+    if (sn.icount != -1ULL) {
+        info->icount = sn.icount;
+        info->has_icount = true;
+    }
 
     return info;
 
@@ -1350,6 +1355,11 @@ static void internal_snapshot_prepare(BlkActionState *common,
     sn->date_sec = tv.tv_sec;
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (replay_mode != REPLAY_MODE_NONE) {
+        sn->icount = replay_get_current_icount();
+    } else {
+        sn->icount = -1ULL;
+    }
 
     ret1 = bdrv_snapshot_create(bs, sn);
     if (ret1 < 0) {
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 2bfcd57578..b0fe42993d 100644
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
index 34e4b71052..0e8dc78684 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2723,6 +2723,11 @@ int save_snapshot(const char *name, Error **errp)
     sn->date_sec = tv.tv_sec;
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (replay_mode != REPLAY_MODE_NONE) {
+        sn->icount = replay_get_current_icount();
+    } else {
+        sn->icount = -1ULL;
+    }
 
     if (name) {
         ret = bdrv_snapshot_find(bs, old_sn, name);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3c16f1e11d..2135a61432 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -27,13 +27,18 @@
 #
 # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
 #
+# @icount: Current instruction count. Appears when execution record/replay
+#          is enabled. Used for "time-traveling" to match the moment
+#          in the recorded execution with the snapshots. (since 5.2)
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
@@ -5527,7 +5532,8 @@
 #                    "date-sec": 1000012,
 #                    "date-nsec": 10,
 #                    "vm-clock-sec": 100,
-#                    "vm-clock-nsec": 20
+#                    "vm-clock-nsec": 20,
+#                    "icount": 220414
 #      }
 #    }
 #
diff --git a/stubs/replay.c b/stubs/replay.c
index 5974ec1f50..eacb366aa8 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -88,3 +88,8 @@ int replay_read_random(void *buf, size_t len)
 {
     return 0;
 }
+
+uint64_t replay_get_current_icount(void)
+{
+    return 0;
+}
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 215902b3ad..27471ffae8 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 Internal snapshots on backing file:
 
 === -blockdev with NBD server on the backing file ===
@@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 Internal snapshots on backing file:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 *** done


