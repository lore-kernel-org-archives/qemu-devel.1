Received: from eggs.gnu.org ([2001:4830:134:3::10]:52994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNHO-0001ey-GO
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNHN-0004E9-2m
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:02 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e]:44404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gaNHM-00049W-Of
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:00 -0500
Received: by mail-qt1-x82e.google.com with SMTP id n32so6161846qte.11
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 08:03:51 -0800 (PST)
Date: Fri, 21 Dec 2018 08:03:03 -0800
Message-Id: <20181221160307.14819-11-palmer@sifive.com>
In-Reply-To: <20181221160307.14819-1-palmer@sifive.com>
References: <20181221160307.14819-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 10/14] RISC-V: Enable second UART on sifive_e
 and sifive_u
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>

From: Michael Clark <mjc@sifive.com>

Previously the second UARTs on the sifive_e and sifive_u machines
where disabled due to check-qtest-riscv32 and check-qtest-riscv64
failures. Recent changes in the QEMU core serial code have
resolved these failures so the second UARTs can be instantiated.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_e.c | 5 ++---
 hw/riscv/sifive_u.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index cb513cc3bb50..5d9d65ff29ab 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -192,9 +192,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm0",
         memmap[SIFIVE_E_PWM0].base, memmap[SIFIVE_E_PWM0].size);
-    /* sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
-        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic),
-                                       SIFIVE_E_UART1_IRQ)); */
+    sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
+        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART1_IRQ));
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi1",
         memmap[SIFIVE_E_QSPI1].base, memmap[SIFIVE_E_QSPI1].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm1",
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 849fa2e6311a..3bd3b67507f8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -368,9 +368,8 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_PLIC].size);
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
-    /* sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
-        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic),
-                                       SIFIVE_U_UART1_IRQ)); */
+    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
+        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, smp_cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
-- 
2.18.1
