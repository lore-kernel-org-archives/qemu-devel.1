Received: from eggs.gnu.org ([209.51.188.92]:42647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUN-0008Ml-DV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUI-0005BC-Ps
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNUI-00059N-Al
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:02 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:32 +0100
Message-Id: <20190214201939.494-3-philmd@redhat.com>
In-Reply-To: <20190214201939.494-1-philmd@redhat.com>
References: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/9] ccid-card-passthru: Replace never
 trigger if statement by an assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Arash Tohidi Chafi <tohidi.arash@gmail.com>

The right side of the comparison is the return value of can_read():
VSCARD_IN_SIZE - card->vscard_in_pos.
Since the 'size' argument of chardev::read() is bound to
what chardev::can_read() returns, this condition can never happen.

Add an assertion, which will always fail if card->vscard_in_pos >=3D
VSCARD_IN_SIZE), since size > 0.

This is a quick fix for CVE-2018-18438 "Integer overflow in
ccid_card_vscard_read() allows memory corruption".

Fixes: CVE-2018-18438
Reported-by: Arash Tohidi Chafi <tohidi.arash@gmail.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 8bb1314f49..1676b5fc05 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -264,24 +264,12 @@ static void ccid_card_vscard_handle_message(Passthr=
uState *card,
     }
 }
=20
-static void ccid_card_vscard_drop_connection(PassthruState *card)
-{
-    qemu_chr_fe_deinit(&card->cs, true);
-    card->vscard_in_pos =3D card->vscard_in_hdr =3D 0;
-}
-
 static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int =
size)
 {
     PassthruState *card =3D opaque;
     VSCMsgHeader *hdr;
=20
-    if (card->vscard_in_pos + size > VSCARD_IN_SIZE) {
-        error_report("no room for data: pos %u +  size %d > %" PRId64 ".=
"
-                     " dropping connection.",
-                     card->vscard_in_pos, size, VSCARD_IN_SIZE);
-        ccid_card_vscard_drop_connection(card);
-        return;
-    }
+    assert(size <=3D VSCARD_IN_SIZE - card->vscard_in_pos);
     assert(card->vscard_in_hdr < VSCARD_IN_SIZE);
     memcpy(card->vscard_in_data + card->vscard_in_pos, buf, size);
     card->vscard_in_pos +=3D size;
--=20
2.20.1
