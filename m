Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B585C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F502230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XX6hRkF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F502230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQeC-0003dk-6z
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXQaG-0006NX-P5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXQaF-0000sz-MV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28510
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXQaF-0000sc-Ii
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574258631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kj75bEF7gydfToKDJj/rPaqrglHCjvzP9RAgL97bSyo=;
 b=XX6hRkF2K5dMji9O9yXZ2fevJO1cp0My7xKrTpA8bMS8CQc68ret2MPABP9RxWamlWv727
 9iOr/3OHohkcrPya3XtlXZhxEdYdEKhHsu7Ig12KvNMyAnGMQm0WoPfnWg3WZSZELrWbWu
 WnhjmBLWDNwI0Ssrbhq1Pw2Hz853l0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-mOh5jKF5OJSmG10yHibUDQ-1; Wed, 20 Nov 2019 09:03:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11D158024D5;
 Wed, 20 Nov 2019 14:03:47 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C57960BB5;
 Wed, 20 Nov 2019 14:03:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/6] block: truncate: Don't make backing file data visible
Date: Wed, 20 Nov 2019 15:03:15 +0100
Message-Id: <20191120140319.1505-3-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-1-kwolf@redhat.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mOh5jKF5OJSmG10yHibUDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When extending the size of an image that has a backing file larger than
its old size, make sure that the backing file data doesn't become
visible in the guest, but the added area is properly zeroed out.

The old behaviour made a difference in 'block_resize' (where showing the
backing file data from an old snapshot rather than zeros is
questionable) as well as in commit block jobs (both from active and
intermediate nodes) and HMP 'commit', where committing to a short
backing file would incorrectly omit writing zeroes for unallocated
blocks on the top layer after the EOF of the short backing file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/io.c b/block/io.c
index 003f4ea38c..8683f7a4bd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3382,6 +3382,31 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, =
int64_t offset, bool exact,
         goto out;
     }
=20
+    /*
+     * If the image has a backing file that is large enough that it would
+     * provide data for the new area, we cannot leave it unallocated becau=
se
+     * then the backing file content would become visible. Instead, zero-f=
ill
+     * the area where backing file and new area overlap.
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
+            ret =3D bdrv_co_do_pwrite_zeroes(bs, old_size,
+                                           MIN(new_bytes, backing_len - ol=
d_size),
+                                           BDRV_REQ_ZERO_WRITE | BDRV_REQ_=
MAY_UNMAP);
+            if (ret < 0) {
+                goto out;
+            }
+        }
+    }
+
     ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not refresh total sector count=
");
--=20
2.20.1


