Received: from eggs.gnu.org ([209.51.188.92]:42902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNV4-0000aR-Sg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNV2-000614-FJ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNUx-0005ce-H1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:45 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:36 +0100
Message-Id: <20190214201939.494-7-philmd@redhat.com>
In-Reply-To: <20190214201939.494-1-philmd@redhat.com>
References: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/9] ccid-card-passthru: Simplify the if()
 condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Simplify the if() condition so we can remove an indent layer
and the code is easier to review.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index ccc3ffa7fa..6cb8b2d26b 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -338,19 +338,17 @@ static void passthru_realize(CCIDCardState *base, E=
rror **errp)
 {
     PassthruState *card =3D PASSTHRU_CCID_CARD(base);
=20
-    card->vscard_in_pos =3D 0;
-    card->vscard_in_hdr =3D 0;
-    if (qemu_chr_fe_backend_connected(&card->cs)) {
-        DPRINTF(card, D_INFO, "ccid-card-passthru: initing chardev");
-        qemu_chr_fe_set_handlers(&card->cs,
-            ccid_card_vscard_can_read,
-            ccid_card_vscard_read,
-            ccid_card_vscard_event, NULL, card, NULL, true);
-        ccid_card_vscard_send_init(card);
-    } else {
+    if (!qemu_chr_fe_backend_connected(&card->cs)) {
         error_setg(errp, "missing chardev");
         return;
     }
+    card->vscard_in_pos =3D 0;
+    card->vscard_in_hdr =3D 0;
+    DPRINTF(card, D_INFO, "ccid-card-passthru: initing chardev");
+    qemu_chr_fe_set_handlers(&card->cs, ccid_card_vscard_can_read,
+                             ccid_card_vscard_read, ccid_card_vscard_eve=
nt,
+                             NULL, card, NULL, true);
+    ccid_card_vscard_send_init(card);
     card->debug =3D parse_debug_env("QEMU_CCID_PASSTHRU_DEBUG", D_VERBOS=
E,
                                   card->debug);
     memcpy(card->atr, DEFAULT_ATR, sizeof(DEFAULT_ATR));
--=20
2.20.1
