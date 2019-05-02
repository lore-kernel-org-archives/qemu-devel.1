Received: from eggs.gnu.org ([209.51.188.92]:36107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvM-0003UE-Ua
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvM-0002vv-1f
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  2 May 2019 20:58:23 +0200
Message-Id: <20190502185835.15185-2-laurent@vivier.eu>
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/13] hw/net/pcnet: Use
 qemu_log_mask(GUEST_ERROR) instead of printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid to clutter stdout until explicitly requested
(with -d guest_errors):

  $ qemu-system-mips -M malta -m 512 -kernel vmlinux-3.2.0-4-4kc-malta
  Bad SWSTYLE=0x04

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190311102712.8572-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/pcnet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index d9ba04bdfc62..16683091c939 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -36,6 +36,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/qdev.h"
 #include "net/net.h"
 #include "net/eth.h"
@@ -1501,7 +1502,8 @@ static void pcnet_bcr_writew(PCNetState *s, uint32_t rap, uint32_t val)
             val |= 0x0300;
             break;
         default:
-            printf("Bad SWSTYLE=0x%02x\n", val & 0xff);
+            qemu_log_mask(LOG_GUEST_ERROR, "pcnet: Bad SWSTYLE=0x%02x\n",
+                          val & 0xff);
             val = 0x0200;
             break;
         }
-- 
2.20.1
