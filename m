Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0FBC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D586920679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D586920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hwH-0007jL-H8
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2htn-0005rM-E1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2htl-0000Zr-0Y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26767)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2htg-0000TV-I0; Tue, 27 Aug 2019 16:16:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D7C96468A;
 Tue, 27 Aug 2019 20:16:54 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03B9E60619;
 Tue, 27 Aug 2019 20:16:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:28 +0100
Message-Id: <20190827201639.30368-2-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 27 Aug 2019 20:16:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/12] util/iov: introduce
 qemu_iovec_init_extended
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Introduce new initialization API, to create requests with padding. Will
be used in the following patch. New API uses qemu_iovec_init_buf if
resulting io vector has only one element, to avoid extra allocations.
So, we need to update qemu_iovec_destroy to support destroying such
QIOVs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-2-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-2-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/iov.h |   7 +++
 util/iov.c         | 112 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 48b45987b7..f3787a0cf7 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -199,6 +199,13 @@ static inline void *qemu_iovec_buf(QEMUIOVector *qio=
v)
=20
 void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
 void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int=
 niov);
+void qemu_iovec_init_extended(
+        QEMUIOVector *qiov,
+        void *head_buf, size_t head_len,
+        QEMUIOVector *mid_qiov, size_t mid_offset, size_t mid_len,
+        void *tail_buf, size_t tail_len);
+void qemu_iovec_init_slice(QEMUIOVector *qiov, QEMUIOVector *source,
+                           size_t offset, size_t len);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
 void qemu_iovec_concat(QEMUIOVector *dst,
                        QEMUIOVector *src, size_t soffset, size_t sbytes)=
;
diff --git a/util/iov.c b/util/iov.c
index 74e6ca8ed7..366ff9cdd1 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -353,6 +353,103 @@ void qemu_iovec_concat(QEMUIOVector *dst,
     qemu_iovec_concat_iov(dst, src->iov, src->niov, soffset, sbytes);
 }
=20
+/*
+ * qiov_find_iov
+ *
+ * Return pointer to iovec structure, where byte at @offset in original =
vector
+ * @iov exactly is.
+ * Set @remaining_offset to be offset inside that iovec to the same byte=
.
+ */
+static struct iovec *iov_skip_offset(struct iovec *iov, size_t offset,
+                                     size_t *remaining_offset)
+{
+    while (offset > 0 && offset >=3D iov->iov_len) {
+        offset -=3D iov->iov_len;
+        iov++;
+    }
+    *remaining_offset =3D offset;
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
+    assert(offset + len <=3D qiov->size);
+
+    iov =3D iov_skip_offset(qiov->iov, offset, head);
+    end_iov =3D iov_skip_offset(iov, *head + len, tail);
+
+    if (*tail > 0) {
+        assert(*tail < end_iov->iov_len);
+        *tail =3D end_iov->iov_len - *tail;
+        end_iov++;
+    }
+
+    *niov =3D end_iov - iov;
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
+    int total_niov, mid_niov =3D 0;
+    struct iovec *p, *mid_iov;
+
+    if (mid_len) {
+        mid_iov =3D qiov_slice(mid_qiov, mid_offset, mid_len,
+                             &mid_head, &mid_tail, &mid_niov);
+    }
+
+    total_niov =3D !!head_len + mid_niov + !!tail_len;
+    if (total_niov =3D=3D 1) {
+        qemu_iovec_init_buf(qiov, NULL, 0);
+        p =3D &qiov->local_iov;
+    } else {
+        qiov->niov =3D qiov->nalloc =3D total_niov;
+        qiov->size =3D head_len + mid_len + tail_len;
+        p =3D qiov->iov =3D g_new(struct iovec, qiov->niov);
+    }
+
+    if (head_len) {
+        p->iov_base =3D head_buf;
+        p->iov_len =3D head_len;
+        p++;
+    }
+
+    if (mid_len) {
+        memcpy(p, mid_iov, mid_niov * sizeof(*p));
+        p[0].iov_base =3D (uint8_t *)p[0].iov_base + mid_head;
+        p[0].iov_len -=3D mid_head;
+        p[mid_niov - 1].iov_len -=3D mid_tail;
+        p +=3D mid_niov;
+    }
+
+    if (tail_len) {
+        p->iov_base =3D tail_buf;
+        p->iov_len =3D tail_len;
+    }
+}
+
 /*
  * Check if the contents of the iovecs are all zero
  */
@@ -374,14 +471,19 @@ bool qemu_iovec_is_zero(QEMUIOVector *qiov)
     return true;
 }
=20
+void qemu_iovec_init_slice(QEMUIOVector *qiov, QEMUIOVector *source,
+                           size_t offset, size_t len)
+{
+    qemu_iovec_init_extended(qiov, NULL, 0, source, offset, len, NULL, 0=
);
+}
+
 void qemu_iovec_destroy(QEMUIOVector *qiov)
 {
-    assert(qiov->nalloc !=3D -1);
+    if (qiov->nalloc !=3D -1) {
+        g_free(qiov->iov);
+    }
=20
-    qemu_iovec_reset(qiov);
-    g_free(qiov->iov);
-    qiov->nalloc =3D 0;
-    qiov->iov =3D NULL;
+    memset(qiov, 0, sizeof(*qiov));
 }
=20
 void qemu_iovec_reset(QEMUIOVector *qiov)
--=20
2.21.0


