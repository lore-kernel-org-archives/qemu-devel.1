Received: from eggs.gnu.org ([2001:4830:134:3::10]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfL-0007tw-Ne
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfK-0002DS-ML
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:47 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:16 +0100
Message-Id: <1516694904-64879-18-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 17/25] sparc: cpu: add CPU_RESOLVING_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

PS:
sparc cpu model names might have spaces, add quotes around
cpu model name when creating CLI so QEMU could find cpu.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h        | 1 +
 tests/machine-none-test.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9fde547..345b39a 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -660,6 +660,7 @@ int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
 
 #define SPARC_CPU_TYPE_SUFFIX "-" TYPE_SPARC_CPU
 #define SPARC_CPU_TYPE_NAME(model) model SPARC_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_SPARC_CPU
 
 #define cpu_signal_handler cpu_sparc_signal_handler
 #define cpu_list sparc_cpu_list
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 134036a..0f80d7b 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -47,6 +47,8 @@ static struct arch2cpu cpus_map[] = {
     { "s390x", "qemu" },
     { "sh4", "sh7750r" },
     { "sh4eb", "sh7751r" },
+    { "sparc", "LEON2" },
+    { "sparc64", "Fujitsu Sparc64" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
@@ -72,7 +74,7 @@ static void test_machine_cpu_cli(void)
                 " add it to cpus_map\n", arch);
         return; /* TODO: die here to force all targets have a test */
     }
-    global_qtest = qtest_startf("-machine none -cpu %s", cpu_model);
+    global_qtest = qtest_startf("-machine none -cpu '%s'", cpu_model);
 
     response = qmp("{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
-- 
2.7.4
