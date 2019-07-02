Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D7C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3786A2183F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3786A2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiA8L-0005jt-GM
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hi8hd-0004Cs-2m
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hi8hZ-0007BL-Dx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:39:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43144)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hi8hN-00070A-W2; Mon, 01 Jul 2019 22:39:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4779330C1205;
 Tue,  2 Jul 2019 02:39:12 +0000 (UTC)
Received: from localhost (ovpn-204-243.brq.redhat.com [10.40.204.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B70AD5D71C;
 Tue,  2 Jul 2019 02:39:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  2 Jul 2019 04:39:03 +0200
Message-Id: <20190702023905.32470-3-mreitz@redhat.com>
In-Reply-To: <20190702023905.32470-1-mreitz@redhat.com>
References: <20190702023905.32470-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 02:39:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/4] block: include base when checking image
 chain for block allocation
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

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

This patch is used in the 'block/stream: introduce a bottom node'
that is following. Instead of the base node, the caller may pass
the node that has the base as its backing image to the function
bdrv_is_allocated_above() with a new parameter include_base =3D true
and get rid of the dependency on the base that may change during
commit/stream parallel jobs. Now, if the specified base is not
found in the backing image chain, the QEMU will abort.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 1559152576-281803-2-git-send-email-andrey.shinkevich@virtuozz=
o.com
[mreitz: Squashed in the following as a rebase on conflicting patches:]
Message-id: e3cf99ae-62e9-8b6e-5a06-d3c8b9363b85@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  3 ++-
 block/commit.c        |  2 +-
 block/io.c            | 21 +++++++++++++++------
 block/mirror.c        |  2 +-
 block/qcow2.c         |  3 ++-
 block/replication.c   |  2 +-
 block/stream.c        |  2 +-
 qemu-img.c            |  2 +-
 8 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index f9415ed740..734c9d2f76 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -449,7 +449,8 @@ int bdrv_block_status_above(BlockDriverState *bs, Blo=
ckDriverState *base,
 int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t byte=
s,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *bas=
e,
-                            int64_t offset, int64_t bytes, int64_t *pnum=
);
+                            bool include_base, int64_t offset, int64_t b=
ytes,
+                            int64_t *pnum);
=20
 bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
diff --git a/block/commit.c b/block/commit.c
index 212c6f639e..ca7e408b26 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -174,7 +174,7 @@ static int coroutine_fn commit_run(Job *job, Error **=
errp)
             break;
         }
         /* Copy if allocated above the base */
-        ret =3D bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base),
+        ret =3D bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base),=
 false,
                                       offset, COMMIT_BUFFER_SIZE, &n);
         copy =3D (ret =3D=3D 1);
         trace_commit_one_iteration(s, offset, n, ret);
diff --git a/block/io.c b/block/io.c
index 9ba1bada36..24a18759fd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2295,10 +2295,11 @@ int coroutine_fn bdrv_is_allocated(BlockDriverSta=
te *bs, int64_t offset,
 /*
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
- * Return true if (a prefix of) the given range is allocated in any imag=
e
- * between BASE and TOP (inclusive).  BASE can be NULL to check if the g=
iven
- * offset is allocated in any image of the chain.  Return false otherwis=
e,
- * or negative errno on failure.
+ * Return 1 if (a prefix of) the given range is allocated in any image
+ * between BASE and TOP (BASE is only included if include_base is set).
+ * BASE can be NULL to check if the given offset is allocated in any
+ * image of the chain.  Return 0 otherwise, or negative errno on
+ * failure.
  *
  * 'pnum' is set to the number of bytes (including and immediately
  * following the specified offset) that are known to be in the same
@@ -2310,17 +2311,21 @@ int coroutine_fn bdrv_is_allocated(BlockDriverSta=
te *bs, int64_t offset,
  */
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum=
)
+                            bool include_base, int64_t offset,
+                            int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *intermediate;
     int ret;
     int64_t n =3D bytes;
=20
+    assert(base || !include_base);
+
     intermediate =3D top;
-    while (intermediate && intermediate !=3D base) {
+    while (include_base || intermediate !=3D base) {
         int64_t pnum_inter;
         int64_t size_inter;
=20
+        assert(intermediate);
         ret =3D bdrv_is_allocated(intermediate, offset, bytes, &pnum_int=
er);
         if (ret < 0) {
             return ret;
@@ -2339,6 +2344,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             n =3D pnum_inter;
         }
=20
+        if (intermediate =3D=3D base) {
+            break;
+        }
+
         intermediate =3D backing_bs(intermediate);
     }
=20
diff --git a/block/mirror.c b/block/mirror.c
index d17be4cdbc..2fcec70e35 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -808,7 +808,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlock=
Job *s)
             return 0;
         }
=20
-        ret =3D bdrv_is_allocated_above(bs, base, offset, bytes, &count)=
;
+        ret =3D bdrv_is_allocated_above(bs, base, false, offset, bytes, =
&count);
         if (ret < 0) {
             return ret;
         }
diff --git a/block/qcow2.c b/block/qcow2.c
index 9396d490d5..2a59eb27fe 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2148,7 +2148,8 @@ static bool is_unallocated(BlockDriverState *bs, in=
t64_t offset, int64_t bytes)
 {
     int64_t nr;
     return !bytes ||
-        (!bdrv_is_allocated_above(bs, NULL, offset, bytes, &nr) && nr =3D=
=3D bytes);
+        (!bdrv_is_allocated_above(bs, NULL, false, offset, bytes, &nr) &=
&
+         nr =3D=3D bytes);
 }
=20
 static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
diff --git a/block/replication.c b/block/replication.c
index b41bc507c0..23b2993d74 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -275,7 +275,7 @@ static coroutine_fn int replication_co_writev(BlockDr=
iverState *bs,
     while (remaining_sectors > 0) {
         int64_t count;
=20
-        ret =3D bdrv_is_allocated_above(top->bs, base->bs,
+        ret =3D bdrv_is_allocated_above(top->bs, base->bs, false,
                                       sector_num * BDRV_SECTOR_SIZE,
                                       remaining_sectors * BDRV_SECTOR_SI=
ZE,
                                       &count);
diff --git a/block/stream.c b/block/stream.c
index 1a906fd860..97fddb2608 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -160,7 +160,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
         } else if (ret >=3D 0) {
             /* Copy if allocated in the intermediate images.  Limit to t=
he
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE=
).  */
-            ret =3D bdrv_is_allocated_above(backing_bs(bs), base,
+            ret =3D bdrv_is_allocated_above(backing_bs(bs), base, false,
                                           offset, n, &n);
=20
             /* Finish early if end of backing file has been reached */
diff --git a/qemu-img.c b/qemu-img.c
index 158b3a505f..79983772de 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3518,7 +3518,7 @@ static int img_rebase(int argc, char **argv)
                  * to take action
                  */
                 ret =3D bdrv_is_allocated_above(backing_bs(bs), prefix_c=
hain_bs,
-                                              offset, n, &n);
+                                              false, offset, n, &n);
                 if (ret < 0) {
                     error_report("error while reading image metadata: %s=
",
                                  strerror(-ret));
--=20
2.21.0


