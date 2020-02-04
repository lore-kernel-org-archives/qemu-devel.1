Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11FBC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596ED2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdSOcOEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596ED2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1lh-0001sv-FE
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hn-0003Vt-Kq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hm-00039p-Lj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hm-00036K-I3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YD9ure/h6d4i1Hq2fV3yRqhlaYDwYh41aimpnPmJGAY=;
 b=CdSOcOEEwqlZAb066MmG36NKSyNHoscVhfFQbAvWCzHBLTS07q6IejNWKUAI1Y0vtwXnC2
 W+/R2SQG7M8GLLZ/p1WJ7NuwI75FQF78jT4V8/Nw7TFDi1RBhG2yDNvtx975aZpgZPPahF
 un6TJRMnMJbk74/SjxTLxOL4aeenLs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-5q1B4ZKoM7SmFwhCbidd5g-1; Tue, 04 Feb 2020 12:09:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30001801F74;
 Tue,  4 Feb 2020 17:09:33 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EE7A1BC6D;
 Tue,  4 Feb 2020 17:09:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 14/33] block: Distinguish paths in *_format_default_perms
Date: Tue,  4 Feb 2020 18:08:29 +0100
Message-Id: <20200204170848.614480-15-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5q1B4ZKoM7SmFwhCbidd5g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_format_default_perms() has one code path for backing files, and one
for storage files.  We want to pull them out into own functions, so
make sure they are completely distinct before so the next patches will
be a bit cleaner.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 1816e92674..39ba6aad0a 100644
--- a/block.c
+++ b/block.c
@@ -2309,6 +2309,13 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
             perm |=3D BLK_PERM_CONSISTENT_READ;
         }
         shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
+
+        if (bs->open_flags & BDRV_O_INACTIVE) {
+            shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
+        }
+
+        *nperm =3D perm;
+        *nshared =3D shared;
     } else {
         /* We want consistent read from backing files if the parent needs =
it.
          * No other operations are performed on backing files. */
@@ -2325,14 +2332,14 @@ void bdrv_format_default_perms(BlockDriverState *bs=
, BdrvChild *c,
=20
         shared |=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
                   BLK_PERM_WRITE_UNCHANGED;
-    }
=20
-    if (bs->open_flags & BDRV_O_INACTIVE) {
-        shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-    }
+        if (bs->open_flags & BDRV_O_INACTIVE) {
+            shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
+        }
=20
-    *nperm =3D perm;
-    *nshared =3D shared;
+        *nperm =3D perm;
+        *nshared =3D shared;
+    }
 }
=20
 uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm)
--=20
2.24.1


