Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E64C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765D7205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765D7205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48475 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1tP-0000YO-MG
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:20:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rZ-0007vC-M4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rY-0003xg-Ov
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rU-0003rz-TT; Tue, 07 May 2019 11:18:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A9943091761;
	Tue,  7 May 2019 15:18:31 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 20E4C10027BD;
	Tue,  7 May 2019 15:18:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:12 +0200
Message-Id: <20190507151819.17401-5-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 07 May 2019 15:18:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/11] qcow2-refcount: check_refcounts_l2: don't
 count fixed cluster as allocated
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

Do not count a cluster which is fixed to be ZERO as allocated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190227131433.197063-5-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 1ac2b0490d..6851807ffc 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1660,15 +1660,6 @@ static int check_refcounts_l2(BlockDriverState *bs=
, BdrvCheckResult *res,
         {
             uint64_t offset =3D l2_entry & L2E_OFFSET_MASK;
=20
-            if (flags & CHECK_FRAG_INFO) {
-                res->bfi.allocated_clusters++;
-                if (next_contiguous_offset &&
-                    offset !=3D next_contiguous_offset) {
-                    res->bfi.fragmented_clusters++;
-                }
-                next_contiguous_offset =3D offset + s->cluster_size;
-            }
-
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
                 if (qcow2_get_cluster_type(bs, l2_entry) =3D=3D
@@ -1721,6 +1712,15 @@ static int check_refcounts_l2(BlockDriverState *bs=
, BdrvCheckResult *res,
                 }
             }
=20
+            if (flags & CHECK_FRAG_INFO) {
+                res->bfi.allocated_clusters++;
+                if (next_contiguous_offset &&
+                    offset !=3D next_contiguous_offset) {
+                    res->bfi.fragmented_clusters++;
+                }
+                next_contiguous_offset =3D offset + s->cluster_size;
+            }
+
             /* Mark cluster as used */
             if (!has_data_file(bs)) {
                 ret =3D qcow2_inc_refcounts_imrt(bs, res, refcount_table=
,
--=20
2.20.1


