Received: from eggs.gnu.org ([2001:4830:134:3::10]:52725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rL2-0006Yi-2s
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rL0-0001tS-FS
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:43:06 -0300
Message-Id: <20180415234307.28132-41-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 40/41] hw/loader: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paul Burton <paul.burton@mips.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/loader.h  | 5 +++--
 hw/core/loader-fit.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 5ed3fd8ae6..2222ca4184 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -1,5 +1,6 @@
 #ifndef LOADER_H
 #define LOADER_H
+#include "qemu/units.h"
 #include "hw/nvram/fw_cfg.h"
 
 /* loader.c */
@@ -52,7 +53,7 @@ int load_image_mr(const char *filename, MemoryRegion *mr);
  * load_image_gzipped_buffer() and load_image_gzipped() will read. It prevents
  * g_malloc() in those functions from allocating a huge amount of memory.
  */
-#define LOAD_IMAGE_MAX_GUNZIP_BYTES (256 << 20)
+#define LOAD_IMAGE_MAX_GUNZIP_BYTES (256 * M_BYTE)
 
 int load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
                               uint8_t **buffer);
@@ -253,6 +254,6 @@ int rom_add_option(const char *file, int32_t bootindex);
 
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
-#define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
+#define UBOOT_MAX_GUNZIP_BYTES (64 * M_BYTE)
 
 #endif
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 0c4a7207f4..0117104d69 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -22,7 +22,7 @@
 #include "exec/memory.h"
 #include "hw/loader.h"
 #include "hw/loader-fit.h"
-#include "qemu/cutils.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
-- 
2.17.0
