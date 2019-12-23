Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87679C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5F3206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5F3206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijKMd-00079c-VS
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 04:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJ8-0003Sw-1D
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJ6-0000as-Ej
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:47:21 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50762)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJ6-0000Ss-38
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:47:20 -0500
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id A16B754006B;
 Mon, 23 Dec 2019 12:47:01 +0300 (MSK)
Subject: [for-5.0 PATCH 03/11] migration: introduce icount field for snapshots
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 23 Dec 2019 12:47:01 +0300
Message-ID: <157709442133.12933.4291167191595240519.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Saving icount as a parameters of the snapshot allows navigation between
them in the execution replay scenario.
This information can be used for finding a specific snapshot for proceeding
the recorded execution to the specific moment of the time.
E.g., 'reverse step' action (introduced in one of the following patches)
needs to load the nearest snapshot which is prior to the current moment
of time.

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
index 9a5d0c9b27..110ac253ab 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -219,6 +219,8 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
         info->date_nsec     = sn_tab[i].date_nsec;
         info->vm_clock_sec  = sn_tab[i].vm_clock_nsec / 1000000000;
         info->vm_clock_nsec = sn_tab[i].vm_clock_nsec % 1000000000;
+        info->icount        = sn_tab[i].icount;
+        info->has_icount    = sn_tab[i].icount != -1ULL;
 
         info_list = g_new0(SnapshotInfoList, 1);
         info_list->value = info;
@@ -651,14 +653,15 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
 void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
 {
     char date_buf[128], clock_buf[128];
+    char icount_buf[128] = {0};
     struct tm tm;
     time_t ti;
     int64_t secs;
     char *sizing = NULL;
 
     if (!sn) {
-        qemu_printf("%-10s%-20s%7s%20s%15s",
-                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
+        qemu_printf("%-10s%-18s%7s%20s%13s%11s",
+                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
     } else {
         ti = sn->date_sec;
         localtime_r(&ti, &tm);
@@ -672,11 +675,16 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
                  (int)(secs % 60),
                  (int)((sn->vm_clock_nsec / 1000000) % 1000));
         sizing = size_to_str(sn->vm_state_size);
-        qemu_printf("%-10s%-20s%7s%20s%15s",
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
@@ -838,6 +846,8 @@ void bdrv_image_info_dump(ImageInfo *info)
                 .date_nsec = elem->value->date_nsec,
                 .vm_clock_nsec = elem->value->vm_clock_sec * 1000000000ULL +
                                  elem->value->vm_clock_nsec,
+                .icount = elem->value->has_icount ?
+                          elem->value->icount : -1ULL,
             };
 
             pstrcpy(sn.id_str, sizeof(sn.id_str), elem->value->id);
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index b04b3e1634..2c003514ef 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -662,6 +662,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
     sn->date_sec = sn_info->date_sec;
     sn->date_nsec = sn_info->date_nsec;
     sn->vm_clock_nsec = sn_info->vm_clock_nsec;
+    sn->icount = sn_info->icount;
     sn->extra_data_size = sizeof(QCowSnapshotExtraData);
 
     /* Allocate the L1 table of the snapshot and copy the current one there. */
@@ -995,6 +996,7 @@ int qcow2_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
         sn_info->date_sec = sn->date_sec;
         sn_info->date_nsec = sn->date_nsec;
         sn_info->vm_clock_nsec = sn->vm_clock_nsec;
+        sn_info->icount = sn->icount;
     }
     *psn_tab = sn_tab;
     return s->nb_snapshots;
diff --git a/blockdev.c b/blockdev.c
index 8e029e9c01..6383a64ddd 100644
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
@@ -1242,6 +1243,10 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     info->vm_state_size = sn.vm_state_size;
     info->vm_clock_nsec = sn.vm_clock_nsec % 1000000000;
     info->vm_clock_sec = sn.vm_clock_nsec / 1000000000;
+    if (sn.icount != -1ULL) {
+        info->icount = sn.icount;
+        info->has_icount = true;
+    }
 
     return info;
 
@@ -1449,6 +1454,11 @@ static void internal_snapshot_prepare(BlkActionState *common,
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
index a71b930b91..ae84bf6ab0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2681,6 +2681,11 @@ int save_snapshot(const char *name, Error **errp)
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
index 0cf68fea14..db3e435c74 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -26,13 +26,18 @@
 #
 # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
 #
+# @icount: Current instruction count. Appears when execution record/replay
+#          is enabled. Used for "time-traveling" to match the moment
+#          in the recorded execution with the snapshots. (since 5.0)
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


