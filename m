Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07699C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 10:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5305208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 10:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5305208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIVOx-0005Oy-Qx
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 06:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIVNc-0003uU-8r
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIVNb-00069x-5K
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIVNY-00067q-Rg; Thu, 10 Oct 2019 06:09:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C787308FBA6;
 Thu, 10 Oct 2019 10:09:04 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FC4D5C223;
 Thu, 10 Oct 2019 10:09:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] qcow2: Limit total allocation range to INT_MAX
Date: Thu, 10 Oct 2019 12:08:57 +0200
Message-Id: <20191010100858.1261-2-mreitz@redhat.com>
In-Reply-To: <20191010100858.1261-1-mreitz@redhat.com>
References: <20191010100858.1261-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 10 Oct 2019 10:09:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the COW areas are included, the size of an allocation can exceed
INT_MAX.  This is kind of limited by handle_alloc() in that it already
caps avail_bytes at INT_MAX, but the number of clusters still reflects
the original length.

This can have all sorts of effects, ranging from the storage layer write
call failing to image corruption.  (If there were no image corruption,
then I suppose there would be data loss because the .cow_end area is
forced to be empty, even though there might be something we need to
COW.)

Fix all of it by limiting nb_clusters so the equivalent number of bytes
will not exceed INT_MAX.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8d5fa1539c..8982b7b762 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1330,6 +1330,9 @@ static int handle_alloc(BlockDriverState *bs, uint6=
4_t guest_offset,
     nb_clusters =3D MIN(nb_clusters, s->l2_slice_size - l2_index);
     assert(nb_clusters <=3D INT_MAX);
=20
+    /* Limit total allocation byte count to INT_MAX */
+    nb_clusters =3D MIN(nb_clusters, INT_MAX >> s->cluster_bits);
+
     /* Find L2 entry for the first involved cluster */
     ret =3D get_cluster_table(bs, guest_offset, &l2_slice, &l2_index);
     if (ret < 0) {
@@ -1412,7 +1415,7 @@ static int handle_alloc(BlockDriverState *bs, uint6=
4_t guest_offset,
      * request actually writes to (excluding COW at the end)
      */
     uint64_t requested_bytes =3D *bytes + offset_into_cluster(s, guest_o=
ffset);
-    int avail_bytes =3D MIN(INT_MAX, nb_clusters << s->cluster_bits);
+    int avail_bytes =3D nb_clusters << s->cluster_bits;
     int nb_bytes =3D MIN(requested_bytes, avail_bytes);
     QCowL2Meta *old_m =3D *m;
=20
--=20
2.21.0


