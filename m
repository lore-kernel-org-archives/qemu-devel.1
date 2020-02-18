Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B93EC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5715C2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3vIEEPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5715C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40KV-0007La-Il
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j40De-00010V-Rn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j40Dd-0007KI-NA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46746
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j40Dd-0007K4-Il
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582022109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YTYv8AieZotQAw9UExylWnb2sFwtVYrQjgy0Kvcwkk=;
 b=c3vIEEPFFiuqJR7JqCESrNopcQhnD/ZphHK8R8K5IejjwLGZHzQS3W9ho9AZdkPzDxcN50
 ZPeJr0DoRonyvLrMYuHpDAl+pdcSVW76s1wfwXksNuOORhmRRbGpyaUvVnwQPuX7Z4Yu5S
 yOoOVRR+CGWgOCPHYb4J8DXmK4/XFCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-Dasi2l6kOVqs5jJYA2RjGg-1; Tue, 18 Feb 2020 05:35:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 849038010F8;
 Tue, 18 Feb 2020 10:35:06 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CBE01BC6D;
 Tue, 18 Feb 2020 10:35:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 03/19] block: Drop bdrv_is_first_non_filter()
Date: Tue, 18 Feb 2020 11:34:38 +0100
Message-Id: <20200218103454.296704-4-mreitz@redhat.com>
In-Reply-To: <20200218103454.296704-1-mreitz@redhat.com>
References: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Dasi2l6kOVqs5jJYA2RjGg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

It is unused now.  (And it was ugly because it needed to explore all BDS
chains from the top.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c               | 26 --------------------------
 include/block/block.h |  1 -
 2 files changed, 27 deletions(-)

diff --git a/block.c b/block.c
index 998bb41a5b..f6731fa9be 100644
--- a/block.c
+++ b/block.c
@@ -6235,32 +6235,6 @@ bool bdrv_recurse_is_first_non_filter(BlockDriverSta=
te *bs,
     return false;
 }
=20
-/* This function checks if the candidate is the first non filter bs down i=
t's
- * bs chain. Since we don't have pointers to parents it explore all bs cha=
ins
- * from the top. Some filters can choose not to pass down the recursion.
- */
-bool bdrv_is_first_non_filter(BlockDriverState *candidate)
-{
-    BlockDriverState *bs;
-    BdrvNextIterator it;
-
-    /* walk down the bs forest recursively */
-    for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
-        bool perm;
-
-        /* try to recurse in this top level bs */
-        perm =3D bdrv_recurse_is_first_non_filter(bs, candidate);
-
-        /* candidate is the first non filter */
-        if (perm) {
-            bdrv_next_cleanup(&it);
-            return true;
-        }
-    }
-
-    return false;
-}
-
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **err=
p)
 {
diff --git a/include/block/block.h b/include/block/block.h
index 78026679ab..a6c0f6668e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -394,7 +394,6 @@ int bdrv_amend_options(BlockDriverState *bs_new, QemuOp=
ts *opts,
 /* external snapshots */
 bool bdrv_recurse_is_first_non_filter(BlockDriverState *bs,
                                       BlockDriverState *candidate);
-bool bdrv_is_first_non_filter(BlockDriverState *candidate);
=20
 /* check if a named node can be replaced when doing drive-mirror */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
--=20
2.24.1


