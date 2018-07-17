Received: from eggs.gnu.org ([2001:4830:134:3::10]:38389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ffPTD-0002zE-7T
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ffPTA-0000wV-W6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ffPTA-0000wB-Q1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A68F400225D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:52:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 14:52:37 +0200
Message-Id: <20180717125239.22517-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180717125239.22517-1-marcandre.lureau@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] char-socket: correctly set has_reconnect
 when parsing QemuOpts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qemu_chr_parse_socket() fills all ChardevSocket fields, but that
doesn't reflect correctly the arguments given with the options / on
the command line. "reconnect" takes a number as argument, and the
default value is 0, which doesn't help to identify the missing
option. The other arguments have default values that are less
problematic, leave them set by default for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index efbad6ee7c..8950f36317 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1111,7 +1111,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
     sock->tn3270 =3D is_tn3270;
     sock->has_wait =3D true;
     sock->wait =3D is_waitconnect;
-    sock->has_reconnect =3D true;
+    sock->has_reconnect =3D qemu_opt_find(opts, "reconnect");
     sock->reconnect =3D reconnect;
     sock->tls_creds =3D g_strdup(tls_creds);
=20
--=20
2.18.0.129.ge3331758f1
