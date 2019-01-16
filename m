Received: from eggs.gnu.org ([209.51.188.92]:39826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjpKw-0002ni-Cr
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjpKs-0000U6-3u
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:50:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gjpKq-0000L7-7s
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:50:41 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 16 Jan 2019 18:49:39 +0100
Message-Id: <20190116174941.342900-4-sgarzare@redhat.com>
In-Reply-To: <20190116174941.342900-1-sgarzare@redhat.com>
References: <20190116174941.342900-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/5] optionrom: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Eric Blake <eblake@redhat.com>

The new pvh.bin option rom can be used with SeaBIOS to boot
uncompressed kernel using the x86/HVM direct boot ABI.

pvh.S contains the entry point of the option rom. It runs
in real mode, loads the e820 table querying the BIOS, and
then it switches to 32bit protected mode and jumps to the
pvh_load_kernel() written in pvh_main.c.
pvh_load_kernel() loads the cmdline and kernel entry_point
using fw_cfg, then it looks for RSDP, fills the
hvm_start_info required by x86/HVM ABI, and finally jumps
to the kernel entry_point.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 Makefile                     |   2 +-
 pc-bios/optionrom/Makefile   |   5 +-
 pc-bios/optionrom/pvh.S      | 200 +++++++++++++++++++++++++++++++++++
 pc-bios/optionrom/pvh_main.c | 116 ++++++++++++++++++++
 pc-bios/pvh.bin              | Bin 0 -> 1536 bytes
 5 files changed, 321 insertions(+), 2 deletions(-)
 create mode 100644 pc-bios/optionrom/pvh.S
 create mode 100644 pc-bios/optionrom/pvh_main.c
 create mode 100644 pc-bios/pvh.bin

diff --git a/Makefile b/Makefile
index a9ac16d94e..dd6d477fb1 100644
--- a/Makefile
+++ b/Makefile
@@ -668,7 +668,7 @@ efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
 efi-e1000e.rom efi-vmxnet3.rom \
 qemu-icon.bmp qemu_logo_no_text.svg \
 bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb =
\
-multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin \
+multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
 s390-ccw.img s390-netboot.img \
 spapr-rtas.bin slof.bin skiboot.lid \
 palcode-clipper \
diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index a9a9e5e7eb..92c91d9949 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -37,7 +37,7 @@ Wa =3D -Wa,
 ASFLAGS +=3D -32
 QEMU_CFLAGS +=3D $(call cc-c-option, $(QEMU_CFLAGS), $(Wa)-32)
=20
-build-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin
+build-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pv=
h.bin
=20
 # suppress auto-removal of intermediate files
 .SECONDARY:
@@ -46,6 +46,9 @@ build-all: multiboot.bin linuxboot.bin linuxboot_dma.bi=
n kvmvapic.bin
 %.o: %.S
 	$(call quiet-command,$(CPP) $(QEMU_INCLUDES) $(QEMU_DGFLAGS) -c -o - $<=
 | $(AS) $(ASFLAGS) -o $@,"AS","$(TARGET_DIR)$@")
