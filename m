Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEDCC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E922175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E922175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqIK-0003Je-L4
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:10:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAK-0004Ti-Fz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAJ-00027l-38
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTqAF-0001sZ-0x; Thu, 23 May 2019 12:01:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B483308792E;
	Thu, 23 May 2019 16:01:39 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-143.ams2.redhat.com
	[10.36.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D06C110027C6;
	Thu, 23 May 2019 16:01:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 23 May 2019 18:01:00 +0200
Message-Id: <20190523160104.21258-12-kwolf@redhat.com>
In-Reply-To: <20190523160104.21258-1-kwolf@redhat.com>
References: <20190523160104.21258-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 23 May 2019 16:01:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 11/15] block: Remove wrong
 bdrv_set_aio_context() calls
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mirror and commit block jobs use bdrv_set_aio_context() to move
their filter node into the right AioContext before hooking it up in the
graph. Similarly, bdrv_open_backing_file() explicitly moves the backing
file node into the right AioContext first.

This isn't necessary any more, they get automatically moved into the
right context now when attaching them.

However, in the case of bdrv_open_backing_file() with a node reference,
it's actually not only unnecessary, but even wrong: The unchecked
bdrv_set_aio_context() changes the AioContext of the child node even if
other parents require it to retain the old context. So this is not only
a simplification, but a bug fix, too.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1684342
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c        | 1 -
 block/commit.c | 2 --
 block/mirror.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/block.c b/block.c
index 19268f52f8..e9261c650d 100644
--- a/block.c
+++ b/block.c
@@ -2539,7 +2539,6 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
         ret =3D -EINVAL;
         goto free_exit;
     }
-    bdrv_set_aio_context(backing_hd, bdrv_get_aio_context(bs));
=20
     if (implicit_backing) {
         bdrv_refresh_filename(backing_hd);
diff --git a/block/commit.c b/block/commit.c
index 4d519506d6..c815def89a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -301,7 +301,6 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
         commit_top_bs->implicit =3D true;
     }
     commit_top_bs->total_sectors =3D top->total_sectors;
-    bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
=20
     bdrv_append(commit_top_bs, top, &local_err);
     if (local_err) {
@@ -443,7 +442,6 @@ int bdrv_commit(BlockDriverState *bs)
         error_report_err(local_err);
         goto ro_cleanup;
     }
-    bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(backing_fil=
e_bs));
=20
     bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
     bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
diff --git a/block/mirror.c b/block/mirror.c
index eb96b52de9..f8bdb5b21b 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1543,7 +1543,6 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
                                           BDRV_REQ_NO_FALLBACK;
     bs_opaque =3D g_new0(MirrorBDSOpaque, 1);
     mirror_top_bs->opaque =3D bs_opaque;
-    bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
=20
     /* bdrv_append takes ownership of the mirror_top_bs reference, need =
to keep
      * it alive until block_job_create() succeeds even if bs has no pare=
nt. */
--=20
2.20.1


