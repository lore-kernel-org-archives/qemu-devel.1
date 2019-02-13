Received: from eggs.gnu.org ([209.51.188.92]:56555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwj7-0002Io-92
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwj4-00075m-Qv
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:33 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwj2-0006p7-Pg
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:30 -0500
Received: by mail-pg1-x542.google.com with SMTP id z11so1313721pgu.0
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:45:22 -0800 (PST)
Date: Wed, 13 Feb 2019 07:44:50 -0800
Message-Id: <20190213154450.14749-12-palmer@sifive.com>
In-Reply-To: <20190213154450.14749-1-palmer@sifive.com>
References: <20190213154450.14749-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 11/11] riscv: Ensure the kernel start address is
 correctly cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Cast the kernel start address to the target bit length.

This ensures that we calculate the initrd offset to a valid address for
the architecture.

Steps to reproduce the original problem (reported by Alex):
  Build U-Boot for the virt machine for riscv32. Then run it with

    $ qemu-system-riscv32 -M virt -kernel u-boot -nographic -initrd <a file>

  You can find the initrd address with

    U-Boot# fdt addr $fdtcontroladdr
    U-Boot# fdt ls /chosen

  Then take a peek at that address:

    U-Boot# md.b <addr>

  and you will see that there is nothing there without this patch. The
  reason is that the binary was loaded to a negative address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Alexander Graf <agraf@suse.de>
Reported-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_e.c | 2 +-
 hw/riscv/sifive_u.c | 2 +-
 hw/riscv/spike.c    | 2 +-
 hw/riscv/virt.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index bfc086609cb9..b1cd11363c93 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -74,7 +74,7 @@ static const struct MemmapEntry {
     [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
 };
 
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2730b25b6032..7bc25820feaa 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -65,7 +65,7 @@ static const struct MemmapEntry {
 
 #define GEM_REVISION        0x10070109
 
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index c66ffc50cc74..2a000a58009a 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -53,7 +53,7 @@ static const struct MemmapEntry {
     [SPIKE_DRAM] =     { 0x80000000,        0x0 },
 };
 
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3e8b19c66898..fc4c6b306e13 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -62,7 +62,7 @@ static const struct MemmapEntry {
     [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
 };
 
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-- 
2.18.1
