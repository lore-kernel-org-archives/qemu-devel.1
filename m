Received: from eggs.gnu.org ([209.51.188.92]:50198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYk-0002HM-GU
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYi-0002iP-Un
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:15 +0100
Message-Id: <20190214104717.3543-13-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
References: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/14] hw/dma/i8257: Use qemu_log_mask(UNIMP)
 instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid to clutter stdout until explicitly requested (with -d unimp):

  $ qemu-system-mips64el -M fulong2e -bios pmon_2e.bin
  dma: command df not supported
  dma: command df not supported
  dma: command df not supported
  dma: command df not supported

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190212145322.30974-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/dma/i8257.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 52675e97c9e7..3e1f13a4aaf4 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -26,6 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/dma/i8257.h"
 #include "qemu/main-loop.h"
+#include "qemu/log.h"
 #include "trace.h"
 
 #define I8257(obj) \
@@ -185,7 +186,8 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
     switch (iport) {
     case 0x00:                  /* command */
         if ((data != 0) && (data & CMD_NOT_SUPPORTED)) {
-            dolog("command %"PRIx64" not supported\n", data);
+            qemu_log_mask(LOG_UNIMP, "%s: cmd 0x%02"PRIx64" not supported\n",
+                          __func__, data);
             return;
         }
         d->command = data;
-- 
2.20.1
