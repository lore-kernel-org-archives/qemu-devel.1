Received: from eggs.gnu.org ([2001:4830:134:3::10]:42240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dINeL-0003wY-O2
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dINeI-0002IB-J1
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:12:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dINeI-0002Gl-0o
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:12:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  6 Jun 2017 19:12:24 -0400
Message-Id: <1496790745-314-2-git-send-email-cota@braap.org>
In-Reply-To: <1496790745-314-1-git-send-email-cota@braap.org>
References: <1496790745-314-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 1/2] util: add cacheinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>, Geert Martin Ijewski <gm.ijewski@web.de>

Add helpers to gather cache info from the host at init-time.

For now, only export the host's I/D cache line sizes, which we
will use to improve cache locality to avoid false sharing.

Suggested-by: Richard Henderson <rth@twiddle.net>
Suggested-by: Geert Martin Ijewski <gm.ijewski@web.de>
Tested-by:    Geert Martin Ijewski <gm.ijewski@web.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/osdep.h |   3 +
 util/Makefile.objs   |   1 +
 util/cacheinfo.c     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 util/cacheinfo.c

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1c9f5e2..ee43521 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -470,4 +470,7 @@ char *qemu_get_pid_name(pid_t pid);
  */
 pid_t qemu_fork(Error **errp);
 
+extern int qemu_icache_linesize;
+extern int qemu_dcache_linesize;
+
 #endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index c6205eb..94d9477 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -20,6 +20,7 @@ util-obj-y += host-utils.o
 util-obj-y += bitmap.o bitops.o hbitmap.o
 util-obj-y += fifo8.o
 util-obj-y += acl.o
+util-obj-y += cacheinfo.o
 util-obj-y += error.o qemu-error.o
 util-obj-y += id.o
 util-obj-y += iov.o qemu-config.o qemu-sockets.o uri.o notify.o
diff --git a/util/cacheinfo.c b/util/cacheinfo.c
new file mode 100644
index 0000000..8c52c77
--- /dev/null
+++ b/util/cacheinfo.c
@@ -0,0 +1,158 @@
+/*
+ * cacheinfo.c - helpers to query the host about its caches
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+int qemu_icache_linesize = 64;
+int qemu_dcache_linesize = 64;
+
+#ifdef _WIN32
+static unsigned int linesize_win(PROCESSOR_CACHE_TYPE type)
+{
+    PSYSTEM_LOGICAL_PROCESSOR_INFORMATION buf;
+    DWORD size = 0;
+    unsigned int ret = 0;
+    BOOL success;
+    size_t n;
+    size_t i;
+
+    success = GetLogicalProcessorInformation(0, &size);
+    if (success || GetLastError() != ERROR_INSUFFICIENT_BUF) {
+        return 0;
+    }
+    buf = (PSYSTEM_LOGICAL_PROCESSOR_INFORMATION)g_malloc0(size);
+    if (!GetLogicalProcessorInformation(buf, &size)) {
+        goto out;
+    }
+
+    n = size / sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION);
+    for (i = 0; i < n; i++) {
+        if (buf[i].Relationship == RelationCache &&
+            buf[i].Cache.Level == 1 &&
+            (buf[i].Cache.Type == CacheUnified ||
+             buf[i].Cache.Type == type)) {
+            ret = buf[i].Cache.LineSize;
+            break;
+        }
+    }
+ out:
+    g_free(buf);
+    return ret;
+}
+#endif
+
+#ifdef __APPLE__
+#include <sys/sysctl.h>
+
+unsigned int linesize_apple(void)
+{
+    unsigned long bytes;
+    size_t len = sizeof(bytes);
+
+    /* There's only a single sysctl for both I/D cache line sizes */
+    if (sysctlbyname("hw.cachelinesize", &bytes, &len, NULL, 0)) {
+        return 0;
+    }
+    return bytes;
+}
+#endif
+
+static void icache_info(void)
+{
+    #ifdef _SC_LEVEL1_ICACHE_LINESIZE
+    {
+        long x = sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
+
+        if (x > 0) {
+            qemu_icache_linesize = x;
+            return;
+        }
+    }
+    #endif
+    #ifdef AT_ICACHEBSIZE
+    /* glibc does not always export this through sysconf, e.g. on PPC */
+    {
+        unsigned long x = qemu_getauxval(AT_ICACHEBSIZE);
+
+        if (x > 0) {
+            qemu_icache_linesize = x;
+            return;
+        }
+    }
+    #endif
+    #ifdef _WIN32
+    {
+        unsigned int x = linesize_win(CacheInstruction);
+
+        if (x > 0) {
+            qemu_icache_linesize = x;
+            return;
+        }
+    }
+    #endif
+    #ifdef __APPLE__
+    {
+        unsigned int x = linesize_apple();
+
+        if (x > 0) {
+            qemu_icache_linesize = x;
+            return;
+        }
+    }
+    #endif
+}
+
+static void dcache_info(void)
+{
+    #ifdef _SC_LEVEL1_DCACHE_LINESIZE
+    {
+        long x = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+
+        if (x > 0) {
+            qemu_dcache_linesize = x;
+            return;
+        }
+    }
+    #endif
+    #ifdef AT_DCACHEBSIZE
+    {
+        unsigned long x = qemu_getauxval(AT_DCACHEBSIZE);
+
+        if (x > 0) {
+            qemu_dcache_linesize = x;
+            return;
+        }
+    }
+    #endif
+    #ifdef _WIN32
+    {
+        unsigned int x = linesize_win(CacheData);
+
+        if (x > 0) {
+            qemu_dcache_linesize = x;
+            return;
+        }
+    }
+    #endif
+    #ifdef __APPLE__
+    {
+        unsigned int x = linesize_apple();
+
+        if (x > 0) {
+            qemu_dcache_linesize = x;
+            return;
+        }
+    }
+    #endif
+}
+
+static void __attribute__((constructor)) cacheinfo_init(void)
+{
+    icache_info();
+    dcache_info();
+}
-- 
2.7.4
