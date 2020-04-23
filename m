Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53CBC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B5220857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMGHeUqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B5220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdSZ-0006TT-OL
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMW-00056o-5g
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMU-0005s1-T8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:01:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRdMU-0005qe-Bz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587654117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Nn1BGNDRMJUjvTEPK9lcTHhadvK0dy2H3wmO+BNMOo=;
 b=ZMGHeUqfwETsKcysgvNdUyCI4ZzShxn/9iJ/RVlRwaCGw4h65OBWTqY0+OiQqD1Z+8Z6c+
 bCNridpLX3R4Z8ae1lkQgItPNV/bXZhKloxl//DPqciGne67cPHS6uOIPLdK3BLaeaaulU
 ui9aAHJC0robAtAFAloB8Car+T1fyEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-8HHwYAVWNaq74q8RW0VP3g-1; Thu, 23 Apr 2020 11:01:53 -0400
X-MC-Unique: 8HHwYAVWNaq74q8RW0VP3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD70835B42;
 Thu, 23 Apr 2020 15:01:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C613C60C81;
 Thu, 23 Apr 2020 15:01:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 07/10] block: truncate: Don't make backing file data visible
Date: Thu, 23 Apr 2020 17:01:24 +0200
Message-Id: <20200423150127.142609-8-kwolf@redhat.com>
In-Reply-To: <20200423150127.142609-1-kwolf@redhat.com>
References: <20200423150127.142609-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
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
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/io.c b/block/io.c
index 795075954e..f618db3499 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3394,6 +3394,30 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, =
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
+     * the new area.
+     *
+     * Note that if the image has a backing file, but was opened without t=
he
+     * backing file, taking care of keeping things consistent with that ba=
cking
+     * file is the user's responsibility.
+     */
+    if (new_bytes && bs->backing) {
+        int64_t backing_len;
+
+        backing_len =3D bdrv_getlength(backing_bs(bs));
+        if (backing_len < 0) {
+            ret =3D backing_len;
+            goto out;
+        }
+
+        if (backing_len > old_size) {
+            flags |=3D BDRV_REQ_ZERO_WRITE;
+        }
+    }
+
     if (drv->bdrv_co_truncate) {
         if (flags & ~bs->supported_truncate_flags) {
             error_setg(errp, "Block driver does not support requested flag=
s");
--=20
2.25.3


