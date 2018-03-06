Received: from eggs.gnu.org ([2001:4830:134:3::10]:53237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJei-0008W3-1E
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJeh-0002il-5k
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:57:52 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJeg-0002if-Uo
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:57:51 -0500
Received: by mail-pf0-x244.google.com with SMTP id 68so8161pfx.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:57:50 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:56:13 +1300
Message-Id: <1520369790-38306-4-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369790-38306-1-git-send-email-mjc@sifive.com>
References: <1520369790-38306-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 05/22] RISC-V: Remove identity_translate
 from load_elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

When load_elf is called with NULL as an argument to the
address translate callback, it does an identity translation.
This commit removes the redundant identity_translate callback.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_e.c | 7 +------
 hw/riscv/sifive_u.c | 7 +------
 hw/riscv/spike.c    | 7 +------
 hw/riscv/virt.c     | 7 +------
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 19eca36..09c9d49 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -82,16 +82,11 @@ static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
     }
 }
 
-static uint64_t identity_translate(void *opaque, uint64_t addr)
-{
-    return addr;
-}
-
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf(kernel_filename, identity_translate, NULL,
+    if (load_elf(kernel_filename, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
                  0, ELF_MACHINE, 1, 0) < 0) {
         error_report("qemu: could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f3f7615..6116c38 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -68,16 +68,11 @@ static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
     }
 }
 
-static uint64_t identity_translate(void *opaque, uint64_t addr)
-{
-    return addr;
-}
-
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf(kernel_filename, identity_translate, NULL,
+    if (load_elf(kernel_filename, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
                  0, ELF_MACHINE, 1, 0) < 0) {
         error_report("qemu: could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 4c233ec..7710333 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -59,16 +59,11 @@ static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
     }
 }
 
-static uint64_t identity_translate(void *opaque, uint64_t addr)
-{
-    return addr;
-}
-
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf_ram_sym(kernel_filename, identity_translate, NULL,
+    if (load_elf_ram_sym(kernel_filename, NULL, NULL,
             &kernel_entry, NULL, &kernel_high, 0, ELF_MACHINE, 1, 0,
             NULL, true, htif_symbol_callback) < 0) {
         error_report("qemu: could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0d101fc..f8c19b4 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -62,16 +62,11 @@ static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
     }
 }
 
-static uint64_t identity_translate(void *opaque, uint64_t addr)
-{
-    return addr;
-}
-
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf(kernel_filename, identity_translate, NULL,
+    if (load_elf(kernel_filename, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
                  0, ELF_MACHINE, 1, 0) < 0) {
         error_report("qemu: could not load kernel '%s'", kernel_filename);
-- 
2.7.0
