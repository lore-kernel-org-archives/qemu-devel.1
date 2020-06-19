Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F125EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 20:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB8F2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 20:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUPDaBFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB8F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmNBV-0003Ei-Rp
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 16:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN8B-00058B-2U
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN87-0007gZ-9G
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592596610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwz7B0a4kmWj+6y73X0oaEKUPbUEAsp0c5c8Gw4VBkU=;
 b=aUPDaBFhB5tUCAxfqN6oK6+YlVcQXjoxlf2+ChJGLPTKvS5WS2TMyhXWTWkp0sJfP66Xka
 XoetRBbIugdHCBkVi32eNEMQ+So866rQI10NmFatFPQxdyRMDejBFtgLW6JXLfTYTL7kPb
 tjg7lE75aNDB0RVW8ZD2Knv1yAiTT78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-b56y-7G3PuiYmN0pTFFRXQ-1; Fri, 19 Jun 2020 15:56:48 -0400
X-MC-Unique: b56y-7G3PuiYmN0pTFFRXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6D5564A7B;
 Fri, 19 Jun 2020 19:56:47 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD2697166C;
 Fri, 19 Jun 2020 19:56:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/6] bitmaps: Use x- prefix for block-dirty-bitmap-popluate
Date: Fri, 19 Jun 2020 14:56:21 -0500
Message-Id: <20200619195621.58740-7-eblake@redhat.com>
In-Reply-To: <20200619195621.58740-1-eblake@redhat.com>
References: <20200619195621.58740-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Give ourselves an out if we need to tweak the interface, in order to
gain more experience with what works when libvirt experiments with
using it.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json       |   6 +-
 qapi/transaction.json      |   4 +-
 blockdev.c                 |  14 ++--
 tests/qemu-iotests/298     |   2 +-
 tests/qemu-iotests/298.out | 128 ++++++++++++++++++-------------------
 5 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 313583b47c16..dcf6b907e45c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2260,7 +2260,7 @@
             '*auto-dismiss': 'bool' } }

 ##
-# @block-dirty-bitmap-populate:
+# @x-block-dirty-bitmap-populate:
 #
 # Creates a new job that writes a pattern into a dirty bitmap.
 #
@@ -2268,13 +2268,13 @@
 #
 # Example:
 #
-# -> { "execute": "block-dirty-bitmap-populate",
+# -> { "execute": "x-block-dirty-bitmap-populate",
 #      "arguments": { "node": "drive0", "target": "bitmap0",
 #                     "job-id": "job0", "pattern": "allocate-top" } }
 # <- { "return": {} }
 #
 ##
