Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9C3C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150E92080C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150E92080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Hnq-0000Iq-FY
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 12:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2HcT-0000S3-7P
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2HcR-0000rI-HX
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:13:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:44768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2HcN-0000ly-PN; Mon, 26 Aug 2019 12:13:19 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2HcH-0006QJ-RC; Mon, 26 Aug 2019 19:13:13 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 26 Aug 2019 19:13:01 +0300
Message-Id: <20190826161312.489398-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190826161312.489398-1-vsementsov@virtuozzo.com>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9 02/13] block/backup: split shareable copying
 part from backup_do_cow
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split copying logic which will be shared with backup-top filter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 33b144305f..13a1d80157 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -248,26 +248,18 @@ static int64_t backup_bitmap_reset_unallocated(BackupBlockJob *s,
     return ret;
 }
 
-static int coroutine_fn backup_do_cow(BackupBlockJob *job,
-                                      int64_t offset, uint64_t bytes,
-                                      bool *error_is_read,
-                                      bool is_write_notifier)
+static int coroutine_fn backup_do_copy(BackupBlockJob *job,
+                                       int64_t offset, uint64_t bytes,
+                                       bool *error_is_read,
+                                       bool is_write_notifier)
 {
-    CowRequest cow_request;
     int ret = 0;
-    int64_t start, end; /* bytes */
+    int64_t start = offset, end = bytes + offset; /* bytes */
     void *bounce_buffer = NULL;
     int64_t status_bytes;
 
-    qemu_co_rwlock_rdlock(&job->flush_rwlock);
-
-    start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
-    end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
-
-    trace_backup_do_cow_enter(job, start, offset, bytes);
-
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
+    assert(QEMU_IS_ALIGNED(end, job->cluster_size));
 
     while (start < end) {
         int64_t dirty_end;
@@ -326,6 +318,31 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         qemu_vfree(bounce_buffer);
     }
 
+    return ret;
+}
+
+static int coroutine_fn backup_do_cow(BackupBlockJob *job,
+                                      int64_t offset, uint64_t bytes,
+                                      bool *error_is_read,
+                                      bool is_write_notifier)
+{
+    CowRequest cow_request;
+    int ret = 0;
+    int64_t start, end; /* bytes */
+
+    qemu_co_rwlock_rdlock(&job->flush_rwlock);
+
+    start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
+    end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
+
+    trace_backup_do_cow_enter(job, start, offset, bytes);
+
+    wait_for_overlapping_requests(job, start, end);
+    cow_request_begin(&cow_request, job, start, end);
+
+    ret = backup_do_copy(job, start, end - start, error_is_read,
+                         is_write_notifier);
+
     cow_request_end(&cow_request);
 
     trace_backup_do_cow_return(job, offset, bytes, ret);
-- 
2.18.0


