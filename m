Received: from eggs.gnu.org ([2001:4830:134:3::10]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIo-0004Dk-T1
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIk-0004Fm-AT
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:07:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 24 Jun 2018 01:06:05 -0300
Message-Id: <20180624040609.17572-13-f4bug@amsat.org>
In-Reply-To: <20180624040609.17572-1-f4bug@amsat.org>
References: <20180624040609.17572-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 12/16] hw/net/stellaris_enet: Use
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
 hw/net/stellaris_enet.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 1e7329517c..165562d788 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
+#include "qemu/log.h"
 #include <zlib.h>
 
 //#define DEBUG_STELLARIS_ENET 1
@@ -343,7 +344,9 @@ static uint64_t stellaris_enet_read(void *opaque, hwaddr offset,
     case 0x3c: /* Undocumented: Timestamp? */
         return 0;
     default:
-        hw_error("stellaris_enet_read: Bad offset %x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "stellaris_enet_rd%d: Illegal register"
+                                       " 0x02%" HWADDR_PRIx "\n",
+                      size * 8, offset);
         return 0;
     }
 }
@@ -442,7 +445,9 @@ static void stellaris_enet_write(void *opaque, hwaddr offset,
         /* Ignored.  */
         break;
     default:
-        hw_error("stellaris_enet_write: Bad offset %x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "stellaris_enet_wr%d: Illegal register "
+                                       "0x02%" HWADDR_PRIx " = 0x%" PRIx64 "\n",
+                      size * 8, offset, value);
     }
 }
 
-- 
2.18.0
