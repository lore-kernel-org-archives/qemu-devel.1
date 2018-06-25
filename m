Received: from eggs.gnu.org ([2001:4830:134:3::10]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQqI-0001IL-QS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQqE-0007cu-Ml
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:02 -0300
Message-Id: <20180625124238.25339-11-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 10/46] hw/smbios: Use the IEC binary prefix
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/smbios/smbios.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 27a07e96f4..a27e54b2fa 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -625,10 +626,6 @@ static void smbios_build_type_11_table(void)
     SMBIOS_BUILD_TABLE_POST;
 }
 
-#define ONE_KB ((ram_addr_t)1 << 10)
-#define ONE_MB ((ram_addr_t)1 << 20)
-#define ONE_GB ((ram_addr_t)1 << 30)
-
 #define MAX_T16_STD_SZ 0x80000000 /* 2T in Kilobytes */
 
 static void smbios_build_type_16_table(unsigned dimm_cnt)
@@ -640,7 +637,7 @@ static void smbios_build_type_16_table(unsigned dimm_cnt)
     t->location = 0x01; /* Other */
     t->use = 0x03; /* System memory */
     t->error_correction = 0x06; /* Multi-bit ECC (for Microsoft, per SeaBIOS) */
-    size_kb = QEMU_ALIGN_UP(ram_size, ONE_KB) / ONE_KB;
+    size_kb = QEMU_ALIGN_UP(ram_size, KiB) / KiB;
     if (size_kb < MAX_T16_STD_SZ) {
         t->maximum_capacity = cpu_to_le32(size_kb);
         t->extended_maximum_capacity = cpu_to_le64(0);
@@ -668,7 +665,7 @@ static void smbios_build_type_17_table(unsigned instance, uint64_t size)
     t->memory_error_information_handle = cpu_to_le16(0xFFFE); /* Not provided */
     t->total_width = cpu_to_le16(0xFFFF); /* Unknown */
     t->data_width = cpu_to_le16(0xFFFF); /* Unknown */
-    size_mb = QEMU_ALIGN_UP(size, ONE_MB) / ONE_MB;
+    size_mb = QEMU_ALIGN_UP(size, MiB) / MiB;
     if (size_mb < MAX_T17_STD_SZ) {
         t->size = cpu_to_le16(size_mb);
         t->extended_size = cpu_to_le32(0);
@@ -707,8 +704,8 @@ static void smbios_build_type_19_table(unsigned instance,
 
     end = start + size - 1;
     assert(end > start);
-    start_kb = start / ONE_KB;
-    end_kb = end / ONE_KB;
+    start_kb = start / KiB;
+    end_kb = end / KiB;
     if (start_kb < UINT32_MAX && end_kb < UINT32_MAX) {
         t->starting_address = cpu_to_le32(start_kb);
         t->ending_address = cpu_to_le32(end_kb);
@@ -869,7 +866,7 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
 
         smbios_build_type_11_table();
 
-#define MAX_DIMM_SZ (16ll * ONE_GB)
+#define MAX_DIMM_SZ (16 * GiB)
 #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
                                         : ((ram_size - 1) % MAX_DIMM_SZ) + 1)
 
-- 
2.18.0
