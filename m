Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561B9C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE1E2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTvcifQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE1E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEMA-0007oq-MH
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihEKM-0006L3-V2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihEKK-00040q-M7
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:59:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihEKK-0003zq-ID
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576594796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBUL4P0L/KEFASTM+sY37eXKc7r25socze7YuXP8xJQ=;
 b=jTvcifQ0maYfIoGmepr8nXGH0GhZSSzFDxaTiksdkKcMwkwaV6KNu0YtF6yYn3aCthzNMz
 Pzc3+3ljehtyIrUDfUWrGLkRCE7ysC9cHFAV7P75VvuiRnghxP11sLHBKwfh014waPBtBu
 DJ6X3CDPbdn/IPq46Gt7xgq+/0OXNkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-2LRWypv4MT619GnCcdmhFQ-1; Tue, 17 Dec 2019 09:59:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D81F107ACC4;
 Tue, 17 Dec 2019 14:59:50 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-20.ams2.redhat.com [10.36.117.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54B9726574;
 Tue, 17 Dec 2019 14:59:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] block: Activate recursively even for already active nodes
Date: Tue, 17 Dec 2019 15:59:37 +0100
Message-Id: <20191217145939.5537-2-kwolf@redhat.com>
In-Reply-To: <20191217145939.5537-1-kwolf@redhat.com>
References: <20191217145939.5537-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2LRWypv4MT619GnCcdmhFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_invalidate_cache_all() assumes that all nodes in a given subtree
are either active or inactive when it starts. Therefore, as soon as it
arrives at an already active node, it stops.

However, this assumption is wrong. For example, it's possible to take a
snapshot of an inactive node, which results in an active overlay over an
inactive backing file. The active overlay is probably also the root node
of an inactive BlockBackend (blk->disable_perm =3D=3D true).

In this case, bdrv_invalidate_cache_all() does not need to do anything
to activate the overlay node, but it still needs to recurse into the
children and the parents to make sure that after returning success,
really everything is activated.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/block.c b/block.c
index 73029fad64..1b6f7c86e8 100644
--- a/block.c
+++ b/block.c
@@ -5335,10 +5335,6 @@ static void coroutine_fn bdrv_co_invalidate_cache(Bl=
ockDriverState *bs,
         return;
     }
=20
-    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
-        return;
-    }
-
     QLIST_FOREACH(child, &bs->children, next) {
         bdrv_co_invalidate_cache(child->bs, &local_err);
         if (local_err) {
@@ -5360,34 +5356,36 @@ static void coroutine_fn bdrv_co_invalidate_cache(B=
lockDriverState *bs,
      * just keep the extended permissions for the next time that an activa=
tion
      * of the image is tried.
      */
-    bs->open_flags &=3D ~BDRV_O_INACTIVE;
-    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    ret =3D bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &loca=
l_err);
-    if (ret < 0) {
-        bs->open_flags |=3D BDRV_O_INACTIVE;
-        error_propagate(errp, local_err);
-        return;
-    }
-    bdrv_set_perm(bs, perm, shared_perm);
-
-    if (bs->drv->bdrv_co_invalidate_cache) {
-        bs->drv->bdrv_co_invalidate_cache(bs, &local_err);
-        if (local_err) {
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        bs->open_flags &=3D ~BDRV_O_INACTIVE;
+        bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
+        ret =3D bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &=
local_err);
+        if (ret < 0) {
             bs->open_flags |=3D BDRV_O_INACTIVE;
             error_propagate(errp, local_err);
             return;
         }
-    }
+        bdrv_set_perm(bs, perm, shared_perm);
=20
-    FOR_EACH_DIRTY_BITMAP(bs, bm) {
-        bdrv_dirty_bitmap_skip_store(bm, false);
-    }
+        if (bs->drv->bdrv_co_invalidate_cache) {
+            bs->drv->bdrv_co_invalidate_cache(bs, &local_err);
+            if (local_err) {
+                bs->open_flags |=3D BDRV_O_INACTIVE;
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
=20
-    ret =3D refresh_total_sectors(bs, bs->total_sectors);
-    if (ret < 0) {
-        bs->open_flags |=3D BDRV_O_INACTIVE;
-        error_setg_errno(errp, -ret, "Could not refresh total sector count=
");
-        return;
+        FOR_EACH_DIRTY_BITMAP(bs, bm) {
+            bdrv_dirty_bitmap_skip_store(bm, false);
+        }
+
+        ret =3D refresh_total_sectors(bs, bs->total_sectors);
+        if (ret < 0) {
+            bs->open_flags |=3D BDRV_O_INACTIVE;
+            error_setg_errno(errp, -ret, "Could not refresh total sector c=
ount");
+            return;
+        }
     }
=20
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
--=20
2.20.1


