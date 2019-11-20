Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0459C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCE8206CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwFMVtEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCE8206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXV2C-0006SR-K8
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXUyi-00046i-Kb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXUyh-0005w4-CQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:45:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXUyh-0005vw-9Z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574275522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VChUaYDMKgOfJYiyiAjNsc7dnP3cRxMNS3wRwVjtGM=;
 b=cwFMVtEhUyYnseeOFAEBrBXc0sEhZqNhNkLJGEgu9NVlanZFI0CzyQEvzsfhK5ZODDVYd3
 d0Qct8iXmNQMHrs6oKD+cjf+IU6UYzQeVyjHtqppmToJKBW1qhAyLG4wv2VzVg4NSyG/5q
 LGj0ADhh3LanP8w2Jjkxndx09Qr38IM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-UiNYszBnMrmFwl84Mq6NnQ-1; Wed, 20 Nov 2019 13:45:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85695100550E;
 Wed, 20 Nov 2019 18:45:18 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F05D01042B7D;
 Wed, 20 Nov 2019 18:45:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/6] block: truncate: Don't make backing file data visible
Date: Wed, 20 Nov 2019 19:44:57 +0100
Message-Id: <20191120184501.28159-3-kwolf@redhat.com>
In-Reply-To: <20191120184501.28159-1-kwolf@redhat.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: UiNYszBnMrmFwl84Mq6NnQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When extending the size of an image that has a backing file larger than
its old size, make sure that the backing file data doesn't become
visible in the guest, but the added area is properly zeroed out.

Consider the following scenario where the overlay is shorter than its
backing file:

    base.qcow2:     AAAAAAAA
    overlay.qcow2:  BBBB

When resizing (extending) overlay.qcow2, the new blocks should not stay
unallocated and make the additional As from base.qcow2 visible like
before this patch, but zeros should be read.

A similar case happens with the various variants of a commit job when an
intermediate file is short (- for unallocated):

    base.qcow2:     A-A-AAAA
    mid.qcow2:      BB-B
    top.qcow2:      C--C--C-

After commit top.qcow2 to mid.qcow2, the following happens:

    mid.qcow2:      CB-C00C0 (correct result)
    mid.qcow2:      CB-C--C- (before this fix)

Without the fix, blocks that previously read as zeros on top.qcow2
suddenly turn into A.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/block/io.c b/block/io.c
index 003f4ea38c..6a5144f8d2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3385,12 +3385,44 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child,=
 int64_t offset, bool exact,
     ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not refresh total sector count=
");
+        goto fail_refresh_total_sectors;
     } else {
         offset =3D bs->total_sectors * BDRV_SECTOR_SIZE;
     }
+
+    /*
+     * If the image has a backing file that is large enough that it would
+     * provide data for the new area, we cannot leave it unallocated becau=
se
+     * then the backing file content would become visible. Instead, zero-f=
ill
+     * the area where backing file and new area overlap.
+     *
+     * Note that if the image has a backing file, but was opened without t=
he
+     * backing file, taking care of keeping things consistent with that ba=
cking
+     * file is the user's responsibility.
+     */
+    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF) {
+        int64_t backing_len;
+
+        backing_len =3D bdrv_getlength(backing_bs(bs));
+        if (backing_len < 0) {
+            ret =3D backing_len;
+            goto out;
+        }
+
+        if (backing_len > old_size) {
+            ret =3D bdrv_co_do_pwrite_zeroes(
+                    bs, old_size, MIN(new_bytes, backing_len - old_size),
+                    BDRV_REQ_ZERO_WRITE | BDRV_REQ_MAY_UNMAP);
+            if (ret < 0) {
+                goto out;
+            }
+        }
+    }
+
     /* It's possible that truncation succeeded but refresh_total_sectors
      * failed, but the latter doesn't affect how we should finish the requ=
est.
      * Pass 0 as the last parameter so that dirty bitmaps etc. are handled=
. */
+fail_refresh_total_sectors:
     bdrv_co_write_req_finish(child, offset - new_bytes, new_bytes, &req, 0=
);
=20
 out:
--=20
2.20.1


