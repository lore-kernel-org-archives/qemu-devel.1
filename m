Received: from eggs.gnu.org ([209.51.188.92]:42598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUH-0008FX-Uh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUF-00054b-Bt
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNUF-0004zo-3Y
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:19:59 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:31 +0100
Message-Id: <20190214201939.494-2-philmd@redhat.com>
In-Reply-To: <20190214201939.494-1-philmd@redhat.com>
References: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/9] ccid-card-passthru: Move assertion in
 read() to can_read()
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

chardev::read() depends of what chardev::can_read() returns, move the
assertion to can_read().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 0a6c657228..8bb1314f49 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -116,8 +116,8 @@ static int ccid_card_vscard_can_read(void *opaque)
 {
     PassthruState *card =3D opaque;
=20
-    return VSCARD_IN_SIZE >=3D card->vscard_in_pos ?
-           VSCARD_IN_SIZE - card->vscard_in_pos : 0;
+    assert(card->vscard_in_pos <=3D VSCARD_IN_SIZE);
+    return VSCARD_IN_SIZE - card->vscard_in_pos;
 }
=20
 static void ccid_card_vscard_handle_init(
@@ -282,7 +282,6 @@ static void ccid_card_vscard_read(void *opaque, const=
 uint8_t *buf, int size)
         ccid_card_vscard_drop_connection(card);
         return;
     }
-    assert(card->vscard_in_pos < VSCARD_IN_SIZE);
     assert(card->vscard_in_hdr < VSCARD_IN_SIZE);
     memcpy(card->vscard_in_data + card->vscard_in_pos, buf, size);
     card->vscard_in_pos +=3D size;
--=20
2.20.1
