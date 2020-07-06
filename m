Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF074C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9392075B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLNE9Jo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9392075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOD4-0004BG-NE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0Y-0004vy-5Q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0W-0004ND-7N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u004E6Ep2Z81gMtCqTLi6rp1iyBNdEC4/fTCVYChyRI=;
 b=FLNE9Jo9QquuZiVa5ODNtbu8J8tB16jG6fjP1zMAvRvsacHdrOzGO+kFglCtZ/qapjvc1B
 O2MX13ou6s1FU9910Om0h8uVX5A0dyp+fIjqefb89a6j9sjOo5kgzG9xkXxlSsmRqDcqiS
 C1cLktVA0z6VhwFxTx15np7Mj3tcsf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-W4Uz5gDRMlCgZ60pO16yyQ-1; Mon, 06 Jul 2020 06:05:49 -0400
X-MC-Unique: W4Uz5gDRMlCgZ60pO16yyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4778A800D5C;
 Mon,  6 Jul 2020 10:05:48 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAB6810013D9;
 Mon,  6 Jul 2020 10:05:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 31/31] qed: Simplify backing reads
Date: Mon,  6 Jul 2020 12:04:32 +0200
Message-Id: <20200706100432.2301919-32-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

The other four drivers that support backing files (qcow, qcow2,
parallels, vmdk) all rely on the block layer to populate zeroes when
reading beyond EOF of a short backing file.  We can simplify the qed
code by doing likewise.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200528094405.145708-11-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qed.h |  1 -
 block/qed.c | 64 +++++------------------------------------------------
 2 files changed, 6 insertions(+), 59 deletions(-)

diff --git a/block/qed.h b/block/qed.h
index 42c115d822..3d12bf78d4 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -140,7 +140,6 @@ typedef struct QEDAIOCB {
 
     /* Current cluster scatter-gather list */
     QEMUIOVector cur_qiov;
-    QEMUIOVector *backing_qiov;
     uint64_t cur_pos;               /* position on block device, in bytes */
     uint64_t cur_cluster;           /* cluster offset in image file */
     unsigned int cur_nclusters;     /* number of clusters being accessed */
diff --git a/block/qed.c b/block/qed.c
index a2dd952699..ece8b9bb60 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -849,56 +849,18 @@ static BDRVQEDState *acb_to_s(QEDAIOCB *acb)
  * @s:              QED state
  * @pos:            Byte position in device
  * @qiov:           Destination I/O vector
- * @backing_qiov:   Possibly shortened copy of qiov, to be allocated here
- * @cb:             Completion function
- * @opaque:         User data for completion function
  *
  * This function reads qiov->size bytes starting at pos from the backing file.
  * If there is no backing file then zeroes are read.
  */
 static int coroutine_fn qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
-                                              QEMUIOVector *qiov,
-                                              QEMUIOVector **backing_qiov)
+                                              QEMUIOVector *qiov)
 {
-    uint64_t backing_length = 0;
-    size_t size;
-    int ret;
-
-    /* If there is a backing file, get its length.  Treat the absence of a
-     * backing file like a zero length backing file.
-     */
     if (s->bs->backing) {
-        int64_t l = bdrv_getlength(s->bs->backing->bs);
-        if (l < 0) {
-            return l;
-        }
-        backing_length = l;
-    }
-
-    /* Zero all sectors if reading beyond the end of the backing file */
-    if (pos >= backing_length ||
-        pos + qiov->size > backing_length) {
-        qemu_iovec_memset(qiov, 0, 0, qiov->size);
-    }
-
-    /* Complete now if there are no backing file sectors to read */
-    if (pos >= backing_length) {
-        return 0;
-    }
-
-    /* If the read straddles the end of the backing file, shorten it */
-    size = MIN((uint64_t)backing_length - pos, qiov->size);
-
-    assert(*backing_qiov == NULL);
-    *backing_qiov = g_new(QEMUIOVector, 1);
-    qemu_iovec_init(*backing_qiov, qiov->niov);
-    qemu_iovec_concat(*backing_qiov, qiov, 0, size);
-
-    BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
-    ret = bdrv_co_preadv(s->bs->backing, pos, size, *backing_qiov, 0);
-    if (ret < 0) {
-        return ret;
+        BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
+        return bdrv_co_preadv(s->bs->backing, pos, qiov->size, qiov, 0);
     }
+    qemu_iovec_memset(qiov, 0, 0, qiov->size);
     return 0;
 }
 
@@ -915,7 +877,6 @@ static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
                                                    uint64_t offset)
 {
     QEMUIOVector qiov;
-    QEMUIOVector *backing_qiov = NULL;
     int ret;
 
     /* Skip copy entirely if there is no work to do */
@@ -925,13 +886,7 @@ static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
 
     qemu_iovec_init_buf(&qiov, qemu_blockalign(s->bs, len), len);
 
-    ret = qed_read_backing_file(s, pos, &qiov, &backing_qiov);
-
-    if (backing_qiov) {
-        qemu_iovec_destroy(backing_qiov);
-        g_free(backing_qiov);
-        backing_qiov = NULL;
-    }
+    ret = qed_read_backing_file(s, pos, &qiov);
 
     if (ret) {
         goto out;
@@ -1339,8 +1294,7 @@ static int coroutine_fn qed_aio_read_data(void *opaque, int ret,
         qemu_iovec_memset(&acb->cur_qiov, 0, 0, acb->cur_qiov.size);
         r = 0;
     } else if (ret != QED_CLUSTER_FOUND) {
-        r = qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
-                                  &acb->backing_qiov);
+        r = qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov);
     } else {
         BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
         r = bdrv_co_preadv(bs->file, offset, acb->cur_qiov.size,
@@ -1365,12 +1319,6 @@ static int coroutine_fn qed_aio_next_io(QEDAIOCB *acb)
     while (1) {
         trace_qed_aio_next_io(s, acb, 0, acb->cur_pos + acb->cur_qiov.size);
 
-        if (acb->backing_qiov) {
-            qemu_iovec_destroy(acb->backing_qiov);
-            g_free(acb->backing_qiov);
-            acb->backing_qiov = NULL;
-        }
-
         acb->qiov_offset += acb->cur_qiov.size;
         acb->cur_pos += acb->cur_qiov.size;
         qemu_iovec_reset(&acb->cur_qiov);
-- 
2.26.2


