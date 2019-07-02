Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C680AC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF96216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF96216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiANJ-0004RX-UD
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51941)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hi8hl-0004HG-C8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hi8hi-0007MZ-Si
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hi8hV-00074T-CS; Mon, 01 Jul 2019 22:39:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A650B307D914;
 Tue,  2 Jul 2019 02:39:17 +0000 (UTC)
Received: from localhost (ovpn-204-243.brq.redhat.com [10.40.204.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13AB218386;
 Tue,  2 Jul 2019 02:39:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  2 Jul 2019 04:39:05 +0200
Message-Id: <20190702023905.32470-5-mreitz@redhat.com>
In-Reply-To: <20190702023905.32470-1-mreitz@redhat.com>
References: <20190702023905.32470-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 02 Jul 2019 02:39:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/4] block/stream: introduce a bottom node
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

The bottom node is the intermediate block device that has the base as its
backing image. It is used instead of the base node while a block stream
job is running to avoid dependency on the base that may change due to the
parallel jobs. The change may take place due to a filter node as well tha=
t
is inserted between the base and the intermediate bottom node. It occurs
when the base node is the top one for another commit or stream job.
After the introduction of the bottom node, don't freeze its backing child=
,
that's the base, anymore.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 1559152576-281803-4-git-send-email-andrey.shinkevich@virtuozz=
o.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/stream.c         | 43 ++++++++++++++++++++++--------------------
 tests/qemu-iotests/245 |  4 ++--
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 65b13b27e0..cd5e2ba9b0 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -31,7 +31,7 @@ enum {
=20
 typedef struct StreamBlockJob {
     BlockJob common;
-    BlockDriverState *base;
+    BlockDriverState *bottom;
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
@@ -54,7 +54,7 @@ static void stream_abort(Job *job)
=20
     if (s->chain_frozen) {
         BlockJob *bjob =3D &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
+        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
     }
 }
=20
@@ -63,11 +63,11 @@ static int stream_prepare(Job *job)
     StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob =3D &s->common;
     BlockDriverState *bs =3D blk_bs(bjob->blk);
-    BlockDriverState *base =3D s->base;
+    BlockDriverState *base =3D backing_bs(s->bottom);
     Error *local_err =3D NULL;
     int ret =3D 0;
=20
-    bdrv_unfreeze_backing_chain(bs, base);
+    bdrv_unfreeze_backing_chain(bs, s->bottom);
     s->chain_frozen =3D false;
=20
     if (bs->backing) {
@@ -110,7 +110,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
     StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk =3D s->common.blk;
     BlockDriverState *bs =3D blk_bs(blk);
-    BlockDriverState *base =3D s->base;
+    bool enable_cor =3D !backing_bs(s->bottom);
     int64_t len;
     int64_t offset =3D 0;
     uint64_t delay_ns =3D 0;
@@ -119,7 +119,8 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
     int64_t n =3D 0; /* bytes */
     void *buf;
=20
-    if (!bs->backing) {
+    if (bs =3D=3D s->bottom) {
+        /* Nothing to stream */
         return 0;
     }
=20
@@ -136,7 +137,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
      * backing chain since the copy-on-read operation does not take base=
 into
      * account.
      */
-    if (!base) {
+    if (enable_cor) {
         bdrv_enable_copy_on_read(bs);
     }
=20
@@ -159,9 +160,8 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
         } else if (ret >=3D 0) {
             /* Copy if allocated in the intermediate images.  Limit to t=
he
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE=
).  */
-            ret =3D bdrv_is_allocated_above(backing_bs(bs), base, false,
+            ret =3D bdrv_is_allocated_above(backing_bs(bs), s->bottom, t=
rue,
                                           offset, n, &n);
-
             /* Finish early if end of backing file has been reached */
             if (ret =3D=3D 0 && n =3D=3D 0) {
                 n =3D len - offset;
@@ -198,7 +198,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
         }
     }
=20
-    if (!base) {
+    if (enable_cor) {
         bdrv_disable_copy_on_read(bs);
     }
=20
@@ -230,8 +230,10 @@ void stream_start(const char *job_id, BlockDriverSta=
te *bs,
     StreamBlockJob *s;
     BlockDriverState *iter;
     bool bs_read_only;
+    int basic_flags =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHAN=
GED;
+    BlockDriverState *bottom =3D bdrv_find_overlay(bs, base);
=20
-    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
+    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
         return;
     }
=20
@@ -248,10 +250,8 @@ void stream_start(const char *job_id, BlockDriverSta=
te *bs,
      * already have our own plans. Also don't allow resize as the image =
size is
      * queried only at the job start and then cached. */
     s =3D block_job_create(job_id, &stream_job_driver, NULL, bs,
-                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHA=
NGED |
-                         BLK_PERM_GRAPH_MOD,
-                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHA=
NGED |
-                         BLK_PERM_WRITE,
+                         basic_flags | BLK_PERM_GRAPH_MOD,
+                         basic_flags | BLK_PERM_WRITE,
                          speed, creation_flags, NULL, NULL, errp);
     if (!s) {
         goto fail;
@@ -259,15 +259,18 @@ void stream_start(const char *job_id, BlockDriverSt=
ate *bs,
=20
     /* Block all intermediate nodes between bs and base, because they wi=
ll
      * disappear from the chain after this operation. The streaming job =
reads
-     * every block only once, assuming that it doesn't change, so block =
writes
-     * and resizes. */
+     * every block only once, assuming that it doesn't change, so forbid=
 writes
+     * and resizes. Reassign the base node pointer because the backing B=
S of the
+     * bottom node might change after the call to bdrv_reopen_set_read_o=
nly()
+     * due to parallel block jobs running.
+     */
+    base =3D backing_bs(bottom);
     for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D backi=
ng_bs(iter)) {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNC=
HANGED,
-                           &error_abort);
+                           basic_flags, &error_abort);
     }
=20
-    s->base =3D base;
+    s->bottom =3D bottom;
     s->backing_file_str =3D g_strdup(backing_file_str);
     s->bs_read_only =3D bs_read_only;
     s->chain_frozen =3D true;
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 349b94aace..bc1ceb9792 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -866,9 +866,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                              auto_finalize =3D False)
         self.assert_qmp(result, 'return', {})
=20
-        # We can't remove hd2 while the stream job is ongoing
+        # We can remove hd2 while the stream job is ongoing
         opts['backing']['backing'] =3D None
-        self.reopen(opts, {}, "Cannot change 'backing' link from 'hd1' t=
o 'hd2'")
+        self.reopen(opts, {})
=20
         # We can't remove hd1 while the stream job is ongoing
         opts['backing'] =3D None
--=20
2.21.0


