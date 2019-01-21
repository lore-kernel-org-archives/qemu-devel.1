Received: from eggs.gnu.org ([209.51.188.92]:51892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyJ-0004aG-Jt
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyG-0004Lm-Ux
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyG-0004L6-K3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:52 -0500
Received: by mail-wr1-x42d.google.com with SMTP id j2so24569663wrw.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:00 +0100
Message-Id: <1548093980-43088-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/49] linuxboot_dma: move common functions in a
 new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>

From: Stefano Garzarella <sgarzare@redhat.com>

In order to allow other option roms to use these common
useful functions and definitions, this patch put them
in two new C header files called optrom.h and
optrom_fw_cfg.h. We also add useful out*() in*()
functions for different size, and new fw_cfg functions
to use when DMA feature is not available.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Based-on: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                        |   4 +
 Makefile                          |   2 +-
 pc-bios/optionrom/Makefile        |   5 +-
 pc-bios/optionrom/linuxboot_dma.c | 102 ++++---------------
 pc-bios/optionrom/optrom.h        | 110 +++++++++++++++++++++
 pc-bios/optionrom/optrom_fw_cfg.h |  92 ++++++++++++++++++
 pc-bios/optionrom/pvh.S           | 200 ++++++++++++++++++++++++++++++++++++++
 pc-bios/optionrom/pvh_main.c      | 116 ++++++++++++++++++++++
 pc-bios/pvh.bin                   | Bin 0 -> 1536 bytes
 9 files changed, 546 insertions(+), 85 deletions(-)
 create mode 100644 pc-bios/optionrom/optrom.h
 create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h
 create mode 100644 pc-bios/optionrom/pvh.S
 create mode 100644 pc-bios/optionrom/pvh_main.c
 create mode 100644 pc-bios/pvh.bin

diff --git a/.gitignore b/.gitignore
index 0430257..321095b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -103,6 +103,10 @@
 /pc-bios/optionrom/linuxboot_dma.bin
 /pc-bios/optionrom/linuxboot_dma.raw
 /pc-bios/optionrom/linuxboot_dma.img
+/pc-bios/optionrom/pvh.asm
+/pc-bios/optionrom/pvh.bin
+/pc-bios/optionrom/pvh.raw
+/pc-bios/optionrom/pvh.img
 /pc-bios/optionrom/multiboot.asm
 /pc-bios/optionrom/multiboot.bin
 /pc-bios/optionrom/multiboot.raw
diff --git a/Makefile b/Makefile
index dccba1d..6de3a38 100644
--- a/Makefile
+++ b/Makefile
@@ -669,7 +669,7 @@ efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
 efi-e1000e.rom efi-vmxnet3.rom \
 qemu-icon.bmp qemu_logo_no_text.svg \
 bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
-multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin \
+multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
 s390-ccw.img s390-netboot.img \
 spapr-rtas.bin slof.bin skiboot.lid \
 palcode-clipper \
diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index a9a9e5e..e33a24d 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -37,7 +37,7 @@ Wa = -Wa,
 ASFLAGS += -32
 QEMU_CFLAGS += $(call cc-c-option, $(QEMU_CFLAGS), $(Wa)-32)
 
-build-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin
+build-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
 
 # suppress auto-removal of intermediate files
 .SECONDARY:
@@ -46,6 +46,9 @@ build-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin
 %.o: %.S
 	$(call quiet-command,$(CPP) $(QEMU_INCLUDES) $(QEMU_DGFLAGS) -c -o - $< | $(AS) $(ASFLAGS) -o $@,"AS","$(TARGET_DIR)$@")
 
+pvh.img: pvh.o pvh_main.o
+	$(call quiet-command,$(LD) $(LDFLAGS_NOPIE) -m $(LD_I386_EMULATION) -T $(SRC_PATH)/pc-bios/optionrom/flat.lds -s -o $@ $^,"BUILD","$(TARGET_DIR)$@")
+
 %.img: %.o
 	$(call quiet-command,$(LD) $(LDFLAGS_NOPIE) -m $(LD_I386_EMULATION) -T $(SRC_PATH)/pc-bios/optionrom/flat.lds -s -o $@ $<,"BUILD","$(TARGET_DIR)$@")
 
