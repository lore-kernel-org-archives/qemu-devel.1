Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA8F20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAJ9OYgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA8F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHQx-0008SV-CD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHPU-0006kt-Dt
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHPQ-0004mE-77
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHPQ-0004iq-42
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580419891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM48J+YDySyDffAEv62+MyKxuBzqVzbkMx2nuDH/eMI=;
 b=LAJ9OYgXdvFBuiKkar1Dj3mF7mUfwmQS+rV1f1BvrEGM7+x2Wh5Km05NA3jjPbgbiKg/h6
 KjXBpkmP53kS5GevixNQD6KjVqf7sinGSTLBPvZOpHM4ooU62yxdCqu8vag9+SvXw3bZ6d
 EZBs8FFwltvMnhz+5xG5GqTFhfeVdFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-wLsCBkhsPFKWi0vUDmQA1w-1; Thu, 30 Jan 2020 16:31:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11A078017CC;
 Thu, 30 Jan 2020 21:31:28 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B60FF5C1B2;
 Thu, 30 Jan 2020 21:31:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] block: eliminate BDRV_REQ_NO_SERIALISING
Date: Thu, 30 Jan 2020 21:30:57 +0000
Message-Id: <20200130213114.325157-2-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-1-stefanha@redhat.com>
References: <20200130213114.325157-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: wLsCBkhsPFKWi0vUDmQA1w-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

It is unused since commit 00e30f0 ("block/backup: use backup-top instead
of write notifiers", 2019-10-01), drop it to simplify the code.

While at it, drop redundant assertions on flags.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 1578495356-46219-2-git-send-email-pbonzini@redhat.com
Message-Id: <1578495356-46219-2-git-send-email-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c            | 18 ++++--------------
 include/block/block.h | 12 ------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/block/io.c b/block/io.c
index f75777f5ea..b3a67fe1db 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1445,8 +1445,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild=
 *child,
      * potential fallback support, if we ever implement any read flags
      * to pass through to drivers.  For now, there aren't any
      * passthrough flags.  */
-    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ |
-                       BDRV_REQ_PREFETCH)));
+    assert(!(flags & ~(BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH)));
=20
     /* Handle Copy on Read and associated serialisation */
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -1458,12 +1457,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChil=
d *child,
         bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
     }
=20
-    /* BDRV_REQ_SERIALISING is only for write operation */
-    assert(!(flags & BDRV_REQ_SERIALISING));
-
-    if (!(flags & BDRV_REQ_NO_SERIALISING)) {
-        bdrv_wait_serialising_requests(req);
-    }
+    bdrv_wait_serialising_requests(req);
=20
     if (flags & BDRV_REQ_COPY_ON_READ) {
         int64_t pnum;
@@ -1711,7 +1705,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child=
,
     bdrv_inc_in_flight(bs);
=20
     /* Don't do copy-on-read if we read data before write operation */
-    if (atomic_read(&bs->copy_on_read) && !(flags & BDRV_REQ_NO_SERIALISIN=
G)) {
+    if (atomic_read(&bs->copy_on_read)) {
         flags |=3D BDRV_REQ_COPY_ON_READ;
     }
=20
@@ -1852,8 +1846,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t o=
ffset, uint64_t bytes,
         return -EPERM;
     }
=20
-    /* BDRV_REQ_NO_SERIALISING is only for read operation */
-    assert(!(flags & BDRV_REQ_NO_SERIALISING));
     assert(!(bs->open_flags & BDRV_O_INACTIVE));
     assert((bs->open_flags & BDRV_O_NO_IO) =3D=3D 0);
     assert(!(flags & ~BDRV_REQ_MASK));
@@ -3222,9 +3214,7 @@ static int coroutine_fn bdrv_co_copy_range_internal(
=20
         /* BDRV_REQ_SERIALISING is only for write operation */
         assert(!(read_flags & BDRV_REQ_SERIALISING));
-        if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
-            bdrv_wait_serialising_requests(&req);
-        }
+        bdrv_wait_serialising_requests(&req);
=20
         ret =3D src->bs->drv->bdrv_co_copy_range_from(src->bs,
                                                     src, src_offset,
diff --git a/include/block/block.h b/include/block/block.h
index e9dcfef7fa..23c76421e4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -51,18 +51,6 @@ typedef enum {
      */
     BDRV_REQ_MAY_UNMAP          =3D 0x4,
=20
-    /*
-     * The BDRV_REQ_NO_SERIALISING flag is only valid for reads and means =
that
-     * we don't want wait_serialising_requests() during the read operation=
.
-     *
-     * This flag is used for backup copy-on-write operations, when we need=
 to
-     * read old data before write (write notifier triggered). It is okay s=
ince
-     * we already waited for other serializing requests in the initiating =
write
-     * (see bdrv_aligned_pwritev), and it is necessary if the initiating w=
rite
-     * is already serializing (without the flag, the read would deadlock
-     * waiting for the serialising write to complete).
-     */
-    BDRV_REQ_NO_SERIALISING     =3D 0x8,
     BDRV_REQ_FUA                =3D 0x10,
     BDRV_REQ_WRITE_COMPRESSED   =3D 0x20,
=20
--=20
2.24.1


