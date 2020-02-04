Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27552C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E022A2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFLGX52M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E022A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1mv-0004sN-3I
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1ht-0003jQ-1G
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hr-0003Pk-MU
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hr-0003Nd-HZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRfIJxI6sQJgJl7Y0+x7abHTYaU/3mZTzm55fyAlmUg=;
 b=LFLGX52MpoGbSb00Zm9zH3KkMU9KBr14fncocU8XhnZi4e+Nu1KUgW/YHroRIkWAyA5okV
 pfM4rnfcly9KRMjuRfR9aJBbvZx3s+y6vB1bMTNT84vS9VZNahLqDHE77VTywFhLZyxlC6
 +21uAZ09IrAQ9trxlW5Gg3HR2rWU830=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-q6AmxsBpMu2ykqIbxJHASA-1; Tue, 04 Feb 2020 12:09:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23CD7800D5C;
 Tue,  4 Feb 2020 17:09:44 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEFBA86C4A;
 Tue,  4 Feb 2020 17:09:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 18/33] block: Add bdrv_default_perms()
Date: Tue,  4 Feb 2020 18:08:33 +0100
Message-Id: <20200204170848.614480-19-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: q6AmxsBpMu2ykqIbxJHASA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

This callback can be used by BDSs that use child_of_bds with the
appropriate BdrvChildRole for their children.

Also, make bdrv_format_default_perms() use it for child_of_bds children
(just a temporary solution until we can drop bdrv_format_default_perms()
altogether).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 46 ++++++++++++++++++++++++++++++++-------
 include/block/block_int.h | 11 ++++++++++
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 3619756175..994a037730 100644
--- a/block.c
+++ b/block.c
@@ -2361,14 +2361,12 @@ static void bdrv_default_perms_for_metadata(BlockDr=
iverState *bs, BdrvChild *c,
     *nshared =3D shared;
 }
=20
-/* TODO: Use */
-static void __attribute__((unused))
-bdrv_default_perms_for_data(BlockDriverState *bs, BdrvChild *c,
-                            const BdrvChildClass *child_class,
-                            BdrvChildRole role,
-                            BlockReopenQueue *reopen_queue,
-                            uint64_t perm, uint64_t shared,
-                            uint64_t *nperm, uint64_t *nshared)
+static void bdrv_default_perms_for_data(BlockDriverState *bs, BdrvChild *c=
,
+                                        const BdrvChildClass *child_class,
+                                        BdrvChildRole role,
+                                        BlockReopenQueue *reopen_queue,
+                                        uint64_t perm, uint64_t shared,
+                                        uint64_t *nperm, uint64_t *nshared=
)
 {
     assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_DATA));
=20
@@ -2403,6 +2401,13 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
                                uint64_t *nperm, uint64_t *nshared)
 {
     bool backing =3D (child_class =3D=3D &child_backing);
+
+    if (child_class =3D=3D &child_of_bds) {
+        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+                           perm, shared, nperm, nshared);
+        return;
+    }
+
     assert(child_class =3D=3D &child_backing || child_class =3D=3D &child_=
file);
=20
     if (!backing) {
@@ -2414,6 +2419,31 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
     }
 }
=20
+void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
+                        const BdrvChildClass *child_class, BdrvChildRole r=
ole,
+                        BlockReopenQueue *reopen_queue,
+                        uint64_t perm, uint64_t shared,
+                        uint64_t *nperm, uint64_t *nshared)
+{
+    assert(child_class =3D=3D &child_of_bds);
+
+    if (role & BDRV_CHILD_FILTERED) {
+        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+                                  perm, shared, nperm, nshared);
+    } else if (role & BDRV_CHILD_COW) {
+        bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_qu=
eue,
+                                       perm, shared, nperm, nshared);
+    } else if (role & BDRV_CHILD_METADATA) {
+        bdrv_default_perms_for_metadata(bs, c, child_class, role, reopen_q=
ueue,
+                                        perm, shared, nperm, nshared);
+    } else if (role & BDRV_CHILD_DATA) {
+        bdrv_default_perms_for_data(bs, c, child_class, role, reopen_queue=
,
+                                    perm, shared, nperm, nshared);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm)
 {
     static const uint64_t permissions[] =3D {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 91883c1e80..35113ab878 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1280,6 +1280,17 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
 bool bdrv_recurse_can_replace(BlockDriverState *bs,
                               BlockDriverState *to_replace);
=20
+/*
+ * Default implementation for BlockDriver.bdrv_child_perm() that can
+ * be used by block filters and image formats, as long as they use the
+ * child_of_bds child class and set an appropriate BdrvChildRole.
+ */
+void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
+                        const BdrvChildClass *child_class, BdrvChildRole r=
ole,
+                        BlockReopenQueue *reopen_queue,
+                        uint64_t perm, uint64_t shared,
+                        uint64_t *nperm, uint64_t *nshared);
+
 /*
  * Default implementation for drivers to pass bdrv_co_block_status() to
  * their file.
--=20
2.24.1


