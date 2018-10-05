Received: from eggs.gnu.org ([2001:4830:134:3::10]:60114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSH-0005zs-86
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSE-0004fY-BW
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SSE-0004er-4c
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id z4-v6so14074890wrb.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:55:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:09 +0100
Message-Id: <20181005154910.3099-21-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 20/21] plugins: add hotness summary to
 hotblocks
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 trace/plugins/hotblocks/hotblocks.c | 33 ++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/trace/plugins/hotblocks/hotblocks.c b/trace/plugins/hotblocks/hotblocks.c
index e9166ad1a5..d2333ad866 100644
--- a/trace/plugins/hotblocks/hotblocks.c
+++ b/trace/plugins/hotblocks/hotblocks.c
@@ -11,11 +11,13 @@
 #include <stdio.h>
 #include <glib.h>
 #include <time.h>
+#include <inttypes.h>
 #include "plugins.h"
 
 /* Plugins need to take care of their own locking */
 GMutex lock;
 GHashTable *hotblocks;
+guint64 limit = 20;
 
 typedef struct {
     uintptr_t pc;
@@ -24,20 +26,49 @@ typedef struct {
     unsigned long total_time;
 } ExecCount;
 
+static gint cmp_hits(gconstpointer a, gconstpointer b)
+{
+    ExecCount *ea = (ExecCount *) a;
+    ExecCount *eb = (ExecCount *) b;
+    return ea->hits > eb->hits ? -1 : 1;
+}
+
 bool plugin_init(const char *args)
 {
+    guint64 count = g_ascii_strtoull(args, NULL, 10);
+    if (count > 0) {
+        limit = count;
+    }
+
     hotblocks = g_hash_table_new(NULL, g_direct_equal);
     return true;
 }
 
 char *plugin_status(void)
 {
-    GString *report = g_string_new("We have ");
+    GString *report = g_string_new("collected ");
+    GList *counts, *it;
     char *r;
+    int i;
+
     g_mutex_lock(&lock);
     g_string_append_printf(report, "%ud entries in the hash table\n",
                            g_hash_table_size(hotblocks));
+    counts = g_hash_table_get_values(hotblocks);
+    it = g_list_sort(counts, cmp_hits);
+
+    for (i = 0; i < limit && it->next; i++, it = it->next) {
+        ExecCount *rec = (ExecCount *) it->data;
+        g_string_append_printf(report,
+                               "  pc: %#016" PRIxPTR
+                               " (%d hits)"
+                               " %lu ns between returns\n",
+                               rec->pc, rec->hits,
+                               rec->total_time / rec->hits);
+    }
+
     g_mutex_unlock(&lock);
+    g_list_free(it);
     r = report->str;
     g_string_free(report, FALSE);
     return r;
-- 
2.17.1
