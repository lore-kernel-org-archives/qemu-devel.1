Received: from eggs.gnu.org ([209.51.188.92]:42779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUp-0000NE-CO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUn-0005n8-FW
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNUd-0005Ux-RF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:25 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:34 +0100
Message-Id: <20190214201939.494-5-philmd@redhat.com>
In-Reply-To: <20190214201939.494-1-philmd@redhat.com>
References: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/9] ccid-card-passthru: Let the
 chardev::read() be more generic
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

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 0c44b38fc2..ba7c285ded 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -285,8 +285,14 @@ static void ccid_card_vscard_read(void *opaque, cons=
t uint8_t *buf, int size)
         card->vscard_in_hdr +=3D hdr->length + sizeof(VSCMsgHeader);
         hdr =3D (VSCMsgHeader *)(card->vscard_in_data + card->vscard_in_=
hdr);
     }
-    if (card->vscard_in_hdr =3D=3D card->vscard_in_pos) {
-        card->vscard_in_pos =3D card->vscard_in_hdr =3D 0;
+
+    /* Drop any messages that were fully processed.  */
+    if (card->vscard_in_hdr > 0) {
+        memmove(card->vscard_in_data,
+                card->vscard_in_data + card->vscard_in_hdr,
+                card->vscard_in_pos - card->vscard_in_hdr);
+        card->vscard_in_pos -=3D card->vscard_in_hdr;
+        card->vscard_in_hdr =3D 0;
     }
 }
=20
--=20
2.20.1
