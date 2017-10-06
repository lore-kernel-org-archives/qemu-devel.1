Received: from eggs.gnu.org ([2001:4830:134:3::10]:41372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPN-0007we-Rf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPM-0005Rq-SY
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:19 -0300
Message-Id: <20171006235023.11952-25-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 24/88] MIPS: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: squashed malta + mipssim + r4k]
---
 hw/mips/mips_malta.c         | 2 +-
 hw/mips/mips_mipssim.c       | 2 +-
 hw/mips/mips_r4k.c           | 2 +-
 target/mips/translate_init.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2adb9bcf89..0eda20e120 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -555,7 +555,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
     MaltaFPGAState *s;
     Chardev *chr;
 
-    s = (MaltaFPGAState *)g_malloc0(sizeof(MaltaFPGAState));
+    s = g_new0(MaltaFPGAState, 1);
 
     memory_region_init_io(&s->iomem, NULL, &malta_fpga_ops, s,
                           "malta-fpga", 0x100000);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index a092072e2a..b2696faba1 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -166,7 +166,7 @@ mips_mipssim_init(MachineState *machine)
     cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env = &cpu->env;
 
-    reset_info = g_malloc0(sizeof(ResetData));
+    reset_info = g_new0(ResetData, 1);
     reset_info->cpu = cpu;
     reset_info->vector = env->active_tc.PC;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 1272d4ef9d..233455d6e7 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -196,7 +196,7 @@ void mips_r4k_init(MachineState *machine)
     cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env = &cpu->env;
 
-    reset_info = g_malloc0(sizeof(ResetData));
+    reset_info = g_new0(ResetData, 1);
     reset_info->cpu = cpu;
     reset_info->vector = env->active_tc.PC;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 8bbded46c4..9778776677 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -806,7 +806,7 @@ static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
 {
     MIPSCPU *cpu = mips_env_get_cpu(env);
 
-    env->tlb = g_malloc0(sizeof(CPUMIPSTLBContext));
+    env->tlb = g_new0(CPUMIPSTLBContext, 1);
 
     switch (def->mmu_type) {
         case MMU_TYPE_NONE:
@@ -839,7 +839,7 @@ static void fpu_init (CPUMIPSState *env, const mips_def_t *def)
 
 static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
 {
-    env->mvp = g_malloc0(sizeof(CPUMIPSMVPContext));
+    env->mvp = g_new0(CPUMIPSMVPContext, 1);
 
     /* MVPConf1 implemented, TLB sharable, no gating storage support,
        programmable cache partitioning implemented, number of allocatable
-- 
2.14.2
