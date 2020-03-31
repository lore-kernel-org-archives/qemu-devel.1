Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04D820838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04D820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFun-0000MW-4m
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <s.reiter@proxmox.com>) id 1jJFt6-0006hz-6s
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <s.reiter@proxmox.com>) id 1jJFt5-00086D-8S
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:21:00 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:19101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <s.reiter@proxmox.com>)
 id 1jJFt2-00081S-S2; Tue, 31 Mar 2020 08:20:57 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DCC5F456DF;
 Tue, 31 Mar 2020 14:20:51 +0200 (CEST)
From: Stefan Reiter <s.reiter@proxmox.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v3 2/3] replication: acquire aio context before calling
 job_cancel_sync
Date: Tue, 31 Mar 2020 14:20:44 +0200
Message-Id: <20200331122045.164356-3-s.reiter@proxmox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331122045.164356-1-s.reiter@proxmox.com>
References: <20200331122045.164356-1-s.reiter@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, slp@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

job_cancel_sync requires the job's lock to be held, all other callers
already do this (replication_stop, drive_backup_abort,
blockdev_backup_abort, job_cancel_sync_all, cancel_common).

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
---
 block/replication.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/replication.c b/block/replication.c
index 413d95407d..6c809cda4e 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -144,12 +144,16 @@ fail:
 static void replication_close(BlockDriverState *bs)
 {
     BDRVReplicationState *s =3D bs->opaque;
+    Job *commit_job =3D &s->commit_job->job;
+    AioContext *commit_ctx =3D commit_job->aio_context;
=20
     if (s->stage =3D=3D BLOCK_REPLICATION_RUNNING) {
         replication_stop(s->rs, false, NULL);
     }
     if (s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
-        job_cancel_sync(&s->commit_job->job);
+        aio_context_acquire(commit_ctx);
+        job_cancel_sync(commit_job);
+        aio_context_release(commit_ctx);
     }
=20
     if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
--=20
2.26.0



