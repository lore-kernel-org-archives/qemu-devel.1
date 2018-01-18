Received: from eggs.gnu.org ([2001:4830:134:3::10]:46992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6a-0004TZ-BV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6Z-00081M-Ic
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:36:00 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 18 Jan 2018 18:34:01 +0100
Message-Id: <1516296842-136976-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
References: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 4/5] arm: cpu: add CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

it will be used for providing to cpu name resolving class for
  cpu_parse_cpu_model(CPU_RESOLVING_TYPE, ...)
in null-machine.c and in linux-user/main.c

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/arm/cpu.h     | 3 +++
 linux-user/main.c    | 2 --
 tests/machine-none.c | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9631670..e2c7f08 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2172,6 +2172,9 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
+/* used to get target's callback in cpu_parse_cpu_model() */
+#define CPU_RESOLVING_TYPE TYPE_ARM_CPU
+
 #define cpu_signal_handler cpu_arm_signal_handler
 #define cpu_list arm_cpu_list
 
diff --git a/linux-user/main.c b/linux-user/main.c
index d481e8c..bcf2e55 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4326,8 +4326,6 @@ int main(int argc, char **argv, char **envp)
 #else
         cpu_model = "qemu32";
 #endif
-#elif defined(TARGET_ARM)
-        cpu_model = "any";
 #elif defined(TARGET_UNICORE32)
         cpu_model = "any";
 #elif defined(TARGET_M68K)
diff --git a/tests/machine-none.c b/tests/machine-none.c
index d16c283..7f64532 100644
--- a/tests/machine-none.c
+++ b/tests/machine-none.c
@@ -24,6 +24,8 @@ struct arch2cpu {
 
 static struct arch2cpu cpus_map[] = {
     /* tested targets list */
+    { "arm", "cortex-a15" },
+    { "aarch64", "cortex-a15" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
