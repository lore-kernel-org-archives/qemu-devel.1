Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19EC28CC4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2ED26C40
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2ED26C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46221 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkWW-0001Vm-Jn
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:36:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWkRu-0006m7-5b
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWkRs-0008Cq-Go
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:32:10 -0400
Received: from relay.sw.ru ([185.231.240.75]:57226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWkRs-0008Ah-7A; Fri, 31 May 2019 12:32:08 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hWkRo-0006Lb-UY; Fri, 31 May 2019 19:32:05 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 31 May 2019 19:32:01 +0300
Message-Id: <20190531163202.162543-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190531163202.162543-1-vsementsov@virtuozzo.com>
References: <20190531163202.162543-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 8/9] block/qcow2-bitmap: fix reopening
 bitmaps to RW
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently reopening bitmaps to RW can't work, as qcow2 needs write
access to file child, to mark bitmaps in-image with IN_USE flag.

The possibility to write-access file child during reopen-RW was
implemented several patches ago with help of
.bdrv_need_rw_file_child_during_reopen_rw handler. Let's use
this new API to fix bitmaps reopening.

Add corresponding test-cases to 255 iotest.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h              |  1 +
 block/qcow2-bitmap.c       |  6 ++++++
 block/qcow2.c              |  1 +
 tests/qemu-iotests/255     |  2 ++
 tests/qemu-iotests/255.out | 35 +++++++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 4c8435141b..d6398bd030 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -726,6 +726,7 @@ void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset);
 void qcow2_cache_discard(Qcow2Cache *c, void *table);
 
 /* qcow2-bitmap.c functions */
+bool qcow2_has_bitmaps(BlockDriverState *bs);
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index f48b5b4eaf..803818b29a 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1102,6 +1102,12 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
     return list;
 }
 
+bool qcow2_has_bitmaps(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    return s->nb_bitmaps;
+}
+
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/qcow2.c b/block/qcow2.c
index 02d8ce7534..ffc067a8ac 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5218,6 +5218,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_reopen_bitmaps_rw = qcow2_reopen_bitmaps_rw,
     .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
     .bdrv_remove_persistent_dirty_bitmap = qcow2_remove_persistent_dirty_bitmap,
+    .bdrv_need_rw_file_child_during_reopen_rw = qcow2_has_bitmaps,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 1b3c081a68..5e8d01686f 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -82,3 +82,5 @@ def test(persistent, restart):
 
 
 test(persistent=False, restart=False)
+test(persistent=True, restart=False)
+test(persistent=True, restart=True)
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
index 5239d27c46..2f0d98d036 100644
--- a/tests/qemu-iotests/255.out
+++ b/tests/qemu-iotests/255.out
@@ -15,3 +15,38 @@ check that no bitmaps are in snapshot: not found
 {"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 check bitmap after commit: name=bitmap0 dirty-clusters=2
 check updated bitmap: name=bitmap0 dirty-clusters=3
+
+Testcase persistent without restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": true}}
+{"return": {}}
+initial bitmap: name=bitmap0 dirty-clusters=1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check that no bitmaps are in snapshot: not found
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+check bitmap after commit: name=bitmap0 dirty-clusters=2
+check updated bitmap: name=bitmap0 dirty-clusters=3
+
+Testcase persistent with restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": true}}
+{"return": {}}
+initial bitmap: name=bitmap0 dirty-clusters=1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check that no bitmaps are in snapshot: not found
+... Restart ...
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+check bitmap after commit: name=bitmap0 dirty-clusters=2
+check updated bitmap: name=bitmap0 dirty-clusters=3
-- 
2.18.0


