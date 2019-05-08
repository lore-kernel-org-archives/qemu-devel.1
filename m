Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A2C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F712175B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F712175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hORKP-0007uS-46
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 14:30:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hORH2-0004vT-C7
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hORH1-0003ag-9O
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hORGv-0003Gi-Ud; Wed, 08 May 2019 14:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5E2381F25;
	Wed,  8 May 2019 18:26:19 +0000 (UTC)
Received: from localhost (ovpn-204-94.brq.redhat.com [10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E548B600CC;
	Wed,  8 May 2019 18:26:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 20:25:46 +0200
Message-Id: <20190508182546.2239-8-mreitz@redhat.com>
In-Reply-To: <20190508182546.2239-1-mreitz@redhat.com>
References: <20190508182546.2239-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 08 May 2019 18:26:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 7/7] block: Ignore loosening perm
 restrictions failures
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
index 8f517be5b4..a5a03906d0 100644
--- a/block.c
+++ b/block.c
@@ -2088,11 +2088,20 @@ static void bdrv_child_abort_perm_update(BdrvChil=
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
+            warn_reportf_err(local_err, "Failed to loosen restrictions: =
");
+            ret =3D 0;
+        }
         return ret;
     }
=20
@@ -2275,10 +2284,20 @@ static void bdrv_replace_child(BdrvChild *child, =
BlockDriverState *new_bs)
         /* Update permissions for old node. This is guaranteed to succee=
d
          * because we're just taking a parent away, so we're loosening
          * restrictions. */
+        bool tighten_restrictions;
+        Error *local_err =3D NULL;
+        int ret;
+
         bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
-        bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
-                        NULL, &error_abort);
-        bdrv_set_perm(old_bs, perm, shared_perm);
+        ret =3D bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
+                              &tighten_restrictions, &local_err);
+        assert(tighten_restrictions =3D=3D false);
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
@@ -5322,7 +5341,9 @@ static bool bdrv_has_bds_parent(BlockDriverState *b=
s, bool only_active)
 static int bdrv_inactivate_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *parent;
+    bool tighten_restrictions;
     uint64_t perm, shared_perm;
+    Error *local_err =3D NULL;
     int ret;
=20
     if (!bs->drv) {
@@ -5358,8 +5379,15 @@ static int bdrv_inactivate_recurse(BlockDriverStat=
e *bs)
=20
     /* Update permissions, they may differ for inactive nodes */
     bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &error_abor=
t);
-    bdrv_set_perm(bs, perm, shared_perm);
+    ret =3D bdrv_check_perm(bs, NULL, perm, shared_perm, NULL,
+                          &tighten_restrictions, &local_err);
+    assert(tighten_restrictions =3D=3D false);
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


