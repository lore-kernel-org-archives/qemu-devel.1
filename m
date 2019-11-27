Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192B7C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC38A20409
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxomSa6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC38A20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxeE-0007oB-Aa
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBr-000464-ND
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBp-0006jS-Ez
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBp-0006iz-Az
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XiiSrurUJqp0clemN6Ew5qrgphB6yCujJ7gol3gizhU=;
 b=OxomSa6pXo6Hx9r2cKjR/izKl9/p4gTjRAmvsyLlmil87PtNGaKMAmsS2FcSbfrzxAeUCc
 TlUbwMor01vsmcDg2tz4oMBo1oJIq0f0lZdB0kr8IaasSkq8rr89G+DxY1pzFG/cblPMW4
 K9T/aA3vjw9Yj2q/KKZrh6ehK7Pxt7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-5UeQnlKBOt-akA6XkIY9RA-1; Wed, 27 Nov 2019 08:17:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFB28106BB43;
 Wed, 27 Nov 2019 13:17:00 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79EC35C219;
 Wed, 27 Nov 2019 13:17:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 14/31] block: Pull out bdrv_default_perms_for_storage()
Date: Wed, 27 Nov 2019 14:16:07 +0100
Message-Id: <20191127131624.1062403-15-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 5UeQnlKBOt-akA6XkIY9RA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 71 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/block.c b/block.c
index 2771bc45ce..4d4ccbacdf 100644
--- a/block.c
+++ b/block.c
@@ -2294,6 +2294,50 @@ static void bdrv_default_perms_for_backing(BlockDriv=
erState *bs, BdrvChild *c,
     *nshared =3D shared;
 }
=20
+static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild=
 *c,
+                                           const BdrvChildClass *child_cla=
ss,
+                                           BdrvChildRole role,
+                                           BlockReopenQueue *reopen_queue,
+                                           uint64_t perm, uint64_t shared,
+                                           uint64_t *nperm, uint64_t *nsha=
red)
+{
+    int flags;
+
+    assert(child_class =3D=3D &child_file ||
+           (child_class =3D=3D &child_of_bds &&
+            (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA))));
+
+    flags =3D bdrv_reopen_get_flags(reopen_queue, bs);
+
+    /*
+     * Apart from the modifications below, the same permissions are
+     * forwarded and left alone as for filters
+     */
+    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+                              perm, shared, &perm, &shared);
+
+    /* Format drivers may touch metadata even if the guest doesn't write *=
/
+    if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
+        perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    }
+
+    /*
+     * bs->file always needs to be consistent because of the metadata. We
+     * can never allow other users to resize or write to it.
+     */
+    if (!(flags & BDRV_O_NO_IO)) {
+        perm |=3D BLK_PERM_CONSISTENT_READ;
+    }
+    shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
+
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    }
+
+    *nperm =3D perm;
+    *nshared =3D shared;
+}
+
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
                                BdrvChildRole role,
@@ -2305,31 +2349,8 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
     assert(child_class =3D=3D &child_backing || child_class =3D=3D &child_=
file);
=20
     if (!backing) {
-        int flags =3D bdrv_reopen_get_flags(reopen_queue, bs);
-
-        /* Apart from the modifications below, the same permissions are
-         * forwarded and left alone as for filters */
-        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
-                                  perm, shared, &perm, &shared);
-
-        /* Format drivers may touch metadata even if the guest doesn't wri=
te */
-        if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
-            perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        /* bs->file always needs to be consistent because of the metadata.=
 We
-         * can never allow other users to resize or write to it. */
-        if (!(flags & BDRV_O_NO_IO)) {
-            perm |=3D BLK_PERM_CONSISTENT_READ;
-        }
-        shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
-
-        if (bs->open_flags & BDRV_O_INACTIVE) {
-            shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        *nperm =3D perm;
-        *nshared =3D shared;
+        bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_qu=
eue,
+                                       perm, shared, nperm, nshared);
     } else {
         bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_qu=
eue,
                                        perm, shared, nperm, nshared);
--=20
2.23.0


