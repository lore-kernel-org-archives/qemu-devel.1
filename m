Received: from eggs.gnu.org ([2001:4830:134:3::10]:37840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ964-00045k-9O
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ960-0001su-AU
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:00 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:41188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ960-0001r9-29
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:56 -0400
Received: by mail-wr0-x241.google.com with SMTP id h10-v6so10635236wrq.8
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:05 +0200
Message-Id: <20180630061040.6018-13-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/47] hw/smbios: Use the IEC binary prefix
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
Message-Id: <20180625124238.25339-11-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/smbios/smbios.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 27a07e9..a27e54b 100644
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
1.8.3.1
