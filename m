Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EAD20882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EAD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBL2T-0003Hy-Cy
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKq3-00014S-Oe
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKq1-0004fL-OL
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpu-0004Ys-8L; Fri, 20 Sep 2019 11:28:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AFD9308421A;
 Fri, 20 Sep 2019 15:28:39 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15FE45D9E5;
 Fri, 20 Sep 2019 15:28:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 14/22] quorum: Stop marking it as a filter
Date: Fri, 20 Sep 2019 17:27:56 +0200
Message-Id: <20190920152804.12875-15-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 20 Sep 2019 15:28:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quorum is not a filter, for example because it cannot guarantee which of
its children will serve the next request.  Thus, any of its children may
differ from the data visible to quorum's parents.

We have other filters with multiple children, but they differ in this
aspect:

- blkverify quits the whole qemu process if its children differ.  As
  such, we can always skip it when we want to skip it (as a filter node)
  by going to any of its children.  Both have the same data.

- replication generally serves requests from bs->file, so this is its
  only actually filtered child.

- Block job filters currently only have one child, but they will
  probably get more children in the future.  Still, they will always
  have only one actually filtered child.

Having "filters" as a dedicated node category only makes sense if you
can skip them by going to a one fixed child that always shows the same
data as the filter node.  Quorum cannot fulfill this, so it is not a
filter.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/quorum.c b/block/quorum.c
index 7a8f8b5475..7f56b4df7c 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1237,7 +1237,6 @@ static BlockDriver bdrv_quorum =3D {
=20
     .bdrv_child_perm                    =3D quorum_child_perm,
=20
-    .is_filter                          =3D true,
     .bdrv_recurse_can_replace           =3D quorum_recurse_can_replace,
=20
     .strong_runtime_opts                =3D quorum_strong_runtime_opts,
--=20
2.21.0


