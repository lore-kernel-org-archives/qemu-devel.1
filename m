Received: from eggs.gnu.org ([209.51.188.92]:51828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyE-0004Uh-UM
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyB-0004Fw-EM
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyB-0004Ew-0Q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:47 -0500
Received: by mail-wr1-x443.google.com with SMTP id v13so24483399wrw.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:54 +0100
Message-Id: <1548093980-43088-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/49] elf: Add optional function ptr to
 load_elf() to parse ELF notes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Liam Merwick <liam.merwick@oracle.com>

This patch adds an optional function pointer, 'elf_note_fn', to
load_elf() which causes load_elf() to additionally parse any
ELF program headers of type PT_NOTE and check to see if the ELF
Note is of the type specified by the 'translate_opaque' arg.
If a matching ELF Note is found then the specfied function pointer
is called to process the ELF note.

Passing a NULL function pointer results in ELF Notes being skipped.

The first consumer of this functionality is the PVHboot support
which needs to read the XEN_ELFNOTE_PHYS32_ENTRY ELF Note while
loading the uncompressed kernel binary in order to discover the
boot entry address for the x86/HVM direct boot ABI.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/alpha/dp264.c               |  4 ++--
 hw/arm/armv7m.c                |  3 ++-
 hw/arm/boot.c                  |  2 +-
 hw/core/generic-loader.c       |  2 +-
 hw/core/loader.c               | 24 ++++++++++++++++--------
 hw/cris/boot.c                 |  3 ++-
 hw/hppa/machine.c              |  6 +++---
 hw/i386/multiboot.c            |  2 +-
 hw/lm32/lm32_boards.c          |  6 ++++--
 hw/lm32/milkymist.c            |  3 ++-
 hw/m68k/an5206.c               |  2 +-
 hw/m68k/mcf5208.c              |  2 +-
 hw/microblaze/boot.c           |  7 ++++---
 hw/mips/mips_fulong2e.c        |  5 +++--
 hw/mips/mips_malta.c           |  5 +++--
 hw/mips/mips_mipssim.c         |  5 +++--
 hw/mips/mips_r4k.c             |  5 +++--
 hw/moxie/moxiesim.c            |  2 +-
 hw/nios2/boot.c                |  7 ++++---
 hw/openrisc/openrisc_sim.c     |  2 +-
 hw/pci-host/prep.c             |  2 +-
 hw/ppc/e500.c                  |  3 ++-
 hw/ppc/mac_newworld.c          |  5 +++--
 hw/ppc/mac_oldworld.c          |  5 +++--
 hw/ppc/ppc440_bamboo.c         |  2 +-
 hw/ppc/sam460ex.c              |  3 ++-
 hw/ppc/spapr.c                 |  7 ++++---
 hw/ppc/virtex_ml507.c          |  2 +-
 hw/riscv/sifive_e.c            |  2 +-
 hw/riscv/sifive_u.c            |  2 +-
 hw/riscv/spike.c               |  2 +-
 hw/riscv/virt.c                |  2 +-
 hw/s390x/ipl.c                 |  9 ++++++---
 hw/sparc/leon3.c               |  3 ++-
 hw/sparc/sun4m.c               |  6 ++++--
 hw/sparc64/sun4u.c             |  4 ++--
 hw/tricore/tricore_testboard.c |  2 +-
 hw/xtensa/sim.c                | 12 ++++++++----
 hw/xtensa/xtfpga.c             |  2 +-
 include/hw/elf_ops.h           |  2 ++
 include/hw/loader.h            |  9 ++++++++-
 41 files changed, 113 insertions(+), 70 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index dd62f2a..0347eb8 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -114,7 +114,7 @@ static void clipper_init(MachineState *machine)
         error_report("no palcode provided");
         exit(1);
     }
