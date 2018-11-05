Received: from eggs.gnu.org ([2001:4830:134:3::10]:34943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=840391f99=Alistair.Francis@wdc.com>)
	id 1gJknr-00035w-05
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 14:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=840391f99=Alistair.Francis@wdc.com>)
	id 1gJknm-0008SX-Sx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 14:44:50 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 5 Nov 2018 19:44:41 +0000
Message-ID: <3988cd7b9d292017537f75c2eed70295a3a84718.1541447021.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/1] riscv: spike: Fix memory leak in the
 board init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

Coverity caught a malloc() call that was never freed. This patch ensures
that we free the memory but also updates the allocation to use
g_strdup_printf() instead of malloc().

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/riscv/spike.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 8a712ed490..268df04c3c 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -316,9 +316,7 @@ static void spike_v1_09_1_board_init(MachineState *mach=
ine)
=20
     /* build config string with supplied memory size */
     char *isa =3D riscv_isa_string(&s->soc.harts[0]);
-    size_t config_string_size =3D strlen(config_string_tmpl) + 48;
-    char *config_string =3D malloc(config_string_size);
-    snprintf(config_string, config_string_size, config_string_tmpl,
+    char *config_string =3D g_strdup_printf(config_string_tmpl,
         (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
         (uint64_t)memmap[SPIKE_DRAM].base,
         (uint64_t)ram_size, isa,
@@ -345,6 +343,8 @@ static void spike_v1_09_1_board_init(MachineState *mach=
ine)
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size=
,
         smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+
+    g_free(config_string);
 }
=20
 static void spike_v1_09_1_machine_init(MachineClass *mc)
--=20
2.19.1
