Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSH-0005zq-84
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSF-0004fi-4o
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SSE-0004fR-Ts
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id d2-v6so9634363wro.7
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:55:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:08 +0100
Message-Id: <20181005154910.3099-20-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 19/21] plugins: add an example hotblocks
 plugin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

This plugin attempts to track hotblocks by total execution count and
average time to return to block. It is intended to be lower impact
than saving a long log file and post-processing it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 trace/plugins/hotblocks/hotblocks.c | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 trace/plugins/hotblocks/hotblocks.c

diff --git a/trace/plugins/hotblocks/hotblocks.c b/trace/plugins/hotblocks/hotblocks.c
new file mode 100644
index 0000000000..e9166ad1a5
--- /dev/null
+++ b/trace/plugins/hotblocks/hotblocks.c
@@ -0,0 +1,69 @@
+/*
+ * Execution Hotblocks Plugin
+ *
+ * Copyright (c) 2018
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * This code is licensed under the GNU GPL v2.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <glib.h>
+#include <time.h>
+#include "plugins.h"
+
+/* Plugins need to take care of their own locking */
+GMutex lock;
+GHashTable *hotblocks;
+
+typedef struct {
+    uintptr_t pc;
+    unsigned int hits;
+    struct timespec last;
+    unsigned long total_time;
+} ExecCount;
+
+bool plugin_init(const char *args)
+{
+    hotblocks = g_hash_table_new(NULL, g_direct_equal);
+    return true;
+}
+
+char *plugin_status(void)
+{
+    GString *report = g_string_new("We have ");
+    char *r;
+    g_mutex_lock(&lock);
+    g_string_append_printf(report, "%ud entries in the hash table\n",
+                           g_hash_table_size(hotblocks));
+    g_mutex_unlock(&lock);
+    r = report->str;
+    g_string_free(report, FALSE);
+    return r;
+}
+
+bool exec_tb(void *tb, uintptr_t pc)
+{
+    ExecCount *cnt;
+    struct timespec current;
+    clock_gettime(CLOCK_MONOTONIC, &current);
+
+    g_mutex_lock(&lock);
+    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) pc);
+    if (cnt) {
+        cnt->hits++;
+        cnt->total_time += current.tv_nsec - cnt->last.tv_nsec;
+        cnt->last = current;
+    } else {
+        cnt = g_new0(ExecCount, 1);
+        cnt->pc = pc;
+        cnt->last = current;
+        cnt->hits = 1;
+        g_hash_table_insert(hotblocks, (gpointer) pc, (gpointer) cnt);
+    }
+    g_mutex_unlock(&lock);
+
+    /* As we are collecting up samples no reason to continue tracing */
+    return false;
+}
-- 
2.17.1
