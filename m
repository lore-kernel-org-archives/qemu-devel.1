Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24935C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC34120652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC34120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49049 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVB3-0004mn-5j
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:00:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUur-00083O-Vb
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUup-000269-9Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuk-0001y1-6D; Tue, 30 Apr 2019 11:43:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44B0B99CFE;
	Tue, 30 Apr 2019 15:43:25 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE4974C7;
	Tue, 30 Apr 2019 15:43:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:33 +0200
Message-Id: <20190430154244.30083-17-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 30 Apr 2019 15:43:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/27] block: introduce byte-based io helpers
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430154233.LxXD-0JUzvVtHOwh4fT9rhFZvVXjLlxmgBP_3nQSE4c@z>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h      | 16 ++++++++++++++++
 include/sysemu/block-backend.h | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 01e855a066..94d45c9708 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -925,6 +925,22 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
=20
+static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
+    int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flag=
s)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    return bdrv_co_preadv(child, offset, bytes, &qiov, flags);
+}
+
+static inline int coroutine_fn bdrv_co_pwrite(BdrvChild *child,
+    int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flag=
s)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    return bdrv_co_pwritev(child, offset, bytes, &qiov, flags);
+}
+
 extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pa=
rent);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_=
parent);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 3be05c2d68..5be6224226 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -124,6 +124,25 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, in=
t64_t offset,
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
+
+static inline int coroutine_fn blk_co_pread(BlockBackend *blk, int64_t o=
ffset,
+                                            unsigned int bytes, void *bu=
f,
+                                            BdrvRequestFlags flags)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    return blk_co_preadv(blk, offset, bytes, &qiov, flags);
+}
+
+static inline int coroutine_fn blk_co_pwrite(BlockBackend *blk, int64_t =
offset,
+                                             unsigned int bytes, void *b=
uf,
+                                             BdrvRequestFlags flags)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    return blk_co_pwritev(blk, offset, bytes, &qiov, flags);
+}
+
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                       int bytes, BdrvRequestFlags flags);
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
--=20
2.20.1


