Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C68C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432222075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432222075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PTI-0004ZR-3n
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PQY-0002YZ-6G
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PQW-0001HK-Na
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PQR-0001Dw-R2; Thu, 12 Sep 2019 09:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EFE2308A9E2;
 Thu, 12 Sep 2019 13:46:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9393F600C4;
 Thu, 12 Sep 2019 13:46:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:45:43 +0200
Message-Id: <20190912134604.22019-2-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 12 Sep 2019 13:46:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/22] qcow2: Fix the calculation of the maximum
 L2 cache size
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

From: Alberto Garcia <berto@igalia.com>

The size of the qcow2 L2 cache defaults to 32 MB, which can be easily
larger than the maximum amount of L2 metadata that the image can have.
For example: with 64 KB clusters the user would need a qcow2 image
with a virtual size of 256 GB in order to have 32 MB of L2 metadata.

Because of that, since commit b749562d9822d14ef69c9eaa5f85903010b86c30
we forbid the L2 cache to become larger than the maximum amount of L2
metadata for the image, calculated using this formula:

    uint64_t max_l2_cache =3D virtual_disk_size / (s->cluster_size / 8);

The problem with this formula is that the result should be rounded up
to the cluster size because an L2 table on disk always takes one full
cluster.

For example, a 1280 MB qcow2 image with 64 KB clusters needs exactly
160 KB of L2 metadata, but we need 192 KB on disk (3 clusters) even if
the last 32 KB of those are not going to be used.

However QEMU rounds the numbers down and only creates 2 cache tables
(128 KB), which is not enough for the image.

A quick test doing 4KB random writes on a 1280 MB image gives me
around 500 IOPS, while with the correct cache size I get 16K IOPS.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0882ff6e92..57734f20cf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -828,7 +828,11 @@ static void read_cache_sizes(BlockDriverState *bs, Q=
emuOpts *opts,
     bool l2_cache_entry_size_set;
     int min_refcount_cache =3D MIN_REFCOUNT_CACHE_SIZE * s->cluster_size=
;
     uint64_t virtual_disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
-    uint64_t max_l2_cache =3D virtual_disk_size / (s->cluster_size / 8);
+    uint64_t max_l2_entries =3D DIV_ROUND_UP(virtual_disk_size, s->clust=
er_size);
+    /* An L2 table is always one cluster in size so the max cache size
+     * should be a multiple of the cluster size. */
+    uint64_t max_l2_cache =3D ROUND_UP(max_l2_entries * sizeof(uint64_t)=
,
+                                     s->cluster_size);
=20
     combined_cache_size_set =3D qemu_opt_get(opts, QCOW2_OPT_CACHE_SIZE)=
;
     l2_cache_size_set =3D qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_SIZE);
--=20
2.20.1


