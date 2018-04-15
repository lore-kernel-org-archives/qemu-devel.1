Received: from eggs.gnu.org ([2001:4830:134:3::10]:52667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKv-0006UW-TC
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKu-0001qA-QO
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:33 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:43:05 -0300
Message-Id: <20180415234307.28132-40-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 39/41] hw/nvdimm: Use the BYTE-based
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/mem/nvdimm.h | 3 ++-
 hw/mem/nvdimm.c         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 7fd87c4e1c..fda855ad1a 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -23,6 +23,7 @@
 #ifndef QEMU_NVDIMM_H
 #define QEMU_NVDIMM_H
 
+#include "qemu/units.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
 
@@ -40,7 +41,7 @@
  *   "NVDIMMs following the NVDIMM Block Mode Specification use an area
  *    at least 128KB in size, which holds around 1000 labels."
  */
-#define MIN_NAMESPACE_LABEL_SIZE      (128UL << 10)
+#define MIN_NAMESPACE_LABEL_SIZE      (128 * K_BYTE)
 
 #define TYPE_NVDIMM      "nvdimm"
 #define NVDIMM(obj)      OBJECT_CHECK(NVDIMMDevice, (obj), TYPE_NVDIMM)
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index acb656b672..0f83e9fb4c 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -54,7 +54,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
     }
     if (value < MIN_NAMESPACE_LABEL_SIZE) {
         error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is required"
-                   " at least 0x%lx", object_get_typename(obj),
+                   " at least 0x%llx", object_get_typename(obj),
                    name, value, MIN_NAMESPACE_LABEL_SIZE);
         goto out;
     }
-- 
2.17.0
