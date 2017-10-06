Received: from eggs.gnu.org ([2001:4830:134:3::10]:41790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQ6-00006s-Ij
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQ3-00061p-W3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:32 -0300
Message-Id: <20171006235023.11952-38-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 37/88] TCG: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: avoid use of g_malloc0() in cpus.c]
---
 cpus.c    | 18 +++++++++---------
 tcg/tcg.c |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/cpus.c b/cpus.c
index c9a624003a..6dea1c7041 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1666,8 +1666,8 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     static QemuThread *single_tcg_cpu_thread;
 
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
-        cpu->thread = g_malloc0(sizeof(QemuThread));
-        cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+        cpu->thread = g_new0(QemuThread, 1);
+        cpu->halt_cond = g_new0(QemuCond, 1);
         qemu_cond_init(cpu->halt_cond);
 
         if (qemu_tcg_mttcg_enabled()) {
@@ -1706,8 +1706,8 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    cpu->thread = g_new0(QemuThread, 1);
+    cpu->halt_cond = g_new0(QemuCond, 1);
     qemu_cond_init(cpu->halt_cond);
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
@@ -1726,8 +1726,8 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    cpu->thread = g_new0(QemuThread, 1);
+    cpu->halt_cond = g_new0(QemuCond, 1);
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
@@ -1742,8 +1742,8 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    cpu->thread = g_new0(QemuThread, 1);
+    cpu->halt_cond = g_new0(QemuCond, 1);
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
@@ -1931,7 +1931,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
         info->value->has_props = !!mc->cpu_index_to_instance_props;
         if (info->value->has_props) {
             CpuInstanceProperties *props;
-            props = g_malloc0(sizeof(*props));
+            props = g_malloc(sizeof(*props));
             *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
             info->value->props = props;
         }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dff9999bc6..d5c1c75aa7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -342,8 +342,8 @@ void tcg_context_init(TCGContext *s)
         total_args += n;
     }
 
-    args_ct = g_malloc(sizeof(TCGArgConstraint) * total_args);
-    sorted_args = g_malloc(sizeof(int) * total_args);
+    args_ct = g_new(TCGArgConstraint, total_args);
+    sorted_args = g_new(int, total_args);
 
     for(op = 0; op < NB_OPS; op++) {
         def = &tcg_op_defs[op];
-- 
2.14.2
