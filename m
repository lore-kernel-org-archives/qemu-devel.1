Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B83C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8396620692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZAlwbKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8396620692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLko-0000dx-J6
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ieLjp-000076-4t
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ieLjn-0005mR-HD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:18:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ieLjn-0005mF-DT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575908299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYU2bFdV8HYp/Dkfz+XS+7aelHvN6sGn5+i1ejOekLo=;
 b=WZAlwbKsORpdENazYT8Ft1W5eGQ8k2ZEq2yWZ0dpdAILP+ahvHewSTCUM9e8Zd9+xfXf6I
 Xkpz54zO2fnKdXHagzwKEkOzfSNz7op4bFNTw3puDUa4axmqD8bshGyRBOP6yI4M/x0r6Q
 WSXfDvzPX42aASVxqlRiRmxCNf0cv64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-dQ4xN_jfO_inN6XfBoJBqw-1; Mon, 09 Dec 2019 11:16:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA727802592;
 Mon,  9 Dec 2019 16:16:12 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98FAC46;
 Mon,  9 Dec 2019 16:16:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2-rc5 1/1] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
Date: Mon,  9 Dec 2019 10:16:07 -0600
Message-Id: <20191209161607.20894-1-eblake@redhat.com>
In-Reply-To: <20191209160015.20253-1-eblake@redhat.com>
References: <20191209160015.20253-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dQ4xN_jfO_inN6XfBoJBqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 vsementsov@virtuozzo.com, "open list:qcow2" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Here is double bug:

First, return error but not set errp. This may lead to:
qmp block-dirty-bitmap-remove may report success when actually failed

block-dirty-bitmap-remove used in a transaction will crash, as
qmp_transaction will think that it returned success and will call
block_dirty_bitmap_remove_commit which will crash, as state->bitmap is
NULL

Second (like in anecdote), this case is not an error at all. As it is
documented in the comment above bdrv_co_remove_persistent_dirty_bitmap
definition, absence of bitmap is not an error, and similar case handled
at start of qcow2_co_remove_persistent_dirty_bitmap, it returns 0 when
there is no bitmaps at all.

But when there are some bitmaps, but not the requested one, it return
error with errp unset.

Fix that.

Trigger:
1. create persistent bitmap A
2. shutdown vm  (bitmap A is synced)
3. start vm
4. create persistent bitmap B
5. remove bitmap B - it fails (and crashes if in transaction)

Potential workaround (rather invasive to ask clients to implement it):
1. create persistent bitmap A
2. shutdown vm
3. start vm
4. create persistent bitmap B
5. remember, that we want to remove bitmap B after vm shutdown
...
  some other operations
...
6. vm shutdown
7. start vm in stopped mode, and remove all bitmaps marked for removing
8. stop vm

Fixes: b56a1e31759b750
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20191205193049.30666-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
[eblake: commit message tweaks]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-bitmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 8abaf632fc7d..c6c8ebbe89d4 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1469,8 +1469,10 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bi=
tmap(BlockDriverState *bs,
     Qcow2BitmapList *bm_list;

     if (s->nb_bitmaps =3D=3D 0) {
-        /* Absence of the bitmap is not an error: see explanation above
-         * bdrv_remove_persistent_dirty_bitmap() definition. */
+        /*
+         * Absence of the bitmap is not an error: see explanation above
+         * bdrv_co_remove_persistent_dirty_bitmap() definition.
+         */
         return 0;
     }

@@ -1485,7 +1487,8 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bit=
map(BlockDriverState *bs,

     bm =3D find_bitmap_by_name(bm_list, name);
     if (bm =3D=3D NULL) {
-        ret =3D -EINVAL;
+        /* Absence of the bitmap is not an error, see above. */
+        ret =3D 0;
         goto out;
     }

--=20
2.21.0


