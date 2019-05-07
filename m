Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60137C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D68206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D68206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48614 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO223-00015j-ET
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:29:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rm-00086D-4M
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rl-00045b-7W
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1ri-00043c-JF; Tue, 07 May 2019 11:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2A53308793B;
	Tue,  7 May 2019 15:18:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A4D2173D9;
	Tue,  7 May 2019 15:18:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:18 +0200
Message-Id: <20190507151819.17401-11-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 07 May 2019 15:18:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/11] commit: Use bdrv_append() in
 commit_start()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

This function combines bdrv_set_backing_hd() and bdrv_replace_node()
so we can use it to simplify the code a bit in commit_start().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20190403143748.9790-1-berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/commit.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 27537d995b..14e5bb394c 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -303,23 +303,14 @@ void commit_start(const char *job_id, BlockDriverSt=
ate *bs,
     commit_top_bs->total_sectors =3D top->total_sectors;
     bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
=20
-    bdrv_set_backing_hd(commit_top_bs, top, &local_err);
+    bdrv_append(commit_top_bs, top, &local_err);
     if (local_err) {
-        bdrv_unref(commit_top_bs);
-        commit_top_bs =3D NULL;
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-    bdrv_replace_node(top, commit_top_bs, &local_err);
-    if (local_err) {
-        bdrv_unref(commit_top_bs);
         commit_top_bs =3D NULL;
         error_propagate(errp, local_err);
         goto fail;
     }
=20
     s->commit_top_bs =3D commit_top_bs;
-    bdrv_unref(commit_top_bs);
=20
     /* Block all nodes between top and base, because they will
      * disappear from the chain after this operation. */
--=20
2.20.1


