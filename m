Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BF7CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4048C208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mq42u4Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4048C208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4GW-00082Y-9X
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vq-0001S5-1j
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vo-0001Ki-1j
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vn-0001KP-Th
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNVjvSYdT3Fxsm1A4G+GPPJYwmuAaRyR339cHbHqnos=;
 b=Mq42u4ArnlQlKPNxZu1fz33nXnwdJU2on/BFCFil5TI/dfMg65Kk5qSSbENEt+RkZHUipr
 WFLdgOA4uZSU+ZVJFNvKByNPH73VtBJO4zDHalL60j4ylAAfofDHI5YsUgGzIFn5a5EMl2
 Cprvpi/zFPqfeCPJli7hoOj9r/I3N0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-p5BY4Aw5PHeQQisYTnykhA-1; Mon, 28 Oct 2019 08:15:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 979F8180496E;
 Mon, 28 Oct 2019 12:15:26 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E7D4600C7;
 Mon, 28 Oct 2019 12:15:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/69] block/mirror: support unaligned write in active mirror
Date: Mon, 28 Oct 2019 13:14:03 +0100
Message-Id: <20191028121501.15279-12-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: p5BY4Aw5PHeQQisYTnykhA-1
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

Prior 9adc1cb49af8d do_sync_target_write had a bug: it reset aligned-up
region in the dirty bitmap, which means that we may not copy some bytes
and assume them copied, which actually leads to producing corrupted
target.

So 9adc1cb49af8d forced dirty bitmap granularity to be
request_alignment for mirror-top filter, so we are not working with
unaligned requests. However forcing large alignment obviously decreases
performance of unaligned requests.

This commit provides another solution for the problem: if unaligned
padding is already dirty, we can safely ignore it, as
1. It's dirty, it will be copied by mirror_iteration anyway
2. It's dirty, so skipping it now we don't increase dirtiness of the
   bitmap and therefore don't damage "synchronicity" of the
   write-blocking mirror.

If unaligned padding is not dirty, we just write it, no reason to touch
dirty bitmap if we succeed (on failure we'll set the whole region
ofcourse, but we loss "synchronicity" on failure anyway).

Note: we need to disable dirty_bitmap, otherwise we will not be able to
see in do_sync_target_write bitmap state before current operation. We
may of course check dirty bitmap before the operation in
bdrv_mirror_top_do_write and remember it, but we don't need active
dirty bitmap for write-blocking mirror anyway.

New code-path is unused until the following commit reverts
9adc1cb49af8d.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191011090711.19940-5-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 351faf9367..11d4d66f43 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1182,14 +1182,67 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMet=
hod method,
                      QEMUIOVector *qiov, int flags)
 {
     int ret;
+    size_t qiov_offset =3D 0;
+    int64_t bitmap_offset, bitmap_end;
=20
-    bdrv_reset_dirty_bitmap(job->dirty_bitmap, offset, bytes);
+    if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
+        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset))
+    {
+            /*
+             * Dirty unaligned padding: ignore it.
+             *
+             * Reasoning:
+             * 1. If we copy it, we can't reset corresponding bit in
+             *    dirty_bitmap as there may be some "dirty" bytes still no=
t
+             *    copied.
+             * 2. It's already dirty, so skipping it we don't diverge mirr=
or
+             *    progress.
+             *
+             * Note, that because of this, guest write may have no contrib=
ution
+             * into mirror converge, but that's not bad, as we have backgr=
ound
+             * process of mirroring. If under some bad circumstances (high=
 guest
+             * IO load) background process starve, we will not converge an=
yway,
+             * even if each write will contribute, as guest is not guarant=
eed to
+             * rewrite the whole disk.
+             */
+            qiov_offset =3D QEMU_ALIGN_UP(offset, job->granularity) - offs=
et;
+            if (bytes <=3D qiov_offset) {
+                /* nothing to do after shrink */
+                return;
+            }
+            offset +=3D qiov_offset;
+            bytes -=3D qiov_offset;
+    }
+
+    if (!QEMU_IS_ALIGNED(offset + bytes, job->granularity) &&
+        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset + bytes - 1))
+    {
+        uint64_t tail =3D (offset + bytes) % job->granularity;
+
+        if (bytes <=3D tail) {
+            /* nothing to do after shrink */
+            return;
+        }
+        bytes -=3D tail;
+    }
+
+    /*
+     * Tails are either clean or shrunk, so for bitmap resetting
+     * we safely align the range down.
+     */
+    bitmap_offset =3D QEMU_ALIGN_UP(offset, job->granularity);
+    bitmap_end =3D QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
+    if (bitmap_offset < bitmap_end) {
+        bdrv_reset_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
+                                bitmap_end - bitmap_offset);
+    }
=20
     job_progress_increase_remaining(&job->common.job, bytes);
=20
     switch (method) {
     case MIRROR_METHOD_COPY:
-        ret =3D blk_co_pwritev(job->target, offset, bytes, qiov, flags);
+        ret =3D blk_co_pwritev_part(job->target, offset, bytes,
+                                  qiov, qiov_offset, flags);
         break;
=20
     case MIRROR_METHOD_ZERO:
@@ -1211,7 +1264,16 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMeth=
od method,
     } else {
         BlockErrorAction action;
=20
-        bdrv_set_dirty_bitmap(job->dirty_bitmap, offset, bytes);
+        /*
+         * We failed, so we should mark dirty the whole area, aligned up.
+         * Note that we don't care about shrunk tails if any: they were di=
rty
+         * at function start, and they must be still dirty, as we've locke=
d
+         * the region for in-flight op.
+         */
+        bitmap_offset =3D QEMU_ALIGN_DOWN(offset, job->granularity);
+        bitmap_end =3D QEMU_ALIGN_UP(offset + bytes, job->granularity);
+        bdrv_set_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
+                              bitmap_end - bitmap_offset);
         job->actively_synced =3D false;
=20
         action =3D mirror_error_action(job, false, -ret);
@@ -1618,6 +1680,9 @@ static BlockJob *mirror_start_job(
     if (!s->dirty_bitmap) {
         goto fail;
     }
+    if (s->copy_mode =3D=3D MIRROR_COPY_MODE_WRITE_BLOCKING) {
+        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
+    }
=20
     ret =3D block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
--=20
2.21.0


