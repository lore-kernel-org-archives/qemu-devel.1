Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB5C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4692054F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4692054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdH19-0000jx-GH
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxo-0008WC-44
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxh-0000z6-00
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxU-0000il-Q6; Tue, 18 Jun 2019 11:23:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 524F33082B69;
 Tue, 18 Jun 2019 15:23:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 700CF5792;
 Tue, 18 Jun 2019 15:23:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:16 +0200
Message-Id: <20190618152318.24953-13-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
References: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 18 Jun 2019 15:23:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/14] block: Ignore loosening perm restrictions
 failures
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
true and an error did occur, we abort the permission update, discard the
error, and instead report success to the caller.

bdrv_child_try_set_perm() itself does not pass &error_abort, but it is
the only public function to change permissions.  As such, callers may
pass &error_abort to it, expecting dropping permission restrictions to
never fail.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 1b10a5ce35..c139540f2b 100644
--- a/block.c
+++ b/block.c
@@ -2121,11 +2121,26 @@ static void bdrv_child_abort_perm_update(BdrvChil=
d *c)
 int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared=
,
                             Error **errp)
 {
+    Error *local_err =3D NULL;
     int ret;
+    bool tighten_restrictions;
=20
-    ret =3D bdrv_child_check_perm(c, NULL, perm, shared, NULL, NULL, err=
p);
+    ret =3D bdrv_child_check_perm(c, NULL, perm, shared, NULL,
+                                &tighten_restrictions, &local_err);
     if (ret < 0) {
         bdrv_child_abort_perm_update(c);
+        if (tighten_restrictions) {
+            error_propagate(errp, local_err);
+        } else {
+            /*
+             * Our caller may intend to only loosen restrictions and
+             * does not expect this function to fail.  Errors are not
+             * fatal in such a case, so we can just hide them from our
+             * caller.
+             */
+            error_free(local_err);
+            ret =3D 0;
+        }
         return ret;
     }
=20
@@ -2308,10 +2323,19 @@ static void bdrv_replace_child(BdrvChild *child, =
BlockDriverState *new_bs)
         /* Update permissions for old node. This is guaranteed to succee=
d
          * because we're just taking a parent away, so we're loosening
          * restrictions. */
+        bool tighten_restrictions;
+        int ret;
+
         bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
-        bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
-                        NULL, &error_abort);
-        bdrv_set_perm(old_bs, perm, shared_perm);
+        ret =3D bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
+                              &tighten_restrictions, NULL);
+        assert(tighten_restrictions =3D=3D false);
+        if (ret < 0) {
+            /* We only tried to loosen restrictions, so errors are not f=
atal */
+            bdrv_abort_perm_update(old_bs);
+        } else {
+            bdrv_set_perm(old_bs, perm, shared_perm);
+        }
=20
         /* When the parent requiring a non-default AioContext is removed=
, the
          * node moves back to the main AioContext */
@@ -5386,6 +5410,7 @@ static bool bdrv_has_bds_parent(BlockDriverState *b=
s, bool only_active)
 static int bdrv_inactivate_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *parent;
+    bool tighten_restrictions;
     uint64_t perm, shared_perm;
     int ret;
=20
@@ -5422,8 +5447,15 @@ static int bdrv_inactivate_recurse(BlockDriverStat=
e *bs)
=20
     /* Update permissions, they may differ for inactive nodes */
     bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &error_abor=
t);
-    bdrv_set_perm(bs, perm, shared_perm);
+    ret =3D bdrv_check_perm(bs, NULL, perm, shared_perm, NULL,
+                          &tighten_restrictions, NULL);
+    assert(tighten_restrictions =3D=3D false);
+    if (ret < 0) {
+        /* We only tried to loosen restrictions, so errors are not fatal=
 */
+        bdrv_abort_perm_update(bs);
+    } else {
+        bdrv_set_perm(bs, perm, shared_perm);
+    }
=20
=20
     /* Recursively inactivate children */
--=20
2.20.1


