Received: from eggs.gnu.org ([2001:4830:134:3::10]:60630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1gRMME-0003LV-Db
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1gRMMA-0007dL-NA
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:15:44 -0500
From: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
	<ricardo.perez_blanco@nokia.com>
Date: Mon, 26 Nov 2018 19:15:33 +0000
Message-ID: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] [PATCH] Allow AArch64 processors to boot from
 a kernel placed over 4GB.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "ricardoperezblanco@gmail.com" <ricardoperezblanco@gmail.com>
Cc: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)" <ricardo.perez_blanco@nokia.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Some machine based on AArch64 can have its main memory over 4GBs. With
the current path, these machines can support "-kernel" in qemu

Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
---
 hw/arm/boot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 586baa9b64..183c5860bd 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -64,7 +64,9 @@ typedef enum {
     FIXUP_BOARDID,      /* overwrite with board ID number */
     FIXUP_BOARD_SETUP,  /* overwrite with board specific setup code addres=
s */
     FIXUP_ARGPTR,       /* overwrite with pointer to kernel args */
+    FIXUP_ARGPTR_HIGHER_32BITS,       /* overwrite with pointer to kernel =
args (higher 32 bits) */
     FIXUP_ENTRYPOINT,   /* overwrite with kernel entry point */
+    FIXUP_ENTRYPOINT_HIGHER_32BITS,   /* overwrite with kernel entry point=
 (higher 32 bits) */
     FIXUP_GIC_CPU_IF,   /* overwrite with GIC CPU interface address */
     FIXUP_BOOTREG,      /* overwrite with boot register address */
     FIXUP_DSB,          /* overwrite with correct DSB insn for cpu */
@@ -84,9 +86,9 @@ static const ARMInsnFixup bootloader_aarch64[] =3D {
     { 0x58000084 }, /* ldr x4, entry ; Load the lower 32-bits of kernel en=
try */
     { 0xd61f0080 }, /* br x4      ; Jump to the kernel entry point */
     { 0, FIXUP_ARGPTR }, /* arg: .word @DTB Lower 32-bits */
-    { 0 }, /* .word @DTB Higher 32-bits */
+    { 0, FIXUP_ARGPTR_HIGHER_32BITS}, /* .word @DTB Higher 32-bits */
     { 0, FIXUP_ENTRYPOINT }, /* entry: .word @Kernel Entry Lower 32-bits *=
/
-    { 0 }, /* .word @Kernel Entry Higher 32-bits */
+    { 0, FIXUP_ENTRYPOINT_HIGHER_32BITS }, /* .word @Kernel Entry Higher 3=
2-bits */
     { 0, FIXUP_TERMINATOR }
 };
=20
@@ -175,7 +177,9 @@ static void write_bootloader(const char *name, hwaddr a=
ddr,
         case FIXUP_BOARDID:
         case FIXUP_BOARD_SETUP:
         case FIXUP_ARGPTR:
+        case FIXUP_ARGPTR_HIGHER_32BITS:
         case FIXUP_ENTRYPOINT:
+        case FIXUP_ENTRYPOINT_HIGHER_32BITS:
         case FIXUP_GIC_CPU_IF:
         case FIXUP_BOOTREG:
         case FIXUP_DSB:
@@ -939,7 +943,6 @@ static uint64_t load_aarch64_image(const char *filename=
, hwaddr mem_base,
             }
         }
     }
-
     *entry =3D mem_base + kernel_load_offset;
     rom_add_blob_fixed_as(filename, buffer, size, *entry, as);
=20
@@ -1153,8 +1156,10 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_in=
fo *info)
             info->dtb_start =3D QEMU_ALIGN_UP(info->initrd_start + initrd_=
size,
                                            align);
             fixupcontext[FIXUP_ARGPTR] =3D info->dtb_start;
+            fixupcontext[FIXUP_ARGPTR_HIGHER_32BITS] =3D info->dtb_start >=
> 32;
         } else {
             fixupcontext[FIXUP_ARGPTR] =3D info->loader_start + KERNEL_ARG=
S_ADDR;
+            fixupcontext[FIXUP_ARGPTR_HIGHER_32BITS] =3D (info->loader_sta=
rt + KERNEL_ARGS_ADDR) >> 32;
             if (info->ram_size >=3D (1ULL << 32)) {
                 error_report("RAM size must be less than 4GB to boot"
                              " Linux kernel using ATAGS (try passing a dev=
ice tree"
@@ -1163,6 +1168,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_inf=
o *info)
             }
         }
         fixupcontext[FIXUP_ENTRYPOINT] =3D entry;
+        fixupcontext[FIXUP_ENTRYPOINT_HIGHER_32BITS] =3D entry >> 32;
=20
         write_bootloader("bootloader", info->loader_start,
                          primary_loader, fixupcontext, as);
--=20
2.14.1
