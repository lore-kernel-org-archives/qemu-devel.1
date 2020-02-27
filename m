Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50544C4BA35
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D03F20838
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxAmLlTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D03F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j78Pj-0006co-6V
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 20:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j78OB-0004cA-7O
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j78O9-0002bX-S5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j78O9-0002aH-Ow
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582768497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUPXxxCKyagr4YZxReptWxzyXWpDfn+h00F9pRtBtOc=;
 b=RxAmLlTNhf5FyuOFS6cLhEE3471xJtdJ3NkWUh9LzL6dsr3tvwJSkh+OU4R4i4EtRkXsel
 d4j28jtBcx9TSZclpFXV8DG8QKBltQ9Qmso3uSsCH2himqJYcss6ny+V4bliyJ4jjNvX8x
 XGyGB0eQJcfiTGWNhm7uGoZEmtGy+lI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-Vr7GnvyIOK6_Ip3C3n4SmQ-1; Wed, 26 Feb 2020 20:54:53 -0500
X-MC-Unique: Vr7GnvyIOK6_Ip3C3n4SmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 508CA1005512;
 Thu, 27 Feb 2020 01:54:51 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8E515C21B;
 Thu, 27 Feb 2020 01:54:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] nbd: Fix regression with multiple meta contexts
Date: Wed, 26 Feb 2020 19:54:45 -0600
Message-Id: <20200227015448.960538-2-eblake@redhat.com>
In-Reply-To: <20200227015448.960538-1-eblake@redhat.com>
References: <20200227015448.960538-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Detected by a hang in the libnbd testsuite.  If a client requests
multiple meta contexts (both base:allocation and qemu:dirty-bitmap:x)
at the same time, our attempt to silence a false-positive warning
about a potential uninitialized variable introduced botched logic: we
were short-circuiting the second context, and never sending the
NBD_REPLY_FLAG_DONE.  Combining two 'if' into one 'if/else' in
bdf200a55 was wrong (I'm a bit embarrassed that such a change was my
initial suggestion after the v1 patch, then I did not review the v2
patch that actually got committed). Revert that, and instead silence
the false positive warning by replacing 'return ret' with 'return 0'
(the value it always has at that point in the code, even though it
eluded the deduction abilities of the robot that reported the false
positive).

Fixes: bdf200a5535
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200206173832.130004-1-eblake@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 nbd/server.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 87fcd2e7bfac..11a31094ff83 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2384,15 +2384,23 @@ static coroutine_fn int nbd_handle_request(NBDClien=
t *client,
                                                !client->export_meta.bitmap=
,
                                                NBD_META_ID_BASE_ALLOCATION=
,
                                                errp);
-            } else {              /* client->export_meta.bitmap */
+                if (ret < 0) {
+                    return ret;
+                }
+            }
+
+            if (client->export_meta.bitmap) {
                 ret =3D nbd_co_send_bitmap(client, request->handle,
                                          client->exp->export_bitmap,
                                          request->from, request->len,
                                          dont_fragment,
                                          true, NBD_META_ID_DIRTY_BITMAP, e=
rrp);
+                if (ret < 0) {
+                    return ret;
+                }
             }

-            return ret;
+            return 0;
         } else {
             return nbd_send_generic_reply(client, request->handle, -EINVAL=
,
                                           "CMD_BLOCK_STATUS not negotiated=
",
--=20
2.24.1


