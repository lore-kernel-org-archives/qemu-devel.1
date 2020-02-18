Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FCBC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C9A2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgXQg1/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C9A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40IB-0002P7-2a
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j40Dv-0001hP-KD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j40Du-0007R8-BL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j40Du-0007Qk-6c
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582022125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aPVtQzc7vjGemDWS1kpzm+7k6kudt5hwR47rSwH8tM=;
 b=VgXQg1/Bt2oVYfgkHjnypFThHJfUwc3Cg/DZdlxZbNLN+RfBdd6LIsiicgQ0V/fHoBP9Tf
 EG6kOUYia4pBg8Y4K6CXTBmv0+TPFOiZkPY/qZr7UPkRR5iV2KKjGKT3Eaq3e1VJv7+8ao
 u+O9OssdLs5IbwR8iA10PeA/K8RitvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-dJ2bKjQKMgyGbJbaCEmcVQ-1; Tue, 18 Feb 2020 05:35:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01F9413FB;
 Tue, 18 Feb 2020 10:35:21 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6877D384;
 Tue, 18 Feb 2020 10:35:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 08/19] quorum: Implement .bdrv_recurse_can_replace()
Date: Tue, 18 Feb 2020 11:34:43 +0100
Message-Id: <20200218103454.296704-9-mreitz@redhat.com>
In-Reply-To: <20200218103454.296704-1-mreitz@redhat.com>
References: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dJ2bKjQKMgyGbJbaCEmcVQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index 17b439056f..3ece6e4382 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -813,6 +813,59 @@ static bool quorum_recurse_is_first_non_filter(BlockDr=
iverState *bs,
     return false;
 }
=20
+static bool quorum_recurse_can_replace(BlockDriverState *bs,
+                                       BlockDriverState *to_replace)
+{
+    BDRVQuorumState *s =3D bs->opaque;
+    int i;
+
+    for (i =3D 0; i < s->num_children; i++) {
+        /*
+         * We have no idea whether our children show the same data as
+         * this node (@bs).  It is actually highly likely that
+         * @to_replace does not, because replacing a broken child is
+         * one of the main use cases here.
+         *
+         * We do know that the new BDS will match @bs, so replacing
+         * any of our children by it will be safe.  It cannot change
+         * the data this quorum node presents to its parents.
+         *
+         * However, replacing @to_replace by @bs in any of our
+         * children's chains may change visible data somewhere in
+         * there.  We therefore cannot recurse down those chains with
+         * bdrv_recurse_can_replace().
+         * (More formally, bdrv_recurse_can_replace() requires that
+         * @to_replace will be replaced by something matching the @bs
+         * passed to it.  We cannot guarantee that.)
+         *
+         * Thus, we can only check whether any of our immediate
+         * children matches @to_replace.
+         *
+         * (In the future, we might add a function to recurse down a
+         * chain that checks that nothing there cares about a change
+         * in data from the respective child in question.  For
+         * example, most filters do not care when their child's data
+         * suddenly changes, as long as their parents do not care.)
+         */
+        if (s->children[i]->bs =3D=3D to_replace) {
+            /*
+             * We now have to ensure that there is no other parent
+             * that cares about replacing this child by a node with
+             * potentially different data.
+             * We do so by checking whether there are any other parents
+             * at all, which is stricter than necessary, but also very
+             * simple.  (We may decide to implement something more
+             * complex and permissive when there is an actual need for
+             * it.)
+             */
+            return QLIST_FIRST(&to_replace->parents) =3D=3D s->children[i]=
 &&
+                QLIST_NEXT(s->children[i], next_parent) =3D=3D NULL;
+        }
+    }
+
+    return false;
+}
+
 static int quorum_valid_threshold(int threshold, int num_children, Error *=
*errp)
 {
=20
@@ -1164,6 +1217,7 @@ static BlockDriver bdrv_quorum =3D {
=20
     .is_filter                          =3D true,
     .bdrv_recurse_is_first_non_filter   =3D quorum_recurse_is_first_non_fi=
lter,
+    .bdrv_recurse_can_replace           =3D quorum_recurse_can_replace,
=20
     .strong_runtime_opts                =3D quorum_strong_runtime_opts,
 };
--=20
2.24.1


