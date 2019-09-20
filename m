Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107B02086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107B02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLK6-0003Ba-Nn
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpo-0000ub-5Z
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpl-0004W1-FK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpi-0004Uj-Of; Fri, 20 Sep 2019 11:28:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1643B18C890D;
 Fri, 20 Sep 2019 15:28:30 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C59A60606;
 Fri, 20 Sep 2019 15:28:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
Date: Fri, 20 Sep 2019 17:27:52 +0200
Message-Id: <20190920152804.12875-11-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 20 Sep 2019 15:28:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index 207054a64e..81b57dbae2 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(Block=
DriverState *bs,
     return false;
 }
=20
+static bool quorum_recurse_can_replace(BlockDriverState *bs,
+                                       BlockDriverState *to_replace)
+{
+    BDRVQuorumState *s =3D bs->opaque;
+    int i;
+
+    for (i =3D 0; i < s->num_children; i++) {
+        /*
+         * We have no idea whether our children show the same data as
+         * this node (@bs).  It is actually highly likely that
+         * @to_replace does not, because replacing a broken child is
+         * one of the main use cases here.
+         *
+         * We do know that the new BDS will match @bs, so replacing
+         * any of our children by it will be safe.  It cannot change
+         * the data this quorum node presents to its parents.
+         *
+         * However, replacing @to_replace by @bs in any of our
+         * children's chains may change visible data somewhere in
+         * there.  We therefore cannot recurse down those chains with
+         * bdrv_recurse_can_replace().
+         * (More formally, bdrv_recurse_can_replace() requires that
+         * @to_replace will be replaced by something matching the @bs
+         * passed to it.  We cannot guarantee that.)
+         *
+         * Thus, we can only check whether any of our immediate
+         * children matches @to_replace.
+         *
+         * (In the future, we might add a function to recurse down a
+         * chain that checks that nothing there cares about a change
+         * in data from the respective child in question.  For
+         * example, most filters do not care when their child's data
+         * suddenly changes, as long as their parents do not care.)
+         */
+        if (s->children[i].child->bs =3D=3D to_replace) {
+            Error *local_err =3D NULL;
+
+            /*
+             * We now have to ensure that there is no other parent
+             * that cares about replacing this child by a node with
+             * potentially different data.
+             */
+            s->children[i].to_be_replaced =3D true;
+            bdrv_child_refresh_perms(bs, s->children[i].child, &local_er=
r);
+
+            /* Revert permissions */
+            s->children[i].to_be_replaced =3D false;
+            bdrv_child_refresh_perms(bs, s->children[i].child, &error_ab=
ort);
+
+            if (local_err) {
+                error_free(local_err);
+                return false;
+            }
+
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static int quorum_valid_threshold(int threshold, int num_children, Error=
 **errp)
 {
=20
@@ -1195,6 +1256,7 @@ static BlockDriver bdrv_quorum =3D {
=20
     .is_filter                          =3D true,
     .bdrv_recurse_is_first_non_filter   =3D quorum_recurse_is_first_non_=
filter,
+    .bdrv_recurse_can_replace           =3D quorum_recurse_can_replace,
=20
     .strong_runtime_opts                =3D quorum_strong_runtime_opts,
 };
--=20
2.21.0


