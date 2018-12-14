Received: from eggs.gnu.org ([2001:4830:134:3::10]:37792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbCD-0000kF-80
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbC6-0003Vv-E4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:19:10 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 14 Dec 2018 00:19:03 +0000
Message-ID: <cac7c30e993d969f89b001d6cb88829c1f6c0073.1544746653.git.alistair.francis@wdc.com>
References: <cover.1544746653.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544746653.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 4/5] RISC-V: Enable second UART on sifive_e
 and sifive_u
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

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
---
 hw/riscv/sifive_e.c | 5 ++---
 hw/riscv/sifive_u.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index cb513cc3bb..5d9d65ff29 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -192,9 +192,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev=
, Error **errp)
         memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm0",
         memmap[SIFIVE_E_PWM0].base, memmap[SIFIVE_E_PWM0].size);
-    /* sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
-        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic),
-                                       SIFIVE_E_UART1_IRQ)); */
+    sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
+        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART1_IRQ=
));
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi1",
         memmap[SIFIVE_E_QSPI1].base, memmap[SIFIVE_E_QSPI1].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm1",
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ef07df2442..3591898011 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -350,9 +350,8 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev=
, Error **errp)
         memmap[SIFIVE_U_PLIC].size);
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ=
));
-    /* sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
-        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic),
-                                       SIFIVE_U_UART1_IRQ)); */
+    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
+        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ=
));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, smp_cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
--=20
2.19.1
