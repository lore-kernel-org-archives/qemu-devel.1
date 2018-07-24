Received: from eggs.gnu.org ([2001:4830:134:3::10]:37725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1fhwKB-0007AR-44
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1fhwKA-0008Ia-6u
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:21:55 -0400
MIME-Version: 1.0
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 24 Jul 2018 08:21:49 -0400
Message-ID: <CAKf6xpvjRO05BAoVaw9vQZ56q84pTNXRa9ugJ2dGtQaTTEmYWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Stable 2.12.1 Request: "ccid-card-passthru: fix
 regression in realize()"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, f4bug@amsat.org, Gerd Hoffmann <kraxel@redhat.com>

I'd like to request this commit for QEMU 2.12.1 stable backport:

commit e58d64a16abc "ccid-card-passthru: fix regression in realize()"

The patch fixes a VM start failure which I experience on 2.12.0.
Patch inlined below

Thanks,
Jason

>From e58d64a16abc2304c4dcb644411eb9580bf63b1e Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Marc-Andr=3DC3=3DA9=3D20Lureau?=3D <marcandre.lureau@redh=
at.com>
Date: Tue, 15 May 2018 17:30:39 +0200
Subject: [PATCH] ccid-card-passthru: fix regression in realize()
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Since cc847bfd16d894fd8c1a2ce25f31772f6cdbbc74, CCID card-passthru
fails to intialize, because it changed a debug line to an error,
probably by mistake. Change it back to a DPRINTF debug.

(solves Boxes creating VM with smartcard passthru failing to start)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180515153039.27514-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 7684db0cb3..25fb19b0d7 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -345,7 +345,7 @@ static void passthru_realize(CCIDCardState *base,
Error **errp)
     card->vscard_in_pos =3D 0;
     card->vscard_in_hdr =3D 0;
     if (qemu_chr_fe_backend_connected(&card->cs)) {
-        error_setg(errp, "ccid-card-passthru: initing chardev");
+        DPRINTF(card, D_INFO, "ccid-card-passthru: initing chardev");
         qemu_chr_fe_set_handlers(&card->cs,
             ccid_card_vscard_can_read,
             ccid_card_vscard_read,
