Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EE6233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EE6233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0pwY-0002DU-ES
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0pv4-0001Bg-LA
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0pv2-0001Aq-2V
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:26:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0puv-00014D-4C; Thu, 22 Aug 2019 12:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79DED3083362;
 Thu, 22 Aug 2019 16:26:23 +0000 (UTC)
Received: from localhost (unknown [10.40.205.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12D386114F;
 Thu, 22 Aug 2019 16:26:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 22 Aug 2019 18:26:17 +0200
Message-Id: <20190822162618.27670-2-mreitz@redhat.com>
In-Reply-To: <20190822162618.27670-1-mreitz@redhat.com>
References: <20190822162618.27670-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 22 Aug 2019 16:26:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] block/file-posix: Fix xfs_write_zeroes()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calling ftruncate() in xfs_write_zeroes() is dangerous because it may
yield and then discard data that parallel write requests have written
past the old EOF in the meantime.  We must not use it here.

Instead, return -ENOTSUP and let the more generic fallocate code handle
writing zeroes past the EOF.

Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Fixes: 50ba5b2d994853b38fed10e0841b119da0f8b8e5
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fbeb0068db..b49e0784a4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1472,10 +1472,13 @@ static int xfs_write_zeroes(BDRVRawState *s, int6=
4_t offset, uint64_t bytes)
     }
=20
     if (offset + bytes > len) {
-        /* XFS_IOC_ZERO_RANGE does not increase the file length */
-        if (ftruncate(s->fd, offset + bytes) < 0) {
-            return -errno;
-        }
+        /*
+         * XFS_IOC_ZERO_RANGE does not increase the file length, but
+         * the caller probably wants us to.
+         * Calling ftruncate() would not be safe, so let the generic
+         * implementation handle this case.
+         */
+        return -ENOTSUP;
     }
=20
     memset(&fl, 0, sizeof(fl));
@@ -1580,7 +1583,10 @@ static int handle_aiocb_write_zeroes(void *opaque)
=20
 #ifdef CONFIG_XFS
     if (s->is_xfs) {
-        return xfs_write_zeroes(s, aiocb->aio_offset, aiocb->aio_nbytes)=
;
+        int ret =3D xfs_write_zeroes(s, aiocb->aio_offset, aiocb->aio_nb=
ytes);
+        if (ret !=3D -ENOTSUP) {
+            return ret;
+        }
     }
 #endif
=20
--=20
2.21.0


