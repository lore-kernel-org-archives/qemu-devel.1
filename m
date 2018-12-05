Received: from eggs.gnu.org ([2001:4830:134:3::10]:41617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gUfiD-00014x-ML
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gUfi9-0003pU-0g
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:32:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gUfi8-0003ow-Nu
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:32:04 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  5 Dec 2018 22:31:22 +0000
Message-Id: <1544049083-16087-3-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1544049083-16087-1-git-send-email-liam.merwick@oracle.com>
References: <1544049083-16087-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [RFC qboot 2/3] pvh: use x86/HVM direct boot ABI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, maran.wilson@oracle.com, liam.merwick@oracle.com

These changes (along with corresponding QEMU and Linux kernel changes)
enable a guest to be booted using the x86/HVM direct boot ABI.

QEMU parses the uncompressed kernel binary passed to it via -kernel
to read the ELF Note which contains the address to be loaded.  QEMU
then depends on qboot to populate the start_info struct needed by
the direct boot ABI and configure the guest e820 tables before
jumping to the loaded kernel entry.

Signed-off-by: George Kennedy <George.Kennedy@oracle.com>
Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 fw_cfg.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 linuxboot.c |  2 +-
 main.c      |  3 +++
 tables.c    |  9 ++++++++
 4 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/fw_cfg.c b/fw_cfg.c
index f5aac739b921..e13ec20d0e8b 100644
--- a/fw_cfg.c
+++ b/fw_cfg.c
@@ -8,6 +8,10 @@
 #include "linuxboot.h"
 #include "multiboot.h"
 #include "benchmark.h"
+#include "start_info.h"
+
+extern struct hvm_start_info start_info;
+extern inline uint32_t ldl_p(void *p);
 
 struct fw_cfg_file {
 	uint32_t size;
@@ -184,6 +188,67 @@ static void boot_multiboot_from_fw_cfg(void)
 	panic();
 }
 
+static void pvh_e820_setup()
+{
+	struct hvm_memmap_table_entry *pvh_e820p;
+	int i, pvh_e820_sz;
+
+	pvh_e820_sz = sizeof(struct hvm_memmap_table_entry) * e820->nr_map;
+
+	pvh_e820p = malloc(pvh_e820_sz);
+	memset(pvh_e820p, 0, pvh_e820_sz);
+
+	for (i = 0; i < e820->nr_map; i++) {
+		pvh_e820p[i].addr = e820->map[i].addr;
+		pvh_e820p[i].size = e820->map[i].size;
+		pvh_e820p[i].type = e820->map[i].type;
+	}
+	start_info.memmap_paddr = (uintptr_t)pvh_e820p;
+	start_info.memmap_entries = e820->nr_map;
+}
+
+void boot_pvh_from_fw_cfg(void)
+{
+	void *kernel_entry;
+	uint32_t sz;
+	struct linuxboot_args args;
+	struct hvm_modlist_entry ramdisk_mod;
+
+	start_info.magic = XEN_HVM_START_MAGIC_VALUE;
+	start_info.version = 1;
+	start_info.flags = 0;
+	start_info.nr_modules = 1;
+	start_info.reserved = 0;
+
+	fw_cfg_select(FW_CFG_CMDLINE_SIZE);
+	args.cmdline_size = fw_cfg_readl_le();
+	args.cmdline_addr = malloc(args.cmdline_size);
+	fw_cfg_read_entry(FW_CFG_CMDLINE_DATA, args.cmdline_addr,
+			  args.cmdline_size);
+	start_info.cmdline_paddr = (uintptr_t)args.cmdline_addr;
+
+	/* Use this field for pvhboot. Not used by pvhboot otherwise */
+	fw_cfg_read_entry(FW_CFG_KERNEL_DATA, &ramdisk_mod,
+			  sizeof(ramdisk_mod));
+	ramdisk_mod.cmdline_paddr = (uintptr_t)&ramdisk_mod;
+	start_info.modlist_paddr = (uintptr_t)&ramdisk_mod;
+
+	pvh_e820_setup();
+
+	fw_cfg_select(FW_CFG_KERNEL_SIZE);
+	sz = fw_cfg_readl_le();
+	if (!sz)
+		panic();
+
+	fw_cfg_select(FW_CFG_KERNEL_ENTRY);
+	kernel_entry = (void *) fw_cfg_readl_le();
+	asm volatile("movl %0, %%ebx" : : "r"(&start_info));
+
+	asm volatile("jmp *%2" : : "a" (0x2badb002),
+		     "b"(&start_info), "c"(kernel_entry));
+	panic();
+}
+
 void boot_from_fwcfg(void)
 {
 	struct linuxboot_args args;
@@ -208,8 +273,13 @@ void boot_from_fwcfg(void)
 	fw_cfg_select(FW_CFG_SETUP_DATA);
 	fw_cfg_read(args.header, sizeof(args.header));
 
-	if (!parse_bzimage(&args))
+	if (!parse_bzimage(&args)) {
+		uint8_t *header = args.header;
+
+		if (ldl_p(header) == 0x464c457f)  /* ELF magic */
+			boot_pvh_from_fw_cfg();
 		boot_multiboot_from_fw_cfg();
+	}
 
 	/* SETUP_DATA already selected */
 	if (args.setup_size > sizeof(args.header))
diff --git a/linuxboot.c b/linuxboot.c
index a5f1c4fa078d..573052cc0f78 100644
--- a/linuxboot.c
+++ b/linuxboot.c
@@ -12,7 +12,7 @@ static inline uint16_t lduw_p(void *p)
 	return val;
 }
 
-static inline uint32_t ldl_p(void *p)
+inline uint32_t ldl_p(void *p)
 {
 	uint32_t val;
 	memcpy(&val, p, 4);
diff --git a/main.c b/main.c
index 699cc1a8e6e7..725d50b94e1e 100644
--- a/main.c
+++ b/main.c
@@ -8,6 +8,9 @@
 #include "pflash.h"
 #include "pci.h"
 #include "benchmark.h"
+#include "start_info.h"
+
+struct hvm_start_info start_info = {0};
 
 static void set_realmode_int(int vec, void *p)
 {
diff --git a/tables.c b/tables.c
index 32b2406b9aed..47bef4125d9e 100644
--- a/tables.c
+++ b/tables.c
@@ -2,6 +2,9 @@
 #include "stdio.h"
 #include "fw_cfg.h"
 #include "string.h"
+#include "start_info.h"
+
+extern struct hvm_start_info start_info;
 
 struct loader_cmd {
 	uint32_t cmd;
@@ -122,6 +125,8 @@ static void do_checksum(char *file, uint32_t offset, uint32_t start, uint32_t le
 	p[offset] -= csum8(&p[start], len);
 }
 
+#define RSDP_FILE "etc/acpi/rsdp"
+
 void extract_acpi(void)
 {
 	int id = fw_cfg_file_id("etc/table-loader");
@@ -138,6 +143,10 @@ void extract_acpi(void)
 		struct loader_cmd *s = &script[i];
 		switch(script[i].cmd) {
 		case CMD_ALLOC:
+			if (strcmp(s->alloc.file, RSDP_FILE) == 0) {
+				start_info.rsdp_paddr =
+				    (uintptr_t)id_to_addr(id);
+			}
 			do_alloc(s->alloc.file, s->alloc.align, s->alloc.zone);
 			break;
 		case CMD_PTR:
-- 
1.8.3.1