diff --git a/pc-bios/optionrom/linuxboot_dma.c b/pc-bios/optionrom/linuxboot_dma.c
index f728dc8..cbcf667 100644
--- a/pc-bios/optionrom/linuxboot_dma.c
+++ b/pc-bios/optionrom/linuxboot_dma.c
@@ -58,21 +58,13 @@ asm(
 "   jmp load_kernel\n"
 );
 
-#define BIOS_CFG_DMA_ADDR_HIGH 0x514
-#define BIOS_CFG_DMA_ADDR_LOW  0x518
-
-#define uint64_t unsigned long long
-#define uint32_t unsigned int
-#define uint16_t unsigned short
-
-#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
-
-#define barrier() asm("" : : : "memory")
-
-static inline void outl(uint32_t value, uint16_t port)
-{
-    asm("outl %0, %w1" : : "a"(value), "Nd"(port));
-}
+/*
+ * The includes of C headers must be after the asm block to avoid compiler
+ * errors.
+ */
+#include <stdint.h>
+#include "optrom.h"
+#include "optrom_fw_cfg.h"
 
 static inline void set_es(void *addr)
 {
@@ -80,12 +72,6 @@ static inline void set_es(void *addr)
     asm("movl %0, %%es" : : "r"(seg));
 }
 
-#ifdef __clang__
-#define ADDR32
-#else
-#define ADDR32 "addr32 "
-#endif
-
 static inline uint16_t readw_es(uint16_t offset)
 {
     uint16_t val;
@@ -108,56 +94,6 @@ static inline void writel_es(uint16_t offset, uint32_t val)
     asm(ADDR32 "movl %0, %%es:(%1)" : : "r"(val), "r"((uint32_t)offset));
 }
 
-static inline uint32_t bswap32(uint32_t x)
-{
-    asm("bswapl %0" : "=r" (x) : "0" (x));
-    return x;
-}
-
-static inline uint64_t bswap64(uint64_t x)
-{
-    asm("bswapl %%eax; bswapl %%edx; xchg %%eax, %%edx" : "=A" (x) : "0" (x));
-    return x;
-}
-
-static inline uint64_t cpu_to_be64(uint64_t x)
-{
-    return bswap64(x);
-}
-
-static inline uint32_t cpu_to_be32(uint32_t x)
-{
-    return bswap32(x);
-}
-
-static inline uint32_t be32_to_cpu(uint32_t x)
-{
-    return bswap32(x);
-}
-
-/* clang is happy to inline this function, and bloats the
- * ROM.
- */
-static __attribute__((__noinline__))
-void bios_cfg_read_entry(void *buf, uint16_t entry, uint32_t len)
-{
-    struct fw_cfg_dma_access access;
-    uint32_t control = (entry << 16) | FW_CFG_DMA_CTL_SELECT
-                        | FW_CFG_DMA_CTL_READ;
-
-    access.address = cpu_to_be64((uint64_t)(uint32_t)buf);
-    access.length = cpu_to_be32(len);
-    access.control = cpu_to_be32(control);
-
-    barrier();
-
-    outl(cpu_to_be32((uint32_t)&access), BIOS_CFG_DMA_ADDR_LOW);
-
-    while (be32_to_cpu(access.control) & ~FW_CFG_DMA_CTL_ERROR) {
-        barrier();
-    }
-}
-
 /* Return top of memory using BIOS function E801. */
 static uint32_t get_e801_addr(void)
 {
@@ -211,9 +147,9 @@ void load_kernel(void)
     uint32_t initrd_end_page, max_allowed_page;
     uint32_t segment_addr, stack_addr;
 
-    bios_cfg_read_entry(&setup_addr, FW_CFG_SETUP_ADDR, 4);
-    bios_cfg_read_entry(&setup_size, FW_CFG_SETUP_SIZE, 4);
-    bios_cfg_read_entry(setup_addr, FW_CFG_SETUP_DATA, setup_size);
+    bios_cfg_read_entry_dma(&setup_addr, FW_CFG_SETUP_ADDR, 4);
+    bios_cfg_read_entry_dma(&setup_size, FW_CFG_SETUP_SIZE, 4);
+    bios_cfg_read_entry_dma(setup_addr, FW_CFG_SETUP_DATA, setup_size);
 
     set_es(setup_addr);
 
@@ -223,8 +159,8 @@ void load_kernel(void)
         writel_es(0x22c, 0x37ffffff);
     }
 
