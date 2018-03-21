Received: from eggs.gnu.org ([2001:4830:134:3::10]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeJ-000208-Eb
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeH-00023S-Pc
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:47:54 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eykeH-00022w-JK
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:47:53 -0400
Received: by mail-pf0-x241.google.com with SMTP id 68so2465089pfx.3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 13:47:53 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 21 Mar 2018 13:46:40 -0700
Message-Id: <1521665220-3869-5-git-send-email-mjc@sifive.com>
In-Reply-To: <1521665220-3869-1-git-send-email-mjc@sifive.com>
References: <1521665220-3869-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/24] RISC-V: Use ROM base address and size
 from memmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Another case of replacing hard coded constants, this time
referring to the definition in the virt machine's memmap.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/virt.c         | 4 ++--
 include/hw/riscv/virt.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0055439..0d101fc 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -338,11 +338,11 @@ static void riscv_virt_board_init(MachineState *machine)
     };
 
     /* copy in the reset vector */
-    copy_le32_to_phys(ROM_BASE, reset_vec, sizeof(reset_vec));
+    copy_le32_to_phys(memmap[VIRT_MROM].base, reset_vec, sizeof(reset_vec));
 
     /* copy in the device tree */
     qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
-    cpu_physical_memory_write(ROM_BASE + sizeof(reset_vec),
+    cpu_physical_memory_write(memmap[VIRT_MROM].base + sizeof(reset_vec),
         s->fdt, s->fdt_size);
 
     /* create PLIC hart topology configuration string */
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 2fbe808..655e85d 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -23,8 +23,6 @@
 #define VIRT(obj) \
     OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_BOARD)
 
-enum { ROM_BASE = 0x1000 };
-
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
-- 
2.7.0
