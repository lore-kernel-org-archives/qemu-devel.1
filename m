Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06264C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15E021537
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15E021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1z4-0005dM-Ng
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hn1yi-0004Rt-2B
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hn1yg-0005uB-OS
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hn1yd-0005ry-5t; Mon, 15 Jul 2019 10:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7835C30C0DCF;
 Mon, 15 Jul 2019 14:29:14 +0000 (UTC)
Received: from localhost (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E72E957A1;
 Mon, 15 Jul 2019 14:29:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Jul 2019 16:28:56 +0200
Message-Id: <20190715142905.9078-3-mreitz@redhat.com>
In-Reply-To: <20190715142905.9078-1-mreitz@redhat.com>
References: <20190715142905.9078-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 15 Jul 2019 14:29:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/11] block: Add BDS.never_freeze
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit and the mirror block job must be able to drop their filter
node at any point.  However, this will not be possible if any of the
BdrvChild links to them is frozen.  Therefore, we need to prevent them
from ever becoming frozen.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20190703172813.6868-2-mreitz@redhat.com
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