-    bios_cfg_read_entry(&initrd_addr, FW_CFG_INITRD_ADDR, 4);
-    bios_cfg_read_entry(&initrd_size, FW_CFG_INITRD_SIZE, 4);
+    bios_cfg_read_entry_dma(&initrd_addr, FW_CFG_INITRD_ADDR, 4);
+    bios_cfg_read_entry_dma(&initrd_size, FW_CFG_INITRD_SIZE, 4);
 
     initrd_end_page = ((uint32_t)(initrd_addr + initrd_size) & -4096);
     max_allowed_page = (readl_es(0x22c) & -4096);
@@ -239,15 +175,15 @@ void load_kernel(void)
 
     }
 
-    bios_cfg_read_entry(initrd_addr, FW_CFG_INITRD_DATA, initrd_size);
+    bios_cfg_read_entry_dma(initrd_addr, FW_CFG_INITRD_DATA, initrd_size);
 
-    bios_cfg_read_entry(&kernel_addr, FW_CFG_KERNEL_ADDR, 4);
-    bios_cfg_read_entry(&kernel_size, FW_CFG_KERNEL_SIZE, 4);
-    bios_cfg_read_entry(kernel_addr, FW_CFG_KERNEL_DATA, kernel_size);
+    bios_cfg_read_entry_dma(&kernel_addr, FW_CFG_KERNEL_ADDR, 4);
+    bios_cfg_read_entry_dma(&kernel_size, FW_CFG_KERNEL_SIZE, 4);
+    bios_cfg_read_entry_dma(kernel_addr, FW_CFG_KERNEL_DATA, kernel_size);
 
-    bios_cfg_read_entry(&cmdline_addr, FW_CFG_CMDLINE_ADDR, 4);
-    bios_cfg_read_entry(&cmdline_size, FW_CFG_CMDLINE_SIZE, 4);
-    bios_cfg_read_entry(cmdline_addr, FW_CFG_CMDLINE_DATA, cmdline_size);
+    bios_cfg_read_entry_dma(&cmdline_addr, FW_CFG_CMDLINE_ADDR, 4);
+    bios_cfg_read_entry_dma(&cmdline_size, FW_CFG_CMDLINE_SIZE, 4);
+    bios_cfg_read_entry_dma(cmdline_addr, FW_CFG_CMDLINE_DATA, cmdline_size);
 
     /* Boot linux */
     segment_addr = ((uint32_t)setup_addr >> 4);
diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h
new file mode 100644
index 0000000..1e5e265
--- /dev/null
+++ b/pc-bios/optionrom/optrom.h
@@ -0,0 +1,110 @@
+/*
+ * Common Option ROM Functions for C code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (c) 2015-2019 Red Hat Inc.
+ *   Authors:
+ *     Marc Marí <marc.mari.barcelo@gmail.com>
+ *     Richard W.M. Jones <rjones@redhat.com>
+ *     Stefano Garzarella <sgarzare@redhat.com>
+ */
+
+#ifndef OPTROM_H
+#define OPTROM_H
+
+#include <stdint.h>
+#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
+
+#define barrier() asm("" : : : "memory")
+
+#ifdef __clang__
+#define ADDR32
+#else
+#define ADDR32 "addr32 "
+#endif
+
+static inline void outb(uint8_t value, uint16_t port)
+{
+    asm volatile("outb %0, %w1" : : "a"(value), "Nd"(port));
+}
+
+static inline void outw(uint16_t value, uint16_t port)
+{
+    asm volatile("outw %0, %w1" : : "a"(value), "Nd"(port));
+}
+
+static inline void outl(uint32_t value, uint16_t port)
+{
+    asm volatile("outl %0, %w1" : : "a"(value), "Nd"(port));
+}
+
+static inline uint8_t inb(uint16_t port)
+{
+    uint8_t value;
+
+    asm volatile("inb %w1, %0" : "=a"(value) : "Nd"(port));
+    return value;
+}
+
+static inline uint16_t inw(uint16_t port)
+{
+    uint16_t value;
+
+    asm volatile("inw %w1, %0" : "=a"(value) : "Nd"(port));
+    return value;
+}
+
+static inline uint32_t inl(uint16_t port)
+{
+    uint32_t value;
+
+    asm volatile("inl %w1, %0" : "=a"(value) : "Nd"(port));
+    return value;
+}
+
+static inline void insb(uint16_t port, uint8_t *buf, uint32_t len)
+{
+    asm volatile("rep insb (%%dx), %%es:(%%edi)"
+                 : "+c"(len), "+D"(buf) : "d"(port) : "memory");
+}
+
+static inline uint32_t bswap32(uint32_t x)
+{
+    asm("bswapl %0" : "=r" (x) : "0" (x));
+    return x;
+}
+
+static inline uint64_t bswap64(uint64_t x)
+{
+    asm("bswapl %%eax; bswapl %%edx; xchg %%eax, %%edx" : "=A" (x) : "0" (x));
+    return x;
+}
+
+static inline uint64_t cpu_to_be64(uint64_t x)
+{
+    return bswap64(x);
+}
+
+static inline uint32_t cpu_to_be32(uint32_t x)
+{
+    return bswap32(x);
+}
+
+static inline uint32_t be32_to_cpu(uint32_t x)
+{
+    return bswap32(x);
+}
+
+#endif /* OPTROM_H */
diff --git a/pc-bios/optionrom/optrom_fw_cfg.h b/pc-bios/optionrom/optrom_fw_cfg.h
new file mode 100644
index 0000000..a3660a5
--- /dev/null
+++ b/pc-bios/optionrom/optrom_fw_cfg.h
@@ -0,0 +1,92 @@
+/*
+ * Common Option ROM Functions for fw_cfg
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (c) 2015-2019 Red Hat Inc.
+ *   Authors:
+ *     Marc Marí <marc.mari.barcelo@gmail.com>
+ *     Richard W.M. Jones <rjones@redhat.com>
+ *     Stefano Garzarella <sgarzare@redhat.com>
+ */
+
+#ifndef OPTROM_FW_CFG_H
+#define OPTROM_FW_CFG_H
+
+#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
+
+#define BIOS_CFG_IOPORT_CFG     0x510
+#define BIOS_CFG_IOPORT_DATA    0x511
+#define BIOS_CFG_DMA_ADDR_HIGH  0x514
+#define BIOS_CFG_DMA_ADDR_LOW   0x518
+
+static __attribute__((unused))
+void bios_cfg_select(uint16_t key)
+{
+    outw(key, BIOS_CFG_IOPORT_CFG);
+}
+
+static __attribute__((unused))
+void bios_cfg_read_entry_io(void *buf, uint16_t entry, uint32_t len)
+{
+    bios_cfg_select(entry);
+    insb(BIOS_CFG_IOPORT_DATA, buf, len);
+}
+
+/*
+ * clang is happy to inline this function, and bloats the
+ * ROM.
+ */
+static __attribute__((__noinline__)) __attribute__((unused))
+void bios_cfg_read_entry_dma(void *buf, uint16_t entry, uint32_t len)
+{
+    struct fw_cfg_dma_access access;
+    uint32_t control = (entry << 16) | FW_CFG_DMA_CTL_SELECT
+                        | FW_CFG_DMA_CTL_READ;
+
+    access.address = cpu_to_be64((uint64_t)(uint32_t)buf);
+    access.length = cpu_to_be32(len);
+    access.control = cpu_to_be32(control);
+
+    barrier();
+
+    outl(cpu_to_be32((uint32_t)&access), BIOS_CFG_DMA_ADDR_LOW);
+
+    while (be32_to_cpu(access.control) & ~FW_CFG_DMA_CTL_ERROR) {
+        barrier();
+    }
+}
+
+static __attribute__((unused))
+void bios_cfg_read_entry(void *buf, uint16_t entry, uint32_t len,
+                         uint32_t version)
+{
+    if (version & FW_CFG_VERSION_DMA) {
+        bios_cfg_read_entry_dma(buf, entry, len);
+    } else {
+        bios_cfg_read_entry_io(buf, entry, len);
+    }
+}
+
+static __attribute__((unused))
+uint32_t bios_cfg_version(void)
+{
+    uint32_t version;
+
+    bios_cfg_read_entry_io(&version, FW_CFG_ID, sizeof(version));
+
+    return version;
+}
+
+#endif /* OPTROM_FW_CFG_H */
diff --git a/pc-bios/optionrom/pvh.S b/pc-bios/optionrom/pvh.S
new file mode 100644
index 0000000..e1d7f4a
--- /dev/null
+++ b/pc-bios/optionrom/pvh.S
@@ -0,0 +1,200 @@
+/*
+ * PVH Option ROM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright Novell Inc, 2009
+ *   Authors: Alexander Graf <agraf@suse.de>
+ *
+ * Copyright (c) 2019 Red Hat Inc.
+ *   Authors: Stefano Garzarella <sgarzare@redhat.com>
+ */
+
+#include "optionrom.h"
+
+#define BOOT_ROM_PRODUCT "PVH loader"
+
+#define GS_PROT_JUMP		0
+#define GS_GDT_DESC		6
+
+#ifdef OPTION_ROM_START
+#undef OPTION_ROM_START
+#endif
+#ifdef OPTION_ROM_END
+#undef OPTION_ROM_END
+#endif
+
+/*
+ * Redefine OPTION_ROM_START and OPTION_ROM_END, because this rom is produced
+ * linking multiple objects.
+ * signrom.py will add padding.
+ */
+#define OPTION_ROM_START                                \
+    .code16;						\
+    .text;						\
+	.global 	_start;				\
+    _start:;						\
+	.short		0xaa55;				\
+	.byte		3; /* desired size in 512 units */
+
+#define OPTION_ROM_END					\
+    _end:
+
+BOOT_ROM_START
+
+run_pvhboot:
+
+	cli
+	cld
+
+	mov		%cs, %eax
+	shl		$0x4, %eax
+
+	/* set up a long jump descriptor that is PC relative */
+
+	/* move stack memory to %gs */
+	mov		%ss, %ecx
+	shl		$0x4, %ecx
+	mov		%esp, %ebx
+	add		%ebx, %ecx
+	sub		$0x20, %ecx
+	sub		$0x30, %esp
+	shr		$0x4, %ecx
+	mov		%cx, %gs
+
+	/* now push the indirect jump descriptor there */
+	mov		(prot_jump), %ebx
+	add		%eax, %ebx
+	movl		%ebx, %gs:GS_PROT_JUMP
+	mov		$8, %bx
+	movw		%bx, %gs:GS_PROT_JUMP + 4
+
+	/* fix the gdt descriptor to be PC relative */
+	movw		(gdt_desc), %bx
+	movw		%bx, %gs:GS_GDT_DESC
+	movl		(gdt_desc+2), %ebx
+	add		%eax, %ebx
+	movl		%ebx, %gs:GS_GDT_DESC + 2
+
+	/* initialize HVM memmap table using int 0x15(e820) */
+
+	/* ES = pvh_e820 struct */
+	mov 		$pvh_e820, %eax
+	shr		$4, %eax
+	mov		%ax, %es
+
+	/* start storing memmap table at %es:8 (pvh_e820.table) */
+	mov 		$8,%edi
+	xor		%ebx, %ebx
+	jmp 		memmap_loop
+
+memmap_loop_check:
+	/* pvh_e820 can contains up to 128 entries */
+	cmp 		$128, %ebx
+	je 		memmap_done
+
+memmap_loop:
+	/* entry size (hvm_memmap_table_entry) & max buffer size (int15) */
+	movl		$24, %ecx
+	/* e820 */
+	movl		$0x0000e820, %eax
+	/* 'SMAP' magic */
+	movl		$0x534d4150, %edx
+	/* store counter value at %es:0 (pvh_e820.entries) */
+	movl 		%ebx, %es:0
+
+	int		$0x15
+	/* error or last entry already done? */
+	jb		memmap_err
+
+	/* %edi += entry size (hvm_memmap_table_entry) */
+	add		$24, %edi
+
+	/* continuation value 0 means last entry */
+	test		%ebx, %ebx
+	jnz		memmap_loop_check
+
+	/* increase pvh_e820.entries to save the last entry */
+	movl 		%es:0, %ebx
+	inc 		%ebx
+
+memmap_done:
+	movl 		%ebx, %es:0
+
+memmap_err:
+
+	/* load the GDT before going into protected mode */
+lgdt:
+	data32 lgdt	%gs:GS_GDT_DESC
+
+	/* get us to protected mode now */
+	movl		$1, %eax
+	movl		%eax, %cr0
+
+	/* the LJMP sets CS for us and gets us to 32-bit */
+ljmp:
+	data32 ljmp	*%gs:GS_PROT_JUMP
+
+prot_mode:
+.code32
+
+	/* initialize all other segments */
+	movl		$0x10, %eax
+	movl		%eax, %ss
+	movl		%eax, %ds
+	movl		%eax, %es
+	movl		%eax, %fs
+	movl		%eax, %gs
+
+	jmp pvh_load_kernel
+
+/* Variables */
+.align 4, 0
+prot_jump:	.long prot_mode
+		.short 8
+
+.align 4, 0
+gdt:
+	/* 0x00 */
+.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+
+	/*
+	 * 0x08: code segment
+	 * (base=0, limit=0xfffff, type=32bit code exec/read, DPL=0, 4k)
+	 */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
+
+	/*
+	 * 0x10: data segment
+	 * (base=0, limit=0xfffff, type=32bit data read/write, DPL=0, 4k)
+	 */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
+
+	/*
+	 * 0x18: code segment
+	 * (base=0, limit=0x0ffff, type=16bit code exec/read/conf, DPL=0, 1b)
+	 */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9e, 0x00, 0x00
+
+	/*
+	 * 0x20: data segment
+	 * (base=0, limit=0x0ffff, type=16bit data read/write, DPL=0, 1b)
+	 */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0x00, 0x00
+
+gdt_desc:
+.short	(5 * 8) - 1
+.long	gdt
+
+BOOT_ROM_END
diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
new file mode 100644
index 0000000..1dcc5c9
--- /dev/null
+++ b/pc-bios/optionrom/pvh_main.c
@@ -0,0 +1,116 @@
+/*
+ * PVH Option ROM for fw_cfg DMA
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (c) 2019 Red Hat Inc.
+ *   Authors:
+ *     Stefano Garzarella <sgarzare@redhat.com>
+ */
+
+asm (".code32"); /* this code will be executed in protected mode */
+
+#include <stddef.h>
+#include <stdint.h>
+#include "optrom.h"
+#include "optrom_fw_cfg.h"
+#include "../../include/hw/xen/start_info.h"
+
+#define RSDP_SIGNATURE          0x2052545020445352LL /* "RSD PTR " */
+#define RSDP_AREA_ADDR          0x000E0000
+#define RSDP_AREA_SIZE          2048
+#define EBDA_BASE_ADDR          0x0000040E
+#define EBDA_SIZE               1024
+
+#define E820_MAXENTRIES         128
+#define CMDLINE_BUFSIZE         4096
+
+/* e820 table filled in pvh.S using int 0x15 */
+struct pvh_e820_table {
+    uint32_t entries;
+    uint32_t reserved;
+    struct hvm_memmap_table_entry table[E820_MAXENTRIES];
+};
+
+struct pvh_e820_table pvh_e820 asm("pvh_e820") __attribute__ ((aligned));
+
+static struct hvm_start_info start_info;
+static uint8_t cmdline_buffer[CMDLINE_BUFSIZE];
+
+
+/* Search RSDP signature. */
+static uintptr_t search_rsdp(uint32_t start_addr, uint32_t end_addr)
+{
+    uint64_t *rsdp_p;
+
+    /* RSDP signature is always on a 16 byte boundary */
+    for (rsdp_p = (uint64_t *)start_addr; rsdp_p < (uint64_t *)end_addr;
+         rsdp_p += 2) {
+        if (*rsdp_p == RSDP_SIGNATURE) {
+            return (uintptr_t)rsdp_p;
+        }
+    }
+
+    return 0;
+}
+
+/* Force the asm name without leading underscore, even on Win32. */
+extern void pvh_load_kernel(void) asm("pvh_load_kernel");
+
+void pvh_load_kernel(void)
+{
+    void *cmdline_addr = &cmdline_buffer;
+    void *kernel_entry;
+    uint32_t cmdline_size, fw_cfg_version = bios_cfg_version();
+
+    start_info.magic = XEN_HVM_START_MAGIC_VALUE;
+    start_info.version = 1;
+
+    /*
+     * pvh_e820 is filled in the pvh.S before to switch in protected mode,
+     * because we can use int 0x15 only in real mode.
+     */
+    start_info.memmap_entries = pvh_e820.entries;
+    start_info.memmap_paddr = (uintptr_t)pvh_e820.table;
+
+    /*
+     * Search RSDP in the main BIOS area below 1 MB.
+     * SeaBIOS store the RSDP in this area, so we try it first.
+     */
+    start_info.rsdp_paddr = search_rsdp(RSDP_AREA_ADDR,
+                                        RSDP_AREA_ADDR + RSDP_AREA_SIZE);
+
+    /* Search RSDP in the EBDA if it is not found */
+    if (!start_info.rsdp_paddr) {
+        /*
+         * Th EBDA address is stored at EBDA_BASE_ADDR. It contains 2 bytes
+         * segment pointer to EBDA, so we must convert it to a linear address.
+         */
+        uint32_t ebda_paddr = ((uint32_t)*((uint16_t *)EBDA_BASE_ADDR)) << 4;
+        if (ebda_paddr > 0x400) {
+            uint32_t *ebda = (uint32_t *)ebda_paddr;
+
+            start_info.rsdp_paddr = search_rsdp(*ebda, *ebda + EBDA_SIZE);
+        }
+    }
+
+    bios_cfg_read_entry(&cmdline_size, FW_CFG_CMDLINE_SIZE, 4, fw_cfg_version);
+    bios_cfg_read_entry(cmdline_addr, FW_CFG_CMDLINE_DATA, cmdline_size,
+                        fw_cfg_version);
+    start_info.cmdline_paddr = (uintptr_t)cmdline_addr;
+
+    bios_cfg_read_entry(&kernel_entry, FW_CFG_KERNEL_ENTRY, 4, fw_cfg_version);
+
+    asm volatile("jmp *%1" : : "b"(&start_info), "c"(kernel_entry));
+}
diff --git a/pc-bios/pvh.bin b/pc-bios/pvh.bin
new file mode 100644
index 0000000000000000000000000000000000000000..38a41761014957d50eb55d790b6957888cbeee0a
GIT binary patch
literal 1536
zcmeHFO=uHA6n<Mbnu=ssNNWxu1R3K=F$hAzLe;1RTZsKrX#Im`@DQq$r1jvTWvz7B
z?oxVDJP5Tn&m!9tH6fLa717p9wTLMN$!ew8f`@9mzS(9Ku{W=skT>6(H}8AjdpoTU
zx4nc-R}e_ND=t*H!BfH+!No@%FjUZISAWu>0?idgIy6ml^CD#nRCq@fD@>KeLo{cJ
zx<%EHEKnhzpezJ1;e`YXiJ*q+1O(dw!^hpQ7pT$a2cWr<sAuUjFBYQFxi6Kp|3@F<
z)B!pk;Acj-gf<gD*4P|zXkS%z@1cqrpaXO1nFw-X_{2siK_#IY>lj?Wv^Sfe_CWwc
zMo)jE&+1vdsF$n<=mM<bpBHtPZ6mt(8k~Kkyx)hi53nBs$a?l<V=Khl>ch!vS2`2j
zK!@F5v$80&x6v7?AWe<181b?evP*iw8i<%%klA}>YNs^C{Dc*yLMGq=SW-nI6_nz7
z%BQ6w;Ckur%B0+$A8tL@hLl04m5hw{>C(7}61AJepV^K6N>WV`zv-#NDc*SAb=dU8
z5b@4O`C!McqcH|Kx{Aj1B+>F^0QgY1D)%opHOIngz1aUP-qIAVoR)6wz;q=m*Mipv
z=?|voayiHJbe2&xOGkaE10O;y;NEju1??_JHTm9Z>j)BPk9irSsmV*X_u;`NrP9Ud
z%ot~9Rh(Jtfr&cgU_oNW2m;LiR3Q!ALGXk(Z}9T$GhKShTmL->w!D%ws>&g?f%w@+
zeuT4BTZlMz-YL+5)_DUw-%XYIy$L=$Oq1<-Wir@)@zRC7_9%jMI3GvdpT4aQ+qTO=
z{<(%7q70X%#fZPOwr1O0K*musTl&iVe`IVV@%M;Ha;boqtX@vs1JUeX6R{T8otMbP
NY^|*c{O<$?e*uLwDi8nw

literal 0
HcmV?d00001

-- 
1.8.3.1
