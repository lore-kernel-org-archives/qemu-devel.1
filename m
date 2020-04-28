Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E533AC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35722085B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSiYuDPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35722085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWxC-0003e4-Hx
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWrG-0000rk-3x
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWrD-0006Ey-Lb
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTWrD-0006Ei-77
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588105770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiJtkm4BOPlkfyJYqkgh9TApAzazKeM4pdRoyO6Os24=;
 b=GSiYuDPY/bvckoAE7m0zUE/m3kA3aYoSArmsY8UDmlF7nfpTk+ent+rdCTwsYqtt6AE5me
 7Ht4vlPIG9niYkdvLeukRDQ49i/EMXkHgEvHlsRzSErx/pCyhGuDybhB+uti5vXwZHb341
 G2HNcv+uA/L6HzGCvhX8EeQ7ocwbLqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-EOKi1xUdOG63Q-8u6Atjhw-1; Tue, 28 Apr 2020 16:29:27 -0400
X-MC-Unique: EOKi1xUdOG63Q-8u6Atjhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F29DD835B44;
 Tue, 28 Apr 2020 20:29:25 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E63D5C1D4;
 Tue, 28 Apr 2020 20:29:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/9] parallels: Rework truncation logic
Date: Tue, 28 Apr 2020 15:29:03 -0500
Message-Id: <20200428202905.770727-8-eblake@redhat.com>
In-Reply-To: <20200428202905.770727-1-eblake@redhat.com>
References: <20200428202905.770727-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The parallels driver tries to use truncation for image growth, but can
only do so when reads are guaranteed as zero.  Now that we have a way
to request zero contents from truncation, we can defer the decision to
actual allocation attempts rather than up front, reducing the number
of places that still use bdrv_has_zero_init_truncate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/parallels.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 2be92cf41708..9dadaa3217b9 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -196,14 +196,24 @@ static int64_t allocate_clusters(BlockDriverState *bs=
, int64_t sector_num,
     }
     if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
         space +=3D s->prealloc_size;
+        /*
+         * We require the expanded size to read back as zero. If the
+         * user permitted truncation, we try that; but if it fails, we
+         * force the safer-but-slower fallocate.
+         */
+        if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_TRUNCATE) {
+            ret =3D bdrv_truncate(bs->file,
+                                (s->data_end + space) << BDRV_SECTOR_BITS,
+                                false, PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WR=
ITE,
+                                NULL);
+            if (ret =3D=3D -ENOTSUP) {
+                s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
+            }
+        }
         if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_FALLOCATE) {
             ret =3D bdrv_pwrite_zeroes(bs->file,
                                      s->data_end << BDRV_SECTOR_BITS,
                                      space << BDRV_SECTOR_BITS, 0);
-        } else {
-            ret =3D bdrv_truncate(bs->file,
-                                (s->data_end + space) << BDRV_SECTOR_BITS,
-                                false, PREALLOC_MODE_OFF, 0, NULL);
         }
         if (ret < 0) {
             return ret;
@@ -828,6 +838,7 @@ static int parallels_open(BlockDriverState *bs, QDict *=
options, int flags,
         qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
     s->prealloc_size =3D MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BI=
TS);
     buf =3D qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
+    /* prealloc_mode can be downgraded later during allocate_clusters */
     s->prealloc_mode =3D qapi_enum_parse(&prealloc_mode_lookup, buf,
                                        PRL_PREALLOC_MODE_FALLOCATE,
                                        &local_err);
@@ -836,10 +847,6 @@ static int parallels_open(BlockDriverState *bs, QDict =
*options, int flags,
         goto fail_options;
     }

-    if (!bdrv_has_zero_init_truncate(bs->file->bs)) {
-        s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
-    }
-
     if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
         s->header->inuse =3D cpu_to_le32(HEADER_INUSE_MAGIC);
         ret =3D parallels_update_header(bs);
--=20
2.26.2


