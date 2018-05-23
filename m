Received: from eggs.gnu.org ([2001:4830:134:3::10]:42768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTx-0000Sc-J7
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTv-0001Oh-UG
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:21 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTv-0001O6-N4
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:19 -0400
Received: by mail-pf0-x243.google.com with SMTP id p14-v6so9553432pfh.9
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:18:19 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:12 +1200
Message-Id: <1527034517-7851-26-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 25/30] RISC-V: Enable second UART on
 sifive_e and sifive_u
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>

Previously the second UARTs on the sifive_e and sifive_u machines
where disabled due to check-qtest-riscv32 and check-qtest-riscv64
failures. Recent changes in the QEMU core serial code have
resolved these failures so the second UARTs can be instantiated.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_e.c | 4 ++--
 hw/riscv/sifive_u.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index e4ecb7aa4bb6..159209199537 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -155,8 +155,8 @@ static void riscv_sifive_e_init(MachineState *machine)
         memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm0",
         memmap[SIFIVE_E_PWM0].base, memmap[SIFIVE_E_PWM0].size);
-    /* sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
-        serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART1_IRQ]); */
+    sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
+        serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART1_IRQ]);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi1",
         memmap[SIFIVE_E_QSPI1].base, memmap[SIFIVE_E_QSPI1].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm1",
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c05dcbba955e..326b0f434cff 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -299,8 +299,8 @@ static void riscv_sifive_u_init(MachineState *machine)
         memmap[SIFIVE_U_PLIC].size);
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
         serial_hd(0), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART0_IRQ]);
-    /* sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
-        serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]); */
+    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
+        serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]);
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, smp_cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
-- 
2.7.0
