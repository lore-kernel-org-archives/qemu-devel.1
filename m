Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C4C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD6C20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD6C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1vr-0002wT-9a
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:23:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1ra-0007vu-FC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rZ-0003yF-CL
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rW-0003tf-Kd; Tue, 07 May 2019 11:18:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA96A89C35;
	Tue,  7 May 2019 15:18:33 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8149357DE5;
	Tue,  7 May 2019 15:18:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:13 +0200
Message-Id: <20190507151819.17401-6-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 07 May 2019 15:18:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/11] qcow2-refcount: don't mask corruptions
 under internal errors
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

No reasons for not reporting found corruptions as corruptions in case
of some internal errors, especially in case of just failed to fix l2
entry (and in this case, missed corruptions may influence comparing
logic, when we calculate difference between corruptions fields of two
results)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190227131433.197063-6-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 6851807ffc..fa7ac1f7cb 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1662,6 +1662,8 @@ static int check_refcounts_l2(BlockDriverState *bs,=
 BdrvCheckResult *res,
=20
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
+                res->corruptions++;
+
                 if (qcow2_get_cluster_type(bs, l2_entry) =3D=3D
                     QCOW2_CLUSTER_ZERO_ALLOC)
                 {
@@ -1697,18 +1699,16 @@ static int check_refcounts_l2(BlockDriverState *b=
s, BdrvCheckResult *res,
                             /* Do not abort, continue checking the rest =
of this
                              * L2 table's entries */
                         } else {
+                            res->corruptions--;
                             res->corruptions_fixed++;
                             /* Skip marking the cluster as used
                              * (it is unused now) */
                             continue;
                         }
-                    } else {
-                        res->corruptions++;
                     }
                 } else {
                     fprintf(stderr, "ERROR offset=3D%" PRIx64 ": Data cl=
uster is "
                         "not properly aligned; L2 entry corrupted.\n", o=
ffset);
-                    res->corruptions++;
                 }
             }
=20
@@ -1879,6 +1879,7 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
             continue;
         }
         if ((refcount =3D=3D 1) !=3D ((l1_entry & QCOW_OFLAG_COPIED) !=3D=
 0)) {
+            res->corruptions++;
             fprintf(stderr, "%s OFLAG_COPIED L2 cluster: l1_index=3D%d "
                     "l1_entry=3D%" PRIx64 " refcount=3D%" PRIu64 "\n",
                     repair ? "Repairing" : "ERROR", i, l1_entry, refcoun=
t);
@@ -1891,9 +1892,8 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
                     res->check_errors++;
                     goto fail;
                 }
+                res->corruptions--;
                 res->corruptions_fixed++;
-            } else {
-                res->corruptions++;
             }
         }
=20
@@ -1925,6 +1925,7 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
                     }
                 }
                 if ((refcount =3D=3D 1) !=3D ((l2_entry & QCOW_OFLAG_COP=
IED) !=3D 0)) {
+                    res->corruptions++;
                     fprintf(stderr, "%s OFLAG_COPIED data cluster: "
                             "l2_entry=3D%" PRIx64 " refcount=3D%" PRIu64=
 "\n",
                             repair ? "Repairing" : "ERROR", l2_entry, re=
fcount);
@@ -1933,8 +1934,6 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
                                     ? l2_entry |  QCOW_OFLAG_COPIED
                                     : l2_entry & ~QCOW_OFLAG_COPIED);
                         l2_dirty++;
-                    } else {
-                        res->corruptions++;
                     }
                 }
             }
@@ -1959,6 +1958,7 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
                 res->check_errors++;
                 goto fail;
             }
+            res->corruptions -=3D l2_dirty;
             res->corruptions_fixed +=3D l2_dirty;
         }
     }
@@ -1997,6 +1997,7 @@ static int check_refblocks(BlockDriverState *bs, Bd=
rvCheckResult *res,
         }
=20
         if (cluster >=3D *nb_clusters) {
+            res->corruptions++;
             fprintf(stderr, "%s refcount block %" PRId64 " is outside im=
age\n",
                     fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
=20
@@ -2036,6 +2037,7 @@ static int check_refblocks(BlockDriverState *bs, Bd=
rvCheckResult *res,
                     goto resize_fail;
                 }
=20
+                res->corruptions--;
                 res->corruptions_fixed++;
                 ret =3D qcow2_inc_refcounts_imrt(bs, res,
                                                refcount_table, nb_cluste=
rs,
@@ -2049,12 +2051,9 @@ static int check_refblocks(BlockDriverState *bs, B=
drvCheckResult *res,
                 continue;
=20
 resize_fail:
-                res->corruptions++;
                 *rebuild =3D true;
                 fprintf(stderr, "ERROR could not resize image: %s\n",
                         strerror(-ret));
-            } else {
-                res->corruptions++;
             }
             continue;
         }
--=20
2.20.1


