Received: from eggs.gnu.org ([2001:4830:134:3::10]:48424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIdJL-0000ZD-If
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIdJJ-0005Yq-3O
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:55:55 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIdJI-0005Yj-U3
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:55:53 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so1989851qtg.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:55:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  7 Jun 2017 08:55:30 -0700
Message-Id: <20170607155536.1193-2-rth@twiddle.net>
In-Reply-To: <20170607155536.1193-1-rth@twiddle.net>
References: <20170607155536.1193-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v4 1/7] util: add cacheinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Add helpers to gather cache info from the host at init-time.

For now, only export the host's I/D cache line sizes, which we
will use to improve cache locality to avoid false sharing.

Suggested-by: Richard Henderson <rth@twiddle.net>
Suggested-by: Geert Martin Ijewski <gm.ijewski@web.de>
Tested-by:    Geert Martin Ijewski <gm.ijewski@web.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1496794624-4083-1-git-send-email-cota@braap.org>
[rth: Move all implementations from tcg/ppc/]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/qemu/osdep.h     |   3 +
 tcg/ppc/tcg-target.inc.c |  71 +------------------
 util/Makefile.objs       |   1 +
 util/cacheinfo.c         | 174 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+), 69 deletions(-)
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
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 8d50f18..1f690df 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2820,14 +2820,11 @@ void tcg_register_jit(void *buf, size_t buf_size)
 }
 #endif /* __ELF__ */
 
-static size_t dcache_bsize = 16;
-static size_t icache_bsize = 16;
-
 void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
     uintptr_t p, start1, stop1;
-    size_t dsize = dcache_bsize;
-    size_t isize = icache_bsize;
+    size_t dsize = qemu_dcache_linesize;
+    size_t isize = qemu_icache_linesize;
 
     start1 = start & ~(dsize - 1);
     stop1 = (stop + dsize - 1) & ~(dsize - 1);
@@ -2844,67 +2841,3 @@ void flush_icache_range(uintptr_t start, uintptr_t stop)
     asm volatile ("sync" : : : "memory");
     asm volatile ("isync" : : : "memory");
 }
