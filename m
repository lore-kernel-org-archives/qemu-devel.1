Received: from eggs.gnu.org ([2001:4830:134:3::10]:41756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12m-000340-VZ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12j-00021a-38
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12i-00021M-Sf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:05 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:18 +0200
Message-Id: <1500040339-119465-28-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 27/28] unicore32: replace uc32_cpu_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 target/unicore32/cpu.h    | 4 +---
 hw/unicore32/puv3.c       | 2 +-
 target/unicore32/helper.c | 5 -----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 7b5b405..7724108 100644
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
index 032078f..89751b1 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -125,7 +125,7 @@ static void puv3_init(MachineState *machine)
         cpu_model = "UniCore-II";
     }
 
-    cpu = uc32_cpu_init(cpu_model);
+    cpu = UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
     if (!cpu) {
         error_report("Unable to find CPU definition");
         exit(1);
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index f9239dc..309dcd1 100644
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
2.7.4
