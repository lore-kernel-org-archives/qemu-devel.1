Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A2C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C732C20706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMqFoiJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C732C20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxtp-0003tY-LO
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRxrG-0006hs-2v
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRxrF-000341-GT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:55:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRxrF-0002zn-16
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587732904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0B7Nxa6nlBy8HqwtOQLslKDHwSwpITaUN4fuyEJ04KU=;
 b=gMqFoiJw3sZtlsgiktNPrCva0i7gb4dGuM7gOkpHAeo918krmOvrMKUY1U/ne+btiL6BjB
 m99iSIY2CG99Hd+XGS+rg6n0tow5yGaoDgSS5h+RPjhxZMGhHj4FznRQDYnRMxSa3mh8Wg
 VY7jUYT8+LcfMH7auYI4N3ou8BIUcCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-7ON1PipZMl2ZjuOyhYjv-g-1; Fri, 24 Apr 2020 08:55:02 -0400
X-MC-Unique: 7ON1PipZMl2ZjuOyhYjv-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D55145F;
 Fri, 24 Apr 2020 12:55:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-114.ams2.redhat.com
 [10.36.114.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCC8D6084A;
 Fri, 24 Apr 2020 12:54:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Fri, 24 Apr 2020 14:54:42 +0200
Message-Id: <20200424125448.63318-5-kwolf@redhat.com>
In-Reply-To: <20200424125448.63318-1-kwolf@redhat.com>
References: <20200424125448.63318-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
qcow2_cluster_zeroize() with flags=3D0 does the right thing: It doesn't
undo any previous preallocation, but just adds the zero flag to all
relevant L2 entries. If an external data file is in use, a write_zeroes
request to the data file is made instead.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c |  2 +-
 block/qcow2.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 17f1363279..4b5fc8c4a7 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1795,7 +1795,7 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint6=
4_t offset,
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
-           end_offset =3D=3D bs->total_sectors << BDRV_SECTOR_BITS);
+           end_offset >=3D bs->total_sectors << BDRV_SECTOR_BITS);
=20
     /* The zero flag is only supported by version 3 and newer */
     if (s->qcow_version < 3) {
diff --git a/block/qcow2.c b/block/qcow2.c
index 9cfbdfc939..98065d7808 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1726,6 +1726,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverStat=
e *bs, QDict *options,
=20
     bs->supported_zero_flags =3D header.version >=3D 3 ?
                                BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK :=
 0;
+    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
=20
     /* Repair image if dirty */
     if (!(flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) && !bs->read_only &&
@@ -4214,6 +4215,39 @@ static int coroutine_fn qcow2_co_truncate(BlockDrive=
rState *bs, int64_t offset,
         g_assert_not_reached();
     }
=20
+    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
+        uint64_t zero_start =3D QEMU_ALIGN_UP(old_length, s->cluster_size)=
;
+
+        /*
+         * Use zero clusters as much as we can. qcow2_cluster_zeroize()
+         * requires a cluster-aligned start. The end may be unaligned if i=
t is
+         * at the end of the image (which it is here).
+         */
+        ret =3D qcow2_cluster_zeroize(bs, zero_start, offset - zero_start,=
 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to zero out new clusters"=
);
+            goto fail;
+        }
+
+        /* Write explicit zeros for the unaligned head */
+        if (zero_start > old_length) {
+            uint64_t len =3D zero_start - old_length;
+            uint8_t *buf =3D qemu_blockalign0(bs, len);
+            QEMUIOVector qiov;
+            qemu_iovec_init_buf(&qiov, buf, len);
+
+            qemu_co_mutex_unlock(&s->lock);
+            ret =3D qcow2_co_pwritev_part(bs, old_length, len, &qiov, 0, 0=
);
+            qemu_co_mutex_lock(&s->lock);
+
+            qemu_vfree(buf);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to zero out the new a=
rea");
+                goto fail;
+            }
+        }
+    }
+
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         /* Flush metadata before actually changing the image size */
         ret =3D qcow2_write_caches(bs);
--=20
2.25.3


