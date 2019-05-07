Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C8C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B32320578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B32320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1yk-00060W-5x
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:26:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rZ-0007vX-WF
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rY-0003xq-SH
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rU-0003qM-DZ; Tue, 07 May 2019 11:18:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3063981E0A;
	Tue,  7 May 2019 15:18:29 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE6EA64026;
	Tue,  7 May 2019 15:18:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:11 +0200
Message-Id: <20190507151819.17401-4-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 07 May 2019 15:18:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/11] qcow2-refcount: check_refcounts_l2:
 reduce ignored overlaps
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

Reduce number of structures ignored in overlap check: when checking
active table ignore active tables, when checking inactive table ignore
inactive ones.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190227131433.197063-4-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 21e50dacf4..1ac2b0490d 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1591,7 +1591,7 @@ enum {
 static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res=
,
                               void **refcount_table,
                               int64_t *refcount_table_size, int64_t l2_o=
ffset,
-                              int flags, BdrvCheckMode fix)
+                              int flags, BdrvCheckMode fix, bool active)
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t *l2_table, l2_entry;
@@ -1682,11 +1682,12 @@ static int check_refcounts_l2(BlockDriverState *b=
s, BdrvCheckResult *res,
                     if (fix & BDRV_FIX_ERRORS) {
                         uint64_t l2e_offset =3D
                             l2_offset + (uint64_t)i * sizeof(uint64_t);
+                        int ign =3D active ? QCOW2_OL_ACTIVE_L2 :
+                                           QCOW2_OL_INACTIVE_L2;
=20
                         l2_entry =3D QCOW_OFLAG_ZERO;
                         l2_table[i] =3D cpu_to_be64(l2_entry);
-                        ret =3D qcow2_pre_write_overlap_check(bs,
-                                QCOW2_OL_ACTIVE_L2 | QCOW2_OL_INACTIVE_L=
2,
+                        ret =3D qcow2_pre_write_overlap_check(bs, ign,
                                 l2e_offset, sizeof(uint64_t), false);
                         if (ret < 0) {
                             fprintf(stderr, "ERROR: Overlap check failed=
\n");
@@ -1762,7 +1763,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
                               void **refcount_table,
                               int64_t *refcount_table_size,
                               int64_t l1_table_offset, int l1_size,
-                              int flags, BdrvCheckMode fix)
+                              int flags, BdrvCheckMode fix, bool active)
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t *l1_table =3D NULL, l2_offset, l1_size2;
@@ -1818,7 +1819,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
             /* Process and check L2 entries */
             ret =3D check_refcounts_l2(bs, res, refcount_table,
                                      refcount_table_size, l2_offset, fla=
gs,
-                                     fix);
+                                     fix, active);
             if (ret < 0) {
                 goto fail;
             }
@@ -2109,7 +2110,7 @@ static int calculate_refcounts(BlockDriverState *bs=
, BdrvCheckResult *res,
     /* current L1 table */
     ret =3D check_refcounts_l1(bs, res, refcount_table, nb_clusters,
                              s->l1_table_offset, s->l1_size, CHECK_FRAG_=
INFO,
-                             fix);
+                             fix, true);
     if (ret < 0) {
         return ret;
     }
@@ -2138,7 +2139,8 @@ static int calculate_refcounts(BlockDriverState *bs=
, BdrvCheckResult *res,
             continue;
         }
         ret =3D check_refcounts_l1(bs, res, refcount_table, nb_clusters,
-                                 sn->l1_table_offset, sn->l1_size, 0, fi=
x);
+                                 sn->l1_table_offset, sn->l1_size, 0, fi=
x,
+                                 false);
         if (ret < 0) {
             return ret;
         }
--=20
2.20.1


