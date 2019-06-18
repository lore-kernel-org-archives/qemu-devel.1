Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF8DC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440C820B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440C820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGrk-0007d0-Gf
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxm-0008T1-Qx
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxh-0000zS-7I
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxY-0000lF-Qf; Tue, 18 Jun 2019 11:23:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED34D30001D8;
 Tue, 18 Jun 2019 15:23:35 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 199C719492;
 Tue, 18 Jun 2019 15:23:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:14 +0200
Message-Id: <20190618152318.24953-11-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
References: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 18 Jun 2019 15:23:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/14] block: Fix order in bdrv_replace_child()
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

We have to start by applying the permission restrictions to new_bs
before we can loosen them on old_bs.  See the comment for the
explanation.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 013369851b..b7d4149c2f 100644
--- a/block.c
+++ b/block.c
@@ -2240,6 +2240,19 @@ static void bdrv_replace_child(BdrvChild *child, B=
lockDriverState *new_bs)
=20
     bdrv_replace_child_noperm(child, new_bs);
=20
+    /*
+     * Start with the new node's permissions.  If @new_bs is a (direct
+     * or indirect) child of @old_bs, we must complete the permission
+     * update on @new_bs before we loosen the restrictions on @old_bs.
+     * Otherwise, bdrv_check_perm() on @old_bs would re-initiate
+     * updating the permissions of @new_bs, and thus not purely loosen
+     * restrictions.
+     */
+    if (new_bs) {
+        bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
+        bdrv_set_perm(new_bs, perm, shared_perm);
+    }
+
     if (old_bs) {
         /* Update permissions for old node. This is guaranteed to succee=
d
          * because we're just taking a parent away, so we're loosening
@@ -2252,11 +2265,6 @@ static void bdrv_replace_child(BdrvChild *child, B=
lockDriverState *new_bs)
          * node moves back to the main AioContext */
         bdrv_try_set_aio_context(old_bs, qemu_get_aio_context(), NULL);
     }
-
-    if (new_bs) {
-        bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
-        bdrv_set_perm(new_bs, perm, shared_perm);
-    }
 }
=20
 /*
--=20
2.20.1


