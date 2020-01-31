Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC869C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DC421734
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMrWUDp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DC421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaNO-0005UK-U3
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLa-0002gO-AP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLY-0004OM-VX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLY-0004Nf-Pi
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKI/xOJyK4CEKumsYglI3UK/B8/0BuSux4WShyruRtU=;
 b=gMrWUDp21dmatYcclw3QRCEJ6vRQoGH+iaXED1ALKH8t/XmQgcw5cxvUCYZpiFII9E5L1i
 3Xsvfzrn+bZpL/N7wm8GBPaOpka2h5kqgVSb1I291+mLQpeVqEg9+MtWUBUjyPR1xrXUCc
 UU2/b/qElbpfa6iSuf7tcrMpV9vyKqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-5TsUAxCrOmeiVtF9B3E9pA-1; Fri, 31 Jan 2020 12:44:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BEE01937FC5;
 Fri, 31 Jan 2020 17:44:42 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEF1584BCE;
 Fri, 31 Jan 2020 17:44:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/17] block: Don't advertise zero_init_truncate with
 encryption
Date: Fri, 31 Jan 2020 11:44:24 -0600
Message-Id: <20200131174436.2961874-6-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5TsUAxCrOmeiVtF9B3E9pA-1
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 38841dcd correctly argued that having qcow2 blindly return 1
for .bdrv_has_zero_init() is wrong for preallocated images built on
block devices, while .bdrv_has_zero_init_truncate() can still return 1
because it is only relied on when changing size with PREALLOC_MODE_OFF
(and this is true even for v2 images which lack the notion of an
explicit zero cluster, since the block layer already filters out the
case of a larger backing file leaking through).  However, it missed
the fact that encrypted images do not default to reading as zero in
any case.

However, instead of changing qcow2's .bdrv_has_zero_init_truncate() to
point to a one-off function that special-cases bs->encryption, it is
smarter to just move the logic about encryption directly to the block
layer (that is, the driver callbacks will never be invoked for
encrypted images, just like they are already not called when a backing
file is present).  This solution fixes the qcow2 issue, has no effect
on the crypto driver (which already lacks .bdrv_has_zero_init*
callbacks), and no other driver currently uses bs->encrypted.

One other reason to fix this at the block layer: any information we
expose about an encrypted image that in turn may alter timing of
algorithms run on that image can be considered a (slight) information
leak; refusing to optimize zero handling of encrypted images thus
avoids the possibility of that being a security concern.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c       | 19 ++++++++++++++++---
 block/qcow2.c |  2 --
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 6c2b2bd2e292..296845040e59 100644
--- a/block.c
+++ b/block.c
@@ -5077,9 +5077,12 @@ int bdrv_has_zero_init(BlockDriverState *bs)
         return 0;
     }

-    /* If BS is a copy on write image, it is initialized to
-       the contents of the base image, which may not be zeroes.  */
-    if (bs->backing) {
+    /*
+     * If BS is a copy on write image, it is initialized to the
+     * contents of the base image, which may not be zeroes.  Likewise,
+     * encrypted images do not read as zero.
+     */
+    if (bs->backing || bs->encrypted) {
         return 0;
     }
     if (bs->drv->bdrv_has_zero_init) {
@@ -5099,6 +5102,16 @@ int bdrv_has_zero_init_truncate(BlockDriverState *bs=
)
         return 0;
     }

+    /*
+     * Encrypted images never default to reading all zero; and even if
+     * they did, advertising that fact might lead to an information
+     * leak based on timing comparisons of algorithms that change if
+     * our result were dynamic.
+     */
+    if (bs->encrypted) {
+        return 0;
+    }
+
     if (bs->backing) {
         /* Depends on the backing image length, but better safe than sorry=
 */
         return 0;
diff --git a/block/qcow2.c b/block/qcow2.c
index 6ea06dbdf48a..40aa751d1de7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4934,8 +4934,6 @@ static int qcow2_has_zero_init(BlockDriverState *bs)

     if (!preallocated) {
         return 1;
-    } else if (bs->encrypted) {
-        return 0;
     } else {
         return bdrv_has_zero_init(s->data_file->bs);
     }
--=20
2.24.1


