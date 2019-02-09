Received: from eggs.gnu.org ([209.51.188.92]:49741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH0o-0005uH-MF
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH0n-0007k6-FX
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:54 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 01:00:33 +0000
Message-ID: <ebecb5dfd7331ba1078dbf52f623cf82fed6ceb1.1549673900.git.alistair.francis@wdc.com>
References: <cover.1549673900.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 08/11] RISC-V: Change local interrupts from
 edge to level
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

This effectively changes riscv_cpu_update_mip
from edge to level. i.e. cpu_interrupt or
cpu_reset_interrupt are called regardless of
the current interrupt level.

Fixes WFI doesn't return when a IPI is issued:

- https://github.com/riscv/riscv-qemu/issues/132

To test:

1) Apply RISC-V Linux CPU hotplug patch:

- http://lists.infradead.org/pipermail/linux-riscv/2018-May/000603.html

2) Enable CONFIG_CPU_HOTPLUG in linux .config

3) Try to offline and online cpus:

  echo 1 > /sys/devices/system/cpu/cpu2/online
  echo 0 > /sys/devices/system/cpu/cpu2/online
  echo 1 > /sys/devices/system/cpu/cpu2/online

Reported-by: Atish Patra <atishp04@gmail.com>
Cc: Atish Patra <atishp04@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 555756d40c..073bdcfe74 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -95,9 +95,9 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mas=
k, uint32_t value)
         cmp =3D atomic_cmpxchg(&env->mip, old, new);
     } while (old !=3D cmp);
=20
-    if (new && !old) {
+    if (new) {
         cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    } else if (!new && old) {
+    } else {
         cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
     }
=20
--=20
2.20.1