-{ 'command': 'block-dirty-bitmap-populate', 'boxed': true,
+{ 'command': 'x-block-dirty-bitmap-populate', 'boxed': true,
   'data': 'BlockDirtyBitmapPopulate' }

 ##
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 21be59faae56..3277e948f321 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -50,7 +50,7 @@
 # - @block-dirty-bitmap-enable: since 4.0
 # - @block-dirty-bitmap-disable: since 4.0
 # - @block-dirty-bitmap-merge: since 4.0
-# - @block-dirty-bitmap-populate: since 5.1
+# - @x-block-dirty-bitmap-populate: since 5.1
 # - @blockdev-backup: since 2.3
 # - @blockdev-snapshot: since 2.5
 # - @blockdev-snapshot-internal-sync: since 1.7
@@ -68,7 +68,7 @@
        'block-dirty-bitmap-enable': 'BlockDirtyBitmap',
        'block-dirty-bitmap-disable': 'BlockDirtyBitmap',
        'block-dirty-bitmap-merge': 'BlockDirtyBitmapMerge',
-       'block-dirty-bitmap-populate': 'BlockDirtyBitmapPopulate',
+       'x-block-dirty-bitmap-populate': 'BlockDirtyBitmapPopulate',
        'blockdev-backup': 'BlockdevBackup',
        'blockdev-snapshot': 'BlockdevSnapshot',
        'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
diff --git a/blockdev.c b/blockdev.c
index d072519e7b91..b86ef5b7f281 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2188,8 +2188,8 @@ static void block_dirty_bitmap_populate_prepare(BlkActionState *common,
     int job_flags = JOB_DEFAULT;

     assert(common->action->type ==
-           TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE);
-    bitpop = common->action->u.block_dirty_bitmap_populate.data;
+           TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_POPULATE);
+    bitpop = common->action->u.x_block_dirty_bitmap_populate.data;

     bmap = block_dirty_bitmap_lookup(bitpop->node, bitpop->name, &bs, errp);
     if (!bmap) {
@@ -2317,7 +2317,7 @@ static const BlkActionOps actions[] = {
         .commit = block_dirty_bitmap_remove_commit,
         .abort = block_dirty_bitmap_remove_abort,
     },
-    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE] = {
+    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_POPULATE] = {
         .instance_size = sizeof(BlockJobActionState),
         .prepare = block_dirty_bitmap_populate_prepare,
         .commit = blockdev_backup_commit,
@@ -2443,12 +2443,12 @@ void qmp_block_passwd(bool has_device, const char *device,
                "Setting block passwords directly is no longer supported");
 }

-void qmp_block_dirty_bitmap_populate(BlockDirtyBitmapPopulate *bitpop,
-                                     Error **errp)
+void qmp_x_block_dirty_bitmap_populate(BlockDirtyBitmapPopulate *bitpop,
+                                       Error **errp)
 {
     TransactionAction action = {
-        .type = TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE,
-        .u.block_dirty_bitmap_populate.data = bitpop,
+        .type = TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_POPULATE,
+        .u.x_block_dirty_bitmap_populate.data = bitpop,
     };
     blockdev_do_action(&action, errp);
 }
diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index 4bfcecd3bc88..2a3df2de85db 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -49,7 +49,7 @@ class Drive:
 def block_dirty_bitmap_populate(vm, node, bitmap, job_id, pattern, **kwargs):
     # Strip any arguments explicitly nulled by the caller:
     kwargs = {key: val for key, val in kwargs.items() if val is not None}
-    result = vm.qmp_log('block-dirty-bitmap-populate',
+    result = vm.qmp_log('x-block-dirty-bitmap-populate',
                         node=node,
                         name=bitmap,
                         job_id=job_id,
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
index 7c0afc71920c..8b75f0e516c0 100644
--- a/tests/qemu-iotests/298.out
+++ b/tests/qemu-iotests/298.out
@@ -33,7 +33,7 @@
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -126,7 +126,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -209,7 +209,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -301,7 +301,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -383,7 +383,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -466,7 +466,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -539,7 +539,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -621,7 +621,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -680,7 +680,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -760,7 +760,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -830,7 +830,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -909,7 +909,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -978,7 +978,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -1048,7 +1048,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -1108,7 +1108,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -1177,7 +1177,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -1249,7 +1249,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -1342,7 +1342,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -1425,7 +1425,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -1517,7 +1517,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -1599,7 +1599,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -1682,7 +1682,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -1755,7 +1755,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -1837,7 +1837,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -1896,7 +1896,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -1976,7 +1976,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -2046,7 +2046,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -2125,7 +2125,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -2194,7 +2194,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -2264,7 +2264,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -2324,7 +2324,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -2393,7 +2393,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -2455,7 +2455,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -2538,7 +2538,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -2611,7 +2611,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -2693,7 +2693,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -2765,7 +2765,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -2838,7 +2838,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -2901,7 +2901,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -2973,7 +2973,7 @@ OK: All bitmaps removed
 expecting 0 dirty sectors; have 0. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -3022,7 +3022,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -3092,7 +3092,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -3152,7 +3152,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -3221,7 +3221,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -3280,7 +3280,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -3340,7 +3340,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -3390,7 +3390,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -3449,7 +3449,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -3511,7 +3511,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -3594,7 +3594,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -3667,7 +3667,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -3749,7 +3749,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -3821,7 +3821,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -3894,7 +3894,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -3957,7 +3957,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -4029,7 +4029,7 @@ OK: All bitmaps removed
 expecting 6 dirty sectors; have 6. OK!

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -4078,7 +4078,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -4148,7 +4148,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -4208,7 +4208,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -4277,7 +4277,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 -- Write #2:
 {"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
@@ -4336,7 +4336,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -4396,7 +4396,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -4446,7 +4446,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
@@ -4505,7 +4505,7 @@ OK: All bitmaps removed
 {"return": {}}

 -- Test block-dirty-bitmap-populate (bitpop0):
-{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"execute": "x-block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
 {"return": {}}
-- 
2.27.0


