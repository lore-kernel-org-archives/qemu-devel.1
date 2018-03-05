Received: from eggs.gnu.org ([2001:4830:134:3::10]:41862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoI1-00044E-3S
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHz-0007IU-Fp
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:21 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:28 -0300
Message-Id: <20180305112732.26471-27-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 26/30] hw/smbios: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/smbios/smbios.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 27a07e96f4..fa02f9ce3f 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -625,10 +625,6 @@ static void smbios_build_type_11_table(void)
     SMBIOS_BUILD_TABLE_POST;
 }
 
-#define ONE_KB ((ram_addr_t)1 << 10)
-#define ONE_MB ((ram_addr_t)1 << 20)
-#define ONE_GB ((ram_addr_t)1 << 30)
-
 #define MAX_T16_STD_SZ 0x80000000 /* 2T in Kilobytes */
 
 static void smbios_build_type_16_table(unsigned dimm_cnt)
@@ -640,7 +636,7 @@ static void smbios_build_type_16_table(unsigned dimm_cnt)
     t->location = 0x01; /* Other */
     t->use = 0x03; /* System memory */
     t->error_correction = 0x06; /* Multi-bit ECC (for Microsoft, per SeaBIOS) */
-    size_kb = QEMU_ALIGN_UP(ram_size, ONE_KB) / ONE_KB;
+    size_kb = QEMU_ALIGN_UP(ram_size, K_BYTE) / K_BYTE;
     if (size_kb < MAX_T16_STD_SZ) {
         t->maximum_capacity = cpu_to_le32(size_kb);
         t->extended_maximum_capacity = cpu_to_le64(0);
@@ -668,7 +664,7 @@ static void smbios_build_type_17_table(unsigned instance, uint64_t size)
     t->memory_error_information_handle = cpu_to_le16(0xFFFE); /* Not provided */
     t->total_width = cpu_to_le16(0xFFFF); /* Unknown */
     t->data_width = cpu_to_le16(0xFFFF); /* Unknown */
-    size_mb = QEMU_ALIGN_UP(size, ONE_MB) / ONE_MB;
+    size_mb = QEMU_ALIGN_UP(size, M_BYTE) / M_BYTE;
     if (size_mb < MAX_T17_STD_SZ) {
         t->size = cpu_to_le16(size_mb);
         t->extended_size = cpu_to_le32(0);
@@ -707,8 +703,8 @@ static void smbios_build_type_19_table(unsigned instance,
 
     end = start + size - 1;
     assert(end > start);
-    start_kb = start / ONE_KB;
-    end_kb = end / ONE_KB;
+    start_kb = start / K_BYTE;
+    end_kb = end / K_BYTE;
     if (start_kb < UINT32_MAX && end_kb < UINT32_MAX) {
         t->starting_address = cpu_to_le32(start_kb);
         t->ending_address = cpu_to_le32(end_kb);
@@ -869,7 +865,7 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
 
         smbios_build_type_11_table();
 
-#define MAX_DIMM_SZ (16ll * ONE_GB)
+#define MAX_DIMM_SZ (16 * G_BYTE)
 #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
                                         : ((ram_size - 1) % MAX_DIMM_SZ) + 1)
 
-- 
2.16.2
