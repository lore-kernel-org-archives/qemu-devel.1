Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18DFCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4ED214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBctYie2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4ED214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP576-0004EK-Rx
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3xf-0003zT-Rc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3xe-0002Rh-EF
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3xe-0002RT-9M
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fkbcTi961hq47nQeUqVstg0lUGdtnHyS6F1r2aTKUI=;
 b=CBctYie2Ejjt00uJnkHlswFBfeAX38cXxG50aKoFHf5J0LSfAYe45wfy4KYja/y/uEL3du
 zWkdsyVH2ITkICfVXiua9iGLTKFT8V8eeP/hY9WZJFZxQmy3zmuRlw8I2N+o91uCHtsAgG
 lFD14vlnV771YAvVIOgettxwylmTrCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-Hh0Z4yNcNwuqy63uq4wlHQ-1; Mon, 28 Oct 2019 08:17:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A97610052E0;
 Mon, 28 Oct 2019 12:17:22 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D0916085E;
 Mon, 28 Oct 2019 12:17:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 66/69] block: Let format drivers pass @exact
Date: Mon, 28 Oct 2019 13:14:58 +0100
Message-Id: <20191028121501.15279-67-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Hh0Z4yNcNwuqy63uq4wlHQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When truncating a format node, the @exact parameter is generally handled
simply by virtue of the format storing the new size in the image
metadata.  Such formats do not need to pass on the parameter to their
file nodes.

There are exceptions, though:
- raw and crypto cannot store the image size, and thus must pass on
  @exact.

- When using qcow2 with an external data file, it just makes sense to
  keep its size in sync with the qcow2 virtual disk (because the
  external data file is the virtual disk).  Therefore, we should pass
  @exact when truncating it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190918095144.955-7-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/crypto.c     |  2 +-
 block/qcow2.c      | 15 ++++++++++++++-
 block/raw-format.c |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index e5a1a2cdf3..24823835c1 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -311,7 +311,7 @@ block_crypto_co_truncate(BlockDriverState *bs, int64_t =
offset, bool exact,
=20
     offset +=3D payload_offset;
=20
-    return bdrv_co_truncate(bs->file, offset, false, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
 }
=20
 static void block_crypto_close(BlockDriverState *bs)
diff --git a/block/qcow2.c b/block/qcow2.c
index de284ad803..9f32dae41f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4027,6 +4027,13 @@ static int coroutine_fn qcow2_co_truncate(BlockDrive=
rState *bs, int64_t offset,
         if ((last_cluster + 1) * s->cluster_size < old_file_size) {
             Error *local_err =3D NULL;
=20
+            /*
+             * Do not pass @exact here: It will not help the user if
+             * we get an error here just because they wanted to shrink
+             * their qcow2 image (on a block device) with qemu-img.
+             * (And on the qcow2 layer, the @exact requirement is
+             * always fulfilled, so there is no need to pass it on.)
+             */
             bdrv_co_truncate(bs->file, (last_cluster + 1) * s->cluster_siz=
e,
                              false, PREALLOC_MODE_OFF, &local_err);
             if (local_err) {
@@ -4045,7 +4052,12 @@ static int coroutine_fn qcow2_co_truncate(BlockDrive=
rState *bs, int64_t offset,
     switch (prealloc) {
     case PREALLOC_MODE_OFF:
         if (has_data_file(bs)) {
-            ret =3D bdrv_co_truncate(s->data_file, offset, false, prealloc=
, errp);
+            /*
+             * If the caller wants an exact resize, the external data
+             * file should be resized to the exact target size, too,
+             * so we pass @exact here.
+             */
+            ret =3D bdrv_co_truncate(s->data_file, offset, exact, prealloc=
, errp);
             if (ret < 0) {
                 goto fail;
             }
@@ -4130,6 +4142,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
         /* Allocate the data area */
         new_file_size =3D allocation_start +
                         nb_new_data_clusters * s->cluster_size;
+        /* Image file grows, so @exact does not matter */
         ret =3D bdrv_co_truncate(bs->file, new_file_size, false, prealloc,=
 errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to resize underlying file: ");
diff --git a/block/raw-format.c b/block/raw-format.c
index 57d84d0bae..3a76ec7dd2 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -387,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverStat=
e *bs, int64_t offset,
=20
     s->size =3D offset;
     offset +=3D s->offset;
-    return bdrv_co_truncate(bs->file, offset, false, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
 }
=20
 static void raw_eject(BlockDriverState *bs, bool eject_flag)
--=20
2.21.0


