Received: from eggs.gnu.org ([2001:4830:134:3::10]:33280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GA-0008L8-RD
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1G8-0002Aw-MF
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:46 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1G8-0002AO-Dz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:44 -0400
Received: by mail-pg0-x244.google.com with SMTP id u62so11808480pgb.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:28 -0700
Message-Id: <20170619181839.25249-2-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 01/12] util: add cacheinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

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
 tcg/ppc/tcg-target.inc.c |  71 +-----------------
 util/Makefile.objs       |   1 +
 util/cacheinfo.c         | 185 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 69 deletions(-)
 create mode 100644 util/cacheinfo.c

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fb008a2..8559634 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -483,4 +483,7 @@ char *qemu_get_pid_name(pid_t pid);
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
index 0000000..f987522
--- /dev/null
+++ b/util/cacheinfo.c
@@ -0,0 +1,185 @@
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
+/*
+ * Operating system specific detection mechanisms.
+ */
+
+#if defined(_AIX)
+# include <sys/systemcfg.h>
+
+static void sys_cache_info(int *isize, int *dsize)
+{
+    *isize = _system_configuration.icache_line;
+    *dsize = _system_configuration.dcache_line;
+}
+
+#elif defined(_WIN32)
+
+static void sys_cache_info(int *isize, int *dsize)
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
+                *isize = *dsize = buf[i].Cache.LineSize;
+                break;
+            case CacheInstruction:
+                *isize = buf[i].Cache.LineSize;
+                break;
+            case CacheData:
+                *dsize = buf[i].Cache.LineSize;
+                break;
+            default:
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
+static void sys_cache_info(int *isize, int *dsize)
+{
+    /* There's only a single sysctl for both I/D cache line sizes.  */
+    long size;
+    size_t len = sizeof(size);
+    if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &size, &len, NULL, 0)) {
+        *isize = *dsize = size;
+    }
+}
+
+#else
+/* POSIX */
+
+static void sys_cache_info(int *isize, int *dsize)
+{
+# ifdef _SC_LEVEL1_ICACHE_LINESIZE
+    *isize = sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
+# endif
+# ifdef _SC_LEVEL1_DCACHE_LINESIZE
+    *dsize = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+# endif
+}
+#endif /* sys_cache_info */
+
+/*
+ * Architecture (+ OS) specific detection mechanisms.
+ */
+
+#if defined(__aarch64__)
+
+static void arch_cache_info(int *isize, int *dsize)
+{
+    if (*isize == 0 || *dsize == 0) {
+        unsigned ctr;
+
+        /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
+           but (at least under Linux) these are marked protected by the
+           kernel.  However, CTR_EL0 contains the minimum linesize in the
+           entire hierarchy, and is used by userspace cache flushing.  */
+        asm volatile("mrs\t%0, ctr_el0" : "=r"(ctr));
+        if (*isize == 0) {
+            *isize = 4 << (ctr & 0xf);
+        }
+        if (*dsize == 0) {
+            *dsize = 4 << ((ctr >> 16) & 0xf);
+        }
+    }
+}
+
+#elif defined(_ARCH_PPC) && defined(__linux__)
+
+static void arch_cache_info(int *isize, int *dsize)
+{
+    if (*isize == 0) {
+        *isize = qemu_getauxval(AT_ICACHEBSIZE);
+    }
+    if (*dsize == 0) {
+        *dsize = qemu_getauxval(AT_DCACHEBSIZE);
+    }
+}
+
+#else
+static void arch_cache_info(int *isize, int *dsize) { }
+#endif /* arch_cache_info */
+
+/*
+ * ... and if all else fails ...
+ */
+
+static void fallback_cache_info(int *isize, int *dsize)
+{
+    /* If we can only find one of the two, assume they're the same.  */
+    if (*isize) {
+        if (*dsize) {
+            /* Success! */
+        } else {
+            *dsize = *isize;
+        }
+    } else if (*dsize) {
+        *isize = *dsize;
+    } else {
+#if defined(_ARCH_PPC)
+        /* For PPC, we're going to use the icache size computed for
+           flush_icache_range.  Which means that we must use the
+           architecture minimum.  */
+        *isize = *dsize = 16;
+#else
+        /* Otherwise, 64 bytes is not uncommon.  */
+        *isize = *dsize = 64;
+#endif
+    }
+}
+
+static void __attribute__((constructor)) init_cache_info(void)
+{
+    int isize = 0, dsize = 0;
+
+    sys_cache_info(&isize, &dsize);
+    arch_cache_info(&isize, &dsize);
+    fallback_cache_info(&isize, &dsize);
+
+    qemu_icache_linesize = isize;
+    qemu_dcache_linesize = dsize;
+}
-- 
2.9.4
