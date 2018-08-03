Received: from eggs.gnu.org ([2001:4830:134:3::10]:40053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0C-0007q9-5F
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0B-0001IT-Gc
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle0B-0001IA-B1
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6900401EF0B
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:08 +0200
Message-Id: <20180803173614.12358-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/10] spice: avoid spice runtime assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The Spice server doesn't like to be started or stopped twice . It
aborts with:

(process:6191): Spice-ERROR **: 19:29:35.912: red-worker.c:623:handle_dev=
_start: assertion `!worker->running' failed

It's easy to avoid that situation since qemu spice_display_is_running
tracks the server state.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 76896f7c7a..13f1c11b61 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -923,12 +923,20 @@ int qemu_spice_display_add_client(int csock, int sk=
ipauth, int tls)
=20
 void qemu_spice_display_start(void)
 {
+    if (spice_display_is_running) {
+        return;
+    }
+
     spice_display_is_running =3D true;
     spice_server_vm_start(spice_server);
 }
=20
 void qemu_spice_display_stop(void)
 {
+    if (!spice_display_is_running) {
+        return;
+    }
+
     spice_server_vm_stop(spice_server);
     spice_display_is_running =3D false;
 }
--=20
2.18.0.547.g1d89318c48
