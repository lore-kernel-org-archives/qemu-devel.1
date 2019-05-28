Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0994FC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E582075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E582075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59275 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVXlU-0007Lc-3t
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 04:47:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVXjz-0006Wz-B2
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVXjx-00038O-VM
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:45:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:57172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hVXjx-00035t-OH; Tue, 28 May 2019 04:45:49 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hVXju-0001Ec-I5; Tue, 28 May 2019 11:45:46 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 28 May 2019 11:45:43 +0300
Message-Id: <20190528084544.183558-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190528084544.183558-1-vsementsov@virtuozzo.com>
References: <20190528084544.183558-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/2] util/iov: introduce
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
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce new initialization API, to create requests with padding. Will
be used in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/iov.h |  5 +++
 util/iov.c         | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 48b45987b7..1c5be66102 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -199,6 +199,11 @@ static inline void *qemu_iovec_buf(QEMUIOVector *qiov)
 
 void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
 void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int niov);
+void qemu_iovec_init_extended(
+        QEMUIOVector *qiov,
+        void *left, size_t left_len,
+        QEMUIOVector *middle, size_t middle_offset, size_t middle_len,
+        void *right, size_t right_len);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
 void qemu_iovec_concat(QEMUIOVector *dst,
                        QEMUIOVector *src, size_t soffset, size_t sbytes);
diff --git a/util/iov.c b/util/iov.c
index 74e6ca8ed7..6bfd609998 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -353,6 +353,95 @@ void qemu_iovec_concat(QEMUIOVector *dst,
     qemu_iovec_concat_iov(dst, src->iov, src->niov, soffset, sbytes);
 }
 
+/*
+ * qiov_find_iov
+ *
+ * Return iov, where byte at @offset (in @qiov) is.
+ * Update @offset to be offset inside that iov to the smae byte.
+ */
+static struct iovec *qiov_find_iov(QEMUIOVector *qiov, size_t *offset)
+{
+    struct iovec *iov = qiov->iov;
+
+    assert(*offset < qiov->size);
+
+    while (*offset >= iov->iov_len) {
+        *offset -= iov->iov_len;
+        iov++;
+    }
+
+    return iov;
+}
+
+/*
+ * qiov_slice
+ *
+ * Fund subarray of iovec's, containing requested range. @head would
+ * be offset in first iov (retruned by the function), @tail would be
+ * count of extra bytes in last iov (returned iov + @niov - 1).
+ */
+static struct iovec *qiov_slice(QEMUIOVector *qiov,
+                                size_t offset, size_t len,
+                                size_t *head, size_t *tail, int *niov)
+{
+    struct iovec *iov = qiov_find_iov(qiov, &offset), *end_iov;
+    size_t end_offset;
+
+    assert(offset + len <= qiov->size);
+
+    end_offset = iov->iov_len;
+    end_iov = iov + 1;
+
+    while (end_offset - offset < len) {
+        end_offset += end_iov->iov_len;
+        end_iov++;
+    }
+
+    *niov = end_iov - iov;
+    *head = offset;
+    *tail = (end_offset - offset) - len;
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
+    int niov;
+    struct iovec *p, *mid_iov = qiov_slice(mid_qiov, mid_offset, mid_len,
+                                           &mid_head, &mid_tail, &niov);
+
+    assert(niov);
+    qiov->niov = qiov->nalloc = niov + !!head_len + !!tail_len;
+    qiov->size = head_len + mid_len + tail_len;
+
+    p = qiov->iov = g_new(struct iovec, qiov->niov);
+    if (head_len) {
+        p->iov_base = head_buf;
+        p->iov_len = head_len;
+        p++;
+    }
+
+    memcpy(p, mid_iov, niov * sizeof(*p));
+    p[0].iov_base = (uint8_t *)p[0].iov_base + mid_head;
+    p[0].iov_len -= mid_head;
+    p[niov - 1].iov_len -= mid_tail;
+    p += niov;
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
-- 
2.18.0


