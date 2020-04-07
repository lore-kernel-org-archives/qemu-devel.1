Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28523C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62C52078C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HewoupjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62C52078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLpCy-0002zS-36
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLpBx-0001Dv-7N
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLpBv-0007Ic-7k
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:27:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLpBv-0007IT-50
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586269622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdR86qhHe1uxu++4yPJ0hB+9l58TZF1dgQH78D6dqRQ=;
 b=HewoupjShwoOWvkw+xDRbd/w68Nw468TADgtAdSJiULWN1u9rx95ABoNeGJOLZGkDLKid3
 bshWvzeCrpB59dNvKnkSECOQ1kYK4luYLk7yOCkOL5a9VSLXRd9kSxHWMOmIN2qLGLEfF1
 qo/n71ZfTpilk8wkIZ5qIS37uGwZCmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-O-AYAPH6OKORbUKs-ue0vQ-1; Tue, 07 Apr 2020 10:26:33 -0400
X-MC-Unique: O-AYAPH6OKORbUKs-ue0vQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E471034AE4;
 Tue,  7 Apr 2020 14:26:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A89695DA60;
 Tue,  7 Apr 2020 14:26:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/7] replication: assert we own context before job_cancel_sync
Date: Tue,  7 Apr 2020 16:26:11 +0200
Message-Id: <20200407142616.7961-3-kwolf@redhat.com>
In-Reply-To: <20200407142616.7961-1-kwolf@redhat.com>
References: <20200407142616.7961-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Reiter <s.reiter@proxmox.com>

job_cancel_sync requires the job's lock to be held, all other callers
already do this (replication_stop, drive_backup_abort,
blockdev_backup_abort, job_cancel_sync_all, cancel_common).

In this case we're in a BlockDriver handler, so we already have a lock,
just assert that it is the same as the one used for the commit_job.

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
Message-Id: <20200407115651.69472-3-s.reiter@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/replication.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/replication.c b/block/replication.c
index 413d95407d..da013c2041 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -144,12 +144,15 @@ fail:
 static void replication_close(BlockDriverState *bs)
 {
     BDRVReplicationState *s =3D bs->opaque;
+    Job *commit_job;
=20
     if (s->stage =3D=3D BLOCK_REPLICATION_RUNNING) {
         replication_stop(s->rs, false, NULL);
     }
     if (s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
-        job_cancel_sync(&s->commit_job->job);
+        commit_job =3D &s->commit_job->job;
+        assert(commit_job->aio_context =3D=3D qemu_get_current_aio_context=
());
+        job_cancel_sync(commit_job);
     }
=20
     if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
--=20
2.20.1


