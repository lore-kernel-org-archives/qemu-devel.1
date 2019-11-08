Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8D9FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4BC2245C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfoL4OBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4BC2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3Vz-0004cn-7w
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tp-0002XQ-7K
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tj-0003G6-Mv
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT3Tj-0003FS-Ia
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573216503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR+yxtQYa/cldhJ2LVJ/5iI77BG0Kv0l0hZCQawnnWs=;
 b=hfoL4OBn6ys3nH2eBF0N0r7/DD22JuzQWPKJhsWIbTRH4uNFrJnOq3SWTRorO+2XtbqWYf
 kp3/h79hCh3fdePGqI2W9TK5x7rYLCWln0hTwMPNLFUz+c2TcJIwUrRxdlCZNuwcZ795hm
 hO8i3tTEDh9frGu5OVhUAJ4Bk6t2TP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-wFNksgljN86z_42XPHKdMA-1; Fri, 08 Nov 2019 07:35:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 310D81005500;
 Fri,  8 Nov 2019 12:34:59 +0000 (UTC)
Received: from localhost (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C35055DA70;
 Fri,  8 Nov 2019 12:34:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v4 1/5] block: Add bdrv_qapi_perm_to_blk_perm()
Date: Fri,  8 Nov 2019 13:34:51 +0100
Message-Id: <20191108123455.39445-2-mreitz@redhat.com>
In-Reply-To: <20191108123455.39445-1-mreitz@redhat.com>
References: <20191108123455.39445-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: wFNksgljN86z_42XPHKdMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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

We need some way to correlate QAPI BlockPermission values with
BLK_PERM_* flags.  We could:

(1) have the same order in the QAPI definition as the the BLK_PERM_*
    flags are in LSb-first order.  However, then there is no guarantee
    that they actually match (e.g. when someone modifies the QAPI schema
    without thinking of the BLK_PERM_* definitions).
    We could add static assertions, but these would break what=E2=80=99s go=
od
    about this solution, namely its simplicity.

(2) define the BLK_PERM_* flags based on the BlockPermission values.
    But this way whenever someone were to modify the QAPI order
    (perfectly sensible in theory), the BLK_PERM_* values would change.
    Because these values are used for file locking, this might break
    file locking between different qemu versions.

Therefore, go the slightly more cumbersome way: Add a function to
translate from the QAPI constants to the BLK_PERM_* flags.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c               | 18 ++++++++++++++++++
 include/block/block.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/block.c b/block.c
index 4cffc2bc35..066433f3e2 100644
--- a/block.c
+++ b/block.c
@@ -2227,6 +2227,24 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
     *nshared =3D shared;
 }
=20
+uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm)
+{
+    static const uint64_t permissions[] =3D {
+        [BLOCK_PERMISSION_CONSISTENT_READ]  =3D BLK_PERM_CONSISTENT_READ,
+        [BLOCK_PERMISSION_WRITE]            =3D BLK_PERM_WRITE,
+        [BLOCK_PERMISSION_WRITE_UNCHANGED]  =3D BLK_PERM_WRITE_UNCHANGED,
+        [BLOCK_PERMISSION_RESIZE]           =3D BLK_PERM_RESIZE,
+        [BLOCK_PERMISSION_GRAPH_MOD]        =3D BLK_PERM_GRAPH_MOD,
+    };
+
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(permissions) !=3D BLOCK_PERMISSION__MAX);
+    QEMU_BUILD_BUG_ON(1UL << ARRAY_SIZE(permissions) !=3D BLK_PERM_ALL + 1=
);
+
+    assert(qapi_perm < BLOCK_PERMISSION__MAX);
+
+    return permissions[qapi_perm];
+}
+
 static void bdrv_replace_child_noperm(BdrvChild *child,
                                       BlockDriverState *new_bs)
 {
diff --git a/include/block/block.h b/include/block/block.h
index 1df9848e74..e9dcfef7fa 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -280,6 +280,7 @@ enum {
 };
=20
 char *bdrv_perm_names(uint64_t perm);
+uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);
=20
 /* disk I/O throttling */
 void bdrv_init(void);
--=20
2.23.0


