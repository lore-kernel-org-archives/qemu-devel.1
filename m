Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E23C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1242081C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1242081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTUmX-0000Tx-Ei
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 13:12:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUfI-0003ey-Sb
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUfH-0007vK-Og
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTUfC-0007mQ-MN; Wed, 22 May 2019 13:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECD7A8667A;
	Wed, 22 May 2019 17:04:14 +0000 (UTC)
Received: from localhost (ovpn-204-123.brq.redhat.com [10.40.204.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 83E84600C0;
	Wed, 22 May 2019 17:04:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 22 May 2019 19:03:49 +0200
Message-Id: <20190522170352.12020-6-mreitz@redhat.com>
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>
References: <20190522170352.12020-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 22 May 2019 17:04:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 5/8] block: Fix order in bdrv_replace_child()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have to start by applying the permission restrictions to new_bs
before we can loosen them on old_bs.  See the comment for the
explanation.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 02157e0652..3029f5c302 100644
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
@@ -2248,11 +2261,6 @@ static void bdrv_replace_child(BdrvChild *child, B=
lockDriverState *new_bs)
         bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL, &error_ab=
ort);
         bdrv_set_perm(old_bs, perm, shared_perm);
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
2.21.0


