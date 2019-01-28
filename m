Received: from eggs.gnu.org ([209.51.188.92]:41232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNe-0003AN-Jg
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNc-0000Z9-RJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:34 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNc-0000RX-HU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id y8so14923697wmi.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:47 +0000
Message-Id: <20190128181047.20781-27-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/26] gdbstub: Simplify gdb_get_cpu_pid() to
 use cpu->cluster_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now we're keeping the cluster index in the CPUState, we don't
need to jump through hoops in gdb_get_cpu_pid() to find the
associated cluster object.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20190121152218.9592-5-peter.maydell@linaro.org
---
 gdbstub.c | 48 +++++-------------------------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index d4cc6ecf99b..3129b5c2842 100644
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
2.20.1
