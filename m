Received: from eggs.gnu.org ([2001:4830:134:3::10]:37857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ964-00045q-RO
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ963-0001z4-Rq
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:00 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ963-0001xa-Ju
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:59 -0400
Received: by mail-wm0-x243.google.com with SMTP id i139-v6so4085516wmf.4
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:08 +0200
Message-Id: <20180630061040.6018-16-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/47] hw/block: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-14-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/m25p80.c  | 5 +++--
 hw/block/nvme.c    | 3 ++-
 hw/block/tc58128.c | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b0ed8fa..e8dfa14 100644
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
index d5bf95b..65c84e7 100644
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
index 1d9f7ee..808ad76 100644
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
1.8.3.1
