Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F12DC04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DD320848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DD320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHZM-0005ZP-3a
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:41:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRHRt-00081V-GU
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRHRr-0004Jx-EU
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:33:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:39668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRHRm-0004DN-VK; Thu, 16 May 2019 10:33:27 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRHRl-0007Lk-CE; Thu, 16 May 2019 17:33:25 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Thu, 16 May 2019 17:33:07 +0300
Message-Id: <20190516143314.81302-3-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 2/9] qapi: add unmap to BlockDeviceStats
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
	den@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
	Anton Nefedov <anton.nefedov@virtuozzo.com>, pbonzini@redhat.com,
	jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json       | 29 +++++++++++++++++++++++------
 include/block/accounting.h |  1 +
 block/qapi.c               |  6 ++++++
 tests/qemu-iotests/227.out | 18 ++++++++++++++++++
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 754d07f1fb..55194f84ce 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -856,6 +856,8 @@
 #
 # @wr_bytes:      The number of bytes written by the device.
 #
+# @unmap_bytes: The number of bytes unmapped by the device (Since 4.1)
+#
 # @rd_operations: The number of read operations performed by the device.
 #
 # @wr_operations: The number of write operations performed by the device.
@@ -863,6 +865,9 @@
 # @flush_operations: The number of cache flush operations performed by the
 #                    device (since 0.15.0)
 #
+# @unmap_operations: The number of unmap operations performed by the device
+#                    (Since 4.1)
+#
 # @rd_total_time_ns: Total time spent on reads in nanoseconds (since 0.15.0).
 #
 # @wr_total_time_ns: Total time spent on writes in nanoseconds (since 0.15.0).
@@ -870,6 +875,9 @@
 # @flush_total_time_ns: Total time spent on cache flushes in nanoseconds
 #                       (since 0.15.0).
 #
+# @unmap_total_time_ns: Total time spent on unmap operations in nanoseconds
+#                       (Since 4.1)
+#
 # @wr_highest_offset: The offset after the greatest byte written to the
 #                     device.  The intended use of this information is for
 #                     growable sparse files (like qcow2) that are used on top
@@ -881,6 +889,9 @@
 # @wr_merged: Number of write requests that have been merged into another
 #             request (Since 2.3).
 #
+# @unmap_merged: Number of unmap requests that have been merged into another
+#                request (Since 4.1)
+#
 # @idle_time_ns: Time since the last I/O operation, in
 #                nanoseconds. If the field is absent it means that
 #                there haven't been any operations yet (Since 2.5).
@@ -894,6 +905,9 @@
 # @failed_flush_operations: The number of failed flush operations
 #                           performed by the device (Since 2.5)
 #
+# @failed_unmap_operations: The number of failed unmap operations performed
+#                           by the device (Since 4.1)
+#
 # @invalid_rd_operations: The number of invalid read operations
 #                          performed by the device (Since 2.5)
 #
@@ -903,6 +917,9 @@
 # @invalid_flush_operations: The number of invalid flush operations
 #                            performed by the device (Since 2.5)
 #
+# @invalid_unmap_operations: The number of invalid unmap operations performed
+#                            by the device (Since 4.1)
+#
 # @account_invalid: Whether invalid operations are included in the
 #                   last access statistics (Since 2.5)
 #
@@ -921,18 +938,18 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
-  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
+  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'unmap_bytes' : 'int',
            'rd_operations': 'int', 'wr_operations': 'int',
-           'flush_operations': 'int',
+           'flush_operations': 'int', 'unmap_operations': 'int',
            'rd_total_time_ns': 'int', 'wr_total_time_ns': 'int',
-           'flush_total_time_ns': 'int',
+           'flush_total_time_ns': 'int', 'unmap_total_time_ns': 'int',
            'wr_highest_offset': 'int',
