Received: from eggs.gnu.org ([209.51.188.92]:51499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gguGw-0002yW-B2
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gguGu-0004HJ-2y
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:34 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gguGl-0003oh-56
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:26 -0500
Received: by mail-wr1-x443.google.com with SMTP id t6so4641153wrr.12
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:30:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  8 Jan 2019 16:30:08 +0000
Message-Id: <20190108163008.7006-5-peter.maydell@linaro.org>
In-Reply-To: <20190108163008.7006-1-peter.maydell@linaro.org>
References: <20190108163008.7006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] gdbstub: Simplify gdb_get_cpu_pid() to use
 cpu->cluster_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <richard.henderson@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Emilio G . Cota" <cota@braap.org>

Now we're keeping the cluster index in the CPUState, we don't
need to jump through hoops in gdb_get_cpu_pid() to find the
associated cluster object.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 48 +++++-------------------------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index bfc7afb5096..5d6cbea9d35 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -644,50 +644,12 @@ static int memtox(char *buf, const char *mem, int len)
 
 static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
-    gchar *path, *name = NULL;
-    Object *obj;
-    CPUClusterState *cluster;
-    uint32_t ret;
-
-    path = object_get_canonical_path(OBJECT(cpu));
-
-    if (path == NULL) {
-        /* Return the default process' PID */
-        ret = s->processes[s->process_num - 1].pid;
-        goto out;
-    }
-
-    name = object_get_canonical_path_component(OBJECT(cpu));
-    assert(name != NULL);
-
-    /*
-     * Retrieve the CPU parent path by removing the last '/' and the CPU name
-     * from the CPU canonical path.
-     */
-    path[strlen(path) - strlen(name) - 1] = '\0';
-
-    obj = object_resolve_path_type(path, TYPE_CPU_CLUSTER, NULL);
-
-    if (obj == NULL) {
-        /* Return the default process' PID */
-        ret = s->processes[s->process_num - 1].pid;
-        goto out;
-    }
-
-    cluster = CPU_CLUSTER(obj);
-    ret = cluster->cluster_id + 1;
-
-out:
-    g_free(name);
-    g_free(path);
-
-    return ret;
-
-#else
     /* TODO: In user mode, we should use the task state PID */
-    return s->processes[s->process_num - 1].pid;
-#endif
+    if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
+        /* Return the default process' PID */
+        return s->processes[s->process_num - 1].pid;
+    }
+    return cpu->cluster_index + 1;
 }
 
 static GDBProcess *gdb_get_process(const GDBState *s, uint32_t pid)
-- 
2.19.2
