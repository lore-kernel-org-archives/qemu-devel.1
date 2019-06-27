Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9DC4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423602063F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423602063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgcz0-0002Yb-A5
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 18:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hgcxQ-0000KG-JX
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hgcxN-0004Ea-Ua
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:33:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hgcxH-0003xl-Ca; Thu, 27 Jun 2019 18:33:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C1C5D65CE2;
 Thu, 27 Jun 2019 22:33:08 +0000 (UTC)
Received: from localhost (ovpn-204-47.brq.redhat.com [10.40.204.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DBDC608C1;
 Thu, 27 Jun 2019 22:33:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 28 Jun 2019 00:32:51 +0200
Message-Id: <20190627223255.3789-2-mreitz@redhat.com>
In-Reply-To: <20190627223255.3789-1-mreitz@redhat.com>
References: <20190627223255.3789-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 27 Jun 2019 22:33:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/5] block: Add BDS.never_freeze
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit and the mirror block job must be able to drop their filter
node at any point.  However, this will not be possible if any of the
BdrvChild links to them is frozen.  Therefore, we need to prevent them
from ever becoming frozen.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 3 +++
 block.c                   | 8 ++++++++
 block/commit.c            | 4 ++++
 block/mirror.c            | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index d6415b53c1..50902531b7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -885,6 +885,9 @@ struct BlockDriverState {
=20
     /* Only read/written by whoever has set active_flush_req to true.  *=
/
     unsigned int flushed_gen;             /* Flushed write generation */
+
+    /* BdrvChild links to this node may never be frozen */
+    bool never_freeze;
 };
=20
 struct BlockBackendRootState {
diff --git a/block.c b/block.c
index c139540f2b..6565192b91 100644
--- a/block.c
+++ b/block.c
@@ -4416,6 +4416,14 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs=
, BlockDriverState *base,
         return -EPERM;
     }
=20
+    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
+        if (i->backing && backing_bs(i)->never_freeze) {
+            error_setg(errp, "Cannot freeze '%s' link to '%s'",
+                       i->backing->name, backing_bs(i)->node_name);
+            return -EPERM;
+        }
+    }
+
     for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
         if (i->backing) {
             i->backing->frozen =3D true;
diff --git a/block/commit.c b/block/commit.c
index ca7e408b26..2c5a6d4ebc 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -298,6 +298,10 @@ void commit_start(const char *job_id, BlockDriverSta=
te *bs,
     if (!filter_node_name) {
         commit_top_bs->implicit =3D true;
     }
+
+    /* So that we can always drop this node */
+    commit_top_bs->never_freeze =3D true;
+
     commit_top_bs->total_sectors =3D top->total_sectors;
=20
     bdrv_append(commit_top_bs, top, &local_err);
diff --git a/block/mirror.c b/block/mirror.c
index 2fcec70e35..8cb75fb409 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1551,6 +1551,10 @@ static BlockJob *mirror_start_job(
     if (!filter_node_name) {
         mirror_top_bs->implicit =3D true;
     }
+
+    /* So that we can always drop this node */
+    mirror_top_bs->never_freeze =3D true;
+
     mirror_top_bs->total_sectors =3D bs->total_sectors;
     mirror_top_bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED;
     mirror_top_bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
--=20
2.21.0


