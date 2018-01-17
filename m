Received: from eggs.gnu.org ([2001:4830:134:3::10]:55578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuV-0005Pb-AJ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuT-00006M-M8
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuT-00005h-G1
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:53 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:28 +0100
Message-Id: <1516203816-19374-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 16/24] unicore32: cpu: add
 TARGET_DEFAULT_CPU_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Guan Xuetao <gxt@mprc.pku.edu.cn>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

Use default value from linux-user for TARGET_DEFAULT_CPU_TYPE.
While at it drop redundant ifdef and let catch all #else set
default to the same 'any' model.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 target/unicore32/cpu.h | 1 +
 linux-user/main.c      | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 3dc6fbc..fd3fa81 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -169,6 +169,7 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 
 #define UNICORE32_CPU_TYPE_SUFFIX "-" TYPE_UNICORE32_CPU
 #define UNICORE32_CPU_TYPE_NAME(model) model UNICORE32_CPU_TYPE_SUFFIX
+#define TARGET_DEFAULT_CPU_TYPE UNICORE32_CPU_TYPE_NAME("any")
 
 static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
diff --git a/linux-user/main.c b/linux-user/main.c
index 279cd97..1cd5033 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4325,8 +4325,6 @@ int main(int argc, char **argv, char **envp)
 #else
         cpu_model = "qemu32";
 #endif
-#elif defined(TARGET_UNICORE32)
-        cpu_model = "any";
 #elif defined(TARGET_SPARC)
 #ifdef TARGET_SPARC64
         cpu_model = "TI UltraSparc II";
-- 
2.7.4
