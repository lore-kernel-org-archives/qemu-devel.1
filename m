Received: from eggs.gnu.org ([2001:4830:134:3::10]:54711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtes-0007Ho-3h
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edteq-0001tf-Sb
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:18 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:02 +0100
Message-Id: <1516694904-64879-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/25] arm: cpu: add CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
thest would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: qemu-arm@nongnu.org
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu.h          | 1 +
 linux-user/main.c         | 2 --
 tests/machine-none-test.c | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9631670..f9fb141 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2171,6 +2171,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_ARM_CPU
 
 #define cpu_signal_handler cpu_arm_signal_handler
 #define cpu_list arm_cpu_list
diff --git a/linux-user/main.c b/linux-user/main.c
index 450eb3c..a35477e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4325,8 +4325,6 @@ int main(int argc, char **argv, char **envp)
 #else
         cpu_model = "qemu32";
 #endif
-#elif defined(TARGET_ARM)
-        cpu_model = "any";
 #elif defined(TARGET_UNICORE32)
         cpu_model = "any";
 #elif defined(TARGET_M68K)
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 2eb13e8..1b213ff 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -24,6 +24,8 @@ struct arch2cpu {
 
 static struct arch2cpu cpus_map[] = {
     /* tested targets list */
+    { "arm", "cortex-a15" },
+    { "aarch64", "cortex-a15" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
