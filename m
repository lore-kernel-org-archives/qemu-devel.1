Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8981DC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5CC20652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5CC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVEC-0007ht-Ka
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:03:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUur-00082S-9W
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-00025X-Rg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUub-0001rm-F0; Tue, 30 Apr 2019 11:43:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFF50C4ECE;
	Tue, 30 Apr 2019 15:43:15 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 141547190D;
	Tue, 30 Apr 2019 15:43:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:28 +0200
Message-Id: <20190430154244.30083-12-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 30 Apr 2019 15:43:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/27] qcow2: Fix full preallocation with
 external data file
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
Message-ID: <20190430154228.-3X2Yn78O0vesAONkuUeTkKMte2OOXf2uAn_gqlEjJQ@z>

preallocate_co() already gave the data file the full size without
forwarding the requested preallocation mode to the protocol. When
bdrv_co_truncate() was called later with the preallocation mode, the
file didn't actually grow any more, so the data file stayed unallocated
even if full preallocation was requested.

Pass the right preallocation mode to preallocate_co() and remove the
second bdrv_co_truncate() to fix this. As a side effect, the ugly
one-byte write in preallocate_co() is replaced with a truncate call,
now leaving the last block unallocated on the protocol level as it
should be.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b4f9f5a240..7fbef97aab 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2721,11 +2721,13 @@ static int qcow2_set_up_encryption(BlockDriverSta=
te *bs,
  * Returns: 0 on success, -errno on failure.
  */
 static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t of=
fset,
-                                       uint64_t new_length, Error **errp=
)
+                                       uint64_t new_length, PreallocMode=
 mode,
+                                       Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t bytes;
     uint64_t host_offset =3D 0;
+    int64_t file_length;
     unsigned int cur_bytes;
     int ret;
     QCowL2Meta *meta;
@@ -2772,12 +2774,19 @@ static int coroutine_fn preallocate_co(BlockDrive=
rState *bs, uint64_t offset,
      * all of the allocated clusters (otherwise we get failing reads aft=
er
      * EOF). Extend the image to the last allocated sector.
      */
-    if (host_offset !=3D 0) {
-        uint8_t data =3D 0;
-        ret =3D bdrv_pwrite(s->data_file, (host_offset + cur_bytes) - 1,
-                          &data, 1);
+    file_length =3D bdrv_getlength(s->data_file->bs);
+    if (file_length < 0) {
+        error_setg_errno(errp, -file_length, "Could not get file size");
+        return file_length;
+    }
+
+    if (host_offset + cur_bytes > file_length) {
+        if (mode =3D=3D PREALLOC_MODE_METADATA) {
+            mode =3D PREALLOC_MODE_OFF;
+        }
+        ret =3D bdrv_co_truncate(s->data_file, host_offset + cur_bytes, =
mode,
+                               errp);
         if (ret < 0) {
-            error_setg_errno(errp, -ret, "Writing to EOF failed");
             return ret;
         }
     }
@@ -3748,10 +3757,16 @@ static int coroutine_fn qcow2_co_truncate(BlockDr=
iverState *bs, int64_t offset,
=20
     switch (prealloc) {
     case PREALLOC_MODE_OFF:
+        if (has_data_file(bs)) {
+            ret =3D bdrv_co_truncate(s->data_file, offset, prealloc, err=
p);
+            if (ret < 0) {
+                goto fail;
+            }
+        }
         break;
=20
     case PREALLOC_MODE_METADATA:
-        ret =3D preallocate_co(bs, old_length, offset, errp);
+        ret =3D preallocate_co(bs, old_length, offset, prealloc, errp);
         if (ret < 0) {
             goto fail;
         }
@@ -3768,7 +3783,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
         /* With a data file, preallocation means just allocating the met=
adata
          * and forwarding the truncate request to the data file */
         if (has_data_file(bs)) {
-            ret =3D preallocate_co(bs, old_length, offset, errp);
+            ret =3D preallocate_co(bs, old_length, offset, prealloc, err=
p);
             if (ret < 0) {
                 goto fail;
             }
@@ -3883,16 +3898,6 @@ static int coroutine_fn qcow2_co_truncate(BlockDri=
verState *bs, int64_t offset,
=20
     bs->total_sectors =3D offset / BDRV_SECTOR_SIZE;
=20
-    if (has_data_file(bs)) {
-        if (prealloc =3D=3D PREALLOC_MODE_METADATA) {
-            prealloc =3D PREALLOC_MODE_OFF;
-        }
-        ret =3D bdrv_co_truncate(s->data_file, offset, prealloc, errp);
-        if (ret < 0) {
-            goto fail;
-        }
-    }
-
     /* write updated header.size */
     offset =3D cpu_to_be64(offset);
     ret =3D bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
--=20
2.20.1


