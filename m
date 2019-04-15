Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A1BC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE72206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE72206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG0Kh-0004Rz-8X
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 08:03:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG0JV-0003z7-LE
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG0JU-00036E-MI
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hG0JU-00035h-H9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B10A308222E;
	Mon, 15 Apr 2019 12:02:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-222.ams2.redhat.com
	[10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C38F360F9B;
	Mon, 15 Apr 2019 12:02:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	samuel.thibault@gnu.org,
	jan.kiszka@siemens.com
Date: Mon, 15 Apr 2019 13:02:05 +0100
Message-Id: <20190415120205.2221-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 15 Apr 2019 12:02:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] slirp: Gcc 9 -O3 fix
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
Message-ID: <20190415120205.QuyJw6GSNotwwg-eE8Acr-nnQELrAfxK_Z0YUWlmer4@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Gcc 9 needs some convincing that sopreprbuf really is going to fill
in iov in the call from soreadbuf, even though the failure case
shouldn't happen.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 slirp/src/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/slirp/src/socket.c b/slirp/src/socket.c
index 4a3c935e25..beb8517f1c 100644
--- a/slirp/src/socket.c
+++ b/slirp/src/socket.c
@@ -181,7 +181,7 @@ soread(struct socket *so)
 	 * No need to check if there's enough room to read.
 	 * soread wouldn't have been called if there weren't
 	 */
-	sopreprbuf(so, iov, &n);
+	assert(sopreprbuf(so, iov, &n) !=3D 0);
=20
 	nn =3D recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
 	if (nn <=3D 0) {
@@ -257,6 +257,7 @@ int soreadbuf(struct socket *so, const char *buf, int=
 size)
 	 * No need to check if there's enough room to read.
 	 * soread wouldn't have been called if there weren't
 	 */
+	assert(size > 0);
 	if (sopreprbuf(so, iov, &n) < size)
         goto err;
=20
--=20
2.21.0


