Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7995C04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A61220835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A61220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48959 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLV4E-0007V7-Ow
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:53:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUux-00089g-Dy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuw-0002CP-DD
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUut-00029M-GF; Tue, 30 Apr 2019 11:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3DE03082E57;
	Tue, 30 Apr 2019 15:43:34 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53A604C7;
	Tue, 30 Apr 2019 15:43:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:38 +0200
Message-Id: <20190430154244.30083-22-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 30 Apr 2019 15:43:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 21/27] block/backup: use buffer-based io
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
Message-ID: <20190430154238.GRtgkmL2ICKeS6huz5uXSu1CyhJSycI8X9z5dtzBfJ0@z>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9988753249..910ed764aa 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -107,7 +107,6 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
                                                       void **bounce_buff=
er)
 {
     int ret;
-    QEMUIOVector qiov;
     BlockBackend *blk =3D job->common.blk;
     int nbytes;
     int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
@@ -118,9 +117,8 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
     if (!*bounce_buffer) {
         *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
     }
-    qemu_iovec_init_buf(&qiov, *bounce_buffer, nbytes);
=20
-    ret =3D blk_co_preadv(blk, start, qiov.size, &qiov, read_flags);
+    ret =3D blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flags)=
;
     if (ret < 0) {
         trace_backup_do_cow_read_fail(job, start, ret);
         if (error_is_read) {
@@ -129,13 +127,13 @@ static int coroutine_fn backup_cow_with_bounce_buff=
er(BackupBlockJob *job,
         goto fail;
     }
=20
-    if (qemu_iovec_is_zero(&qiov)) {
+    if (buffer_is_zero(*bounce_buffer, nbytes)) {
         ret =3D blk_co_pwrite_zeroes(job->target, start,
-                                   qiov.size, write_flags | BDRV_REQ_MAY=
_UNMAP);
+                                   nbytes, write_flags | BDRV_REQ_MAY_UN=
MAP);
     } else {
-        ret =3D blk_co_pwritev(job->target, start,
-                             qiov.size, &qiov, write_flags |
-                             (job->compress ? BDRV_REQ_WRITE_COMPRESSED =
: 0));
+        ret =3D blk_co_pwrite(job->target, start,
+                            nbytes, *bounce_buffer, write_flags |
+                            (job->compress ? BDRV_REQ_WRITE_COMPRESSED :=
 0));
     }
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
--=20
2.20.1


