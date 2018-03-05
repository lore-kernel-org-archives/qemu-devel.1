Received: from eggs.gnu.org ([2001:4830:134:3::10]:41298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHd-0003PS-GT
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHc-0006wR-DR
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:27:57 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:11 -0300
Message-Id: <20180305112732.26471-10-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/30] hw/sparc: use the BYTE-based
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc/leon3.c     | 8 ++++----
 hw/sparc/sun4m.c     | 7 +++----
 hw/sparc64/niagara.c | 2 +-
 hw/sparc64/sun4u.c   | 2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index bba3aa3dee..31be3f32b0 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -139,9 +139,9 @@ static void leon3_generic_hw_init(MachineState *machine)
     env->qemu_irq_ack = leon3_irq_manager;
 
     /* Allocate RAM */
-    if ((uint64_t)ram_size > (1UL << 30)) {
-        error_report("Too much memory for this machine: %d, maximum 1G",
-                     (unsigned int)(ram_size / (1024 * 1024)));
+    if (ram_size > 1 * G_BYTE) {
+        error_report("Too much memory for this machine: %lluMB, maximum 1G",
+                     ram_size / M_BYTE);
         exit(1);
     }
 
@@ -149,7 +149,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x40000000, ram);
 
     /* Allocate BIOS */
-    prom_size = 8 * 1024 * 1024; /* 8Mb */
+    prom_size = 8 * M_BYTE;
     memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
     memory_region_set_readonly(prom, true);
     memory_region_add_subregion(address_space_mem, 0x00000000, prom);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 9d82490794..01b4d0c36e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -66,7 +66,7 @@
 #define KERNEL_LOAD_ADDR     0x00004000
 #define CMDLINE_ADDR         0x007ff000
 #define INITRD_LOAD_ADDR     0x00800000
-#define PROM_SIZE_MAX        (1024 * 1024)
+#define PROM_SIZE_MAX        (1 * M_BYTE)
 #define PROM_VADDR           0xffd00000
 #define PROM_FILENAME        "openbios-sparc32"
 #define CFG_ADDR             0xd00000510ULL
@@ -744,9 +744,8 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size,
 
     /* allocate RAM */
     if ((uint64_t)RAM_size > max_mem) {
-        error_report("Too much memory for this machine: %d, maximum %d",
-                     (unsigned int)(RAM_size / (1024 * 1024)),
-                     (unsigned int)(max_mem / (1024 * 1024)));
+        error_report("Too much memory for this machine: %llu, maximum %llu",
+                     RAM_size / M_BYTE, max_mem / M_BYTE);
         exit(1);
     }
     dev = qdev_create(NULL, "memory");
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 1874477ef6..97a78ca9a2 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -84,7 +84,7 @@ typedef struct NiagaraBoardState {
 #define NIAGARA_PROM_BASE   0xfff0000000ULL
 #define NIAGARA_Q_OFFSET    0x10000ULL
 #define NIAGARA_OBP_OFFSET  0x80000ULL
-#define PROM_SIZE_MAX       (4 * 1024 * 1024)
+#define PROM_SIZE_MAX       (4 * M_BYTE)
 
 static void add_rom_or_fail(const char *file, const hwaddr addr)
 {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index b84589e0b6..7a39ec7859 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -53,7 +53,7 @@
 
 #define KERNEL_LOAD_ADDR     0x00404000
 #define CMDLINE_ADDR         0x003ff000
-#define PROM_SIZE_MAX        (4 * 1024 * 1024)
+#define PROM_SIZE_MAX        (4 * M_BYTE)
 #define PROM_VADDR           0x000ffd00000ULL
 #define PBM_SPECIAL_BASE     0x1fe00000000ULL
 #define PBM_MEM_BASE         0x1ff00000000ULL
-- 
2.16.2
