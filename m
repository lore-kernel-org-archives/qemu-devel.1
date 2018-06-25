Received: from eggs.gnu.org ([2001:4830:134:3::10]:54014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQqR-0001Ni-0h
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQqQ-0007jH-07
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:05 -0300
Message-Id: <20180625124238.25339-14-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 13/46] hw/block: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, "open list:Block layer core" <qemu-block@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/m25p80.c  | 5 +++--
 hw/block/nvme.c    | 3 ++-
 hw/block/tc58128.c | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b0ed8fa418..e8dfa14b33 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
 #include "hw/ssi/ssi.h"
@@ -541,12 +542,12 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
     switch (cmd) {
     case ERASE_4K:
     case ERASE4_4K:
-        len = 4 << 10;
+        len = 4 * KiB;
         capa_to_assert = ER_4K;
         break;
     case ERASE_32K:
     case ERASE4_32K:
-        len = 32 << 10;
+        len = 32 * KiB;
         capa_to_assert = ER_32K;
         break;
     case ERASE_SECTOR:
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d5bf95b79b..65c84e7de3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/block/block.h"
 #include "hw/hw.h"
 #include "hw/pci/msix.h"
@@ -648,7 +649,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
 
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
 {
-    static const int data_len = 4096;
+    static const int data_len = 4 * KiB;
     uint32_t min_nsid = le32_to_cpu(c->nsid);
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 1d9f7ee000..808ad76ba6 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "hw/loader.h"
@@ -26,7 +27,7 @@ typedef struct {
 
 static tc58128_dev tc58128_devs[2];
 
-#define FLASH_SIZE (16*1024*1024)
+#define FLASH_SIZE (16 * MiB)
 
 static void init_dev(tc58128_dev * dev, const char *filename)
 {
-- 
2.18.0
