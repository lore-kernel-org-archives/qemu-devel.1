Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dI0ou-0007nE-Fr
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dI0or-0000GC-Bn
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dI0or-0000FB-0v
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  5 Jun 2017 18:49:37 -0400
Message-Id: <1496702979-26132-2-git-send-email-cota@braap.org>
In-Reply-To: <1496702979-26132-1-git-send-email-cota@braap.org>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 1/3] compiler: define QEMU_CACHELINE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>

This is a constant used as a hint for padding structs to hopefully avoid
false cache line sharing.

The constant can be set at configure time by defining QEMU_CACHELINE_SIZE
via --extra-cflags. If not set there, we try to obtain the value from
the machine running the configure script. If we fail, we default to
reasonable values, i.e. 128 bytes for ppc64 and 64 bytes for all others.

Note: the configure script only picks up the cache line size when run
on Linux hosts because I have no other platforms (e.g. Windows, BSD's)
to test on.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure               | 38 ++++++++++++++++++++++++++++++++++++++
 include/qemu/compiler.h | 17 +++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/configure b/configure
index 13e040d..6a68cb2 100755
--- a/configure
+++ b/configure
@@ -4832,6 +4832,41 @@ EOF
   fi
 fi
 
+# Find out the size of a cache line on the host
+# TODO: support more platforms
+cat > $TMPC<<EOF
+#ifdef __linux__
+
+#include <stdio.h>
+
+#define SYSFS "/sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size"
+
+int main(int argc, char *argv[])
+{
+    unsigned int size;
+    FILE *fp;
+
+    fp = fopen(SYSFS, "r");
+    if (fp == NULL) {
+        return -1;
+    }
+    if (!fscanf(fp, "%u", &size)) {
+        return -1;
+    }
+    return size;
+}
+#else
+#error Cannot find host cache line size
+#endif
+EOF
+
+host_cacheline_size=0
+if compile_prog "" "" ; then
+    ./$TMPE
+    host_cacheline_size=$?
+fi
+
+
 ##########################################
 # check for _Static_assert()
 
@@ -5284,6 +5319,9 @@ fi
 if test "$bigendian" = "yes" ; then
   echo "HOST_WORDS_BIGENDIAN=y" >> $config_host_mak
 fi
+if test "$host_cacheline_size" -gt 0 ; then
+    echo "HOST_CACHELINE_SIZE=$host_cacheline_size" >> $config_host_mak
+fi
 if test "$mingw32" = "yes" ; then
   echo "CONFIG_WIN32=y" >> $config_host_mak
   rc_version=$(cat $source_path/VERSION)
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 340e5fd..178d831 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -40,6 +40,23 @@
 # define QEMU_PACKED __attribute__((packed))
 #endif
 
+/*
+ * Cache line size of the host. Can be overriden.
+ * Note that this is just a compile-time hint to hopefully avoid false sharing
+ * of cache lines; code must be correct regardless of the constant's value.
+ */
+#ifndef QEMU_CACHELINE_SIZE
+# ifdef HOST_CACHELINE_SIZE
+#  define QEMU_CACHELINE_SIZE HOST_CACHELINE_SIZE
+# else
+#  if defined(__powerpc64__)
+#   define QEMU_CACHELINE_SIZE 128
+#  else
+#   define QEMU_CACHELINE_SIZE 64
+#  endif
+# endif
+#endif
+
 #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
 
 #ifndef glue
-- 
2.7.4
