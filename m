Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AB6C742BE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C492080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C492080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvzT-00055v-9D
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32956)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlvz2-0003g1-Cw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlvz0-0001b8-Uk
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:53:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlvyw-0001XX-RO; Fri, 12 Jul 2019 09:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C65330821BE;
 Fri, 12 Jul 2019 13:53:02 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D4F65D739;
 Fri, 12 Jul 2019 13:53:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Jul 2019 15:52:53 +0200
Message-Id: <20190712135253.9410-3-kwolf@redhat.com>
In-Reply-To: <20190712135253.9410-1-kwolf@redhat.com>
References: <20190712135253.9410-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 12 Jul 2019 13:53:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] file-posix: Use max transfer length/segment
 count only for SCSI passthrough
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Regular kernel block devices (/dev/sda*, /dev/nvme*, etc) don't have
max segment size/max segment count hardware requirements exposed
to the userspace, but rather the kernel block layer
takes care to split the incoming requests that
violate these requirements.

Allowing the kernel to do the splitting allows qemu to avoid
various overheads that arise otherwise from this.

This is especially visible in nbd server,
exposing as a raw file, a mostly empty qcow2 image over the net.
In this case most of the reads by the remote user
won't even hit the underlying kernel block device,
and therefore most of the  overhead will be in the
nbd traffic which increases significantly with lower max transfer size.

In addition to that even for local block device
access the peformance improves a bit due to less
traffic between qemu and the kernel when large
transfer sizes are used (e.g for image conversion)

More info can be found at:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1647104

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 54 ++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ab05b51a66..4479cc7ab4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1038,15 +1038,13 @@ static void raw_reopen_abort(BDRVReopenState *sta=
te)
     s->reopen_state =3D NULL;
 }
=20
-static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
+static int sg_get_max_transfer_length(int fd)
 {
 #ifdef BLKSECTGET
     int max_bytes =3D 0;
-    short max_sectors =3D 0;
-    if (bs->sg && ioctl(fd, BLKSECTGET, &max_bytes) =3D=3D 0) {
+
+    if (ioctl(fd, BLKSECTGET, &max_bytes) =3D=3D 0) {
         return max_bytes;
-    } else if (!bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) =3D=3D 0) =
{
-        return max_sectors << BDRV_SECTOR_BITS;
     } else {
         return -errno;
     }
@@ -1055,25 +1053,31 @@ static int hdev_get_max_transfer_length(BlockDriv=
erState *bs, int fd)
 #endif
 }
=20
-static int hdev_get_max_segments(const struct stat *st)
+static int sg_get_max_segments(int fd)
 {
 #ifdef CONFIG_LINUX
     char buf[32];
     const char *end;
-    char *sysfspath;
+    char *sysfspath =3D NULL;
     int ret;
-    int fd =3D -1;
+    int sysfd =3D -1;
     long max_segments;
+    struct stat st;
+
+    if (fstat(fd, &st)) {
+        ret =3D -errno;
+        goto out;
+    }
=20
     sysfspath =3D g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segmen=
ts",
-                                major(st->st_rdev), minor(st->st_rdev));
-    fd =3D open(sysfspath, O_RDONLY);
-    if (fd =3D=3D -1) {
+                                major(st.st_rdev), minor(st.st_rdev));
+    sysfd =3D open(sysfspath, O_RDONLY);
+    if (sysfd =3D=3D -1) {
         ret =3D -errno;
         goto out;
     }
     do {
-        ret =3D read(fd, buf, sizeof(buf) - 1);
+        ret =3D read(sysfd, buf, sizeof(buf) - 1);
     } while (ret =3D=3D -1 && errno =3D=3D EINTR);
     if (ret < 0) {
         ret =3D -errno;
@@ -1090,8 +1094,8 @@ static int hdev_get_max_segments(const struct stat =
*st)
     }
=20
 out:
-    if (fd !=3D -1) {
-        close(fd);
+    if (sysfd !=3D -1) {
+        close(sysfd);
     }
     g_free(sysfspath);
     return ret;
@@ -1103,19 +1107,17 @@ out:
 static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s =3D bs->opaque;
-    struct stat st;
=20
-    if (!fstat(s->fd, &st)) {
-        if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
-            int ret =3D hdev_get_max_transfer_length(bs, s->fd);
-            if (ret > 0 && ret <=3D BDRV_REQUEST_MAX_BYTES) {
-                bs->bl.max_transfer =3D pow2floor(ret);
-            }
-            ret =3D hdev_get_max_segments(&st);
-            if (ret > 0) {
-                bs->bl.max_transfer =3D MIN(bs->bl.max_transfer,
-                                          ret * getpagesize());
-            }
+    if (bs->sg) {
+        int ret =3D sg_get_max_transfer_length(s->fd);
+
+        if (ret > 0 && ret <=3D BDRV_REQUEST_MAX_BYTES) {
+            bs->bl.max_transfer =3D pow2floor(ret);
+        }
+
+        ret =3D sg_get_max_segments(s->fd);
+        if (ret > 0) {
+            bs->bl.max_transfer =3D MIN(bs->bl.max_transfer, ret * getpa=
gesize());
         }
     }
=20
--=20
2.20.1


