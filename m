Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B6BC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACBE20B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACBE20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huyAy-0005Xe-OK
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 08:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60662)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1huy96-0002Hy-V2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1huy96-0002BI-1f
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:00:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1huy93-00029W-Ov; Tue, 06 Aug 2019 08:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07A288E00A;
 Tue,  6 Aug 2019 12:00:49 +0000 (UTC)
Received: from localhost (ovpn-204-49.brq.redhat.com [10.40.204.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FD8C5C686;
 Tue,  6 Aug 2019 12:00:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  6 Aug 2019 13:59:52 +0200
Message-Id: <20190806115952.8456-8-mreitz@redhat.com>
In-Reply-To: <20190806115952.8456-1-mreitz@redhat.com>
References: <20190806115952.8456-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 06 Aug 2019 12:00:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 7/7] block/backup: disable copy_range for
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
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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
Cc: qemu-stable@nongnu.org
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


