Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB10C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DC720882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DC720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKzO-0008AF-2Z
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpe-0000gB-Re
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpc-0004Pt-OG
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpY-0004M5-D5; Fri, 20 Sep 2019 11:28:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47D68C058CBD;
 Fri, 20 Sep 2019 15:28:18 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D444B60167;
 Fri, 20 Sep 2019 15:28:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 05/22] quorum: Fix child permissions
Date: Fri, 20 Sep 2019 17:27:47 +0200
Message-Id: <20190920152804.12875-6-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 20 Sep 2019 15:28:18 +0000 (UTC)
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

Quorum is not actually a filter.  It cannot share WRITE or RESIZE on its
children.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/quorum.c b/block/quorum.c
index df68adcfaa..17b439056f 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1114,6 +1114,23 @@ static char *quorum_dirname(BlockDriverState *bs, =
Error **errp)
     return NULL;
 }
=20
+static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
+                              const BdrvChildRole *role,
+                              BlockReopenQueue *reopen_queue,
+                              uint64_t perm, uint64_t shared,
+                              uint64_t *nperm, uint64_t *nshared)
+{
+    *nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
+
+    /*
+     * We cannot share RESIZE or WRITE, as this would make the
+     * children differ from each other.
+     */
+    *nshared =3D (shared & (BLK_PERM_CONSISTENT_READ |
+                          BLK_PERM_WRITE_UNCHANGED))
+             | DEFAULT_PERM_UNCHANGED;
+}
+
 static const char *const quorum_strong_runtime_opts[] =3D {
     QUORUM_OPT_VOTE_THRESHOLD,
     QUORUM_OPT_BLKVERIFY,
@@ -1143,7 +1160,7 @@ static BlockDriver bdrv_quorum =3D {
     .bdrv_add_child                     =3D quorum_add_child,
     .bdrv_del_child                     =3D quorum_del_child,
=20
-    .bdrv_child_perm                    =3D bdrv_filter_default_perms,
+    .bdrv_child_perm                    =3D quorum_child_perm,
=20
     .is_filter                          =3D true,
     .bdrv_recurse_is_first_non_filter   =3D quorum_recurse_is_first_non_=
filter,
--=20
2.21.0


