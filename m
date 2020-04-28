Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF042C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328B12085B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaB/BJAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328B12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWw8-0001I6-15
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWrG-0000tZ-OC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWrF-0006FK-B5
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTWrE-0006F6-RH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588105772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jA4LUUOrccYXDFuL7sYE/Al5qd+NSv/o7L7uj2ovfWs=;
 b=YaB/BJAmZJTEK69P+/deH6If9EjklXj2eVJBac/B+3uOn8f778J5/CE2k3EAin0fwV0ShR
 lGYsC2OLRbgW3Y02KppFCBT7xKIWJA02JmXW2FrkoIm/2IQap6XfgcprqQMIO/drul7MK+
 wUAlu0/2DqLlpNo4Zm5vLMpQAW9KJW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-eYl3Wl9aOfC3QrxM7raFmg-1; Tue, 28 Apr 2020 16:29:28 -0400
X-MC-Unique: eYl3Wl9aOfC3QrxM7raFmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 262E4107ACF3;
 Tue, 28 Apr 2020 20:29:27 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4673D5C1D4;
 Tue, 28 Apr 2020 20:29:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/9] vhdx: Rework truncation logic
Date: Tue, 28 Apr 2020 15:29:04 -0500
Message-Id: <20200428202905.770727-9-eblake@redhat.com>
In-Reply-To: <20200428202905.770727-1-eblake@redhat.com>
References: <20200428202905.770727-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, Jeff Cody <codyprime@gmail.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vhdx driver uses truncation for image growth, with a special case
for blocks that already read as zero but which are only being
partially written.  But with a bit of rearranging, it's just as easy
to defer the decision on whether truncation resulted in zeroes to the
actual allocation attempt, reducing the number of places that still
use bdrv_has_zero_init_truncate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/vhdx.c | 89 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 38 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 21497f731878..fe544abaf52a 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1241,12 +1241,16 @@ exit:
 /*
  * Allocate a new payload block at the end of the file.
  *
- * Allocation will happen at 1MB alignment inside the file
+ * Allocation will happen at 1MB alignment inside the file.
+ *
+ * If @need_zero is set on entry but not cleared on return, then truncatio=
n
+ * could not guarantee that the new portion reads as zero, and the caller
+ * will take care of it instead.
  *
  * Returns the file offset start of the new payload block
  */
 static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
-                                    uint64_t *new_offset)
+                               uint64_t *new_offset, bool *need_zero)
 {
     int64_t current_len;

@@ -1263,6 +1267,17 @@ static int vhdx_allocate_block(BlockDriverState *bs,=
 BDRVVHDXState *s,
         return -EINVAL;
     }

+    if (*need_zero) {
+        int ret;
+
+        ret =3D bdrv_truncate(bs->file, *new_offset + s->block_size, false=
,
+                            PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
+        if (ret !=3D -ENOTSUP) {
+            *need_zero =3D false;
+            return ret;
+        }
+    }
+
     return bdrv_truncate(bs->file, *new_offset + s->block_size, false,
                          PREALLOC_MODE_OFF, 0, NULL);
 }
@@ -1356,18 +1371,38 @@ static coroutine_fn int vhdx_co_writev(BlockDriverS=
tate *bs, int64_t sector_num,
                 /* in this case, we need to preserve zero writes for
                  * data that is not part of this write, so we must pad
                  * the rest of the buffer to zeroes */
-
-                /* if we are on a posix system with ftruncate() that exten=
ds
-                 * a file, then it is zero-filled for us.  On Win32, the r=
aw
-                 * layer uses SetFilePointer and SetFileEnd, which does no=
t
-                 * zero fill AFAIK */
-
-                /* Queue another write of zero buffers if the underlying f=
ile
-                 * does not zero-fill on file extension */
-
-                if (bdrv_has_zero_init_truncate(bs->file->bs) =3D=3D 0) {
-                    use_zero_buffers =3D true;
-
+                use_zero_buffers =3D true;
+                /* fall through */
+            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
+            case PAYLOAD_BLOCK_UNMAPPED:
+            case PAYLOAD_BLOCK_UNMAPPED_v095:
+            case PAYLOAD_BLOCK_UNDEFINED:
+                bat_prior_offset =3D sinfo.file_offset;
+                ret =3D vhdx_allocate_block(bs, s, &sinfo.file_offset,
+                                          &use_zero_buffers);
+                if (ret < 0) {
+                    goto exit;
+                }
+                /*
+                 * once we support differencing files, this may also be
+                 * partially present
+                 */
+                /* update block state to the newly specified state */
+                vhdx_update_bat_table_entry(bs, s, &sinfo, &bat_entry,
+                                            &bat_entry_offset,
+                                            PAYLOAD_BLOCK_FULLY_PRESENT);
+                bat_update =3D true;
+                /*
+                 * Since we just allocated a block, file_offset is the
+                 * beginning of the payload block. It needs to be the
+                 * write address, which includes the offset into the
+                 * block, unless the entire block needs to read as
+                 * zeroes but truncation was not able to provide them,
+                 * in which case we need to fill in the rest.
+                 */
+                if (!use_zero_buffers) {
+                    sinfo.file_offset +=3D sinfo.block_offset;
+                } else {
                     /* zero fill the front, if any */
                     if (sinfo.block_offset) {
                         iov1.iov_len =3D sinfo.block_offset;
@@ -1379,7 +1414,7 @@ static coroutine_fn int vhdx_co_writev(BlockDriverSta=
te *bs, int64_t sector_num,
                     }

                     /* our actual data */
-                    qemu_iovec_concat(&hd_qiov, qiov,  bytes_done,
+                    qemu_iovec_concat(&hd_qiov, qiov, bytes_done,
                                       sinfo.bytes_avail);

                     /* zero fill the back, if any */
@@ -1394,29 +1429,7 @@ static coroutine_fn int vhdx_co_writev(BlockDriverSt=
ate *bs, int64_t sector_num,
                         sectors_to_write +=3D iov2.iov_len >> BDRV_SECTOR_=
BITS;
                     }
                 }
-                /* fall through */
-            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
-            case PAYLOAD_BLOCK_UNMAPPED:
-            case PAYLOAD_BLOCK_UNMAPPED_v095:
-            case PAYLOAD_BLOCK_UNDEFINED:
-                bat_prior_offset =3D sinfo.file_offset;
-                ret =3D vhdx_allocate_block(bs, s, &sinfo.file_offset);
-                if (ret < 0) {
-                    goto exit;
-                }
-                /* once we support differencing files, this may also be
-                 * partially present */
-                /* update block state to the newly specified state */
-                vhdx_update_bat_table_entry(bs, s, &sinfo, &bat_entry,
-                                            &bat_entry_offset,
-                                            PAYLOAD_BLOCK_FULLY_PRESENT);
-                bat_update =3D true;
-                /* since we just allocated a block, file_offset is the
-                 * beginning of the payload block. It needs to be the
-                 * write address, which includes the offset into the block=
 */
-                if (!use_zero_buffers) {
-                    sinfo.file_offset +=3D sinfo.block_offset;
-                }
+
                 /* fall through */
             case PAYLOAD_BLOCK_FULLY_PRESENT:
                 /* if the file offset address is in the header zone,
--=20
2.26.2


