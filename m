Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB6CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3988D2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7uaowRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3988D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzxs-0003Gn-Iu
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNzvC-0005WK-UX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNzvB-00009x-Qe
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49758
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNzvB-00009h-Nv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geB+6xHxdFggyeS2F0LobGnvUpazIDtEjIYhXgJJVUE=;
 b=P7uaowRfjhMEKPH7tCsYAkawtVVnBJcUO0Rhqe4rBAB85HoDwzITvPGzMyLPai15ZjlyzC
 ZBqwBUmuT10jZul7MCi9JrujySlz/zfsBa4r31bYT4XgdB6sEXk0Q5IkJ7ZjR3ECFepK8B
 WE0r5TwXaTVt7X+yimhedeyiDIqi2x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-u1qOFLUrNOaP8qEht7Rffg-1; Fri, 25 Oct 2019 09:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AB34107AD31;
 Fri, 25 Oct 2019 13:46:25 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 140EF5D70E;
 Fri, 25 Oct 2019 13:46:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 4/7] block/backup: drop dead code from backup_job_create
Date: Fri, 25 Oct 2019 15:46:08 +0200
Message-Id: <20191025134611.25920-5-kwolf@redhat.com>
In-Reply-To: <20191025134611.25920-1-kwolf@redhat.com>
References: <20191025134611.25920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: u1qOFLUrNOaP8qEht7Rffg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

After commit 00e30f05de1d195, there is no more "goto error" points
after job creation, so after "error:" @job is always NULL and we don't
need roll-back job creation.

Reported-by: Coverity (CID 1406402)
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index dddcf77f53..cf62b1a38c 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -474,10 +474,7 @@ BlockJob *backup_job_create(const char *job_id, BlockD=
riverState *bs,
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(sync_bitmap, NULL);
     }
-    if (job) {
-        backup_clean(&job->common.job);
-        job_early_fail(&job->common.job);
-    } else if (backup_top) {
+    if (backup_top) {
         bdrv_backup_top_drop(backup_top);
     }
=20
--=20
2.20.1


