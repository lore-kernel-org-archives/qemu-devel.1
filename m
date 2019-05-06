Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF0C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39D820830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39D820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNjdL-00063M-Sg
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 15:50:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjb0-0004Xb-GP
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjaz-000238-Gd
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hNjax-00021R-2f; Mon, 06 May 2019 15:48:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 673323079B71;
	Mon,  6 May 2019 19:48:14 +0000 (UTC)
Received: from localhost (ovpn-204-185.brq.redhat.com [10.40.204.185])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FA381758C;
	Mon,  6 May 2019 19:48:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 21:47:49 +0200
Message-Id: <20190506194753.12464-4-mreitz@redhat.com>
In-Reply-To: <20190506194753.12464-1-mreitz@redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 06 May 2019 19:48:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/7] block/mirror: Fix child permissions
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We cannot use bdrv_child_try_set_perm() to give up all restrictions on
the child edge, and still have bdrv_mirror_top_child_perm() request
BLK_PERM_WRITE.  Fix this by making bdrv_mirror_top_child_perm() return
0/BLK_PERM_ALL when we want to give up all permissions, and replacing
bdrv_child_try_set_perm() by bdrv_child_refresh_perms().

The bdrv_child_try_set_perm() before removing the node with
bdrv_replace_node() is then unnecessary.  No permissions have changed
since the previous invocation of bdrv_child_try_set_perm().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index ff15cfb197..e15adce98e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -85,6 +85,7 @@ typedef struct MirrorBlockJob {
=20
 typedef struct MirrorBDSOpaque {
     MirrorBlockJob *job;
+    bool stop;
 } MirrorBDSOpaque;
=20
 struct MirrorOp {
@@ -656,8 +657,9 @@ static int mirror_exit_common(Job *job)
=20
     /* We don't access the source any more. Dropping any WRITE/RESIZE is
      * required before it could become a backing file of target_bs. */
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
+    bs_opaque->stop =3D true;
+    bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
+                             &error_abort);
     if (!abort && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing =3D s->is_none_mode ? src : s->base;
         if (backing_bs(target_bs) !=3D backing) {
@@ -704,13 +706,12 @@ static int mirror_exit_common(Job *job)
     g_free(s->replaces);
     bdrv_unref(target_bs);
=20
-    /* Remove the mirror filter driver from the graph. Before this, get =
rid of
+    /*
+     * Remove the mirror filter driver from the graph. Before this, get =
rid of
      * the blockers on the intermediate nodes so that the resulting stat=
e is
-     * valid. Also give up permissions on mirror_top_bs->backing, which =
might
-     * block the removal. */
+     * valid.
+     */
     block_job_remove_all_bdrv(bjob);
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
=20
     /* We just changed the BDS the job BB refers to (with either or both=
 of the
@@ -1468,6 +1469,18 @@ static void bdrv_mirror_top_child_perm(BlockDriver=
State *bs, BdrvChild *c,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshare=
d)
 {
+    MirrorBDSOpaque *s =3D bs->opaque;
+
+    if (s->stop) {
+        /*
+         * If the job is to be stopped, we do not need to forward
+         * anything to the real image.
+         */
+        *nperm =3D 0;
+        *nshared =3D BLK_PERM_ALL;
+        return;
+    }
+
     /* Must be able to forward guest writes to the real image */
     *nperm =3D 0;
     if (perm & BLK_PERM_WRITE) {
@@ -1687,8 +1700,9 @@ fail:
         job_early_fail(&s->common.job);
     }
=20
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
+    bs_opaque->stop =3D true;
+    bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
+                             &error_abort);
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
=20
     bdrv_unref(mirror_top_bs);
--=20
2.20.1


