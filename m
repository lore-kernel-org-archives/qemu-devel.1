Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3161AC43215
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 02:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EDF206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 02:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIhN1Hf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EDF206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV5Dd-0000fJ-Vh
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 21:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iV59n-0005JR-KJ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iV59l-00034c-2L
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iV59k-000335-UU
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573699608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47xaOjcuo94e/5zHn1u4hTI+rbUhD+M67pRD//YF174=;
 b=CIhN1Hf33arA2Gynx/vML8BENWEjc2nDwh0FFB6j9ORx61WQh1DTABju1g2Qj896kgDCR7
 Oyc4VcLj69+U6+fX+n1pnLLtzvvEoFZpbIclzqDlcoFmThDcwh0l7nLAlB2qe3xiwlTHMp
 0E4KnX5r86YwD6AmS0CG7/89oE6Qgpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-qqT1jtxxOIOskAzBQDAK6Q-1; Wed, 13 Nov 2019 21:46:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCE70DB60;
 Thu, 14 Nov 2019 02:46:43 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56C9181759;
 Thu, 14 Nov 2019 02:46:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
Date: Wed, 13 Nov 2019 20:46:33 -0600
Message-Id: <20191114024635.11363-3-eblake@redhat.com>
In-Reply-To: <20191114024635.11363-1-eblake@redhat.com>
References: <20191114024635.11363-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qqT1jtxxOIOskAzBQDAK6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, mlevitsk@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We document that for qcow2 persistent bitmaps, the name cannot exceed
1023 bytes.  It is inconsistent if transient bitmaps do not have to
abide by the same limit, and it is unlikely that any existing client
even cares about using bitmap names this long.  It's time to codify
that ALL bitmaps managed by qemu (whether persistent in qcow2 or not)
have a documented maximum length.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json         |  2 +-
 include/block/dirty-bitmap.h |  2 ++
 block/dirty-bitmap.c         | 12 +++++++++---
 block/qcow2-bitmap.c         |  2 ++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index aa97ee264112..0cf68fea1450 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2042,7 +2042,7 @@
 #
 # @node: name of device/node which the bitmap is tracking
 #
-# @name: name of the dirty bitmap
+# @name: name of the dirty bitmap (must be less than 1024 bytes)
 #
 # @granularity: the bitmap granularity, default is 64k for
 #               block-dirty-bitmap-add
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 958e7474fb51..e2b20ecab9a3 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -14,6 +14,8 @@ typedef enum BitmapCheckFlags {
                              BDRV_BITMAP_INCONSISTENT)
 #define BDRV_BITMAP_ALLOW_RO (BDRV_BITMAP_BUSY | BDRV_BITMAP_INCONSISTENT)

+#define BDRV_BITMAP_MAX_NAME_SIZE 1023
+
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
                                           uint32_t granularity,
                                           const char *name,
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 4bbb251b2c9c..7039e8252009 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -104,9 +104,15 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverS=
tate *bs,

     assert(is_power_of_2(granularity) && granularity >=3D BDRV_SECTOR_SIZE=
);

-    if (name && bdrv_find_dirty_bitmap(bs, name)) {
-        error_setg(errp, "Bitmap already exists: %s", name);
-        return NULL;
+    if (name) {
+        if (bdrv_find_dirty_bitmap(bs, name)) {
+            error_setg(errp, "Bitmap already exists: %s", name);
+            return NULL;
+        }
+        if (strlen(name) > BDRV_BITMAP_MAX_NAME_SIZE) {
+            error_setg(errp, "Bitmap name too long: %s", name);
+            return NULL;
+        }
     }
     bitmap_size =3D bdrv_getlength(bs);
     if (bitmap_size < 0) {
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index ef9ef628a0d0..809bbc5d20c8 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -42,6 +42,8 @@
 #define BME_MIN_GRANULARITY_BITS 9
 #define BME_MAX_NAME_SIZE 1023

+QEMU_BUILD_BUG_ON(BME_MAX_NAME_SIZE !=3D BDRV_BITMAP_MAX_NAME_SIZE);
+
 #if BME_MAX_TABLE_SIZE * 8ULL > INT_MAX
 #error In the code bitmap table physical size assumed to fit into int
 #endif
--=20
2.21.0


