Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5211DECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0D220CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0D220CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7zUk-0000T5-Ac
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 06:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7zTG-0007Nn-6y
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7zTF-0004nP-2D
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:03:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7zTA-0004m6-Cb; Wed, 11 Sep 2019 06:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 740C5315C02D;
 Wed, 11 Sep 2019 10:03:22 +0000 (UTC)
Received: from localhost (ovpn-116-94.ams2.redhat.com [10.36.116.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 175656012A;
 Wed, 11 Sep 2019 10:03:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 11 Sep 2019 12:03:16 +0200
Message-Id: <20190911100316.32282-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 11 Sep 2019 10:03:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3] blockjob: update nodes head while removing
 all bdrv
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

block_job_remove_all_bdrv() iterates through job->nodes, calling
bdrv_root_unref_child() for each entry. The call to the latter may
reach child_job_[can_]set_aio_ctx(), which will also attempt to
traverse job->nodes, potentially finding entries that where freed
on previous iterations.

To avoid this situation, update job->nodes head on each iteration to
ensure that already freed entries are no longer linked to the list.

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1746631
Signed-off-by: Sergio Lopez <slp@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
v3:
- Rewrote the loop to make the whole function a bit simpler
  (Also, remove the node from the job->nodes list before unref'ing it,
  just to be extra-safe)
---
 blockjob.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 2abed0f551..c6e20e2fcd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -175,14 +175,23 @@ static const BdrvChildRole child_job =3D {
=20
 void block_job_remove_all_bdrv(BlockJob *job)
 {
-    GSList *l;
-    for (l =3D job->nodes; l; l =3D l->next) {
+    /*
+     * bdrv_root_unref_child() may reach child_job_[can_]set_aio_ctx(),
+     * which will also traverse job->nodes, so consume the list one by
+     * one to make sure that such a concurrent access does not attempt
+     * to process an already freed BdrvChild.
+     */
+    while (job->nodes) {
+        GSList *l =3D job->nodes;
         BdrvChild *c =3D l->data;
+
+        job->nodes =3D l->next;
+
         bdrv_op_unblock_all(c->bs, job->blocker);
         bdrv_root_unref_child(c);
+
+        g_slist_free_1(l);
     }
-    g_slist_free(job->nodes);
-    job->nodes =3D NULL;
 }
=20
 bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
--=20
2.21.0


