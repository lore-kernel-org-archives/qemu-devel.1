Received: from eggs.gnu.org ([2001:4830:134:3::10]:52593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7X-0007S4-FS
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7U-0005tw-AE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:43 -0500
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com
	([104.47.41.74]:37696
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj7U-0005tl-32
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:40 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:54:11 -0500
Message-ID: <148900645191.27090.14005849682729903734.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 17/20] target/i386: encrypt bios rom
 when memory encryption is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

If guest is launched with memory encryption enabled then we encrypt the
data copied into pflash device also set the debug ops for PC.BIOS, PC.RAM
and PLFASH memory regions. This will ensure that any debug access to these
memory region will go through the memory encryption APIs. It cover both plfash
type of device as well as passing the bios image via -bios option in qemu
command line.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/i386/pc.c       |    7 +++++++
 hw/i386/pc_sysfw.c |   30 +++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e..a0c0816 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1392,6 +1392,13 @@ void pc_memory_init(PCMachineState *pcms,
         e820_add_entry(0x100000000ULL, pcms->above_4g_mem_size, E820_RAM);
     }
 
+    /* if memory encryption is enabled then set the memory encryption
+     * ops so that any debug read and write to guest memory from hypervisor will
+     * go through encryption routines. */
+    if (kvm_memcrypt_enabled()) {
+        kvm_memcrypt_set_debug_ops(ram);
+    }
+
     if (!pcmc->has_reserved_memory &&
         (machine->ram_slots ||
          (machine->maxram_size > machine->ram_size))) {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index f915ad0..518a341 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -47,7 +47,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
                              MemoryRegion *flash_mem,
                              int ram_size)
 {
-    int isa_bios_size;
+    int ret, isa_bios_size;
     MemoryRegion *isa_bios;
     uint64_t flash_size;
     void *flash_ptr, *isa_bios_ptr;
@@ -72,6 +72,15 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
            ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
            isa_bios_size);
 
+    /* If memory encryption is enabled then encrypt the ISA rom */
+    if (kvm_memcrypt_enabled()) {
+        ret = kvm_memcrypt_encrypt_launch_data(isa_bios_ptr, isa_bios_size);
+        if (ret) {
+            fprintf(stderr, "Error: failed to encrypt isa_bios image\n");
+        }
+        kvm_memcrypt_set_debug_ops(isa_bios);
+    }
+
     memory_region_set_readonly(isa_bios, true);
 }
 
@@ -103,6 +112,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
  */
 static void pc_system_flash_init(MemoryRegion *rom_memory)
 {
+    int ret;
     int unit;
     DriveInfo *pflash_drv;
     BlockBackend *blk;
@@ -113,6 +123,8 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
     pflash_t *system_flash;
     MemoryRegion *flash_mem;
     char name[64];
+    void *flash_ptr;
+    int flash_size;
 
     sector_bits = 12;
     sector_size = 1 << sector_bits;
@@ -168,7 +180,20 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
                                              0      /* be */);
         if (unit == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
+
             pc_isa_bios_init(rom_memory, flash_mem, size);
+
+            /* Encrypt the pflash boot ROM */
+            if (kvm_memcrypt_enabled()) {
+                flash_ptr = memory_region_get_ram_ptr(flash_mem);
+                flash_size = memory_region_size(flash_mem);
+                ret = kvm_memcrypt_encrypt_launch_data(flash_ptr, flash_size);
+                if (ret) {
+                    fprintf(stderr, "Error: failed to encrypt %s\n", name);
+                    exit(1);
+                }
+                kvm_memcrypt_set_debug_ops(flash_mem);
+            }
         }
     }
 }
@@ -208,6 +233,9 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
     }
     g_free(filename);
 
+    if (kvm_memcrypt_enabled()) {
+        kvm_memcrypt_set_debug_ops(bios);
+    }
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = bios_size;
     if (isa_bios_size > (128 * 1024)) {
