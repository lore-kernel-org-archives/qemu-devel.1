Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AA5C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956EB2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWUK+lQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956EB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxML-00054n-HG
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBW-0003sv-1j
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBS-0006D4-Sk
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBS-0006By-CT
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QQP3dfPP/ckAX9O97zEj5GVOKuJYfirYs2+U727g8Y=;
 b=cWUK+lQ1pSk6+5FTkcY56G1/TV72xocJ1IpxL0BTvfCetcV5KYl65luUYIlUc+zw9Yo0xZ
 MsnIHCMbz7mXEqli8k/sogPTxp90wggjGD8vYABPDMWQhb9yMhZFE9GBBTLv+OvQlYGvVB
 zEds/3hwVJ69qQMzRqWNCwW8s9MI3aU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-_ofcak72O4eZPsjF6fWyXA-1; Wed, 27 Nov 2019 08:16:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E6F105047A;
 Wed, 27 Nov 2019 13:16:39 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B4E95C219;
 Wed, 27 Nov 2019 13:16:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 05/31] block: Drop BdrvChildClass.stay_at_node
Date: Wed, 27 Nov 2019 14:15:58 +0100
Message-Id: <20191127131624.1062403-6-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _ofcak72O4eZPsjF6fWyXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should better be in BdrvChildRole so that parents can decide when
to and when not to keep the child node fixed.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 2 +-
 blockjob.c                | 3 +--
 include/block/block_int.h | 4 ----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 90974ae36b..6c50ad661e 100644
--- a/block.c
+++ b/block.c
@@ -4103,7 +4103,7 @@ static bool should_update_child(BdrvChild *c, BlockDr=
iverState *to)
     GHashTable *found;
     bool ret;
=20
-    if (c->klass->stay_at_node) {
+    if (c->role & BDRV_CHILD_STAY_AT_NODE) {
         return false;
     }
=20
diff --git a/blockjob.c b/blockjob.c
index e7dbb4093a..f58356fb6c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -170,7 +170,6 @@ static const BdrvChildClass child_job =3D {
     .drained_end        =3D child_job_drained_end,
     .can_set_aio_ctx    =3D child_job_can_set_aio_ctx,
     .set_aio_ctx        =3D child_job_set_aio_ctx,
-    .stay_at_node       =3D true,
 };
=20
 void block_job_remove_all_bdrv(BlockJob *job)
@@ -217,7 +216,7 @@ int block_job_add_bdrv(BlockJob *job, const char *name,=
 BlockDriverState *bs,
     if (job->job.aio_context !=3D qemu_get_aio_context()) {
         aio_context_release(job->job.aio_context);
     }
-    c =3D bdrv_root_attach_child(bs, name, &child_job, 0,
+    c =3D bdrv_root_attach_child(bs, name, &child_job, BDRV_CHILD_STAY_AT_=
NODE,
                                job->job.aio_context, perm, shared_perm, jo=
b,
                                errp);
     if (job->job.aio_context !=3D qemu_get_aio_context()) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 85cfa4b069..102ce7853e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -660,10 +660,6 @@ typedef struct BdrvAioNotifier {
 } BdrvAioNotifier;
=20
 struct BdrvChildClass {
-    /* If true, bdrv_replace_node() doesn't change the node this BdrvChild
-     * points to. */
-    bool stay_at_node;
-
     /* If true, the parent is a BlockDriverState and bdrv_next_all_states(=
)
      * will return it. This information is used for drain_all, where every=
 node
      * will be drained separately, so the drain only needs to be propagate=
d to
--=20
2.23.0


