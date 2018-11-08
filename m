Received: from eggs.gnu.org ([2001:4830:134:3::10]:53683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKp7n-0006KB-H2
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKp7j-0002fe-5K
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:33:51 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKp7i-0002Jp-Gf
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:33:46 -0500
Received: by mail-pf1-x444.google.com with SMTP id s9-v6so2328107pfm.13
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 10:33:22 -0800 (PST)
Date: Thu,  8 Nov 2018 10:33:06 -0800
Message-Id: <20181108183306.4361-2-palmer@sifive.com>
In-Reply-To: <20181108183306.4361-1-palmer@sifive.com>
References: <20181108183306.4361-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL] riscv: spike: Fix memory leak in the board init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Coverity caught a malloc() call that was never freed. This patch ensures
that we free the memory but also updates the allocation to use
g_strdup_printf() instead of malloc().

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/spike.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 8a712ed49026..268df04c3c7d 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -316,9 +316,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
 
     /* build config string with supplied memory size */
     char *isa = riscv_isa_string(&s->soc.harts[0]);
-    size_t config_string_size = strlen(config_string_tmpl) + 48;
-    char *config_string = malloc(config_string_size);
-    snprintf(config_string, config_string_size, config_string_tmpl,
+    char *config_string = g_strdup_printf(config_string_tmpl,
         (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
         (uint64_t)memmap[SPIKE_DRAM].base,
         (uint64_t)ram_size, isa,
@@ -345,6 +343,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
         smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+
+    g_free(config_string);
 }
 
 static void spike_v1_09_1_machine_init(MachineClass *mc)
-- 
2.18.1
