Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C32C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC52D213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC52D213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGhh-00070A-0X
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56082)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxb-00086F-P2
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxZ-0000pv-3g
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxO-0000dD-W4; Tue, 18 Jun 2019 11:23:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B058307D935;
 Tue, 18 Jun 2019 15:23:33 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7E8E19492;
 Tue, 18 Jun 2019 15:23:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:12 +0200
Message-Id: <20190618152318.24953-9-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
References: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 18 Jun 2019 15:23:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/14] block/mirror: Fix child permissions
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

From: Max Reitz <mreitz@redhat.com>

We cannot use bdrv_child_try_set_perm() to give up all restrictions on
the child edge, and still have bdrv_mirror_top_child_perm() request
BLK_PERM_WRITE.  Fix this by making bdrv_mirror_top_child_perm() return
0/BLK_PERM_ALL when we want to give up all permissions, and replacing
bdrv_child_try_set_perm() by bdrv_child_refresh_perms().

The bdrv_child_try_set_perm() before removing the node with
bdrv_replace_node() is then unnecessary.  No permissions have changed
since the previous invocation of bdrv_child_try_set_perm().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b5878ba574..d17be4cdbc 100644
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
@@ -1459,6 +1460,18 @@ static void bdrv_mirror_top_child_perm(BlockDriver=
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
@@ -1681,8 +1694,9 @@ fail:
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


