Received: from eggs.gnu.org ([2001:4830:134:3::10]:36229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZzLf-0007ba-53
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZz7z-0000lA-VU
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:16:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gZz7w-0000dy-3g
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:16:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B1E288E55
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:16:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 18:15:45 +0400
Message-Id: <20181220141553.24098-5-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/12] spice: avoid spice runtime assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

The Spice server doesn't like to be started or stopped twice . It
aborts with:

(process:6191): Spice-ERROR **: 19:29:35.912: red-worker.c:623:handle_dev=
_start: assertion `!worker->running' failed

It's easy to avoid that situation since qemu spice_display_is_running
tracks the server state.

After the commit "spice: do not stop spice if VM is paused", it will
be possible to pause and resume the VM, and this will call
qemu_spice_display_start() twice. The easiest is to add a check for
spice_display_is_running with this patch to avoid the assert.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index fc850b3f50..1f1501de78 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -922,12 +922,20 @@ int qemu_spice_display_add_client(int csock, int sk=
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
2.20.1.2.gb21ebb671b
