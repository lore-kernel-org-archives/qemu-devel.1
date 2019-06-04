Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F2FC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431EA23CBC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431EA23CBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYC8t-0002os-FM
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:18:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6H-00018d-R8
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6B-0005hJ-Bg
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:41660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC6A-0005C1-O6; Tue, 04 Jun 2019 12:15:43 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5j-0005Pq-8I; Tue, 04 Jun 2019 19:15:15 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  4 Jun 2019 19:15:03 +0300
Message-Id: <20190604161514.262241-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 01/12] util/iov: introduce
 qemu_iovec_init_extended
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
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce new initialization API, to create requests with padding. Will
be used in the following patch. New API uses qemu_iovec_init_buf if
resulting io vector has only one element, to avoid extra allocations.
So, we need to update qemu_iovec_destroy to support destroying such
QIOVs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/iov.h |   7 +++
 util/iov.c         | 112 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 48b45987b7..f3787a0cf7 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -199,6 +199,13 @@ static inline void *qemu_iovec_buf(QEMUIOVector *qiov)
 
 void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
 void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int niov);
+void qemu_iovec_init_extended(
+        QEMUIOVector *qiov,
+        void *head_buf, size_t head_len,
+        QEMUIOVector *mid_qiov, size_t mid_offset, size_t mid_len,
+        void *tail_buf, size_t tail_len);
+void qemu_iovec_init_slice(QEMUIOVector *qiov, QEMUIOVector *source,
+                           size_t offset, size_t len);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
 void qemu_iovec_concat(QEMUIOVector *dst,
                        QEMUIOVector *src, size_t soffset, size_t sbytes);
diff --git a/util/iov.c b/util/iov.c
index 74e6ca8ed7..39b6e31494 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -353,6 +353,103 @@ void qemu_iovec_concat(QEMUIOVector *dst,
     qemu_iovec_concat_iov(dst, src->iov, src->niov, soffset, sbytes);
 }
 
+/*
+ * qiov_find_iov
+ *
+ * Return pointer to iovec structure, where byte at @offset in original vector
+ * @iov exactly is.
+ * Set @remaining_offset to be offset inside that iovec to the same byte.
+ */
+static struct iovec *iov_skip_offset(struct iovec *iov, size_t offset,
+                                     size_t *remaining_offset)
+{
+    while (offset > 0 && offset >= iov->iov_len) {
+        offset -= iov->iov_len;
+        iov++;
+    }
+    *remaining_offset = offset;
+
+    return iov;
+}
+
+/*
+ * qiov_slice
+ *
+ * Find subarray of iovec's, containing requested range. @head would
+ * be offset in first iov (returned by the function), @tail would be
+ * count of extra bytes in last iovec (returned iov + @niov - 1).
+ */
+static struct iovec *qiov_slice(QEMUIOVector *qiov,
+                                size_t offset, size_t len,
+                                size_t *head, size_t *tail, int *niov)
+{
+    struct iovec *iov, *end_iov;
+
+    assert(offset + len <= qiov->size);
+
+    iov = iov_skip_offset(qiov->iov, offset, head);
+    end_iov = iov_skip_offset(iov, *head + len, tail);
+
+    if (*tail > 0) {
+        assert(*tail < end_iov->iov_len);
+        *tail = end_iov->iov_len - *tail;
+        end_iov++;
+    }
+
+    *niov = end_iov - iov;
+
+    return iov;
+}
+
+/*
+ * Compile new iovec, combining @head_buf buffer, sub-qiov of @mid_qiov,
+ * and @tail_buf buffer into new qiov.
+ */
+void qemu_iovec_init_extended(
+        QEMUIOVector *qiov,
+        void *head_buf, size_t head_len,
+        QEMUIOVector *mid_qiov, size_t mid_offset, size_t mid_len,
+        void *tail_buf, size_t tail_len)
+{
+    size_t mid_head, mid_tail;
+    int total_niov, mid_niov;
+    struct iovec *p, *mid_iov;
+
+    if (mid_len) {
+        mid_iov = qiov_slice(mid_qiov, mid_offset, mid_len,
+                             &mid_head, &mid_tail, &mid_niov);
+    }
+
+    total_niov = !!head_len + mid_niov + !!tail_len;
+    if (total_niov == 1) {
+        qemu_iovec_init_buf(qiov, NULL, 0);
+        p = &qiov->local_iov;
+    } else {
+        qiov->niov = qiov->nalloc = total_niov;
+        qiov->size = head_len + mid_len + tail_len;
+        p = qiov->iov = g_new(struct iovec, qiov->niov);
+    }
+
+    if (head_len) {
+        p->iov_base = head_buf;
+        p->iov_len = head_len;
+        p++;
+    }
+
+    if (mid_len) {
+        memcpy(p, mid_iov, mid_niov * sizeof(*p));
+        p[0].iov_base = (uint8_t *)p[0].iov_base + mid_head;
+        p[0].iov_len -= mid_head;
+        p[mid_niov - 1].iov_len -= mid_tail;
+        p += mid_niov;
+    }
+
+    if (tail_len) {
+        p->iov_base = tail_buf;
+        p->iov_len = tail_len;
+    }
+}
+
 /*
  * Check if the contents of the iovecs are all zero
  */
@@ -374,14 +471,19 @@ bool qemu_iovec_is_zero(QEMUIOVector *qiov)
     return true;
 }
 
+void qemu_iovec_init_slice(QEMUIOVector *qiov, QEMUIOVector *source,
+                           size_t offset, size_t len)
+{
+    qemu_iovec_init_extended(qiov, NULL, 0, source, offset, len, NULL, 0);
+}
+
 void qemu_iovec_destroy(QEMUIOVector *qiov)
 {
-    assert(qiov->nalloc != -1);
+    if (qiov->nalloc != -1) {
+        g_free(qiov->iov);
+    }
 
-    qemu_iovec_reset(qiov);
-    g_free(qiov->iov);
-    qiov->nalloc = 0;
-    qiov->iov = NULL;
+    memset(qiov, 0, sizeof(*qiov));
 }
 
 void qemu_iovec_reset(QEMUIOVector *qiov)
-- 
2.18.0


