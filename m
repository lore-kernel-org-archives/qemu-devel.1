Received: from eggs.gnu.org ([2001:4830:134:3::10]:59933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMJS-0006Ji-9k
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMJR-0003eZ-FS
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:41:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Jun 2018 10:40:34 -0300
Message-Id: <20180622134036.23182-13-f4bug@amsat.org>
In-Reply-To: <20180622134036.23182-1-f4bug@amsat.org>
References: <20180622134036.23182-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/14] hw/net/smc91c111: Use
 qemu_log_mask(GUEST_ERROR) instead of hw_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>

hw_error() finally calls abort(), but there is no need to abort here.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/smc91c111.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index c8cc5379b7..9094c0b47c 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -11,6 +11,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/devices.h"
+#include "qemu/log.h"
 /* For crc32 */
 #include <zlib.h>
 
@@ -478,7 +479,9 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
         }
         break;
     }
-    hw_error("smc91c111_write: Bad reg %d:%x\n", s->bank, (int)offset);
+    qemu_log_mask(LOG_GUEST_ERROR, "smc91c111_write(bank:%d) Illegal register"
+                                   " 0x%" HWADDR_PRIx " = 0x%x\n",
+                  s->bank, offset, value);
 }
 
 static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
@@ -621,7 +624,9 @@ static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
         }
         break;
     }
-    hw_error("smc91c111_read: Bad reg %d:%x\n", s->bank, (int)offset);
+    qemu_log_mask(LOG_GUEST_ERROR, "smc91c111_read(bank:%d) Illegal register"
+                                   " 0x%" HWADDR_PRIx "\n",
+                  s->bank, offset);
     return 0;
 }
 
-- 
2.18.0.rc2
