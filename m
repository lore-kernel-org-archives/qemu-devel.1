Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88622C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56ECA20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56ECA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48514 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1vj-0002no-JY
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:22:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rW-0007pv-Dq
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rU-0003se-Fj
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rO-0003lE-Lw; Tue, 07 May 2019 11:18:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F370308793B;
	Tue,  7 May 2019 15:18:24 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 075F860C5F;
	Tue,  7 May 2019 15:18:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:09 +0200
Message-Id: <20190507151819.17401-2-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 07 May 2019 15:18:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/11] qcow2-refcount: fix check_oflag_copied
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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

Increase corruptions_fixed only after successful fix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190227131433.197063-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index e0fe322500..ed3d8ebd57 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1846,7 +1846,7 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
     for (i =3D 0; i < s->l1_size; i++) {
         uint64_t l1_entry =3D s->l1_table[i];
         uint64_t l2_offset =3D l1_entry & L1E_OFFSET_MASK;
-        bool l2_dirty =3D false;
+        int l2_dirty =3D 0;
=20
         if (!l2_offset) {
             continue;
@@ -1912,8 +1912,7 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
                         l2_table[j] =3D cpu_to_be64(refcount =3D=3D 1
                                     ? l2_entry |  QCOW_OFLAG_COPIED
                                     : l2_entry & ~QCOW_OFLAG_COPIED);
-                        l2_dirty =3D true;
-                        res->corruptions_fixed++;
+                        l2_dirty++;
                     } else {
                         res->corruptions++;
                     }
@@ -1921,7 +1920,7 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
             }
         }
=20
-        if (l2_dirty) {
+        if (l2_dirty > 0) {
             ret =3D qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2=
,
                                                 l2_offset, s->cluster_si=
ze,
                                                 false);
@@ -1940,6 +1939,7 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
                 res->check_errors++;
                 goto fail;
             }
+            res->corruptions_fixed +=3D l2_dirty;
         }
     }
=20
--=20
2.20.1


