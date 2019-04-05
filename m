Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C5C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 19:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480832171F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 19:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480832171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCUAR-0005hH-Aq
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 15:06:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCU9e-0004ms-P1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCU9d-0001c2-JA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:05:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCU8d-0008EJ-MU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:05:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EE193082A49;
	Fri,  5 Apr 2019 18:46:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-242.ams2.redhat.com
	[10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2DF3310018E0;
	Fri,  5 Apr 2019 18:46:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Date: Fri,  5 Apr 2019 19:46:48 +0100
Message-Id: <20190405184648.17029-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 05 Apr 2019 18:46:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405184648.A3sqAdzZN7pPgqeDb8cDyFAZhKRq5KDYI4Kr6G0YnxY@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Gcc 9 needs some convincing that sopreprbuf really is going to fill
in iov in the call from soreadbuf, even though the failure case
shouldn't happen; so swing the check around initialising the fields.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 slirp/src/socket.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/slirp/src/socket.c b/slirp/src/socket.c
index 4a3c935e25..4a2222a95f 100644
--- a/slirp/src/socket.c
+++ b/slirp/src/socket.c
@@ -113,12 +113,14 @@ size_t sopreprbuf(struct socket *so, struct iovec *=
iov, int *np)
 	DEBUG_CALL("sopreprbuf");
 	DEBUG_ARG("so =3D %p", so);
=20
-	if (len <=3D 0)
-		return 0;
-
 	iov[0].iov_base =3D sb->sb_wptr;
+        iov[0].iov_len =3D 0;
         iov[1].iov_base =3D NULL;
         iov[1].iov_len =3D 0;
+
+	if (len <=3D 0)
+		return 0;
+
 	if (sb->sb_wptr < sb->sb_rptr) {
 		iov[0].iov_len =3D sb->sb_rptr - sb->sb_wptr;
 		/* Should never succeed, but... */
--=20
2.21.0


