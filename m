Received: from eggs.gnu.org ([2001:4830:134:3::10]:55193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv3H-0000sj-EG
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv3G-0007cG-Ic
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv3G-0007bm-Bq
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61E84C056828
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:13 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC7F05D736
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:47 +0200
Message-Id: <1503592308-93913-25-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 24/25] unicore32: replace
 uc32_cpu_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
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
index ff62efb..eb9862f 100644
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
