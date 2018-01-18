Received: from eggs.gnu.org ([2001:4830:134:3::10]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6Z-0004SN-Ce
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6W-0007y7-53
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:35:59 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 18 Jan 2018 18:34:00 +0100
Message-Id: <1516296842-136976-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
References: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 3/5] linux-user: prepare for switching to
 cpu_create() API
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

temporarily add #ifdef CPU_RESOLVING_TYPE in linux-user/main.c
so that  each target could gradually switch to cpu_create() and
not converted yet could continue to use cpu_init().

Once all targets are converted
    temporary ifdefs and cpu_init() API
will be removed

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 linux-user/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 450eb3c..d481e8c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -44,6 +44,7 @@ static const char *argv0;
 static int gdbstub_port;
 static envlist_t *envlist;
 static const char *cpu_model;
+static const char *cpu_type;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
@@ -3847,7 +3848,7 @@ void init_task_state(TaskState *ts)
 CPUArchState *cpu_copy(CPUArchState *env)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    CPUState *new_cpu = cpu_init(cpu_model);
+    CPUState *new_cpu = cpu_create(cpu_type);
     CPUArchState *new_env = new_cpu->env_ptr;
     CPUBreakpoint *bp;
     CPUWatchpoint *wp;
@@ -4362,7 +4363,17 @@ int main(int argc, char **argv, char **envp)
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
+
+#ifdef CPU_RESOLVING_TYPE
+    cpu_type = cpu_parse_cpu_model(CPU_RESOLVING_TYPE, cpu_model);
+    if (!cpu_type) {
+        exit(1);
+    }
+    cpu_create(cpu_type);
+#else
     cpu = cpu_init(cpu_model);
+    cpu_type = object_class_get_name(object_get_class(OBJECT(cpu)));
+#endif
     env = cpu->env_ptr;
     cpu_reset(cpu);
 
-- 
2.7.4
