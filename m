Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTlM4-0006R5-Ck
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTlM3-0005iA-24
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:49:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Jun 2018 11:49:05 +0200
Message-Id: <1529056145-6404-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3] loader: Check access size when calling
 rom_ptr() to avoid crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

The rom_ptr() function allows direct access to the ROM blobs that we
load during startup. However, there are currently no checks for the
size of the accesses, so it's currently possible to crash QEMU for
example with:

$ echo "Insane in the mainframe" > /tmp/test.txt
$ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
Segmentation fault (core dumped)
$ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
Segmentation fault (core dumped)
$ echo -n HdrS > /tmp/hdr.txt
$ sparc64-softmmu/qemu-system-sparc64 -kernel /tmp/hdr.txt -initrd /tmp/hdr.txt
Segmentation fault (core dumped)

We need a possibility to check the size of the ROM area that we want
to access, thus let's add a size parameter to the rom_ptr() function
to avoid these problems.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Fix the check in find_rom()

 hw/core/loader.c     | 10 +++++-----
 hw/mips/mips_malta.c |  6 ++++--
 hw/s390x/ipl.c       | 13 ++++++++++---
 hw/sparc/sun4m.c     |  4 ++--
 hw/sparc64/sun4u.c   |  4 ++--
 include/hw/loader.h  |  2 +-
 target/arm/cpu.c     |  2 +-
 7 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 06bdbca..4a06cce 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -191,7 +191,7 @@ void pstrcpy_targphys(const char *name, hwaddr dest, int buf_size,
         rom_add_blob_fixed(name, source, (nulp - source) + 1, dest);
     } else {
         rom_add_blob_fixed(name, source, buf_size, dest);
-        ptr = rom_ptr(dest + buf_size - 1);
+        ptr = rom_ptr(dest + buf_size - 1, sizeof(*ptr));
         *ptr = 0;
     }
 }
@@ -1165,7 +1165,7 @@ void rom_reset_order_override(void)
     fw_cfg_reset_order_override(fw_cfg);
 }
 
-static Rom *find_rom(hwaddr addr)
+static Rom *find_rom(hwaddr addr, size_t size)
 {
     Rom *rom;
 
@@ -1179,7 +1179,7 @@ static Rom *find_rom(hwaddr addr)
         if (rom->addr > addr) {
             continue;
         }
-        if (rom->addr + rom->romsize < addr) {
+        if (rom->addr + rom->romsize < addr + size) {
             continue;
         }
         return rom;
@@ -1249,11 +1249,11 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t size)
     return (d + l) - dest;
 }
 
-void *rom_ptr(hwaddr addr)
+void *rom_ptr(hwaddr addr, size_t size)
 {
     Rom *rom;
 
-    rom = find_rom(addr);
+    rom = find_rom(addr, size);
     if (!rom || !rom->data)
         return NULL;
     return rom->data + (addr - rom->addr);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 494f84e..3733e2f 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1133,11 +1133,13 @@ void mips_malta_init(MachineState *machine)
            a neat trick which allows bi-endian firmware. */
 #ifndef TARGET_WORDS_BIGENDIAN
         {
-            uint32_t *end, *addr = rom_ptr(FLASH_ADDRESS);
+            uint32_t *end, *addr;
+            const size_t swapsize = MIN(bios_size, 0x3e0000);
+            addr = rom_ptr(FLASH_ADDRESS, swapsize);
             if (!addr) {
                 addr = memory_region_get_ram_ptr(bios);
             }
-            end = (void *)addr + MIN(bios_size, 0x3e0000);
+            end = (void *)addr + swapsize;
             while (addr < end) {
                 bswap32s(addr);
                 addr++;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 04245b5..bcac204 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -169,9 +169,12 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
          * loader) and it won't work. For this case we force it to 0x10000, too.
          */
         if (pentry == KERN_IMAGE_START || pentry == 0x800) {
+            char *parm_area = rom_ptr(KERN_PARM_AREA, strlen(ipl->cmdline) + 1);
             ipl->start_addr = KERN_IMAGE_START;
             /* Overwrite parameters in the kernel image, which are "rom" */
-            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
+            if (parm_area) {
+                strcpy(parm_area, ipl->cmdline);
+            }
         } else {
             ipl->start_addr = pentry;
         }
@@ -179,6 +182,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
         if (ipl->initrd) {
             ram_addr_t initrd_offset;
             int initrd_size;
+            uint64_t *romptr;
 
             initrd_offset = INITRD_START;
             while (kernel_size + 0x100000 > initrd_offset) {
@@ -195,8 +199,11 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
              * we have to overwrite values in the kernel image,
              * which are "rom"
              */
-            stq_p(rom_ptr(INITRD_PARM_START), initrd_offset);
-            stq_p(rom_ptr(INITRD_PARM_SIZE), initrd_size);
+            romptr = rom_ptr(INITRD_PARM_START, 16);
+            if (romptr) {
+                stq_p(romptr, initrd_offset);
+                stq_p(romptr + 1, initrd_size);
+            }
         }
     }
     /*
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0ee779f..8eef74b 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -272,8 +272,8 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
         }
         if (initrd_size > 0) {
             for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
-                ptr = rom_ptr(KERNEL_LOAD_ADDR + i);
-                if (ldl_p(ptr) == 0x48647253) { // HdrS
+                ptr = rom_ptr(KERNEL_LOAD_ADDR + i, 24);
+                if (ptr && ldl_p(ptr) == 0x48647253) { /* HdrS */
                     stl_p(ptr + 16, INITRD_LOAD_ADDR);
                     stl_p(ptr + 20, initrd_size);
                     break;
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 1bede85..5b76863 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -186,8 +186,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
         }
         if (*initrd_size > 0) {
             for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
-                ptr = rom_ptr(*kernel_addr + i);
-                if (ldl_p(ptr + 8) == 0x48647253) { /* HdrS */
+                ptr = rom_ptr(*kernel_addr + i, 32);
+                if (ptr && ldl_p(ptr + 8) == 0x48647253) { /* HdrS */
                     stl_p(ptr + 24, *initrd_addr + *kernel_addr);
                     stl_p(ptr + 28, *initrd_size);
                     break;
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 5ed3fd8..e98b84b 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -226,7 +226,7 @@ void rom_set_fw(FWCfgState *f);
 void rom_set_order_override(int order);
 void rom_reset_order_override(void);
 int rom_copy(uint8_t *dest, hwaddr addr, size_t size);
-void *rom_ptr(hwaddr addr);
+void *rom_ptr(hwaddr addr, size_t size);
 void hmp_info_roms(Monitor *mon, const QDict *qdict);
 
 #define rom_add_file_fixed(_f, _a, _i)          \
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab047b9..95f92b2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -232,7 +232,7 @@ static void arm_cpu_reset(CPUState *s)
 
         /* Load the initial SP and PC from offset 0 and 4 in the vector table */
         vecbase = env->v7m.vecbase[env->v7m.secure];
-        rom = rom_ptr(vecbase);
+        rom = rom_ptr(vecbase, 8);
         if (rom) {
             /* Address zero is covered by ROM which hasn't yet been
              * copied into physical memory.
-- 
1.8.3.1
