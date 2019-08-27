Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C925AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A182D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A182D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hwK-0007rn-81
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2htz-0005vc-3f
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2htx-0000gd-5h
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2htt-0000fB-8p; Tue, 27 Aug 2019 16:17:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A56418B3D84;
 Tue, 27 Aug 2019 20:17:08 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC38860CC0;
 Tue, 27 Aug 2019 20:16:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:29 +0100
Message-Id: <20190827201639.30368-3-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 27 Aug 2019 20:17:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/12] util/iov: improve qemu_iovec_is_zero
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

We'll need to check a part of qiov soon, so implement it now.

Optimization with align down to 4 * sizeof(long) is dropped due to:
1. It is strange: it aligns length of the buffer, but where is a
   guarantee that buffer pointer is aligned itself?
2. buffer_is_zero() is a better place for optimizations and it has
   them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-3-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-3-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/iov.h |  2 +-
 block/io.c         |  2 +-
 util/iov.c         | 31 +++++++++++++++++++------------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index f3787a0cf7..29957c8a72 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -212,7 +212,7 @@ void qemu_iovec_concat(QEMUIOVector *dst,
 size_t qemu_iovec_concat_iov(QEMUIOVector *dst,
                              struct iovec *src_iov, unsigned int src_cnt=
,
                              size_t soffset, size_t sbytes);
-bool qemu_iovec_is_zero(QEMUIOVector *qiov);
+bool qemu_iovec_is_zero(QEMUIOVector *qiov, size_t qiov_offeset, size_t =
bytes);
 void qemu_iovec_destroy(QEMUIOVector *qiov);
 void qemu_iovec_reset(QEMUIOVector *qiov);
 size_t qemu_iovec_to_buf(QEMUIOVector *qiov, size_t offset,
diff --git a/block/io.c b/block/io.c
index 56bbf195bb..f656fb2dce 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1722,7 +1722,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvCh=
ild *child,
=20
     if (!ret && bs->detect_zeroes !=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_OF=
F &&
         !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
-        qemu_iovec_is_zero(qiov)) {
+        qemu_iovec_is_zero(qiov, 0, qiov->size)) {
         flags |=3D BDRV_REQ_ZERO_WRITE;
         if (bs->detect_zeroes =3D=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMA=
P) {
             flags |=3D BDRV_REQ_MAY_UNMAP;
diff --git a/util/iov.c b/util/iov.c
index 366ff9cdd1..9ac0261853 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -451,23 +451,30 @@ void qemu_iovec_init_extended(
 }
=20
 /*
- * Check if the contents of the iovecs are all zero
+ * Check if the contents of subrange of qiov data is all zeroes.
  */
-bool qemu_iovec_is_zero(QEMUIOVector *qiov)
+bool qemu_iovec_is_zero(QEMUIOVector *qiov, size_t offset, size_t bytes)
 {
-    int i;
-    for (i =3D 0; i < qiov->niov; i++) {
-        size_t offs =3D QEMU_ALIGN_DOWN(qiov->iov[i].iov_len, 4 * sizeof=
(long));
-        uint8_t *ptr =3D qiov->iov[i].iov_base;
-        if (offs && !buffer_is_zero(qiov->iov[i].iov_base, offs)) {
+    struct iovec *iov;
+    size_t current_offset;
+
+    assert(offset + bytes <=3D qiov->size);
+
+    iov =3D iov_skip_offset(qiov->iov, offset, &current_offset);
+
+    while (bytes) {
+        uint8_t *base =3D (uint8_t *)iov->iov_base + current_offset;
+        size_t len =3D MIN(iov->iov_len - current_offset, bytes);
+
+        if (!buffer_is_zero(base, len)) {
             return false;
         }
-        for (; offs < qiov->iov[i].iov_len; offs++) {
-            if (ptr[offs]) {
-                return false;
-            }
-        }
+
+        current_offset =3D 0;
+        bytes -=3D len;
+        iov++;
     }
+
     return true;
 }
=20
--=20
2.21.0