-    size = load_elf(palcode_filename, cpu_alpha_superpage_to_phys,
+    size = load_elf(palcode_filename, NULL, cpu_alpha_superpage_to_phys,
                     NULL, &palcode_entry, &palcode_low, &palcode_high,
                     0, EM_ALPHA, 0, 0);
     if (size < 0) {
@@ -133,7 +133,7 @@ static void clipper_init(MachineState *machine)
     if (kernel_filename) {
         uint64_t param_offset;
 
-        size = load_elf(kernel_filename, cpu_alpha_superpage_to_phys,
+        size = load_elf(kernel_filename, NULL, cpu_alpha_superpage_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high,
                         0, EM_ALPHA, 0, 0);
         if (size < 0) {
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index f444652..ae68aad 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -293,7 +293,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
     as = cpu_get_address_space(cs, asidx);
 
     if (kernel_filename) {
-        image_size = load_elf_as(kernel_filename, NULL, NULL, &entry, &lowaddr,
+        image_size = load_elf_as(kernel_filename, NULL, NULL, NULL,
+                                 &entry, &lowaddr,
                                  NULL, big_endian, EM_ARM, 1, 0, as);
         if (image_size < 0) {
             image_size = load_image_targphys_as(kernel_filename, 0,
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c7a67af..9d8746f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -885,7 +885,7 @@ static int64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
         }
     }
 
-    ret = load_elf_as(info->kernel_filename, NULL, NULL,
+    ret = load_elf_as(info->kernel_filename, NULL, NULL, NULL,
                       pentry, lowaddr, highaddr, big_endian, elf_machine,
                       1, data_swab, as);
     if (ret <= 0) {
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index fbae05f..3695dd4 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -136,7 +136,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
 
         if (!s->force_raw) {
-            size = load_elf_as(s->file, NULL, NULL, &entry, NULL, NULL,
+            size = load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL, NULL,
                                big_endian, 0, 0, 0, as);
 
             if (size < 0) {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index c4f62fe..3a000d5 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -396,37 +396,42 @@ fail:
 }
 
 /* return < 0 if error, otherwise the number of bytes loaded in memory */
-int load_elf(const char *filename, uint64_t (*translate_fn)(void *, uint64_t),
+int load_elf(const char *filename,
+             uint64_t (*elf_note_fn)(void *, void *, bool),
+             uint64_t (*translate_fn)(void *, uint64_t),
              void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
              uint64_t *highaddr, int big_endian, int elf_machine,
              int clear_lsb, int data_swab)
 {
-    return load_elf_as(filename, translate_fn, translate_opaque, pentry,
-                       lowaddr, highaddr, big_endian, elf_machine, clear_lsb,
-                       data_swab, NULL);
+    return load_elf_as(filename, elf_note_fn, translate_fn, translate_opaque,
+                       pentry, lowaddr, highaddr, big_endian, elf_machine,
+                       clear_lsb, data_swab, NULL);
 }
 
 /* return < 0 if error, otherwise the number of bytes loaded in memory */
 int load_elf_as(const char *filename,
+                uint64_t (*elf_note_fn)(void *, void *, bool),
                 uint64_t (*translate_fn)(void *, uint64_t),
                 void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
                 uint64_t *highaddr, int big_endian, int elf_machine,
                 int clear_lsb, int data_swab, AddressSpace *as)
 {
-    return load_elf_ram(filename, translate_fn, translate_opaque,
+    return load_elf_ram(filename, elf_note_fn, translate_fn, translate_opaque,
                         pentry, lowaddr, highaddr, big_endian, elf_machine,
                         clear_lsb, data_swab, as, true);
 }
 
 /* return < 0 if error, otherwise the number of bytes loaded in memory */
 int load_elf_ram(const char *filename,
+                 uint64_t (*elf_note_fn)(void *, void *, bool),
                  uint64_t (*translate_fn)(void *, uint64_t),
                  void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
                  uint64_t *highaddr, int big_endian, int elf_machine,
                  int clear_lsb, int data_swab, AddressSpace *as,
                  bool load_rom)
 {
-    return load_elf_ram_sym(filename, translate_fn, translate_opaque,
+    return load_elf_ram_sym(filename, elf_note_fn,
+                            translate_fn, translate_opaque,
                             pentry, lowaddr, highaddr, big_endian,
                             elf_machine, clear_lsb, data_swab, as,
                             load_rom, NULL);
@@ -434,6 +439,7 @@ int load_elf_ram(const char *filename,
 
 /* return < 0 if error, otherwise the number of bytes loaded in memory */
 int load_elf_ram_sym(const char *filename,
+                     uint64_t (*elf_note_fn)(void *, void *, bool),
                      uint64_t (*translate_fn)(void *, uint64_t),
                      void *translate_opaque, uint64_t *pentry,
                      uint64_t *lowaddr, uint64_t *highaddr, int big_endian,
@@ -476,11 +482,13 @@ int load_elf_ram_sym(const char *filename,
 
     lseek(fd, 0, SEEK_SET);
     if (e_ident[EI_CLASS] == ELFCLASS64) {
-        ret = load_elf64(filename, fd, translate_fn, translate_opaque, must_swab,
+        ret = load_elf64(filename, fd, elf_note_fn,
+                         translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, elf_machine, clear_lsb,
                          data_swab, as, load_rom, sym_cb);
     } else {
-        ret = load_elf32(filename, fd, translate_fn, translate_opaque, must_swab,
+        ret = load_elf32(filename, fd, elf_note_fn,
+                         translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, elf_machine, clear_lsb,
                          data_swab, as, load_rom, sym_cb);
     }
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index f896ed7..95cba21 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -75,7 +75,8 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_info *li)
     env->load_info = li;
     /* Boots a kernel elf binary, os/linux-2.6/vmlinux from the axis 
        devboard SDK.  */
-    image_size = load_elf(li->image_filename, translate_kernel_address, NULL,
+    image_size = load_elf(li->image_filename, NULL,
+                          translate_kernel_address, NULL,
                           &entry, NULL, &high, 0, EM_CRIS, 0, 0);
     li->entry = entry;
     if (image_size < 0) {
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index ac6dd7f..d1b1d3c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -135,8 +135,8 @@ static void machine_hppa_init(MachineState *machine)
         exit(1);
     }
 
-    size = load_elf(firmware_filename, NULL,
-                    NULL, &firmware_entry, &firmware_low, &firmware_high,
+    size = load_elf(firmware_filename, NULL, NULL, NULL,
+                    &firmware_entry, &firmware_low, &firmware_high,
                     true, EM_PARISC, 0, 0);
 
     /* Unfortunately, load_elf sign-extends reading elf32.  */
@@ -165,7 +165,7 @@ static void machine_hppa_init(MachineState *machine)
 
     /* Load kernel */
     if (kernel_filename) {
-        size = load_elf(kernel_filename, &cpu_hppa_to_phys,
+        size = load_elf(kernel_filename, NULL, &cpu_hppa_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high,
                         true, EM_PARISC, 0, 0);
 
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 6234068..a3e33fb 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -199,7 +199,7 @@ int load_multiboot(FWCfgState *fw_cfg,
             exit(1);
         }
 
-        kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
                                &elf_low, &elf_high, 0, I386_ELF_MACHINE,
                                0, 0);
         if (kernel_size < 0) {
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index fd8eccc..05157f8 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -138,7 +138,8 @@ static void lm32_evr_init(MachineState *machine)
         uint64_t entry;
         int kernel_size;
 
-        kernel_size = load_elf(kernel_filename, NULL, NULL, &entry, NULL, NULL,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
+                               &entry, NULL, NULL,
                                1, EM_LATTICEMICO32, 0, 0);
         reset_info->bootstrap_pc = entry;
 
@@ -231,7 +232,8 @@ static void lm32_uclinux_init(MachineState *machine)
         uint64_t entry;
         int kernel_size;
 
-        kernel_size = load_elf(kernel_filename, NULL, NULL, &entry, NULL, NULL,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
+                               &entry, NULL, NULL,
                                1, EM_LATTICEMICO32, 0, 0);
         reset_info->bootstrap_pc = entry;
 
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 63c6894..7b0046b 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -175,7 +175,8 @@ milkymist_init(MachineState *machine)
         uint64_t entry;
 
         /* Boots a kernel elf binary.  */
-        kernel_size = load_elf(kernel_filename, NULL, NULL, &entry, NULL, NULL,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
+                               &entry, NULL, NULL,
                                1, EM_LATTICEMICO32, 0, 0);
         reset_info->bootstrap_pc = entry;
 
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 5e067ea..06e3803 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -66,7 +66,7 @@ static void an5206_init(MachineState *machine)
         exit(1);
     }
 
-    kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
+    kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
                            NULL, NULL, 1, EM_68K, 0, 0);
     entry = elf_entry;
     if (kernel_size < 0) {
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0f2245d..8531e07 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -294,7 +294,7 @@ static void mcf5208evb_init(MachineState *machine)
         exit(1);
     }
 
-    kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
+    kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
                            NULL, NULL, 1, EM_68K, 0, 0);
     entry = elf_entry;
     if (kernel_size < 0) {
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 489ab83..a7af4c0 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -142,13 +142,14 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
 #endif
 
         /* Boots a kernel elf binary.  */
-        kernel_size = load_elf(kernel_filename, NULL, NULL,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, &low, &high,
                                big_endian, EM_MICROBLAZE, 0, 0);
         base32 = entry;
         if (base32 == 0xc0000000) {
-            kernel_size = load_elf(kernel_filename, translate_kernel_address,
-                                   NULL, &entry, NULL, NULL,
+            kernel_size = load_elf(kernel_filename, NULL,
+                                   translate_kernel_address, NULL,
+                                   &entry, NULL, NULL,
                                    big_endian, EM_MICROBLAZE, 0, 0);
         }
         /* Always boot into physical ram.  */
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 2fbba32..1f24a9f 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -111,8 +111,9 @@ static int64_t load_kernel (CPUMIPSState *env)
     uint32_t *prom_buf;
     long prom_size;
 
-    kernel_size = load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys,
-                           NULL, (uint64_t *)&kernel_entry,
+    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
+                           cpu_mips_kseg0_to_phys, NULL,
+                           (uint64_t *)&kernel_entry,
                            (uint64_t *)&kernel_low, (uint64_t *)&kernel_high,
                            0, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index c1cf0fe..7466776 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1010,8 +1010,9 @@ static int64_t load_kernel (void)
     big_endian = 0;
 #endif
 
-    kernel_size = load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys,
-                           NULL, (uint64_t *)&kernel_entry, NULL,
+    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
+                           cpu_mips_kseg0_to_phys, NULL,
+                           (uint64_t *)&kernel_entry, NULL,
                            (uint64_t *)&kernel_high, big_endian, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index f665752..824abda 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -69,8 +69,9 @@ static int64_t load_kernel(void)
     big_endian = 0;
 #endif
 
-    kernel_size = load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys,
-                           NULL, (uint64_t *)&entry, NULL,
+    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
+                           cpu_mips_kseg0_to_phys, NULL,
+                           (uint64_t *)&entry, NULL,
                            (uint64_t *)&kernel_high, big_endian,
                            EM_MIPS, 1, 0);
     if (kernel_size >= 0) {
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 1922407..a015a6d 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -92,8 +92,9 @@ static int64_t load_kernel(void)
 #else
     big_endian = 0;
 #endif
-    kernel_size = load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys,
-                           NULL, (uint64_t *)&entry, NULL,
+    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
+                           cpu_mips_kseg0_to_phys, NULL,
+                           (uint64_t *)&entry, NULL,
                            (uint64_t *)&kernel_high, big_endian,
                            EM_MIPS, 1, 0);
     if (kernel_size >= 0) {
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index c6b6f72..eddeed9 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -57,7 +57,7 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams *loader_params)
     long kernel_size;
     ram_addr_t initrd_offset;
 
-    kernel_size = load_elf(loader_params->kernel_filename,  NULL, NULL,
+    kernel_size = load_elf(loader_params->kernel_filename,  NULL, NULL, NULL,
                            &entry, &kernel_low, &kernel_high, 1, EM_MOXIE,
                            0, 0);
 
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index ed5cb28..5f0ab2f 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -146,13 +146,14 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
 #endif
 
         /* Boots a kernel elf binary. */
-        kernel_size = load_elf(kernel_filename, NULL, NULL,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, &low, &high,
                                big_endian, EM_ALTERA_NIOS2, 0, 0);
         base32 = entry;
         if (base32 == 0xc0000000) {
-            kernel_size = load_elf(kernel_filename, translate_kernel_address,
-                                   NULL, &entry, NULL, NULL,
+            kernel_size = load_elf(kernel_filename, NULL,
+                                   translate_kernel_address, NULL,
+                                   &entry, NULL, NULL,
                                    big_endian, EM_ALTERA_NIOS2, 0, 0);
         }
 
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index a495a84..7d3b734 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -96,7 +96,7 @@ static void openrisc_load_kernel(ram_addr_t ram_size,
     hwaddr entry;
 
     if (kernel_filename && !qtest_enabled()) {
-        kernel_size = load_elf(kernel_filename, NULL, NULL,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &elf_entry, NULL, NULL, 1, EM_OPENRISC,
                                1, 0);
         entry = elf_entry;
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index b1b6b16..8b9e1fd 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -331,7 +331,7 @@ static void raven_realize(PCIDevice *d, Error **errp)
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, s->bios_name);
         if (filename) {
             if (s->elf_machine != EM_NONE) {
-                bios_size = load_elf(filename, NULL, NULL, NULL,
+                bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
                                      NULL, NULL, 1, s->elf_machine, 0, 0);
             }
             if (bios_size < 0) {
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 0581e9e..7553f67 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -988,7 +988,8 @@ void ppce500_init(MachineState *machine)
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
 
-    payload_size = load_elf(filename, NULL, NULL, &bios_entry, &loadaddr, NULL,
+    payload_size = load_elf(filename, NULL, NULL, NULL,
+                            &bios_entry, &loadaddr, NULL,
                             1, PPC_ELF_MACHINE, 0, 0);
     if (payload_size < 0) {
         /*
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index bb19eab..40be6d0 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -165,7 +165,7 @@ static void ppc_core99_init(MachineState *machine)
 
     /* Load OpenBIOS (ELF) */
     if (filename) {
-        bios_size = load_elf(filename, NULL, NULL, NULL,
+        bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
                              NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
 
         g_free(filename);
@@ -188,7 +188,8 @@ static void ppc_core99_init(MachineState *machine)
 #endif
         kernel_base = KERNEL_LOAD_ADDR;
 
-        kernel_size = load_elf(kernel_filename, translate_kernel_address, NULL,
+        kernel_size = load_elf(kernel_filename, NULL,
+                               translate_kernel_address, NULL,
                                NULL, &lowaddr, NULL, 1, PPC_ELF_MACHINE,
                                0, 0);
         if (kernel_size < 0)
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 817f70e..c28dde1 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -140,7 +140,7 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* Load OpenBIOS (ELF) */
     if (filename) {
-        bios_size = load_elf(filename, 0, NULL, NULL, NULL, NULL,
+        bios_size = load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL,
                              1, PPC_ELF_MACHINE, 0, 0);
         g_free(filename);
     } else {
@@ -161,7 +161,8 @@ static void ppc_heathrow_init(MachineState *machine)
         bswap_needed = 0;
 #endif
         kernel_base = KERNEL_LOAD_ADDR;
-        kernel_size = load_elf(kernel_filename, translate_kernel_address, NULL,
+        kernel_size = load_elf(kernel_filename, NULL,
+                               translate_kernel_address, NULL,
                                NULL, &lowaddr, NULL, 1, PPC_ELF_MACHINE,
                                0, 0);
         if (kernel_size < 0)
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index fc06191..6318301 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -256,7 +256,7 @@ static void bamboo_init(MachineState *machine)
         success = load_uimage(kernel_filename, &entry, &loadaddr, NULL,
                               NULL, NULL);
         if (success < 0) {
-            success = load_elf(kernel_filename, NULL, NULL, &elf_entry,
+            success = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
                                &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE,
                                0, 0);
             entry = elf_entry;
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 84ea592..934674f 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -557,7 +557,8 @@ static void sam460ex_init(MachineState *machine)
         if (success < 0) {
             uint64_t elf_entry, elf_lowaddr;
 
-            success = load_elf(machine->kernel_filename, NULL, NULL, &elf_entry,
+            success = load_elf(machine->kernel_filename, NULL,
+                               NULL, NULL, &elf_entry,
                                &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE, 0, 0);
             entry = elf_entry;
             loadaddr = elf_lowaddr;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0942f35..3cbc44c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2852,11 +2852,12 @@ static void spapr_machine_init(MachineState *machine)
     if (kernel_filename) {
         uint64_t lowaddr = 0;
 
-        spapr->kernel_size = load_elf(kernel_filename, translate_kernel_address,
-                                      NULL, NULL, &lowaddr, NULL, 1,
+        spapr->kernel_size = load_elf(kernel_filename, NULL,
+                                      translate_kernel_address, NULL,
+                                      NULL, &lowaddr, NULL, 1,
                                       PPC_ELF_MACHINE, 0, 0);
         if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
-            spapr->kernel_size = load_elf(kernel_filename,
+            spapr->kernel_size = load_elf(kernel_filename, NULL,
                                           translate_kernel_address, NULL, NULL,
                                           &lowaddr, NULL, 0, PPC_ELF_MACHINE,
                                           0, 0);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 5177120..5a711cb 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -258,7 +258,7 @@ static void virtex_init(MachineState *machine)
         hwaddr boot_offset;
 
         /* Boots a kernel elf binary.  */
-        kernel_size = load_elf(kernel_filename, NULL, NULL,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, &low, &high, 1, PPC_ELF_MACHINE,
                                0, 0);
         boot_info.bootstrap_pc = entry & 0x00ffffff;
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5d9d65f..bfc0866 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -78,7 +78,7 @@ static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf(kernel_filename, NULL, NULL,
+    if (load_elf(kernel_filename, NULL, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
                  0, EM_RISCV, 1, 0) < 0) {
         error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3bd3b67..2730b25 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -69,7 +69,7 @@ static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf(kernel_filename, NULL, NULL,
+    if (load_elf(kernel_filename, NULL, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
                  0, EM_RISCV, 1, 0) < 0) {
         error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 268df04..c66ffc5 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -57,7 +57,7 @@ static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf_ram_sym(kernel_filename, NULL, NULL,
+    if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
             &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0,
             NULL, true, htif_symbol_callback) < 0) {
         error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e7f0716..3e8b19c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -66,7 +66,7 @@ static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf(kernel_filename, NULL, NULL,
+    if (load_elf(kernel_filename, NULL, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
                  0, EM_RISCV, 1, 0) < 0) {
         error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 21f64ad..896888b 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -131,7 +131,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
             goto error;
         }
 
-        bios_size = load_elf(bios_filename, bios_translate_addr, &fwbase,
+        bios_size = load_elf(bios_filename, NULL,
+                             bios_translate_addr, &fwbase,
                              &ipl->bios_start_addr, NULL, NULL, 1,
                              EM_S390, 0, 0);
         if (bios_size > 0) {
@@ -155,7 +156,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
     }
 
     if (ipl->kernel) {
-        kernel_size = load_elf(ipl->kernel, NULL, NULL, &pentry, NULL,
+        kernel_size = load_elf(ipl->kernel, NULL, NULL, NULL,
+                               &pentry, NULL,
                                NULL, 1, EM_S390, 0, 0);
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
@@ -436,7 +438,8 @@ static int load_netboot_image(Error **errp)
         goto unref_mr;
     }
 
-    img_size = load_elf_ram(netboot_filename, NULL, NULL, &ipl->start_addr,
+    img_size = load_elf_ram(netboot_filename, NULL, NULL, NULL,
+                            &ipl->start_addr,
                             NULL, NULL, 1, EM_S390, 0, 0, NULL, false);
 
     if (img_size < 0) {
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index fa98ab8..774639a 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -190,7 +190,8 @@ static void leon3_generic_hw_init(MachineState *machine)
         long     kernel_size;
         uint64_t entry;
 
-        kernel_size = load_elf(kernel_filename, NULL, NULL, &entry, NULL, NULL,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
+                               &entry, NULL, NULL,
                                1 /* big endian */, EM_SPARC, 0, 0);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 709ee37..779f3f9 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -242,7 +242,8 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
 #else
         bswap_needed = 0;
 #endif
-        kernel_size = load_elf(kernel_filename, translate_kernel_address, NULL,
+        kernel_size = load_elf(kernel_filename, NULL,
+                               translate_kernel_address, NULL,
                                NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
         if (kernel_size < 0)
             kernel_size = load_aout(kernel_filename, KERNEL_LOAD_ADDR,
@@ -692,7 +693,8 @@ static void prom_init(hwaddr addr, const char *bios_name)
     }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
-        ret = load_elf(filename, translate_prom_address, &addr, NULL,
+        ret = load_elf(filename, NULL,
+                       translate_prom_address, &addr, NULL,
                        NULL, NULL, 1, EM_SPARC, 0, 0);
         if (ret < 0 || ret > PROM_SIZE_MAX) {
             ret = load_image_targphys(filename, addr, PROM_SIZE_MAX);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index f76b19e..b9bd4be 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -153,7 +153,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
 #else
         bswap_needed = 0;
 #endif
-        kernel_size = load_elf(kernel_filename, NULL, NULL, kernel_entry,
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, kernel_entry,
                                kernel_addr, &kernel_top, 1, EM_SPARCV9, 0, 0);
         if (kernel_size < 0) {
             *kernel_addr = KERNEL_LOAD_ADDR;
@@ -411,7 +411,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
     }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
-        ret = load_elf(filename, translate_prom_address, &addr,
+        ret = load_elf(filename, NULL, translate_prom_address, &addr,
                        NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
         if (ret < 0 || ret > PROM_SIZE_MAX) {
             ret = load_image_targphys(filename, addr, PROM_SIZE_MAX);
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index a58096f..003592a 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -45,7 +45,7 @@ static void tricore_load_kernel(CPUTriCoreState *env)
     long kernel_size;
 
     kernel_size = load_elf(tricoretb_binfo.kernel_filename, NULL,
-                           NULL, &entry, NULL,
+                           NULL, NULL, &entry, NULL,
                            NULL, 0,
                            EM_TRICORE, 1, 0);
     if (kernel_size <= 0) {
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index b6ccb3c..12c7437 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -97,11 +97,15 @@ static void xtensa_sim_init(MachineState *machine)
         uint64_t elf_entry;
         uint64_t elf_lowaddr;
 #ifdef TARGET_WORDS_BIGENDIAN
-        int success = load_elf(kernel_filename, translate_phys_addr, cpu,
-                &elf_entry, &elf_lowaddr, NULL, 1, EM_XTENSA, 0, 0);
+        int success = load_elf(kernel_filename, NULL,
+                               translate_phys_addr, cpu,
+                               &elf_entry, &elf_lowaddr,
+                               NULL, 1, EM_XTENSA, 0, 0);
 #else
-        int success = load_elf(kernel_filename, translate_phys_addr, cpu,
-                &elf_entry, &elf_lowaddr, NULL, 0, EM_XTENSA, 0, 0);
+        int success = load_elf(kernel_filename, NULL,
+                               translate_phys_addr, cpu,
+                               &elf_entry, &elf_lowaddr,
+                               NULL, 0, EM_XTENSA, 0, 0);
 #endif
         if (success > 0) {
             env->pc = elf_entry;
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 2109431..cec5bda 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -378,7 +378,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
         uint64_t elf_entry;
         uint64_t elf_lowaddr;
-        int success = load_elf(kernel_filename, translate_phys_addr, cpu,
+        int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
                 &elf_entry, &elf_lowaddr, NULL, be, EM_XTENSA, 0, 0);
         if (success > 0) {
             entry_point = elf_entry;
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index e2cb675..3438d6f 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -266,6 +266,7 @@ fail:
 }
 
 static int glue(load_elf, SZ)(const char *name, int fd,
+                              uint64_t (*elf_note_fn)(void *, void *, bool),
                               uint64_t (*translate_fn)(void *, uint64_t),
                               void *translate_opaque,
                               int must_swab, uint64_t *pentry,
@@ -498,6 +499,7 @@ static int glue(load_elf, SZ)(const char *name, int fd,
             data = NULL;
         }
     }
+
     g_free(phdr);
     if (lowaddr)
         *lowaddr = (uint64_t)(elf_sword)low;
diff --git a/include/hw/loader.h b/include/hw/loader.h
index de8a296..3e1b3a4 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -93,6 +93,8 @@ const char *load_elf_strerror(int error);
 
 /** load_elf_ram_sym:
  * @filename: Path of ELF file
+ * @elf_note_fn: optional function to parse ELF Note type
+ *               passed via @translate_opaque
  * @translate_fn: optional function to translate load addresses
  * @translate_opaque: opaque data passed to @translate_fn
  * @pentry: Populated with program entry point. Ignored if NULL.
@@ -125,6 +127,7 @@ typedef void (*symbol_fn_t)(const char *st_name, int st_info,
                             uint64_t st_value, uint64_t st_size);
 
 int load_elf_ram_sym(const char *filename,
+                     uint64_t (*elf_note_fn)(void *, void *, bool),
                      uint64_t (*translate_fn)(void *, uint64_t),
                      void *translate_opaque, uint64_t *pentry,
                      uint64_t *lowaddr, uint64_t *highaddr, int big_endian,
@@ -136,6 +139,7 @@ int load_elf_ram_sym(const char *filename,
  * symbol callback function
  */
 int load_elf_ram(const char *filename,
+                 uint64_t (*elf_note_fn)(void *, void *, bool),
                  uint64_t (*translate_fn)(void *, uint64_t),
                  void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
                  uint64_t *highaddr, int big_endian, int elf_machine,
@@ -146,6 +150,7 @@ int load_elf_ram(const char *filename,
  * Same as load_elf_ram(), but always loads the elf as ROM
  */
 int load_elf_as(const char *filename,
+                uint64_t (*elf_note_fn)(void *, void *, bool),
                 uint64_t (*translate_fn)(void *, uint64_t),
                 void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
                 uint64_t *highaddr, int big_endian, int elf_machine,
@@ -155,7 +160,9 @@ int load_elf_as(const char *filename,
  * Same as load_elf_as(), but doesn't allow the caller to specify an
  * AddressSpace.
  */
-int load_elf(const char *filename, uint64_t (*translate_fn)(void *, uint64_t),
+int load_elf(const char *filename,
+             uint64_t (*elf_note_fn)(void *, void *, bool),
+             uint64_t (*translate_fn)(void *, uint64_t),
              void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
              uint64_t *highaddr, int big_endian, int elf_machine,
              int clear_lsb, int data_swab);
-- 
1.8.3.1
