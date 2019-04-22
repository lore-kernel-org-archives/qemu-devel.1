Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A6C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A7720656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A7720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIaUF-000515-44
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 11:04:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP7-0000oH-35
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00038c-Nc
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:55294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP4-00036M-DO; Mon, 22 Apr 2019 10:58:42 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP1-0003k3-Kw; Mon, 22 Apr 2019 17:58:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 22 Apr 2019 17:58:33 +0300
Message-Id: <20190422145838.70903-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 4/9] block/qed: use buffer-based io
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
	stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422145833.kAteeAuM-Gwv4n4wfhJ3A4uSIzj4N2HOfioakJt2iV8@z>

Move to _co_ versions of io functions qed_read_table() and
qed_write_table(), as we use qemu_co_mutex_unlock()
anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qed-table.c | 12 +++++-------
 block/qed.c       |  6 ++----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index c497bd4aec..cf30edd977 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -21,22 +21,22 @@
 /* Called with table_lock held.  */
 static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
 {
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(
-        qiov, table->offsets, s->header.cluster_size * s->header.table_size);
+    unsigned int bytes = s->header.cluster_size * s->header.table_size;
+
     int noffsets;
     int i, ret;
 
     trace_qed_read_table(s, offset, table);
 
     qemu_co_mutex_unlock(&s->table_lock);
-    ret = bdrv_preadv(s->bs->file, offset, &qiov);
+    ret = bdrv_co_pread(s->bs->file, offset, bytes, table->offsets, 0);
     qemu_co_mutex_lock(&s->table_lock);
     if (ret < 0) {
         goto out;
     }
 
     /* Byteswap offsets */
-    noffsets = qiov.size / sizeof(uint64_t);
+    noffsets = bytes / sizeof(uint64_t);
     for (i = 0; i < noffsets; i++) {
         table->offsets[i] = le64_to_cpu(table->offsets[i]);
     }
@@ -66,7 +66,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
     unsigned int sector_mask = BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1;
     unsigned int start, end, i;
     QEDTable *new_table;
-    QEMUIOVector qiov;
     size_t len_bytes;
     int ret;
 
@@ -79,7 +78,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
     len_bytes = (end - start) * sizeof(uint64_t);
 
     new_table = qemu_blockalign(s->bs, len_bytes);
-    qemu_iovec_init_buf(&qiov, new_table->offsets, len_bytes);
 
     /* Byteswap table */
     for (i = start; i < end; i++) {
@@ -91,7 +89,7 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
     offset += start * sizeof(uint64_t);
 
     qemu_co_mutex_unlock(&s->table_lock);
-    ret = bdrv_pwritev(s->bs->file, offset, &qiov);
+    ret = bdrv_co_pwrite(s->bs->file, offset, len_bytes, new_table->offsets, 0);
     qemu_co_mutex_lock(&s->table_lock);
     trace_qed_write_table_cb(s, table, flush, ret);
     if (ret < 0) {
diff --git a/block/qed.c b/block/qed.c
index 89af05d524..912edaf56a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -113,15 +113,13 @@ static int coroutine_fn qed_write_header(BDRVQEDState *s)
     int nsectors = DIV_ROUND_UP(sizeof(QEDHeader), BDRV_SECTOR_SIZE);
     size_t len = nsectors * BDRV_SECTOR_SIZE;
     uint8_t *buf;
-    QEMUIOVector qiov;
     int ret;
 
     assert(s->allocating_acb || s->allocating_write_reqs_plugged);
 
     buf = qemu_blockalign(s->bs, len);
-    qemu_iovec_init_buf(&qiov, buf, len);
 
-    ret = bdrv_co_preadv(s->bs->file, 0, qiov.size, &qiov, 0);
+    ret = bdrv_co_pread(s->bs->file, 0, len, buf, 0);
     if (ret < 0) {
         goto out;
     }
@@ -129,7 +127,7 @@ static int coroutine_fn qed_write_header(BDRVQEDState *s)
     /* Update header */
     qed_header_cpu_to_le(&s->header, (QEDHeader *) buf);
 
-    ret = bdrv_co_pwritev(s->bs->file, 0, qiov.size,  &qiov, 0);
+    ret = bdrv_co_pwrite(s->bs->file, 0, len,  buf, 0);
     if (ret < 0) {
         goto out;
     }
-- 
2.18.0


