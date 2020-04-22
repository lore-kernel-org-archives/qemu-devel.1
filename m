Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A993C5518B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CC82074B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEYImxLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CC82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHE6-0005Lo-DN
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRHC7-0002q2-MO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRHC5-000390-0q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:21:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRHC4-00035f-Kq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587568903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZV2ktlitBnBkkNbak0x+TpyfWlGjpjfThGnq4xx/Rc0=;
 b=LEYImxLRUJaSX/OO9rTPonu7sJ6CV14OWReIA8lz25HEDb3/4AieXS0kdxTLlKn+MWYvqm
 VDgGOM71UuC/OBw1ozNGXHloHenS9YCgSxSaCESuH2IQJzbI5YI5p4GowUcbJO75E0m+EZ
 lLqKRqNSmAyP7/GtzT6+09TzdorVIiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-3MIPIrlaOdyiOtafr0T4TQ-1; Wed, 22 Apr 2020 11:21:40 -0400
X-MC-Unique: 3MIPIrlaOdyiOtafr0T4TQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72642DB70;
 Wed, 22 Apr 2020 15:21:39 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-212.ams2.redhat.com
 [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 885F3600D2;
 Wed, 22 Apr 2020 15:21:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 1/9] block: Add flags to BlockDriver.bdrv_co_truncate()
Date: Wed, 22 Apr 2020 17:21:21 +0200
Message-Id: <20200422152129.167074-2-kwolf@redhat.com>
In-Reply-To: <20200422152129.167074-1-kwolf@redhat.com>
References: <20200422152129.167074-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a new BdrvRequestFlags parameter to the .bdrv_co_truncate()
driver callbacks, and a supported_truncate_flags field in
BlockDriverState that allows drivers to advertise support for request
flags in the context of truncate.

For now, we always pass 0 and no drivers declare support for any flag.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block_int.h   | 10 +++++++++-
 block/crypto.c              |  3 ++-
 block/file-posix.c          |  2 +-
 block/file-win32.c          |  2 +-
 block/gluster.c             |  1 +
 block/io.c                  |  8 +++++++-
 block/iscsi.c               |  2 +-
 block/nfs.c                 |  3 ++-
 block/qcow2.c               |  2 +-
 block/qed.c                 |  1 +
 block/raw-format.c          |  2 +-
 block/rbd.c                 |  1 +
 block/sheepdog.c            |  4 ++--
 block/ssh.c                 |  2 +-
 tests/test-block-iothread.c |  3 ++-
 15 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4c3587ea19..92335f33c7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -355,7 +355,7 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_truncate)(BlockDriverState *bs, int64_t off=
set,
                                          bool exact, PreallocMode prealloc=
,
-                                         Error **errp);
+                                         BdrvRequestFlags flags, Error **e=
rrp);
=20
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
@@ -847,6 +847,14 @@ struct BlockDriverState {
     /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
      * BDRV_REQ_MAY_UNMAP, BDRV_REQ_WRITE_UNCHANGED) */
     unsigned int supported_zero_flags;
+    /*
+     * Flags honoured during truncate (so far: BDRV_REQ_ZERO_WRITE).
+     *
+     * If BDRV_REQ_ZERO_WRITE is given, the truncate operation must make s=
ure
+     * that any added space reads as all zeros. If this can't be guarantee=
d,
+     * the operation must fail.
+     */
+    unsigned int supported_truncate_flags;
=20
     /* the following member gives a name to every node on the bs graph. */
     char node_name[32];
