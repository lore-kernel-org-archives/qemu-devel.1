Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62909C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7EE20665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7EE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sc3-0006tW-0x
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9ru6-0002mq-Dq
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9ru4-0000ZW-FX
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:22:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9ru0-0000YE-Ua; Mon, 16 Sep 2019 10:22:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3122F81DEC;
 Mon, 16 Sep 2019 14:22:52 +0000 (UTC)
Received: from localhost (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBED3600C1;
 Mon, 16 Sep 2019 14:22:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 16:22:31 +0200
Message-Id: <20190916142246.31474-2-mreitz@redhat.com>
In-Reply-To: <20190916142246.31474-1-mreitz@redhat.com>
References: <20190916142246.31474-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 16 Sep 2019 14:22:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/16] block: Use QEMU_IS_ALIGNED
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

From: Nir Soffer <nirsof@gmail.com>

Replace instances of:

    (n & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0

And:

   (n & ~BDRV_SECTOR_MASK) =3D=3D 0

With:

    QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE)

Which reveals the intent of the code better, and makes it easier to
locate the code checking alignment.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-id: 20190827185913.27427-2-nsoffer@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/bochs.c         | 4 ++--
 block/cloop.c         | 4 ++--
 block/dmg.c           | 4 ++--
 block/io.c            | 8 ++++----
 block/qcow2-cluster.c | 4 ++--
 block/qcow2.c         | 4 ++--
 block/vvfat.c         | 8 ++++----
 qemu-img.c            | 2 +-
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/block/bochs.c b/block/bochs.c
index 962f18592d..32bb83b268 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -248,8 +248,8 @@ bochs_co_preadv(BlockDriverState *bs, uint64_t offset=
, uint64_t bytes,
     QEMUIOVector local_qiov;
     int ret;
=20
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
=20
     qemu_iovec_init(&local_qiov, qiov->niov);
     qemu_co_mutex_lock(&s->lock);
diff --git a/block/cloop.c b/block/cloop.c
index 384c9735bb..4de94876d4 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -253,8 +253,8 @@ cloop_co_preadv(BlockDriverState *bs, uint64_t offset=
, uint64_t bytes,
     int nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
     int ret, i;
=20
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
=20
     qemu_co_mutex_lock(&s->lock);
=20
diff --git a/block/dmg.c b/block/dmg.c
index 45f6b28f17..4a045f2b3e 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -697,8 +697,8 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, =
uint64_t bytes,
     int nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
     int ret, i;
=20
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
=20
     qemu_co_mutex_lock(&s->lock);
=20
diff --git a/block/io.c b/block/io.c
index 16a598fd08..f8c3596131 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1097,8 +1097,8 @@ static int coroutine_fn bdrv_driver_preadv(BlockDri=
verState *bs,
     sector_num =3D offset >> BDRV_SECTOR_BITS;
     nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
=20
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
     assert(bytes <=3D BDRV_REQUEST_MAX_BYTES);
     assert(drv->bdrv_co_readv);
=20
@@ -1171,8 +1171,8 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDr=
iverState *bs,
     sector_num =3D offset >> BDRV_SECTOR_BITS;
     nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
=20
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
     assert(bytes <=3D BDRV_REQUEST_MAX_BYTES);
=20
     assert(drv->bdrv_co_writev);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index dcacd3c450..cb44b6c6ba 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -471,8 +471,8 @@ static bool coroutine_fn do_perform_cow_encrypt(Block=
DriverState *bs,
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s =3D bs->opaque;
-        assert((offset_in_cluster & ~BDRV_SECTOR_MASK) =3D=3D 0);
-        assert((bytes & ~BDRV_SECTOR_MASK) =3D=3D 0);
+        assert(QEMU_IS_ALIGNED(offset_in_cluster, BDRV_SECTOR_SIZE));
+        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
         assert(s->crypto);
         if (qcow2_co_encrypt(bs, cluster_offset,
                              src_cluster_offset + offset_in_cluster,
diff --git a/block/qcow2.c b/block/qcow2.c
index 57734f20cf..cac18f0ba2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2067,8 +2067,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockD=
riverState *bs,
                     goto fail;
                 }
=20
-                assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-                assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+                assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+                assert(QEMU_IS_ALIGNED(cur_bytes, BDRV_SECTOR_SIZE));
                 if (qcow2_co_decrypt(bs, cluster_offset, offset,
                                      cluster_data, cur_bytes) < 0) {
                     ret =3D -EIO;
diff --git a/block/vvfat.c b/block/vvfat.c
index f6c28805dd..019b8f1341 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1547,8 +1547,8 @@ vvfat_co_preadv(BlockDriverState *bs, uint64_t offs=
et, uint64_t bytes,
     int nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
     void *buf;
=20
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
=20
     buf =3D g_try_malloc(bytes);
     if (bytes && buf =3D=3D NULL) {
@@ -3082,8 +3082,8 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t off=
set, uint64_t bytes,
     int nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
     void *buf;
=20
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
=20
     buf =3D g_try_malloc(bytes);
     if (bytes && buf =3D=3D NULL) {
diff --git a/qemu-img.c b/qemu-img.c
index 4ee436fc94..384c6f38bc 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2141,7 +2141,7 @@ static int img_convert(int argc, char **argv)
             int64_t sval;
=20
             sval =3D cvtnum(optarg);
-            if (sval < 0 || sval & (BDRV_SECTOR_SIZE - 1) ||
+            if (sval < 0 || !QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
                 sval / BDRV_SECTOR_SIZE > MAX_BUF_SECTORS) {
                 error_report("Invalid buffer size for sparse output spec=
ified. "
                     "Valid sizes are multiples of %llu up to %llu. Selec=
t "
--=20
2.21.0


