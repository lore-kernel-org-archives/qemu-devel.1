Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4770C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C9221848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C9221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i19JA-0005Fg-Ny
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 09:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i19EW-0000gk-12
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i19EU-0003vT-B9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:03:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i19EL-0003nA-Bk; Fri, 23 Aug 2019 09:03:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE6EA1053E64;
 Fri, 23 Aug 2019 13:03:47 +0000 (UTC)
Received: from localhost (ovpn-204-96.brq.redhat.com [10.40.204.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35DA010027BA;
 Fri, 23 Aug 2019 13:03:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 23 Aug 2019 15:03:40 +0200
Message-Id: <20190823130341.21550-2-mreitz@redhat.com>
In-Reply-To: <20190823130341.21550-1-mreitz@redhat.com>
References: <20190823130341.21550-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 23 Aug 2019 13:03:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] block/file-posix: Reduce xfsctl() use
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch removes xfs_write_zeroes() and xfs_discard().  Both functions
have been added just before the same feature was present through
fallocate():

- fallocate() has supported PUNCH_HOLE for XFS since Linux 2.6.38 (March
  2011); xfs_discard() was added in December 2010.

- fallocate() has supported ZERO_RANGE for XFS since Linux 3.15 (June
  2014); xfs_write_zeroes() was added in November 2013.

Nowadays, all systems that qemu runs on should support both fallocate()
features (RHEL 7's kernel does).

xfsctl() is still useful for getting the request alignment for O_DIRECT,
so this patch does not remove our dependency on it completely.

Note that xfs_write_zeroes() had a bug: It calls ftruncate() when the
file is shorter than the specified range (because ZERO_RANGE does not
increase the file length).  ftruncate() may yield and then discard data
that parallel write requests have written past the EOF in the meantime.
Dropping the function altogether fixes the bug.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 50ba5b2d994853b38fed10e0841b119da0f8b8e5
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 77 +---------------------------------------------
 1 file changed, 1 insertion(+), 76 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fbeb0068db..4519065573 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1459,59 +1459,6 @@ out:
     }
 }
=20
-#ifdef CONFIG_XFS
-static int xfs_write_zeroes(BDRVRawState *s, int64_t offset, uint64_t by=
tes)
-{
-    int64_t len;
-    struct xfs_flock64 fl;
-    int err;
-
-    len =3D lseek(s->fd, 0, SEEK_END);
-    if (len < 0) {
-        return -errno;
-    }
-
-    if (offset + bytes > len) {
-        /* XFS_IOC_ZERO_RANGE does not increase the file length */
-        if (ftruncate(s->fd, offset + bytes) < 0) {
-            return -errno;
-        }
-    }
-
-    memset(&fl, 0, sizeof(fl));
-    fl.l_whence =3D SEEK_SET;
-    fl.l_start =3D offset;
-    fl.l_len =3D bytes;
-
-    if (xfsctl(NULL, s->fd, XFS_IOC_ZERO_RANGE, &fl) < 0) {
-        err =3D errno;
-        trace_file_xfs_write_zeroes(strerror(errno));
-        return -err;
-    }
-
-    return 0;
-}
-
-static int xfs_discard(BDRVRawState *s, int64_t offset, uint64_t bytes)
-{
-    struct xfs_flock64 fl;
-    int err;
-
-    memset(&fl, 0, sizeof(fl));
-    fl.l_whence =3D SEEK_SET;
-    fl.l_start =3D offset;
-    fl.l_len =3D bytes;
-
-    if (xfsctl(NULL, s->fd, XFS_IOC_UNRESVSP64, &fl) < 0) {
-        err =3D errno;
-        trace_file_xfs_discard(strerror(errno));
-        return -err;
-    }
-
-    return 0;
-}
-#endif
-
 static int translate_err(int err)
 {
     if (err =3D=3D -ENODEV || err =3D=3D -ENOSYS || err =3D=3D -EOPNOTSU=
PP ||
@@ -1567,10 +1514,8 @@ static ssize_t handle_aiocb_write_zeroes_block(Raw=
PosixAIOData *aiocb)
 static int handle_aiocb_write_zeroes(void *opaque)
 {
     RawPosixAIOData *aiocb =3D opaque;
-#if defined(CONFIG_FALLOCATE) || defined(CONFIG_XFS)
-    BDRVRawState *s =3D aiocb->bs->opaque;
-#endif
 #ifdef CONFIG_FALLOCATE
+    BDRVRawState *s =3D aiocb->bs->opaque;
     int64_t len;
 #endif
=20
@@ -1578,12 +1523,6 @@ static int handle_aiocb_write_zeroes(void *opaque)
         return handle_aiocb_write_zeroes_block(aiocb);
     }
=20
-#ifdef CONFIG_XFS
-    if (s->is_xfs) {
-        return xfs_write_zeroes(s, aiocb->aio_offset, aiocb->aio_nbytes)=
;
-    }
-#endif
-
 #ifdef CONFIG_FALLOCATE_ZERO_RANGE
     if (s->has_write_zeroes) {
         int ret =3D do_fallocate(s->fd, FALLOC_FL_ZERO_RANGE,
@@ -1646,14 +1585,6 @@ static int handle_aiocb_write_zeroes_unmap(void *o=
paque)
     }
 #endif
=20
-#ifdef CONFIG_XFS
-    if (s->is_xfs) {
-        /* xfs_discard() guarantees that the discarded area reads as all=
-zero
-         * afterwards, so we can use it here. */
-        return xfs_discard(s, aiocb->aio_offset, aiocb->aio_nbytes);
-    }
-#endif
-
     /* If we couldn't manage to unmap while guaranteed that the area rea=
ds as
      * all-zero afterwards, just write zeroes without unmapping */
     ret =3D handle_aiocb_write_zeroes(aiocb);
@@ -1730,12 +1661,6 @@ static int handle_aiocb_discard(void *opaque)
         ret =3D -errno;
 #endif
     } else {
-#ifdef CONFIG_XFS
-        if (s->is_xfs) {
-            return xfs_discard(s, aiocb->aio_offset, aiocb->aio_nbytes);
-        }
-#endif
-
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
         ret =3D do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEE=
P_SIZE,
                            aiocb->aio_offset, aiocb->aio_nbytes);
--=20
2.21.0


