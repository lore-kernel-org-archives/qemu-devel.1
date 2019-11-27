Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B9C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFDC20678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g702vqf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFDC20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxYS-0008Rl-98
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBm-0003yd-W9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBl-0006fX-Iw
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBl-0006dV-CZ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gHbzE/cU5BM+ZWevkVt9OYf2iwoN0E1OIBZLqb5v6cE=;
 b=g702vqf3lkgIB97hOQCw7RHx1q9wlEMRhsaPopnDI6k0D8VohL0RtWH+0ElnXJsjz1bBPz
 041wUyQR/2QHcV2JeZGS2vOhoMLp9Aypg+FQZUilfhlVq8gDABsQNGgbnGua/bx6Dwp+Hn
 3+cVh7vVkOKllZcxnwscLdiGxT60xQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-Dx3axAjWPvGxx3gWd2JSoA-1; Wed, 27 Nov 2019 08:16:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C186184CAD3;
 Wed, 27 Nov 2019 13:16:56 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C894467646;
 Wed, 27 Nov 2019 13:16:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 12/31] block: Distinguish paths in
 *_format_default_perms
Date: Wed, 27 Nov 2019 14:16:05 +0100
Message-Id: <20191127131624.1062403-13-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Dx3axAjWPvGxx3gWd2JSoA-1
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

bdrv_format_default_perms() has one code path for backing files, and one
for storage files.  We want to pull them out into own functions, so
make sure they are completely distinct before so the next patches will
be a bit cleaner.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 8542768d35..eb282f0977 100644
--- a/block.c
+++ b/block.c
@@ -2285,6 +2285,13 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
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
@@ -2301,14 +2308,14 @@ void bdrv_format_default_perms(BlockDriverState *bs=
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
2.23.0


