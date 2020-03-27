Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E1C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDDC20658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHeGllYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDDC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrlK-0000c7-2W
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHri1-0005eb-DI
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHrhz-0004hd-MI
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHrhz-0004gy-Ha
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585325987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2yZyuVHJ8pbFolfMbYA0T7S/y89rJCjMePE+tPwNL4=;
 b=QHeGllYmVcX86rLrBmJJp9HIuIEyNcxE0bLPPO6JmiuC4PUGrwaaPtvEQpjJG8wUVFkaKI
 WuoaZ7OBEI1RXj+6LBBMwop2pt4dix0Ie747cANkwKGCtm3EJGvhKyVLMQLBUtRWMrub7i
 vRgU60WcWdbayvNDMLxTvaGBCwRFlA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-uPfziAzkNs6xA-sNm3jPYg-1; Fri, 27 Mar 2020 12:19:45 -0400
X-MC-Unique: uPfziAzkNs6xA-sNm3jPYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC407801A18;
 Fri, 27 Mar 2020 16:19:44 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5B0F5C1D8;
 Fri, 27 Mar 2020 16:19:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] io: Support shutdown of TLS channel
Date: Fri, 27 Mar 2020 11:19:35 -0500
Message-Id: <20200327161936.2225989-3-eblake@redhat.com>
In-Reply-To: <20200327161936.2225989-1-eblake@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: berrange@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gnutls documents that while many apps simply yank out the underlying
transport at the end of communication in the name of efficiency, this
is indistinguishable from a malicious actor terminating the connection
prematurely.  Since our channel I/O code already supports the notion of
a graceful shutdown request, it is time to plumb that through to the
TLS layer, and wait for TLS to give the all clear before then
terminating traffic on the underlying channel.

Note that channel-tls now always advertises shutdown support,
regardless of whether the underlying channel also has that support.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 io/channel-tls.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7ec8ceff2f01..f90905823e1d 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -360,10 +360,35 @@ static int qio_channel_tls_shutdown(QIOChannel *ioc,
                                     Error **errp)
 {
     QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);
+    int ret =3D 0;

     tioc->shutdown |=3D how;

-    return qio_channel_shutdown(tioc->master, how, errp);
+    do {
+        switch (how) {
+        case QIO_CHANNEL_SHUTDOWN_READ:
+            /* No TLS counterpart */
+            break;
+        case QIO_CHANNEL_SHUTDOWN_WRITE:
+            ret =3D qcrypto_tls_session_shutdown(tioc->session, QCRYPTO_SH=
UT_WR);
+            break;
+        case QIO_CHANNEL_SHUTDOWN_BOTH:
+            ret =3D qcrypto_tls_session_shutdown(tioc->session,
+                                               QCRYPTO_SHUT_RDWR);
+            break;
+        default:
+            abort();
+        }
+    } while (ret =3D=3D -EAGAIN);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Cannot shut down TLS channel");
+        return -1;
+    }
+
+    if (qio_channel_has_feature(tioc->master, QIO_CHANNEL_FEATURE_SHUTDOWN=
)) {
+        return qio_channel_shutdown(tioc->master, how, errp);
+    }
+    return 0;
 }

 static int qio_channel_tls_close(QIOChannel *ioc,
--=20
2.26.0.rc2


