Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B614EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86ADC21734
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dq6WucUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ADC21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaQB-0001OO-JT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLj-00038w-VC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLi-0004fF-L5
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLi-0004ec-Gx
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4rFAJzXEu4+xQ1KGm8pisE5inMABop5rkbEiEgeSus=;
 b=Dq6WucUY7Oer/xMFxr0dg535DdCMYpooGvw4YAbFEPZW1F+NWclsIftYwyoShfjWqIuTQV
 0q58SEWTXK92MHYI/enIRjl1EDg+3xU01i57alqE1wDBRXqVNvyXHAIuipfxAi6LI3bly1
 O7TzoqUokToVGH5x9sP2/oJ61KZsWxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-VmLEKIqBO4SMu_YsNn6m9A-1; Fri, 31 Jan 2020 12:44:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51FC61937FC0;
 Fri, 31 Jan 2020 17:44:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4E1384D96;
 Fri, 31 Jan 2020 17:44:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/17] block: Add new BDRV_ZERO_OPEN flag
Date: Fri, 31 Jan 2020 11:44:29 -0600
Message-Id: <20200131174436.2961874-11-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: VmLEKIqBO4SMu_YsNn6m9A-1
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Knowing that a file reads as all zeroes when created is useful, but
limited in scope to drivers that can create images.  However, there
are also situations where pre-existing images can quickly be
determined to read as all zeroes, even when the image was not just
created by the same process.  The optimization used in qemu-img
convert to avoid a pre-zeroing pass on the destination is just as
useful in such a scenario.  As such, it is worth the block layer
adding another bit to bdrv_known_zeroes().

Note that while BDRV_ZERO_CREATE cannot chase through backing layers
(because it only applies at creation time, but the backing layer was
not created at the same time as the active layer being created), it IS
okay for BDRV_ZERO_OPEN to chase through layers (as long as all layers
currently read as zero, the image reads as zero).

Upcoming patches will update the qcow2, file-posix, and nbd drivers to
advertise the new bit when appropriate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c               | 12 ++++++------
 include/block/block.h | 10 ++++++++++
 qemu-img.c            | 10 ++++++----
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index fac0813140aa..d68f527dc41f 100644
--- a/block.c
+++ b/block.c
@@ -5078,7 +5078,7 @@ int bdrv_known_zeroes_truncate(BlockDriverState *bs)

 int bdrv_known_zeroes(BlockDriverState *bs)
 {
-    int mask =3D BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE;
+    int mask =3D BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE | BDRV_ZERO_OPEN;

     if (!bs->drv) {
         return 0;
@@ -5100,17 +5100,17 @@ int bdrv_known_zeroes(BlockDriverState *bs)
      * ZERO_CREATE is not viable.  If the current layer is smaller
      * than the backing layer, truncation may expose backing data,
      * restricting ZERO_TRUNCATE; treat failure to query size in the
-     * same manner.  Otherwise, we can trust the driver.
+     * same manner.  For ZERO_OPEN, we insist that both backing and
+     * current layer report the bit.
      */
-
     if (bs->backing) {
         int64_t back =3D bdrv_getlength(bs->backing->bs);
         int64_t curr =3D bdrv_getlength(bs);

-        if (back < 0 || curr < back) {
-            return 0;
+        mask =3D bdrv_known_zeroes(bs->backing->bs) & BDRV_ZERO_OPEN;
+        if (back >=3D 0 && curr >=3D back) {
+            mask |=3D BDRV_ZERO_TRUNCATE;
         }
-        mask =3D BDRV_ZERO_TRUNCATE;
     }

     if (bs->drv->bdrv_known_zeroes) {
diff --git a/include/block/block.h b/include/block/block.h
index a6a227f50678..dafb8cc2bd80 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -105,6 +105,16 @@ typedef enum {
      * for drivers that set .bdrv_co_truncate.
      */
     BDRV_ZERO_TRUNCATE      =3D 0x2,
+
+    /*
+     * bdrv_known_zeroes() should include this bit if an image is
+     * known to read as all zeroes when first opened; this bit should
+     * not be relied on after any writes to the image.  This can be
+     * set even if BDRV_ZERO_INIT is clear, but should only be set if
+     * making the determination is more efficient than looping over
+     * block status for the image.
+     */
+    BDRV_ZERO_OPEN          =3D 0x4,
 } BdrvZeroFlags;

 typedef struct BlockSizes {
diff --git a/qemu-img.c b/qemu-img.c
index e60217e6c382..c8519a74f738 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1985,10 +1985,12 @@ static int convert_do_copy(ImgConvertState *s)
     int64_t sector_num =3D 0;

     /* Check whether we have zero initialisation or can get it efficiently=
 */
-    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
-        !s->target_has_backing) {
-        s->has_zero_init =3D !!(bdrv_known_zeroes(blk_bs(s->target)) &
-                              BDRV_ZERO_CREATE);
+    if (!s->has_zero_init && s->min_sparse && !s->target_has_backing) {
+        ret =3D bdrv_known_zeroes(blk_bs(s->target));
+        if (ret & BDRV_ZERO_OPEN ||
+            (s->target_is_new && ret & BDRV_ZERO_CREATE)) {
+            s->has_zero_init =3D true;
+        }
     }

     if (!s->has_zero_init && !s->target_has_backing &&
--=20
2.24.1


