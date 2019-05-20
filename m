Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDBAC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B7C214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B7C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSl28-0004Gn-Tx
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:21:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwr-0008F4-50
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwq-0003Yf-3Y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSkwm-0003Hd-LU; Mon, 20 May 2019 12:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 275CF308FC47;
	Mon, 20 May 2019 16:14:59 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 433E7189B6;
	Mon, 20 May 2019 16:14:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 20 May 2019 18:14:30 +0200
Message-Id: <20190520161453.30723-2-kwolf@redhat.com>
In-Reply-To: <20190520161453.30723-1-kwolf@redhat.com>
References: <20190520161453.30723-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 20 May 2019 16:15:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/24] block/file-posix: Truncate in
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.20.1


