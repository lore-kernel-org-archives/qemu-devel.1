Received: from eggs.gnu.org ([2001:4830:134:3::10]:35916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZzLf-00078Y-29
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZz84-0000oW-Bt
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:16:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gZz84-0000nC-3O
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:16:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D7C0804E5
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:16:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 18:15:47 +0400
Message-Id: <20181220141553.24098-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/12] spice: do not stop spice if VM is
 paused
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

spice_server_vm_start/stop() was added to help migration state (commit
f5bb039c6d97ef3e664094eab3c9a4dc1824ed73).

However, a paused VM could keep running the spice server. This will
allow a Spice client to keep sending commands to a spice chardev. This
allows to stop/cont a VM from a Spice monitor port. Character
devices (vdagent/usb/smartcard/..) should not read from Spice when the
VM is paused.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 6fefd95cea..9627f07cd8 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -628,7 +628,7 @@ static void vm_change_state_handler(void *opaque, int=
 running,
 {
     if (running) {
         qemu_spice_display_start();
-    } else {
+    } else if (state !=3D RUN_STATE_PAUSED) {
         qemu_spice_display_stop();
     }
 }
--=20
2.20.1.2.gb21ebb671b
