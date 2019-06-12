Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158DBC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF72020896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF72020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCCZ-00056s-64
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBT4-0000Cl-V5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBT2-0008Ih-RE
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBSx-0008E4-5K; Wed, 12 Jun 2019 18:11:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 22DDEA3B6F;
 Wed, 12 Jun 2019 22:11:32 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A37B75DEDF;
 Wed, 12 Jun 2019 22:11:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:55 +0200
Message-Id: <20190612221004.2317-34-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 12 Jun 2019 22:11:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 33/42] blockdev: Fix active commit choice
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

We have to perform an active commit whenever the top node has a parent
that has taken the WRITE permission on it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a464cabf9e..5370f3b738 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3294,6 +3294,7 @@ void qmp_block_commit(bool has_job_id, const char *=
job_id, const char *device,
      */
     BlockdevOnError on_error =3D BLOCKDEV_ON_ERROR_REPORT;
     int job_flags =3D JOB_DEFAULT;
+    uint64_t top_perm, top_shared;
=20
     if (!has_speed) {
         speed =3D 0;
@@ -3406,14 +3407,31 @@ void qmp_block_commit(bool has_job_id, const char=
 *job_id, const char *device,
         goto out;
     }
=20
-    if (top_bs =3D=3D bs) {
+    /*
+     * Active commit is required if and only if someone has taken a
+     * WRITE permission on the top node.  Historically, we have always
+     * used active commit for top nodes, so continue that practice.
+     * (Active commit is never really wrong.)
+     */
+    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
+    if (top_perm & BLK_PERM_WRITE ||
+        bdrv_skip_rw_filters(top_bs) =3D=3D bdrv_skip_rw_filters(bs))
+    {
         if (has_backing_file) {
             error_setg(errp, "'backing-file' specified,"
                              " but 'top' is the active layer");
             goto out;
         }
-        commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
-                            job_flags, speed, on_error,
+        if (!has_job_id) {
+            /*
+             * Emulate here what block_job_create() does, because it
+             * is possible that @bs !=3D @top_bs (the block job should
+             * be named after @bs, even if @top_bs is the actual
+             * source)
+             */
+            job_id =3D bdrv_get_device_name(bs);
+        }
+        commit_active_start(job_id, top_bs, base_bs, job_flags, speed, o=
n_error,
                             filter_node_name, NULL, NULL, false, &local_=
err);
     } else {
         BlockDriverState *overlay_bs =3D bdrv_find_overlay(bs, top_bs);
--=20
2.21.0


