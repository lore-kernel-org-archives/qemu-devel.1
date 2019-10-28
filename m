Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D20FCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9F0214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQKtHJ1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9F0214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4B4-0005hT-Sq
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vl-0001LM-Te
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vj-0001In-Sx
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60480
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vj-0001IR-P5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5OQWPv79KD3SNwPjN2Ee0ud2g7tdqc31S9r0UcfX68=;
 b=KQKtHJ1eDWmG7YMsXZDlssPsRDJsAJqgtbQWFvbcfEp3XVoJT8D/nLMoCEqDANgMzqozUG
 qgQD5Jkzl0gbnP4RRoL4h0v6hIDZ0WP5p67HT3k97QZgbW+UaleBBwmIwXjg/Zj2Sv7YHw
 G/ZeX7od6gd0LEvROidKMLsDi20LKks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-QEBbO9jgPAysu4tq7Yks2g-1; Mon, 28 Oct 2019 08:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9344581A334;
 Mon, 28 Oct 2019 12:15:22 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3892F60BF7;
 Mon, 28 Oct 2019 12:15:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/69] block/mirror: simplify do_sync_target_write
Date: Mon, 28 Oct 2019 13:14:01 +0100
Message-Id: <20191028121501.15279-10-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QEBbO9jgPAysu4tq7Yks2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

do_sync_target_write is called from bdrv_mirror_top_do_write after
write/discard operation, all inside active_write/active_write_settle
protecting us from mirror iteration. So the whole area is dirty for
sure, no reason to examine dirty bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191011090711.19940-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 95 +++++++++++++++-----------------------------------
 1 file changed, 28 insertions(+), 67 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index a6c50caea4..351faf9367 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1181,84 +1181,45 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMet=
hod method,
                      uint64_t offset, uint64_t bytes,
                      QEMUIOVector *qiov, int flags)
 {
-    QEMUIOVector target_qiov;
-    uint64_t dirty_offset =3D offset;
-    uint64_t dirty_bytes;
-
-    if (qiov) {
-        qemu_iovec_init(&target_qiov, qiov->niov);
-    }
-
-    while (true) {
-        bool valid_area;
-        int ret;
-
-        bdrv_dirty_bitmap_lock(job->dirty_bitmap);
-        dirty_bytes =3D MIN(offset + bytes - dirty_offset, INT_MAX);
-        valid_area =3D bdrv_dirty_bitmap_next_dirty_area(job->dirty_bitmap=
,
-                                                       &dirty_offset,
-                                                       &dirty_bytes);
-        if (!valid_area) {
-            bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
-            break;
-        }
+    int ret;
=20
-        bdrv_reset_dirty_bitmap_locked(job->dirty_bitmap,
-                                       dirty_offset, dirty_bytes);
-        bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
+    bdrv_reset_dirty_bitmap(job->dirty_bitmap, offset, bytes);
=20
-        job_progress_increase_remaining(&job->common.job, dirty_bytes);
+    job_progress_increase_remaining(&job->common.job, bytes);
=20
-        assert(dirty_offset - offset <=3D SIZE_MAX);
-        if (qiov) {
-            qemu_iovec_reset(&target_qiov);
-            qemu_iovec_concat(&target_qiov, qiov,
-                              dirty_offset - offset, dirty_bytes);
-        }
-
-        switch (method) {
-        case MIRROR_METHOD_COPY:
-            ret =3D blk_co_pwritev(job->target, dirty_offset, dirty_bytes,
-                                 qiov ? &target_qiov : NULL, flags);
-            break;
+    switch (method) {
+    case MIRROR_METHOD_COPY:
+        ret =3D blk_co_pwritev(job->target, offset, bytes, qiov, flags);
+        break;
=20
-        case MIRROR_METHOD_ZERO:
-            assert(!qiov);
-            ret =3D blk_co_pwrite_zeroes(job->target, dirty_offset, dirty_=
bytes,
-                                       flags);
-            break;
+    case MIRROR_METHOD_ZERO:
+        assert(!qiov);
+        ret =3D blk_co_pwrite_zeroes(job->target, offset, bytes, flags);
+        break;
=20
-        case MIRROR_METHOD_DISCARD:
-            assert(!qiov);
-            ret =3D blk_co_pdiscard(job->target, dirty_offset, dirty_bytes=
);
-            break;
+    case MIRROR_METHOD_DISCARD:
+        assert(!qiov);
+        ret =3D blk_co_pdiscard(job->target, offset, bytes);
+        break;
=20
-        default:
-            abort();
-        }
+    default:
+        abort();
+    }
=20
-        if (ret >=3D 0) {
-            job_progress_update(&job->common.job, dirty_bytes);
-        } else {
-            BlockErrorAction action;
+    if (ret >=3D 0) {
+        job_progress_update(&job->common.job, bytes);
+    } else {
+        BlockErrorAction action;
=20
-            bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_offset, dirty_b=
ytes);
-            job->actively_synced =3D false;
+        bdrv_set_dirty_bitmap(job->dirty_bitmap, offset, bytes);
+        job->actively_synced =3D false;
=20
-            action =3D mirror_error_action(job, false, -ret);
-            if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
-                if (!job->ret) {
-                    job->ret =3D ret;
-                }
-                break;
+        action =3D mirror_error_action(job, false, -ret);
+        if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
+            if (!job->ret) {
+                job->ret =3D ret;
             }
         }
-
-        dirty_offset +=3D dirty_bytes;
-    }
-
-    if (qiov) {
-        qemu_iovec_destroy(&target_qiov);
     }
 }
=20
--=20
2.21.0


