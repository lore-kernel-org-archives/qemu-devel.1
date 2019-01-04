Received: from eggs.gnu.org ([208.118.235.92]:59065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfU5p-0002zg-7l
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfU5m-00087p-5F
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:21:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gfU5m-00086y-0D
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:21:10 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 19:20:57 +0100
Message-Id: <20190104182057.8778-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/char/stm32f2xx_usart: Do not update data
 register when device is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

When the device is disable, the internal circuitry keep the data
register loaded and doesn't update it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/stm32f2xx_usart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index f3363a2952..10392c70e2 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -53,14 +53,13 @@ static void stm32f2xx_usart_receive(void *opaque, con=
st uint8_t *buf, int size)
 {
     STM32F2XXUsartState *s =3D opaque;
=20
-    s->usart_dr =3D *buf;
-
     if (!(s->usart_cr1 & USART_CR1_UE && s->usart_cr1 & USART_CR1_RE)) {
         /* USART not enabled - drop the chars */
         DB_PRINT("Dropping the chars\n");
         return;
     }
=20
+    s->usart_dr =3D *buf;
     s->usart_sr |=3D USART_SR_RXNE;
=20
     if (s->usart_cr1 & USART_CR1_RXNEIE) {
--=20
2.17.2
