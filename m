Received: from eggs.gnu.org ([2001:4830:134:3::10]:53742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1gRk1B-0001gX-Vf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 15:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1gRjv1-0007TI-2y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 15:25:16 -0500
From: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
	<ricardo.perez_blanco@nokia.com>
Date: Tue, 27 Nov 2018 20:25:06 +0000
Message-ID: <20181127202422.32745-1-ricardo.perez_blanco@nokia.com>
References: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
In-Reply-To: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2] Allow AArch64 processors to boot from a
 kernel placed over 4GB.
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
the current path, these machines can support "-kernel" in qemu.

Note that, currently, none of the QEMU machines have their main memory over
4GBs.

Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
---
 hw/arm/boot.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 586baa9b64..2e443c2bd1 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -63,8 +63,10 @@ typedef enum {
     FIXUP_TERMINATOR,   /* end of insns */
     FIXUP_BOARDID,      /* overwrite with board ID number */
     FIXUP_BOARD_SETUP,  /* overwrite with board specific setup code addres=
s */
-    FIXUP_ARGPTR,       /* overwrite with pointer to kernel args */
-    FIXUP_ENTRYPOINT,   /* overwrite with kernel entry point */
+    FIXUP_ARGPTR_LO,       /* overwrite with pointer to kernel args */
+    FIXUP_ARGPTR_HI,       /* overwrite with pointer to kernel args (highe=
r 32 bits) */
+    FIXUP_ENTRYPOINT_LO,   /* overwrite with kernel entry point */
+    FIXUP_ENTRYPOINT_HI,   /* overwrite with kernel entry point (higher 32=
 bits) */
     FIXUP_GIC_CPU_IF,   /* overwrite with GIC CPU interface address */
     FIXUP_BOOTREG,      /* overwrite with boot register address */
     FIXUP_DSB,          /* overwrite with correct DSB insn for cpu */
@@ -83,10 +85,10 @@ static const ARMInsnFixup bootloader_aarch64[] =3D {
     { 0xaa1f03e3 }, /* mov x3, xzr */
     { 0x58000084 }, /* ldr x4, entry ; Load the lower 32-bits of kernel en=
try */
     { 0xd61f0080 }, /* br x4      ; Jump to the kernel entry point */
-    { 0, FIXUP_ARGPTR }, /* arg: .word @DTB Lower 32-bits */
-    { 0 }, /* .word @DTB Higher 32-bits */
-    { 0, FIXUP_ENTRYPOINT }, /* entry: .word @Kernel Entry Lower 32-bits *=
/
-    { 0 }, /* .word @Kernel Entry Higher 32-bits */
+    { 0, FIXUP_ARGPTR_LO }, /* arg: .word @DTB Lower 32-bits */
+    { 0, FIXUP_ARGPTR_HI}, /* .word @DTB Higher 32-bits */
+    { 0, FIXUP_ENTRYPOINT_LO }, /* entry: .word @Kernel Entry Lower 32-bit=
s */
+    { 0, FIXUP_ENTRYPOINT_HI }, /* .word @Kernel Entry Higher 32-bits */
     { 0, FIXUP_TERMINATOR }
 };
=20
@@ -106,8 +108,8 @@ static const ARMInsnFixup bootloader[] =3D {
     { 0xe59f2004 }, /* ldr     r2, [pc, #4] */
     { 0xe59ff004 }, /* ldr     pc, [pc, #4] */
     { 0, FIXUP_BOARDID },
-    { 0, FIXUP_ARGPTR },
-    { 0, FIXUP_ENTRYPOINT },
+    { 0, FIXUP_ARGPTR_LO },
+    { 0, FIXUP_ENTRYPOINT_LO },
     { 0, FIXUP_TERMINATOR }
 };
=20
@@ -174,8 +176,10 @@ static void write_bootloader(const char *name, hwaddr =
addr,
             break;
         case FIXUP_BOARDID:
         case FIXUP_BOARD_SETUP:
-        case FIXUP_ARGPTR:
-        case FIXUP_ENTRYPOINT:
+        case FIXUP_ARGPTR_LO:
+        case FIXUP_ARGPTR_HI:
+        case FIXUP_ENTRYPOINT_LO:
+        case FIXUP_ENTRYPOINT_HI:
         case FIXUP_GIC_CPU_IF:
         case FIXUP_BOOTREG:
         case FIXUP_DSB:
@@ -1152,9 +1156,11 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_in=
fo *info)
             /* Place the DTB after the initrd in memory with alignment. */
             info->dtb_start =3D QEMU_ALIGN_UP(info->initrd_start + initrd_=
size,
                                            align);
-            fixupcontext[FIXUP_ARGPTR] =3D info->dtb_start;
+            fixupcontext[FIXUP_ARGPTR_LO] =3D info->dtb_start;
+            fixupcontext[FIXUP_ARGPTR_HI] =3D info->dtb_start >> 32;
         } else {
-            fixupcontext[FIXUP_ARGPTR] =3D info->loader_start + KERNEL_ARG=
S_ADDR;
+            fixupcontext[FIXUP_ARGPTR_LO] =3D info->loader_start + KERNEL_=
ARGS_ADDR;
+            fixupcontext[FIXUP_ARGPTR_HI] =3D (info->loader_start + KERNEL=
_ARGS_ADDR) >> 32;
             if (info->ram_size >=3D (1ULL << 32)) {
                 error_report("RAM size must be less than 4GB to boot"
                              " Linux kernel using ATAGS (try passing a dev=
ice tree"
@@ -1162,7 +1168,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_inf=
o *info)
                 exit(1);
             }
         }
-        fixupcontext[FIXUP_ENTRYPOINT] =3D entry;
+        fixupcontext[FIXUP_ENTRYPOINT_LO] =3D entry;
+        fixupcontext[FIXUP_ENTRYPOINT_HI] =3D entry >> 32;
=20
         write_bootloader("bootloader", info->loader_start,
                          primary_loader, fixupcontext, as);
--=20
2.14.1