-           'rd_merged': 'int', 'wr_merged': 'int',
+           'rd_merged': 'int', 'wr_merged': 'int', 'unmap_merged': 'int',
            '*idle_time_ns': 'int',
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
-           'failed_flush_operations': 'int',
+           'failed_flush_operations': 'int', 'failed_unmap_operations': 'int',
            'invalid_rd_operations': 'int', 'invalid_wr_operations': 'int',
-           'invalid_flush_operations': 'int',
+           'invalid_flush_operations': 'int', 'invalid_unmap_operations': 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'],
            '*rd_latency_histogram': 'BlockLatencyHistogramInfo',
diff --git a/include/block/accounting.h b/include/block/accounting.h
index d1f67b10dd..ba8b04d572 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -36,6 +36,7 @@ enum BlockAcctType {
     BLOCK_ACCT_READ,
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
+    BLOCK_ACCT_UNMAP,
     BLOCK_MAX_IOTYPE,
 };
 
diff --git a/block/qapi.c b/block/qapi.c
index 0c13c86f4e..f9447a3297 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -434,24 +434,30 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 
     ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
     ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
+    ds->unmap_bytes = stats->nr_bytes[BLOCK_ACCT_UNMAP];
     ds->rd_operations = stats->nr_ops[BLOCK_ACCT_READ];
     ds->wr_operations = stats->nr_ops[BLOCK_ACCT_WRITE];
+    ds->unmap_operations = stats->nr_ops[BLOCK_ACCT_UNMAP];
 
     ds->failed_rd_operations = stats->failed_ops[BLOCK_ACCT_READ];
     ds->failed_wr_operations = stats->failed_ops[BLOCK_ACCT_WRITE];
     ds->failed_flush_operations = stats->failed_ops[BLOCK_ACCT_FLUSH];
+    ds->failed_unmap_operations = stats->failed_ops[BLOCK_ACCT_UNMAP];
 
     ds->invalid_rd_operations = stats->invalid_ops[BLOCK_ACCT_READ];
     ds->invalid_wr_operations = stats->invalid_ops[BLOCK_ACCT_WRITE];
     ds->invalid_flush_operations =
         stats->invalid_ops[BLOCK_ACCT_FLUSH];
+    ds->invalid_unmap_operations = stats->invalid_ops[BLOCK_ACCT_UNMAP];
 
     ds->rd_merged = stats->merged[BLOCK_ACCT_READ];
     ds->wr_merged = stats->merged[BLOCK_ACCT_WRITE];
+    ds->unmap_merged = stats->merged[BLOCK_ACCT_UNMAP];
     ds->flush_operations = stats->nr_ops[BLOCK_ACCT_FLUSH];
     ds->wr_total_time_ns = stats->total_time_ns[BLOCK_ACCT_WRITE];
     ds->rd_total_time_ns = stats->total_time_ns[BLOCK_ACCT_READ];
     ds->flush_total_time_ns = stats->total_time_ns[BLOCK_ACCT_FLUSH];
+    ds->unmap_total_time_ns = stats->total_time_ns[BLOCK_ACCT_UNMAP];
 
     ds->has_idle_time_ns = stats->last_access_time_ns > 0;
     if (ds->has_idle_time_ns) {
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index e77efaf4cf..e9ab4d21f9 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -15,6 +15,8 @@ Testing: -drive driver=null-co,if=virtio
         {
             "device": "virtio0",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -24,13 +26,17 @@ Testing: -drive driver=null-co,if=virtio
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": true,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": true,
                 "rd_operations": 0,
@@ -74,6 +80,8 @@ Testing: -drive driver=null-co,if=none
         {
             "device": "none0",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -83,13 +91,17 @@ Testing: -drive driver=null-co,if=none
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": true,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": true,
                 "rd_operations": 0,
@@ -163,6 +175,8 @@ Testing: -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,i
         {
             "device": "",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -172,13 +186,17 @@ Testing: -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,i
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": false,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": false,
                 "rd_operations": 0,
-- 
2.17.1


