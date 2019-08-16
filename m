Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D048CC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A408920644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A408920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYnx-0004EX-Ky
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYde-0000PE-6r
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdc-00042n-L7
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdZ-0003uS-08; Fri, 16 Aug 2019 05:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 587FC308A9BE;
 Fri, 16 Aug 2019 09:35:08 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24ED55C1D6;
 Fri, 16 Aug 2019 09:35:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:39 +0200
Message-Id: <20190816093439.14262-17-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
References: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 16 Aug 2019 09:35:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/16] file-posix: Handle undetectable alignment
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nir Soffer <nirsof@gmail.com>

In some cases buf_align or request_alignment cannot be detected:

1. With Gluster, buf_align cannot be detected since the actual I/O is
   done on Gluster server, and qemu buffer alignment does not matter.
   Since we don't have alignment requirement, buf_align=3D1 is the best
   value.

2. With local XFS filesystem, buf_align cannot be detected if reading
   from unallocated area. In this we must align the buffer, but we don't
   know what is the correct size. Using the wrong alignment results in
   I/O error.

3. With Gluster backed by XFS, request_alignment cannot be detected if
   reading from unallocated area. In this case we need to use the
   correct alignment, and failing to do so results in I/O errors.

4. With NFS, the server does not use direct I/O, so both buf_align cannot
   be detected. In this case we don't need any alignment so we can use
   buf_align=3D1 and request_alignment=3D1.

These cases seems to work when storage sector size is 512 bytes, because
the current code starts checking align=3D512. If the check succeeds
because alignment cannot be detected we use 512. But this does not work
for storage with 4k sector size.

To determine if we can detect the alignment, we probe first with
align=3D1. If probing succeeds, maybe there are no alignment requirement
(cases 1, 4) or we are probing unallocated area (cases 2, 3). Since we
don't have any way to tell, we treat this as undetectable alignment. If
probing with align=3D1 fails with EINVAL, but probing with one of the
expected alignments succeeds, we know that we found a working alignment.

Practically the alignment requirements are the same for buffer
alignment, buffer length, and offset in file. So in case we cannot
detect buf_align, we can use request alignment. If we cannot detect
request alignment, we can fallback to a safe value. To use this logic,
we probe first request alignment instead of buf_align.

Here is a table showing the behaviour with current code (the value in
parenthesis is the optimal value).

Case    Sector    buf_align (opt)   request_alignment (opt)     result
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1       512       512   (1)          512   (512)                 OK
1       4096      512   (1)          4096  (4096)                FAIL
----------------------------------------------------------------------
2       512       512   (512)        512   (512)                 OK
2       4096      512   (4096)       4096  (4096)                FAIL
----------------------------------------------------------------------
3       512       512   (1)          512   (512)                 OK
3       4096      512   (1)          512   (4096)                FAIL
----------------------------------------------------------------------
4       512       512   (1)          512   (1)                   OK
4       4096      512   (1)          512   (1)                   OK

Same cases with this change:

Case    Sector    buf_align (opt)   request_alignment (opt)     result
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1       512       512   (1)          512   (512)                 OK
1       4096      4096  (1)          4096  (4096)                OK
----------------------------------------------------------------------
2       512       512   (512)        512   (512)                 OK
2       4096      4096  (4096)       4096  (4096)                OK
----------------------------------------------------------------------
3       512       4096  (1)          4096  (512)                 OK
3       4096      4096  (1)          4096  (4096)                OK
----------------------------------------------------------------------
4       512       4096  (1)          4096  (1)                   OK
4       4096      4096  (1)          4096  (1)                   OK

I tested that provisioning VMs and copying disks on local XFS and
Gluster with 4k bytes sector size work now, resolving bugs [1],[2].
I tested also on XFS, NFS, Gluster with 512 bytes sector size.

[1] https://bugzilla.redhat.com/1737256
[2] https://bugzilla.redhat.com/1738657

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4479cc7ab4..b8b4dad553 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -323,6 +323,7 @@ static void raw_probe_alignment(BlockDriverState *bs,=
 int fd, Error **errp)
     BDRVRawState *s =3D bs->opaque;
     char *buf;
     size_t max_align =3D MAX(MAX_BLOCKSIZE, getpagesize());
+    size_t alignments[] =3D {1, 512, 1024, 2048, 4096};
=20
     /* For SCSI generic devices the alignment is not really used.
        With buffered I/O, we don't have any restrictions. */
@@ -349,25 +350,38 @@ static void raw_probe_alignment(BlockDriverState *b=
s, int fd, Error **errp)
     }
 #endif
=20
-    /* If we could not get the sizes so far, we can only guess them */
-    if (!s->buf_align) {
+    /*
+     * If we could not get the sizes so far, we can only guess them. Fir=
st try
+     * to detect request alignment, since it is more likely to succeed. =
Then
+     * try to detect buf_align, which cannot be detected in some cases (=
e.g.
+     * Gluster). If buf_align cannot be detected, we fallback to the val=
ue of
+     * request_alignment.
+     */
+
+    if (!bs->bl.request_alignment) {
+        int i;
         size_t align;
-        buf =3D qemu_memalign(max_align, 2 * max_align);
-        for (align =3D 512; align <=3D max_align; align <<=3D 1) {
-            if (raw_is_io_aligned(fd, buf + align, max_align)) {
-                s->buf_align =3D align;
+        buf =3D qemu_memalign(max_align, max_align);
+        for (i =3D 0; i < ARRAY_SIZE(alignments); i++) {
+            align =3D alignments[i];
+            if (raw_is_io_aligned(fd, buf, align)) {
+                /* Fallback to safe value. */
+                bs->bl.request_alignment =3D (align !=3D 1) ? align : ma=
x_align;
                 break;
             }
         }
         qemu_vfree(buf);
     }
=20
-    if (!bs->bl.request_alignment) {
+    if (!s->buf_align) {
+        int i;
         size_t align;
-        buf =3D qemu_memalign(s->buf_align, max_align);
-        for (align =3D 512; align <=3D max_align; align <<=3D 1) {
-            if (raw_is_io_aligned(fd, buf, align)) {
-                bs->bl.request_alignment =3D align;
+        buf =3D qemu_memalign(max_align, 2 * max_align);
+        for (i =3D 0; i < ARRAY_SIZE(alignments); i++) {
+            align =3D alignments[i];
+            if (raw_is_io_aligned(fd, buf + align, max_align)) {
+                /* Fallback to request_aligment. */
+                s->buf_align =3D (align !=3D 1) ? align : bs->bl.request=
_alignment;
                 break;
             }
         }
--=20
2.20.1


