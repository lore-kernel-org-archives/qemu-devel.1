Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D7AC04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAF020830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAF020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33217 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNjdN-000658-2H
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 15:50:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjbT-0004ut-Ld
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjbR-0002KP-OC
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hNjbJ-0002Ce-1q; Mon, 06 May 2019 15:48:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E479688302;
	Mon,  6 May 2019 19:48:34 +0000 (UTC)
Received: from localhost (ovpn-204-185.brq.redhat.com [10.40.204.185])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 22B711001DC7;
	Mon,  6 May 2019 19:48:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 21:47:53 +0200
Message-Id: <20190506194753.12464-8-mreitz@redhat.com>
In-Reply-To: <20190506194753.12464-1-mreitz@redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 06 May 2019 19:48:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 7/7] block: Ignore loosening perm restrictions
 failures
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

We generally assume that loosening permission restrictions can never
fail.  We have seen in the past that this assumption is wrong.  This has
led to crashes because we generally pass &error_abort when loosening
permissions.

However, a failure in such a case should actually be handled in quite
the opposite way: It is very much not fatal, so qemu may report it, but
still consider the operation successful.  The only realistic problem is
that qemu may then retain permissions and thus locks on images it
actually does not require.  But again, that is not fatal.

To implement this behavior, we make all functions that change
permissions and that pass &error_abort to the initiating function
(bdrv_check_perm() or bdrv_child_check_perm()) evaluate the
@loosen_restrictions value introduced in the previous patch.  If it is
true and an error did occur, we abort the permission update, report
the error, and report success to the caller.

bdrv_child_try_set_perm() itself does not pass &error_abort, but it is
the only public function to change permissions.  As such, callers may
pass &error_abort to it, expecting dropping permission restrictions to
never fail.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 105866d15a..42a0f3d305 100644
--- a/block.c
+++ b/block.c
@@ -2082,11 +2082,20 @@ static void bdrv_child_abort_perm_update(BdrvChil=
d *c)
 int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared=
,
                             Error **errp)
 {
+    Error *local_err =3D NULL;
     int ret;
+    bool loosen_restrictions;
=20
-    ret =3D bdrv_child_check_perm(c, NULL, perm, shared, NULL, NULL, err=
p);
+    ret =3D bdrv_child_check_perm(c, NULL, perm, shared, NULL,
+                                &loosen_restrictions, &local_err);
     if (ret < 0) {
         bdrv_child_abort_perm_update(c);
+        if (loosen_restrictions) {
+            warn_reportf_err(local_err, "Failed to loosen restrictions: =
");
+            ret =3D 0;
+        } else {
+            error_propagate(errp, local_err);
+        }
         return ret;
     }
=20
@@ -2269,10 +2278,20 @@ static void bdrv_replace_child(BdrvChild *child, =
BlockDriverState *new_bs)
         /* Update permissions for old node. This is guaranteed to succee=
d
          * because we're just taking a parent away, so we're loosening
          * restrictions. */
+        bool loosen_restrictions;
+        Error *local_err =3D NULL;
+        int ret;
+
         bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
-        bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
-                        NULL, &error_abort);
-        bdrv_set_perm(old_bs, perm, shared_perm);
+        ret =3D bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
+                              &loosen_restrictions, &local_err);
+        assert(loosen_restrictions =3D=3D true);
+        if (ret < 0) {
+            warn_reportf_err(local_err, "Failed to loosen restrictions: =
");
+            bdrv_abort_perm_update(old_bs);
+        } else {
+            bdrv_set_perm(old_bs, perm, shared_perm);
+        }
     }
 }
=20
@@ -5316,7 +5335,9 @@ static bool bdrv_has_bds_parent(BlockDriverState *b=
s, bool only_active)
 static int bdrv_inactivate_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *parent;
+    bool loosen_restrictions;
     uint64_t perm, shared_perm;
+    Error *local_err =3D NULL;
     int ret;
=20
     if (!bs->drv) {
@@ -5352,8 +5373,15 @@ static int bdrv_inactivate_recurse(BlockDriverStat=
e *bs)
=20
     /* Update permissions, they may differ for inactive nodes */
     bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &error_abor=
t);
-    bdrv_set_perm(bs, perm, shared_perm);
+    ret =3D bdrv_check_perm(bs, NULL, perm, shared_perm, NULL,
+                          &loosen_restrictions, &local_err);
+    assert(loosen_restrictions =3D=3D true);
+    if (ret < 0) {
+        warn_reportf_err(local_err, "Failed to loosen restrictions: ");
+        bdrv_abort_perm_update(bs);
+    } else {
+        bdrv_set_perm(bs, perm, shared_perm);
+    }
=20
=20
     /* Recursively inactivate children */
--=20
2.20.1


