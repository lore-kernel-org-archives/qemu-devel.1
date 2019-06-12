Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E7C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C431920896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C431920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbC97-0000ky-3c
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBkq-0007eF-NZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBXI-0002UM-3b
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:16:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBSL-0007qB-8B; Wed, 12 Jun 2019 18:10:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B1F6307C940;
 Wed, 12 Jun 2019 22:10:55 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2050119744;
 Wed, 12 Jun 2019 22:10:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:41 +0200
Message-Id: <20190612221004.2317-20-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 22:10:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 19/42] block: Use CAF in bdrv_co_rw_vmstate()
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

If a node whose driver does not provide VM state functions has a
metadata child, the VM state should probably go there; if it is a
filter, the VM state should probably go there.  It follows that we
should generally go down to the primary child.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 659ea0c52a..14f99e1c00 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2395,6 +2395,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVect=
or *qiov, int64_t pos,
                    bool is_read)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *child_bs =3D bdrv_primary_bs(bs);
     int ret =3D -ENOTSUP;
=20
     bdrv_inc_in_flight(bs);
@@ -2407,8 +2408,8 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVect=
or *qiov, int64_t pos,
         } else {
             ret =3D drv->bdrv_save_vmstate(bs, qiov, pos);
         }
-    } else if (bs->file) {
-        ret =3D bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+    } else if (child_bs) {
+        ret =3D bdrv_co_rw_vmstate(child_bs, qiov, pos, is_read);
     }
=20
     bdrv_dec_in_flight(bs);
--=20
2.21.0


