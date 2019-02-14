Received: from eggs.gnu.org ([209.51.188.92]:42801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUt-0000QV-CD
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUp-0005p0-Df
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNUl-0005YP-J5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:33 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:35 +0100
Message-Id: <20190214201939.494-6-philmd@redhat.com>
In-Reply-To: <20190214201939.494-1-philmd@redhat.com>
References: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/9] ccid-card-passthru: Replace assert() by
 QEMU_BUILD_BUG_ON()
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index ba7c285ded..ccc3ffa7fa 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -29,6 +29,9 @@ do {                                                   =
 \
 #define D_MORE_INFO 3
 #define D_VERBOSE 4
=20
+/* maximum size of ATR - from 7816-3 */
+#define MAX_ATR_SIZE        40
+
 /* TODO: do we still need this? */
 static const uint8_t DEFAULT_ATR[] =3D {
 /*
@@ -41,10 +44,9 @@ static const uint8_t DEFAULT_ATR[] =3D {
  0x13, 0x08
 };
=20
-#define VSCARD_IN_SIZE      (64 * KiB)
+QEMU_BUILD_BUG_ON(sizeof(DEFAULT_ATR) > MAX_ATR_SIZE);
=20
-/* maximum size of ATR - from 7816-3 */
-#define MAX_ATR_SIZE        40
+#define VSCARD_IN_SIZE      (64 * KiB)
=20
 typedef struct PassthruState PassthruState;
=20
@@ -351,7 +353,6 @@ static void passthru_realize(CCIDCardState *base, Err=
or **errp)
     }
     card->debug =3D parse_debug_env("QEMU_CCID_PASSTHRU_DEBUG", D_VERBOS=
E,
                                   card->debug);
-    assert(sizeof(DEFAULT_ATR) <=3D MAX_ATR_SIZE);
     memcpy(card->atr, DEFAULT_ATR, sizeof(DEFAULT_ATR));
     card->atr_length =3D sizeof(DEFAULT_ATR);
 }
--=20
2.20.1
