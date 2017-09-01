Received: from eggs.gnu.org ([2001:4830:134:3::10]:41270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUq-0000Np-F2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUl-0003FI-Oh
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUl-0003Ez-JY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:16 -0300
Message-Id: <20170901150317.10380-29-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 28/29] unicore32: replace uc32_cpu_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1503592308-93913-25-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/unicore32/cpu.h    | 4 +---
 hw/unicore32/puv3.c       | 2 +-
 target/unicore32/helper.c | 5 -----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 7b5b405e79..7724108281 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -165,9 +165,7 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
-UniCore32CPU *uc32_cpu_init(const char *cpu_model);
-
-#define cpu_init(cpu_model) CPU(uc32_cpu_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model)
 
 static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index ff62efb4df..eb9862fa2f 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -127,7 +127,7 @@ static void puv3_init(MachineState *machine)
         cpu_model = "UniCore-II";
     }
 
-    cpu = uc32_cpu_init(cpu_model);
+    cpu = UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
     if (!cpu) {
         error_report("Unable to find CPU definition");
         exit(1);
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index f9239dc7b8..309dcd1ae1 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -27,11 +27,6 @@
 #define DPRINTF(fmt, ...) do {} while (0)
 #endif
 
-UniCore32CPU *uc32_cpu_init(const char *cpu_model)
-{
-    return UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
-}
-
 #ifndef CONFIG_USER_ONLY
 void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
         uint32_t cop)
-- 
2.13.5
