Received: from eggs.gnu.org ([2001:4830:134:3::10]:54244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eifHV-00048D-3i
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eifHR-0008DU-Ee
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eifHR-0008DJ-9k
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F06D81DE4
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 11:49:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  5 Feb 2018 11:49:36 +0000
Message-Id: <20180205114938.15784-3-berrange@redhat.com>
In-Reply-To: <20180205114938.15784-1-berrange@redhat.com>
References: <20180205114938.15784-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] ui: avoid 'local_err' variable shadowing
 in VNC SASL auth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The start_auth_sasl() method declares a 'Error *local_err' variable in
an inner if () {...} scope, which shadows a variable of the same name
declared at the start of the method. This is confusing for reviewers and
may trigger compiler warnings.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index fbccca8c8a..8ebd0d3d00 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -556,7 +556,6 @@ void start_auth_sasl(VncState *vs)
     /* Inform SASL that we've got an external SSF layer from TLS/x509 */
     if (vs->auth =3D=3D VNC_AUTH_VENCRYPT &&
         vs->subauth =3D=3D VNC_AUTH_VENCRYPT_X509SASL) {
-        Error *local_err =3D NULL;
         int keysize;
         sasl_ssf_t ssf;
=20
@@ -565,7 +564,6 @@ void start_auth_sasl(VncState *vs)
         if (keysize < 0) {
             trace_vnc_auth_fail(vs, vs->auth, "cannot TLS get cipher siz=
e",
                                 error_get_pretty(local_err));
-            error_free(local_err);
             sasl_dispose(&vs->sasl.conn);
             vs->sasl.conn =3D NULL;
             goto authabort;
--=20
2.14.3
