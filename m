Received: from eggs.gnu.org ([2001:4830:134:3::10]:40130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0M-00080y-Ne
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0M-0001Lw-1e
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle0L-0001Lc-TD
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7ACFC857AB
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:10 +0200
Message-Id: <20180803173614.12358-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/10] spice: do not stop spice if VM is paused
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

spice_server_vm_start/stop() was added to help migration state.

However, a paused VM could keep running the spice server. This will
allow a Spice client to keep sending commands to a spice chardev. This
allows to stop/cont a VM from a Spice monitor port.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 6bd107f0f9..88f0cd7262 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -629,7 +629,7 @@ static void vm_change_state_handler(void *opaque, int=
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
2.18.0.547.g1d89318c48
