Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BDCC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4990208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4990208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41585 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhtR-0005Ps-Ro
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:36:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnz-0001Wm-3m
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnw-0001v7-02
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhnY-000126-2G; Tue, 28 May 2019 15:30:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FD4A2E97DA;
	Tue, 28 May 2019 19:29:28 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ACAB51972A;
	Tue, 28 May 2019 19:29:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:40 +0200
Message-Id: <20190528192847.2730-15-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 28 May 2019 19:29:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/21] block: Use bdrv_unref_child() for all
 children in bdrv_close()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

bdrv_unref_child() does the following things:

  - Updates the child->bs->inherits_from pointer.
  - Calls bdrv_detach_child() to remove the BdrvChild from bs->children.
  - Calls bdrv_unref() to unref the child BlockDriverState.

When bdrv_unref_child() was introduced in commit 33a604075c it was not
used in bdrv_close() because the drivers that had additional children
(like quorum or blkverify) had already called bdrv_unref() on their
children during their own close functions.

This was changed later (in 0bd6e91a7e for quorum, in 3e586be0b2 for
blkverify) so there's no reason not to use bdrv_unref_child() in
bdrv_close() anymore.

After this there's also no need to remove bs->backing and bs->file
separately from the rest of the children, so bdrv_close() can be
simplified.

Now bdrv_close() unrefs all children (before this patch it was only
bs->file and bs->backing). As a result, none of the callers of
brvd_attach_child() should remove their reference to child_bs (because
this function effectively steals that reference). This patch updates a
couple of tests that were doing their own bdrv_unref().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 6d1d5feaa53aa1ab127adb73d605dc4503e3abd5.1557754872.git.berto=
@igalia.com
[mreitz: s/where/were/]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                     | 16 +++-------------
 tests/test-bdrv-drain.c     |  6 ------
 tests/test-bdrv-graph-mod.c |  1 -
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/block.c b/block.c
index cb11537029..be37280dc7 100644
--- a/block.c
+++ b/block.c
@@ -3877,22 +3877,12 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv =3D NULL;
     }
=20
-    bdrv_set_backing_hd(bs, NULL, &error_abort);
-
-    if (bs->file !=3D NULL) {
-        bdrv_unref_child(bs, bs->file);
-        bs->file =3D NULL;
-    }
-
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-        /* TODO Remove bdrv_unref() from drivers' close function and use
-         * bdrv_unref_child() here */
-        if (child->bs->inherits_from =3D=3D bs) {
-            child->bs->inherits_from =3D NULL;
-        }
-        bdrv_detach_child(child);
+        bdrv_unref_child(bs, child);
     }
=20
+    bs->backing =3D NULL;
+    bs->file =3D NULL;
     g_free(bs->opaque);
     bs->opaque =3D NULL;
     atomic_set(&bs->copy_on_read, 0);
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index eda90750eb..5534c2adf9 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1436,12 +1436,6 @@ static void test_detach_indirect(bool by_parent_cb=
)
     bdrv_unref(parent_b);
     blk_unref(blk);
=20
-    /* XXX Once bdrv_close() unref's children instead of just detaching =
them,
-     * this won't be necessary any more. */
-    bdrv_unref(a);
-    bdrv_unref(a);
-    bdrv_unref(c);
-
     g_assert_cmpint(a->refcnt, =3D=3D, 1);
     g_assert_cmpint(b->refcnt, =3D=3D, 1);
     g_assert_cmpint(c->refcnt, =3D=3D, 1);
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 283dc84869..747c0bf8fc 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -116,7 +116,6 @@ static void test_update_perm_tree(void)
     g_assert_nonnull(local_err);
     error_free(local_err);
=20
-    bdrv_unref(bs);
     blk_unref(root);
 }
=20
--=20
2.21.0


