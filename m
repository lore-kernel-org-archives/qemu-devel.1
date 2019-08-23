Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2FBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CBC2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CBC2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Asp-00088F-Gi
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1AhD-00043I-0T
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1AhB-0004gt-Vx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1Ah6-0004dc-S6; Fri, 23 Aug 2019 10:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 462F989AC9;
 Fri, 23 Aug 2019 14:37:36 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC1856CE58;
 Fri, 23 Aug 2019 14:37:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 09:37:24 -0500
Message-Id: <20190823143726.27062-4-eblake@redhat.com>
In-Reply-To: <20190823143726.27062-1-eblake@redhat.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 23 Aug 2019 14:37:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/5] nbd: Implement client use of NBD FAST_ZERO
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 libguestfs@redhat.com, nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The client side is fairly straightforward: if the server advertised
fast zero support, then we can map that to BDRV_REQ_NO_FALLBACK
support.  A server that advertises FAST_ZERO but not WRITE_ZEROES
is technically broken, but we can ignore that situation as it does
not change our behavior.

Signed-off-by: Eric Blake <eblake@redhat.com>

---

Perhaps this is worth merging with the previous patch.
---
 block/nbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index beed46fb3414..8339d7106366 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1044,6 +1044,10 @@ static int nbd_client_co_pwrite_zeroes(BlockDriver=
State *bs, int64_t offset,
     if (!(flags & BDRV_REQ_MAY_UNMAP)) {
         request.flags |=3D NBD_CMD_FLAG_NO_HOLE;
     }
+    if (flags & BDRV_REQ_NO_FALLBACK) {
+        assert(s->info.flags & NBD_FLAG_SEND_FAST_ZERO);
+        request.flags |=3D NBD_CMD_FLAG_FAST_ZERO;
+    }

     if (!bytes) {
         return 0;
@@ -1239,6 +1243,9 @@ static int nbd_client_connect(BlockDriverState *bs,=
 Error **errp)
     }
     if (s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |=3D BDRV_REQ_MAY_UNMAP;
+        if (s->info.flags & NBD_FLAG_SEND_FAST_ZERO) {
+            bs->supported_zero_flags |=3D BDRV_REQ_NO_FALLBACK;
+        }
     }

     s->sioc =3D sioc;
--=20
2.21.0


