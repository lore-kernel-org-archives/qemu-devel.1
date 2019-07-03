Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBC9C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0725021881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0725021881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijEa-0001I7-BH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hij3y-0007p3-Dx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hij3x-00006C-GS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hij3u-0007yC-UG; Wed, 03 Jul 2019 13:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7589B369A0;
 Wed,  3 Jul 2019 17:28:29 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10B7E1001B35;
 Wed,  3 Jul 2019 17:28:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  3 Jul 2019 19:28:07 +0200
Message-Id: <20190703172813.6868-7-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
References: <20190703172813.6868-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 03 Jul 2019 17:28:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/12] block: Deep-clear inherits_from
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BDS.inherits_from does not always point to an immediate parent node.
When launching a block job with a filter node, for example, the node
directly below the filter will not point to the filter, but keep its old
pointee (above the filter).

If that pointee goes away while the job is still running, the node's
inherits_from will not be updated and thus point to garbage.  To fix
this, bdrv_unref_child() has to check not only the parent node's
immediate children for nodes whose inherits_from needs to be cleared,
but its whole subtree.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 1fc9e709ad..5f5a06eb7d 100644
--- a/block.c
+++ b/block.c
@@ -2493,18 +2493,20 @@ void bdrv_root_unref_child(BdrvChild *child)
     bdrv_unref(child_bs);
 }
=20
-void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
+/**
+ * Clear all inherits_from pointers from children and grandchildren of
+ * @root that point to @root, where necessary.
+ */
+static void bdrv_unset_inherits_from(BlockDriverState *root, BdrvChild *=
child)
 {
-    if (child =3D=3D NULL) {
-        return;
-    }
-
-    if (child->bs->inherits_from =3D=3D parent) {
-        BdrvChild *c;
+    BdrvChild *c;
=20
-        /* Remove inherits_from only when the last reference between par=
ent and
-         * child->bs goes away. */
-        QLIST_FOREACH(c, &parent->children, next) {
+    if (child->bs->inherits_from =3D=3D root) {
+        /*
+         * Remove inherits_from only when the last reference between roo=
t and
+         * child->bs goes away.
+         */
+        QLIST_FOREACH(c, &root->children, next) {
             if (c !=3D child && c->bs =3D=3D child->bs) {
                 break;
             }
@@ -2514,6 +2516,18 @@ void bdrv_unref_child(BlockDriverState *parent, Bd=
rvChild *child)
         }
     }
=20
+    QLIST_FOREACH(c, &child->bs->children, next) {
+        bdrv_unset_inherits_from(root, c);
+    }
+}
+
+void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
+{
+    if (child =3D=3D NULL) {
+        return;
+    }
+
+    bdrv_unset_inherits_from(parent, child);
     bdrv_root_unref_child(child);
 }
=20
--=20
2.21.0


