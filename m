Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6205AC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4692087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jp22HSlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4692087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1l4-0000Ow-Bd
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hp-0003YN-M7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hn-0003CH-C7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hn-00037u-8N
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZiNjTF0jDc3vu7eGAI0QHGQ+YbJ7cq6m/5Rve8EBNw=;
 b=Jp22HSlWWb0xr9oejOJXtoiSn/XSQHv9Kb/36WTOxz0SY25bqCDQ5yilu8t0i8l3JSnr53
 +HRFRucCeTL8zQJPeO4f5jXJzP3wjldGxiHn66VLsbPVlQS+9m+2yB+nP9IF5Bksv/q0m6
 ge0HiKHm8aXUvW0gwb+Wt93yhOT+pUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-3GowrM4oPcCr8iehtBIYlg-1; Tue, 04 Feb 2020 12:09:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC2348010F5;
 Tue,  4 Feb 2020 17:09:35 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C9DF1001B08;
 Tue,  4 Feb 2020 17:09:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 15/33] block: Pull out bdrv_default_perms_for_backing()
Date: Tue,  4 Feb 2020 18:08:30 +0100
Message-Id: <20200204170848.614480-16-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3GowrM4oPcCr8iehtBIYlg-1
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
 block.c | 62 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/block.c b/block.c
index 39ba6aad0a..b26ec10cce 100644
--- a/block.c
+++ b/block.c
@@ -2280,6 +2280,44 @@ void bdrv_filter_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
     *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHAN=
GED;
 }
=20
+static void bdrv_default_perms_for_backing(BlockDriverState *bs, BdrvChild=
 *c,
+                                           const BdrvChildClass *child_cla=
ss,
+                                           BdrvChildRole role,
+                                           BlockReopenQueue *reopen_queue,
+                                           uint64_t perm, uint64_t shared,
+                                           uint64_t *nperm, uint64_t *nsha=
red)
+{
+    assert(child_class =3D=3D &child_backing ||
+           (child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_COW)));
+
+    /*
+     * We want consistent read from backing files if the parent needs it.
+     * No other operations are performed on backing files.
+     */
+    perm &=3D BLK_PERM_CONSISTENT_READ;
+
+    /*
+     * If the parent can deal with changing data, we're okay with a
+     * writable and resizable backing file.
+     * TODO Require !(perm & BLK_PERM_CONSISTENT_READ), too?
+     */
+    if (shared & BLK_PERM_WRITE) {
+        shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    } else {
+        shared =3D 0;
+    }
+
+    shared |=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
+              BLK_PERM_WRITE_UNCHANGED;
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
@@ -2317,28 +2355,8 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
         *nperm =3D perm;
         *nshared =3D shared;
     } else {
-        /* We want consistent read from backing files if the parent needs =
it.
-         * No other operations are performed on backing files. */
-        perm &=3D BLK_PERM_CONSISTENT_READ;
-
-        /* If the parent can deal with changing data, we're okay with a
-         * writable and resizable backing file. */
-        /* TODO Require !(perm & BLK_PERM_CONSISTENT_READ), too? */
-        if (shared & BLK_PERM_WRITE) {
-            shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        } else {
-            shared =3D 0;
-        }
-
-        shared |=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
-                  BLK_PERM_WRITE_UNCHANGED;
-
-        if (bs->open_flags & BDRV_O_INACTIVE) {
-            shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        *nperm =3D perm;
-        *nshared =3D shared;
+        bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_qu=
eue,
+                                       perm, shared, nperm, nshared);
     }
 }
=20
--=20
2.24.1


