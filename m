Received: from eggs.gnu.org ([2001:4830:134:3::10]:60989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cS14e-000607-U0
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cS14e-0006QP-76
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:35:16 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:35224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1cS14e-0006Q0-1A
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:35:16 -0500
Received: by mail-vk0-x230.google.com with SMTP id x75so32350832vke.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 04:35:15 -0800 (PST)
MIME-Version: 1.0
From: James Hanley <jhanley@dgtlrift.com>
Date: Fri, 13 Jan 2017 07:35:14 -0500
Message-ID: <CAF++6AOnuOzwiiPRJEGatzX7LuoJKU5ij2xWRLkKbxhytJscqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] system_clock_scale unset in hw/intc/armv7m_nvic.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org, qemu-arm <qemu-arm@nongnu.org>, qemu-devel@nongnu.org

How should system_clock_scale be set in hw/intc/armv7m_nvic.c - there is no
API for the global, and I've defaulted the global to SYSTICK_SCALE which
seems to work, but is not obvious.  This was needed as this value was set
to zero and the arm firmware was selecting the external clock source
causing zero to be returned from systick_scale() and the interrupt to run
continuously.

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 06d8db6..c15841e 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -70,7 +70,7 @@ static const uint8_t nvic_id[] = {
 #define SYSTICK_CLKSOURCE (1 << 2)
 #define SYSTICK_COUNTFLAG (1 << 16)

-int system_clock_scale;
+int system_clock_scale = SYSTICK_SCALE;

 /* Conversion factor from qemu timer to SysTick frequencies.  */
 static inline int64_t systick_scale(nvic_state *s)
