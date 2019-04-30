Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586F5C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EF120651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EF120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVIB-0002i2-Bd
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:07:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuq-00081V-G2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-00024i-9x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuI-0001be-6X; Tue, 30 Apr 2019 11:42:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7500DA705;
	Tue, 30 Apr 2019 15:42:57 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9040F17121;
	Tue, 30 Apr 2019 15:42:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:20 +0200
Message-Id: <20190430154244.30083-4-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 30 Apr 2019 15:42:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/27] vpc: unlock Coroutine lock to make IO
 submit Concurrently
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
Message-ID: <20190430154220.s3nYd5WqK32GwiUtmXDqbLZaTP2Dv4Xg6r8hWEY7d8k@z>

From: Zhengui li <lizhengui@huawei.com>

Concurrent IO becomes serial IO because of the qemu Coroutine lock,
which reduce IO performance severely.

So unlock Coroutine lock before bdrv_co_pwritev and
bdrv_co_preadv to fix it.

Signed-off-by: Zhengui li <lizhengui@huawei.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/vpc.c b/block/vpc.c
index a902a4c54d..0c279b87c8 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -639,8 +639,10 @@ vpc_co_preadv(BlockDriverState *bs, uint64_t offset,=
 uint64_t bytes,
             qemu_iovec_reset(&local_qiov);
             qemu_iovec_concat(&local_qiov, qiov, bytes_done, n_bytes);
=20
+            qemu_co_mutex_unlock(&s->lock);
             ret =3D bdrv_co_preadv(bs->file, image_offset, n_bytes,
                                  &local_qiov, 0);
+            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
@@ -697,8 +699,10 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t offset=
, uint64_t bytes,
         qemu_iovec_reset(&local_qiov);
         qemu_iovec_concat(&local_qiov, qiov, bytes_done, n_bytes);
=20
+        qemu_co_mutex_unlock(&s->lock);
         ret =3D bdrv_co_pwritev(bs->file, image_offset, n_bytes,
                               &local_qiov, 0);
+        qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
             goto fail;
         }
--=20
2.20.1


