Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F01C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881E120896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881E120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBa6-0004nL-N6
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45123)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBRe-0006zh-Aa
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBRd-0007GV-4s
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBRa-0007D9-CT; Wed, 12 Jun 2019 18:10:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E52B30F1BA5;
 Wed, 12 Jun 2019 22:10:09 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69D5D5ED2F;
 Wed, 12 Jun 2019 22:10:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:23 +0200
Message-Id: <20190612221004.2317-2-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 22:10:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 01/42] block: Mark commit and mirror as
 filter drivers
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit and mirror block nodes are filters, so they should be marked
as such.  (Strictly speaking, BDS.is_filter's documentation states that
a filter's child must be bs->file.  The following patch will relax this
restriction, however.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/commit.c | 2 ++
 block/mirror.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index c815def89a..f20a26fecd 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -256,6 +256,8 @@ static BlockDriver bdrv_commit_top =3D {
     .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_commit_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_commit_top_child_perm,
+
+    .is_filter                  =3D true,
 };
=20
 void commit_start(const char *job_id, BlockDriverState *bs,
diff --git a/block/mirror.c b/block/mirror.c
index f8bdb5b21b..4fa8f57c80 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1480,6 +1480,8 @@ static BlockDriver bdrv_mirror_top =3D {
     .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
+
+    .is_filter                  =3D true,
 };
=20
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
--=20
2.21.0