=20
+%.img: %.o %_main.o
+	$(call quiet-command,$(LD) $(LDFLAGS_NOPIE) -m $(LD_I386_EMULATION) -T =
$(SRC_PATH)/pc-bios/optionrom/flat.lds -s -o $@ $?,"BUILD","$(TARGET_DIR)=
$@")
+
 %.img: %.o
 	$(call quiet-command,$(LD) $(LDFLAGS_NOPIE) -m $(LD_I386_EMULATION) -T =
$(SRC_PATH)/pc-bios/optionrom/flat.lds -s -o $@ $<,"BUILD","$(TARGET_DIR)=
$@")
=20
diff --git a/pc-bios/optionrom/pvh.S b/pc-bios/optionrom/pvh.S
new file mode 100644
index 0000000000..e1d7f4a7a7
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
+ * Redefine OPTION_ROM_START and OPTION_ROM_END, because this rom is pro=
duced
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
+	/* ES =3D pvh_e820 struct */
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
+	/* %edi +=3D entry size (hvm_memmap_table_entry) */
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
+	 * (base=3D0, limit=3D0xfffff, type=3D32bit code exec/read, DPL=3D0, 4k=
)
+	 */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
+
+	/*
+	 * 0x10: data segment
+	 * (base=3D0, limit=3D0xfffff, type=3D32bit data read/write, DPL=3D0, 4=
k)
+	 */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
+
+	/*
+	 * 0x18: code segment
+	 * (base=3D0, limit=3D0x0ffff, type=3D16bit code exec/read/conf, DPL=3D=
0, 1b)
+	 */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9e, 0x00, 0x00
+
+	/*
+	 * 0x20: data segment
+	 * (base=3D0, limit=3D0x0ffff, type=3D16bit data read/write, DPL=3D0, 1=
b)
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
index 0000000000..f355476e68
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
+struct pvh_e820_table pvh_e820 __attribute__ ((aligned));
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
+    for (rsdp_p =3D (uint64_t *)start_addr; rsdp_p < (uint64_t *)end_add=
r;
+         rsdp_p +=3D 2) {
+        if (*rsdp_p =3D=3D RSDP_SIGNATURE) {
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
+    void *cmdline_addr =3D &cmdline_buffer;
+    void *kernel_entry;
+    uint32_t cmdline_size, fw_cfg_version =3D bios_cfg_version();
+
+    start_info.magic =3D XEN_HVM_START_MAGIC_VALUE;
+    start_info.version =3D 1;
+
+    /*
+     * pvh_e820 is filled in the pvh.S before to switch in protected mod=
e,
+     * because we can use int 0x15 only in real mode.
+     */
+    start_info.memmap_entries =3D pvh_e820.entries;
+    start_info.memmap_paddr =3D (uintptr_t)pvh_e820.table;
+
+    /*
+     * Search RSDP in the main BIOS area below 1 MB.
+     * SeaBIOS store the RSDP in this area, so we try it first.
+     */
+    start_info.rsdp_paddr =3D search_rsdp(RSDP_AREA_ADDR,
+                                        RSDP_AREA_ADDR + RSDP_AREA_SIZE)=
;
+
+    /* Search RSDP in the EBDA if it is not found */
+    if (!start_info.rsdp_paddr) {
+        /*
+         * Th EBDA address is stored at EBDA_BASE_ADDR. It contains 2 by=
tes
+         * segment pointer to EBDA, so we must convert it to a linear ad=
dress.
+         */
+        uint32_t ebda_paddr =3D ((uint32_t)*((uint16_t *)EBDA_BASE_ADDR)=
) << 4;
+        if (ebda_paddr > 0x400) {
+            uint32_t *ebda =3D (uint32_t *)ebda_paddr;
+
+            start_info.rsdp_paddr =3D search_rsdp(*ebda, *ebda + EBDA_SI=
ZE);
+        }
+    }
+
+    bios_cfg_read_entry(&cmdline_size, FW_CFG_CMDLINE_SIZE, 4, fw_cfg_ve=
rsion);
+    bios_cfg_read_entry(cmdline_addr, FW_CFG_CMDLINE_DATA, cmdline_size,
+                        fw_cfg_version);
+    start_info.cmdline_paddr =3D (uintptr_t)cmdline_addr;
+
+    bios_cfg_read_entry(&kernel_entry, FW_CFG_KERNEL_ENTRY, 4, fw_cfg_ve=
rsion);
+
+    asm volatile("jmp *%1" : : "b"(&start_info), "c"(kernel_entry));
+}
diff --git a/pc-bios/pvh.bin b/pc-bios/pvh.bin
new file mode 100644
index 0000000000000000000000000000000000000000..38a41761014957d50eb55d790=
b6957888cbeee0a
GIT binary patch
literal 1536
zcmeHFO=3DuHA6n<Mbnu=3DssNNWxu1R3K=3DF$hAzLe;1RTZsKrX#Im`@DQq$r1jvTWvz7B
z?oxVDJP5Tn&m!9tH6fLa717p9wTLMN$!ew8f`@9mzS(9Ku{W=3DskT>6(H}8AjdpoTU
zx4nc-R}e_ND=3Dt*H!BfH+!No@%FjUZISAWu>0?idgIy6ml^CD#nRCq@fD@>KeLo{cJ
zx<%EHEKnhzpezJ1;e`YXiJ*q+1O(dw!^hpQ7pT$a2cWr<sAuUjFBYQFxi6Kp|3@F<
z)B!pk;Acj-gf<gD*4P|zXkS%z@1cqrpaXO1nFw-X_{2siK_#IY>lj?Wv^Sfe_CWwc
zMo)jE&+1vdsF$n<=3DmM<bpBHtPZ6mt(8k~Kkyx)hi53nBs$a?l<V=3DKhl>ch!vS2`2j
zK!@F5v$80&x6v7?AWe<181b?evP*iw8i<%%klA}>YNs^C{Dc*yLMGq=3DSW-nI6_nz7
z%BQ6w;Ckur%B0+$A8tL@hLl04m5hw{>C(7}61AJepV^K6N>WV`zv-#NDc*SAb=3DdU8
z5b@4O`C!McqcH|Kx{Aj1B+>F^0QgY1D)%opHOIngz1aUP-qIAVoR)6wz;q=3Dm*Mipv
z=3D?|voayiHJbe2&xOGkaE10O;y;NEju1??_JHTm9Z>j)BPk9irSsmV*X_u;`NrP9Ud
z%ot~9Rh(Jtfr&cgU_oNW2m;LiR3Q!ALGXk(Z}9T$GhKShTmL->w!D%ws>&g?f%w@+
zeuT4BTZlMz-YL+5)_DUw-%XYIy$L=3D$Oq1<-Wir@)@zRC7_9%jMI3GvdpT4aQ+qTO=3D
z{<(%7q70X%#fZPOwr1O0K*musTl&iVe`IVV@%M;Ha;boqtX@vs1JUeX6R{T8otMbP
NY^|*c{O<$?e*uLwDi8nw

literal 0
HcmV?d00001

--=20
2.20.1
