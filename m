Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C4C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E406B20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E406B20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32815 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7k2-0005nJ-7Z
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57241)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xc-0001zm-ER
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xb-0004Fq-Fs
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XZ-0004EQ-Gr; Fri, 09 Aug 2019 12:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7CB63078A2E;
 Fri,  9 Aug 2019 16:14:52 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75C3660BF7;
 Fri,  9 Aug 2019 16:14:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:44 +0200
Message-Id: <20190809161407.11920-20-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 16:14:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 19/42] block: Use CAF in bdrv_co_rw_vmstate()
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index dca4689b2f..e222d91893 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2434,6 +2434,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVect=
or *qiov, int64_t pos,
                    bool is_read)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *child_bs =3D bdrv_primary_bs(bs);
     int ret =3D -ENOTSUP;
=20
     bdrv_inc_in_flight(bs);
@@ -2446,8 +2447,8 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVect=
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