-
-#if defined _AIX
-#include <sys/systemcfg.h>
-
-static void __attribute__((constructor)) tcg_cache_init(void)
-{
-    icache_bsize = _system_configuration.icache_line;
-    dcache_bsize = _system_configuration.dcache_line;
-}
-
-#elif defined __linux__
-static void __attribute__((constructor)) tcg_cache_init(void)
-{
-    unsigned long dsize = qemu_getauxval(AT_DCACHEBSIZE);
-    unsigned long isize = qemu_getauxval(AT_ICACHEBSIZE);
-
-    if (dsize == 0 || isize == 0) {
-        if (dsize == 0) {
-            fprintf(stderr, "getauxval AT_DCACHEBSIZE failed\n");
-        }
-        if (isize == 0) {
-            fprintf(stderr, "getauxval AT_ICACHEBSIZE failed\n");
-        }
-        exit(1);
-    }
-    dcache_bsize = dsize;
-    icache_bsize = isize;
-}
-
-#elif defined __APPLE__
-#include <sys/sysctl.h>
-
-static void __attribute__((constructor)) tcg_cache_init(void)
-{
-    size_t len;
-    unsigned cacheline;
-    int name[2] = { CTL_HW, HW_CACHELINE };
-
-    len = sizeof(cacheline);
-    if (sysctl(name, 2, &cacheline, &len, NULL, 0)) {
-        perror("sysctl CTL_HW HW_CACHELINE failed");
-        exit(1);
-    }
-    dcache_bsize = cacheline;
-    icache_bsize = cacheline;
-}
-
-#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
-#include <sys/sysctl.h>
-
-static void __attribute__((constructor)) tcg_cache_init(void)
-{
-    size_t len = 4;
-    unsigned cacheline;
-
-    if (sysctlbyname ("machdep.cacheline_size", &cacheline, &len, NULL, 0)) {
-        fprintf(stderr, "sysctlbyname machdep.cacheline_size failed: %s\n",
-                strerror(errno));
-        exit(1);
-    }
-    dcache_bsize = cacheline;
-    icache_bsize = cacheline;
-}
-#endif
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
index 0000000..0238ca6
--- /dev/null
+++ b/util/cacheinfo.c
@@ -0,0 +1,174 @@
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
+int qemu_icache_linesize = 0;
+int qemu_dcache_linesize = 0;
+
+#if defined(_AIX)
+# include <sys/systemcfg.h>
+
+static void sys_cache_info(void)
+{
+    qemu_icache_linesize = _system_configuration.icache_line;
+    qemu_dcache_linesize = _system_configuration.dcache_line;
+}
+
+#elif defined(_WIN32)
+
+static void sys_cache_info(void)
+{
+    SYSTEM_LOGICAL_PROCESSOR_INFORMATION *buf;
+    DWORD size = 0;
+    BOOL success;
+    size_t i, n;
+
+    /* Check for the required buffer size first.  Note that if the zero
+       size we use for the probe results in success, then there is no
+       data available; fail in that case.  */
+    success = GetLogicalProcessorInformation(0, &size);
+    if (success || GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
+        return;
+    }
+
+    n = size / sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION);
+    size = n * sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION);
+    buf = g_new0(SYSTEM_LOGICAL_PROCESSOR_INFORMATION, n);
+    if (!GetLogicalProcessorInformation(buf, &size)) {
+        goto fail;
+    }
+
+    for (i = 0; i < n; i++) {
+        if (buf[i].Relationship == RelationCache
+            && buf[i].Cache.Level == 1) {
+            switch (buf[i].Cache.Type) {
+            case CacheUnified:
+                qemu_icache_linesize = buf[i].Cache.LineSize;
+                qemu_dcache_linesize = buf[i].Cache.LineSize;
+                break;
+            case CacheInstruction:
+                qemu_icache_linesize = buf[i].Cache.LineSize;
+                break;
+            case CacheData:
+                qemu_dcache_linesize = buf[i].Cache.LineSize;
+                break;
+            }
+        }
+    }
+ fail:
+    g_free(buf);
+}
+
+#elif defined(__APPLE__) \
+      || defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
+# include <sys/sysctl.h>
+# if defined(__APPLE__)
+#  define SYSCTL_CACHELINE_NAME "hw.cachelinesize"
+# else
+#  define SYSCTL_CACHELINE_NAME "machdep.cacheline_size"
+# endif
+
+static void sys_cache_info(void)
+{
+    /* There's only a single sysctl for both I/D cache line sizes.  */
+    size_t len = sizeof(qemu_icache_linesize);
+    if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &qemu_icache_linesize,
+                      &len, NULL, 0)) {
+        qemu_dcache_linesize = qemu_icache_linesize;
+    }
+}
+
+#else
+/* POSIX, with extra Linux ifdefs.  */
+
+static int icache_info(void)
+{
+# ifdef _SC_LEVEL1_ICACHE_LINESIZE
+    {
+        long x = sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
+        if (x > 0) {
+            return x;
+        }
+    }
+# endif
+# ifdef AT_ICACHEBSIZE
+    /* glibc does not always export this through sysconf, e.g. on PPC */
+    {
+        unsigned long x = qemu_getauxval(AT_ICACHEBSIZE);
+        if (x > 0) {
+            return x;
+        }
+    }
+# endif
+    return 0;
+}
+
+/* Similarly for the D cache.  */
+static int dcache_info(void)
+{
+# ifdef _SC_LEVEL1_DCACHE_LINESIZE
+    {
+        long x = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+        if (x > 0) {
+            return x;
+        }
+    }
+# endif
+# ifdef AT_DCACHEBSIZE
+    {
+        unsigned long x = qemu_getauxval(AT_DCACHEBSIZE);
+        if (x > 0) {
+            return x;
+        }
+    }
+# endif
+    return 0;
+}
+
+static void sys_cache_info(void)
+{
+    qemu_icache_linesize = icache_info();
+    qemu_dcache_linesize = dcache_info();
+}
+#endif
+
+static void __attribute__((constructor)) init_cache_info(void)
+{
+    int isize, dsize;
+
+    sys_cache_info();
+
+    isize = qemu_icache_linesize;
+    dsize = qemu_dcache_linesize;
+
+    /* If we can only find one of the two, assume they're the same.  */
+    if (isize) {
+        if (dsize) {
+            /* Success! */
+            return;
+        } else {
+            dsize = isize;
+        }
+    } else if (dsize) {
+        isize = dsize;
+    } else {
+#if defined(_ARCH_PPC)
+        /* For PPC, we're going to use the icache size computed for
+           flush_icache_range.  Which means that we must use the
+           architecture minimum.  */
+        isize = dsize = 16;
+#else
+        /* Otherwise, 64 bytes is not uncommon.  */
+        isize = dsize = 64;
+#endif
+    }
+
+    qemu_icache_linesize = isize;
+    qemu_dcache_linesize = dsize;
+}
-- 
2.9.4
