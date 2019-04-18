Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E43C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 13:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E7920656
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 13:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E7920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41225 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH6eY-0004x4-JK
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 09:00:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hH6dM-0004Kd-60
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hH6dK-00076U-5o
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hH6dJ-000746-Ts
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15C7A305396A;
	Thu, 18 Apr 2019 12:59:17 +0000 (UTC)
Received: from localhost (ovpn-112-32.ams2.redhat.com [10.36.112.32])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0185919C65;
	Thu, 18 Apr 2019 12:59:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 14:59:07 +0200
Message-Id: <20190418125908.11928-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190418125908.11928-1-marcandre.lureau@redhat.com>
References: <20190418125908.11928-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 18 Apr 2019 12:59:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] slirp: ensure there is enough space in
 mbuf to null-terminate
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Prasad J Pandit <pjp@fedoraproject.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418125907.zjgAaXAS0UnAb1Nsb-F2i_k1nF-XxS17KDL-UZe8O7E@z>

Prevents from buffer overflows.
Related to: https://bugzilla.redhat.com/show_bug.cgi?id=3D1664205

Cc: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/src/tcp_subr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/slirp/src/tcp_subr.c b/slirp/src/tcp_subr.c
index fde9207b0c..c43598de48 100644
--- a/slirp/src/tcp_subr.c
+++ b/slirp/src/tcp_subr.c
@@ -644,6 +644,7 @@ tcp_emu(struct socket *so, struct mbuf *m)
 			memcpy(so_rcv->sb_wptr, m->m_data, m->m_len);
 			so_rcv->sb_wptr +=3D m->m_len;
 			so_rcv->sb_rptr +=3D m->m_len;
+			m_inc(m, m->m_len + 1);
 			m->m_data[m->m_len] =3D 0; /* NULL terminate */
 			if (strchr(m->m_data, '\r') || strchr(m->m_data, '\n')) {
 				if (sscanf(so_rcv->sb_data, "%u%*[ ,]%u", &n1, &n2) =3D=3D 2) {
@@ -677,6 +678,7 @@ tcp_emu(struct socket *so, struct mbuf *m)
 		}
=20
         case EMU_FTP: /* ftp */
+                m_inc(m, m->m_len + 1);
                 *(m->m_data+m->m_len) =3D 0; /* NUL terminate for strstr=
 */
 		if ((bptr =3D (char *)strstr(m->m_data, "ORT")) !=3D NULL) {
 			/*
@@ -774,6 +776,7 @@ tcp_emu(struct socket *so, struct mbuf *m)
 		/*
 		 * Need to emulate DCC CHAT, DCC SEND and DCC MOVE
 		 */
+		m_inc(m, m->m_len + 1);
 		*(m->m_data+m->m_len) =3D 0; /* NULL terminate the string for strstr *=
/
 		if ((bptr =3D (char *)strstr(m->m_data, "DCC")) =3D=3D NULL)
 			 return 1;
--=20
2.21.0.313.ge35b8cb8e2


