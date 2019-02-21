Received: from eggs.gnu.org ([209.51.188.92]:34719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCS-00025e-3g
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCO-0006u9-IC
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmCL-0006qf-1E
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D1DC308FC22
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:07:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:06:57 +0100
Message-Id: <20190221110703.5775-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190221110703.5775-1-marcandre.lureau@redhat.com>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/11] spice: do not stop spice if VM is
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
Cc: kraxel@redhat.com

spice_server_vm_start/stop() was added to help migration state (commit
f5bb039c6d97ef3e664094eab3c9a4dc1824ed73).

However, a paused VM could keep running the spice server. This will
allow a Spice client to keep sending commands to a spice chardev. This
allows to stop/cont a VM from a Spice monitor port. Character
devices (vdagent/usb/smartcard/..) should not read from Spice when the
VM is paused.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
---
 ui/spice-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 91d0960522..92eebe5f0e 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -627,7 +627,7 @@ static void vm_change_state_handler(void *opaque, int=
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
2.21.0.rc1
