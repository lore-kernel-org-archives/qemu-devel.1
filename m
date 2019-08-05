Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE15C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215652064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215652064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hug3k-0004NP-Bh
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hufzn-0006Ke-8I
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hufzm-00062S-7R
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hufzj-0005zC-SE; Mon, 05 Aug 2019 12:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FB523084045;
 Mon,  5 Aug 2019 16:37:59 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDEA25C1D8;
 Mon,  5 Aug 2019 16:37:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  5 Aug 2019 18:37:40 +0200
Message-Id: <20190805163740.23616-8-mreitz@redhat.com>
In-Reply-To: <20190805163740.23616-1-mreitz@redhat.com>
References: <20190805163740.23616-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 05 Aug 2019 16:37:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/7] block/backup: disable copy_range for
 compressed backup
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Enabled by default copy_range ignores compress option. It's definitely
unexpected for user.

It's broken since introduction of copy_range usage in backup in
9ded4a011496.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190730163251.755248-3-vsementsov@virtuozzo.com
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index 1ee271f9f1..b26c22c4b8 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -657,7 +657,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     job->cluster_size =3D cluster_size;
     job->copy_bitmap =3D copy_bitmap;
     copy_bitmap =3D NULL;
-    job->use_copy_range =3D true;
+    job->use_copy_range =3D !compress; /* compression isn't supported fo=
r it */
     job->copy_range_size =3D MIN_NON_ZERO(blk_get_max_transfer(job->comm=
on.blk),
                                         blk_get_max_transfer(job->target=
));
     job->copy_range_size =3D MAX(job->cluster_size,
--=20
2.21.0