diff --git a/block/crypto.c b/block/crypto.c
index d577f89659..3721a8495c 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -299,7 +299,8 @@ static int block_crypto_co_create_generic(BlockDriverSt=
ate *bs,
=20
 static int coroutine_fn
 block_crypto_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
-                         PreallocMode prealloc, Error **errp)
+                         PreallocMode prealloc, BdrvRequestFlags flags,
+                         Error **errp)
 {
     BlockCrypto *crypto =3D bs->opaque;
     uint64_t payload_offset =3D
diff --git a/block/file-posix.c b/block/file-posix.c
index 7e19bbff5f..53f475ed61 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2080,7 +2080,7 @@ raw_regular_truncate(BlockDriverState *bs, int fd, in=
t64_t offset,
=20
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offs=
et,
                                         bool exact, PreallocMode prealloc,
-                                        Error **errp)
+                                        BdrvRequestFlags flags, Error **er=
rp)
 {
     BDRVRawState *s =3D bs->opaque;
     struct stat st;
diff --git a/block/file-win32.c b/block/file-win32.c
index 15859839a1..a6b0dda5c3 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -469,7 +469,7 @@ static void raw_close(BlockDriverState *bs)
=20
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offs=
et,
                                         bool exact, PreallocMode prealloc,
-                                        Error **errp)
+                                        BdrvRequestFlags flags, Error **er=
rp)
 {
     BDRVRawState *s =3D bs->opaque;
     LONG low, high;
diff --git a/block/gluster.c b/block/gluster.c
index 0aa1f2cda4..d06df900f6 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1228,6 +1228,7 @@ static coroutine_fn int qemu_gluster_co_truncate(Bloc=
kDriverState *bs,
                                                  int64_t offset,
                                                  bool exact,
                                                  PreallocMode prealloc,
+                                                 BdrvRequestFlags flags,
                                                  Error **errp)
 {
     BDRVGlusterState *s =3D bs->opaque;
diff --git a/block/io.c b/block/io.c
index aba67f66b9..04ac5cf023 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3344,6 +3344,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, i=
nt64_t offset, bool exact,
     BlockDriverState *bs =3D child->bs;
     BlockDriver *drv =3D bs->drv;
     BdrvTrackedRequest req;
+    BdrvRequestFlags flags =3D 0;
     int64_t old_size, new_bytes;
     int ret;
=20
@@ -3394,7 +3395,12 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, =
int64_t offset, bool exact,
     }
=20
     if (drv->bdrv_co_truncate) {
-        ret =3D drv->bdrv_co_truncate(bs, offset, exact, prealloc, errp);
+        if (flags & ~bs->supported_truncate_flags) {
+            error_setg(errp, "Block driver does not support requested flag=
s");
+            ret =3D -ENOTSUP;
+            goto out;
+        }
+        ret =3D drv->bdrv_co_truncate(bs, offset, exact, prealloc, flags, =
errp);
     } else if (bs->file && drv->is_filter) {
         ret =3D bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
     } else {
diff --git a/block/iscsi.c b/block/iscsi.c
index 0b4b7210df..914a1de9fb 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2124,7 +2124,7 @@ static void iscsi_reopen_commit(BDRVReopenState *reop=
en_state)
=20
 static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t of=
fset,
                                           bool exact, PreallocMode preallo=
c,
-                                          Error **errp)
+                                          BdrvRequestFlags flags, Error **=
errp)
 {
     IscsiLun *iscsilun =3D bs->opaque;
     int64_t cur_length;
diff --git a/block/nfs.c b/block/nfs.c
index cc2413d5ab..2393fbfe6b 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -755,7 +755,8 @@ static int64_t nfs_get_allocated_file_size(BlockDriverS=
tate *bs)
=20
 static int coroutine_fn
 nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
-                     PreallocMode prealloc, Error **errp)
+                     PreallocMode prealloc, BdrvRequestFlags flags,
+                     Error **errp)
 {
     NFSClient *client =3D bs->opaque;
     int ret;
diff --git a/block/qcow2.c b/block/qcow2.c
index b524b0c53f..0b406b22fb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3964,7 +3964,7 @@ fail:
=20
 static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t of=
fset,
                                           bool exact, PreallocMode preallo=
c,
-                                          Error **errp)
+                                          BdrvRequestFlags flags, Error **=
errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t old_length;
diff --git a/block/qed.c b/block/qed.c
index 1af9b3cb1d..fb6100bd20 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1467,6 +1467,7 @@ static int coroutine_fn bdrv_qed_co_truncate(BlockDri=
verState *bs,
                                              int64_t offset,
                                              bool exact,
                                              PreallocMode prealloc,
+                                             BdrvRequestFlags flags,
                                              Error **errp)
 {
     BDRVQEDState *s =3D bs->opaque;
diff --git a/block/raw-format.c b/block/raw-format.c
index 93b25e1b6b..9331368f43 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -371,7 +371,7 @@ static void raw_refresh_limits(BlockDriverState *bs, Er=
ror **errp)
=20
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offs=
et,
                                         bool exact, PreallocMode prealloc,
-                                        Error **errp)
+                                        BdrvRequestFlags flags, Error **er=
rp)
 {
     BDRVRawState *s =3D bs->opaque;
=20
diff --git a/block/rbd.c b/block/rbd.c
index e637639a07..f2d52091c7 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1108,6 +1108,7 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockDri=
verState *bs,
                                              int64_t offset,
                                              bool exact,
                                              PreallocMode prealloc,
+                                             BdrvRequestFlags flags,
                                              Error **errp)
 {
     int r;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 59f7ebb171..ef0a6e743e 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2288,7 +2288,7 @@ static int64_t sd_getlength(BlockDriverState *bs)
=20
 static int coroutine_fn sd_co_truncate(BlockDriverState *bs, int64_t offse=
t,
                                        bool exact, PreallocMode prealloc,
-                                       Error **errp)
+                                       BdrvRequestFlags flags, Error **err=
p)
 {
     BDRVSheepdogState *s =3D bs->opaque;
     int ret, fd;
@@ -2604,7 +2604,7 @@ static coroutine_fn int sd_co_writev(BlockDriverState=
 *bs, int64_t sector_num,
=20
     assert(!flags);
     if (offset > s->inode.vdi_size) {
-        ret =3D sd_co_truncate(bs, offset, false, PREALLOC_MODE_OFF, NULL)=
;
+        ret =3D sd_co_truncate(bs, offset, false, PREALLOC_MODE_OFF, 0, NU=
LL);
         if (ret < 0) {
             return ret;
         }
diff --git a/block/ssh.c b/block/ssh.c
index 84e92821c0..9eb33df859 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1298,7 +1298,7 @@ static int64_t ssh_getlength(BlockDriverState *bs)
=20
 static int coroutine_fn ssh_co_truncate(BlockDriverState *bs, int64_t offs=
et,
                                         bool exact, PreallocMode prealloc,
-                                        Error **errp)
+                                        BdrvRequestFlags flags, Error **er=
rp)
 {
     BDRVSSHState *s =3D bs->opaque;
=20
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 0c861809f0..2f3b76323d 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -46,7 +46,8 @@ static int coroutine_fn bdrv_test_co_pdiscard(BlockDriver=
State *bs,
=20
 static int coroutine_fn
 bdrv_test_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
-                      PreallocMode prealloc, Error **errp)
+                      PreallocMode prealloc, BdrvRequestFlags flags,
+                      Error **errp)
 {
     return 0;
 }
--=20
2.25.3


