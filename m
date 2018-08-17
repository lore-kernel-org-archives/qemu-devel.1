Received: from eggs.gnu.org ([2001:4830:134:3::10]:39242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqiam-0000nl-Gq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqiai-0003yk-G7
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:31:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fqiai-0003yX-A8
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE6FB4067720
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 17:31:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Aug 2018 19:31:03 +0200
Message-Id: <20180817173104.14691-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vnc: call sasl_server_init() only when required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, dgilbert@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

VNC server is calling sasl_server_init() during startup of QEMU, even
if SASL auth has not been enabled.

This may create undesirable warnings like "Could not find keytab file:
/etc/qemu/krb5.tab" when the user didn't configure SASL on host and
started VNC server.

Instead, only initialize SASL when needed. Note that HMP/QMP "change
vnc" calls vnc_display_open() again, which will initialize SASL if
needed.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1609327

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 359693238b..fc507d7f36 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4054,7 +4054,7 @@ void vnc_display_open(const char *id, Error **errp)
     trace_vnc_auth_init(vd, 1, vd->ws_auth, vd->ws_subauth);
=20
 #ifdef CONFIG_VNC_SASL
-    if ((saslErr =3D sasl_server_init(NULL, "qemu")) !=3D SASL_OK) {
+    if (sasl && ((saslErr =3D sasl_server_init(NULL, "qemu")) !=3D SASL_=
OK)) {
         error_setg(errp, "Failed to initialize SASL auth: %s",
                    sasl_errstring(saslErr, NULL, NULL));
         goto fail;
--=20
2.18.0.547.g1d89318c48
