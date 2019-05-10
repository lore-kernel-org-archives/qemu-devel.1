Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAE7C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC0F20896
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC0F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50085 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCr2-0005RE-II
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:14:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hPCp0-0004FK-0U
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hPCoz-0002p4-5S
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hPCox-0002nh-5L; Fri, 10 May 2019 17:12:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B17A3082206;
	Fri, 10 May 2019 21:12:46 +0000 (UTC)
Received: from localhost (ovpn-204-59.brq.redhat.com [10.40.204.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 13ACE1A267;
	Fri, 10 May 2019 21:12:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 10 May 2019 23:12:44 +0200
Message-Id: <20190510211244.26461-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 10 May 2019 21:12:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] block/file-posix: Truncate in
 xfs_write_zeroes()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

XFS_IOC_ZERO_RANGE does not increase the file length:
$ touch foo
$ xfs_io -c 'zero 0 65536' foo
$ stat -c "size=3D%s, blocks=3D%b" foo
size=3D0, blocks=3D128

We do want writes beyond the EOF to automatically increase the file
length, however.  This is evidenced by the fact that iotest 061 is
broken on XFS since qcow2's check implementation checks for blocks
beyond the EOF.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1cf4ee49eb..e09e15bbf8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1444,9 +1444,22 @@ out:
 #ifdef CONFIG_XFS
 static int xfs_write_zeroes(BDRVRawState *s, int64_t offset, uint64_t by=
tes)
 {
+    int64_t len;
     struct xfs_flock64 fl;
     int err;
=20
+    len =3D lseek(s->fd, 0, SEEK_END);
+    if (len < 0) {
+        return -errno;
+    }
+
+    if (offset + bytes > len) {
+        /* XFS_IOC_ZERO_RANGE does not increase the file length */
+        if (ftruncate(s->fd, offset + bytes) < 0) {
+            return -errno;
+        }
+    }
+
     memset(&fl, 0, sizeof(fl));
     fl.l_whence =3D SEEK_SET;
     fl.l_start =3D offset;
--=20
2.21.0


