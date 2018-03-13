Received: from eggs.gnu.org ([2001:4830:134:3::10]:58131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsi8-0005p9-J1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsi3-0003NO-Pq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:00 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsi3-0003Lt-GH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:55 -0400
Received: by mail-wm0-x241.google.com with SMTP id a20so16162290wmd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:55 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:36 +0100
Message-Id: <20180313224719.4954-27-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/69] membarrier: add --enable-membarrier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Actually enable the global memory barriers if supported by the OS.
Because only recent versions of Linux include the support, they
are disabled by default.  Note that it also has to be disabled
for QEMU to run under Wine.

Before this patch, rcutorture reports 85 ns/read for my machine,
after the patch it reports 12.5 ns/read.  On the other hand updates
go from 50 *micro*seconds to 20 *milli*seconds.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 42 +++++++++++++++++++++++++++++++++++-
 include/qemu/sys_membarrier.h | 10 +++++++++
 util/Makefile.objs            |  1 +
 util/sys_membarrier.c         | 50 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 util/sys_membarrier.c

diff --git a/configure b/configure
index 26d56eb5bb..db87fc4fed 100755
--- a/configure
+++ b/configure
@@ -342,7 +342,7 @@ attr=""
 libattr=""
 xfs=""
 tcg="yes"
-
+membarrier=""
 vhost_net="no"
 vhost_crypto="no"
 vhost_scsi="no"
@@ -1161,6 +1161,10 @@ for opt do
   ;;
   --enable-attr) attr="yes"
   ;;
+  --disable-membarrier) membarrier="no"
+  ;;
+  --enable-membarrier) membarrier="yes"
+  ;;
   --disable-blobs) blobs="no"
   ;;
   --with-pkgversion=*) pkgversion="$optarg"
@@ -1577,6 +1581,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   xen-pci-passthrough
   brlapi          BrlAPI (Braile)
   curl            curl connectivity
+  membarrier      membarrier system call (for Linux 4.14+ or Windows)
   fdt             fdt device tree
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
@@ -5137,6 +5142,37 @@ if compile_prog "" "" ; then
     have_fsxattr=yes
 fi
 
+##########################################
+# check for usable membarrier system call
+if test "$membarrier" = "yes"; then
+    have_membarrier=no
+    if test "$mingw32" = "yes" ; then
+        have_membarrier=yes
+    elif test "$linux" = "yes" ; then
+        cat > $TMPC << EOF
+    #include <linux/membarrier.h>
+    #include <sys/syscall.h>
+    #include <unistd.h>
+    #include <stdlib.h>
+    int main(void) {
+        syscall(__NR_membarrier, MEMBARRIER_CMD_QUERY, 0);
+        syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0);
+	exit(0);
+    }
+EOF
+        if compile_prog "" "" ; then
+            have_membarrier=yes
+        fi
+    fi
+    if test "$have_membarrier" = "no"; then
+      feature_not_found "membarrier" "membarrier system call not available"
+    fi
+else
+    # Do not enable it by default even for Mingw32, because it doesn't
+    # work on Wine.
+    membarrier=no
+fi
+
 ##########################################
 # check if rtnetlink.h exists and is useful
 have_rtnetlink=no
@@ -5763,6 +5799,7 @@ fi
 echo "malloc trim support $malloc_trim"
 echo "RDMA support      $rdma"
 echo "fdt support       $fdt"
+echo "membarrier        $membarrier"
 echo "preadv support    $preadv"
 echo "fdatasync         $fdatasync"
 echo "madvise           $madvise"
@@ -6245,6 +6282,9 @@ fi
 if test "$fdt" = "yes" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
 fi
+if test "$membarrier" = "yes" ; then
+  echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
+fi
 if test "$signalfd" = "yes" ; then
   echo "CONFIG_SIGNALFD=y" >> $config_host_mak
 fi
diff --git a/include/qemu/sys_membarrier.h b/include/qemu/sys_membarrier.h
index 9ce7f5210b..316e3dc4a2 100644
--- a/include/qemu/sys_membarrier.h
+++ b/include/qemu/sys_membarrier.h
@@ -9,9 +9,19 @@
 #ifndef QEMU_SYS_MEMBARRIER_H
 #define QEMU_SYS_MEMBARRIER_H 1
 
+#ifdef CONFIG_MEMBARRIER
+/* Only block reordering at the compiler level in the performance-critical
+ * side.  The slow side forces processor-level ordering on all other cores
+ * through a system call.
+ */
+extern void smp_mb_global_init(void);
+extern void smp_mb_global(void);
+#define smp_mb_placeholder()       barrier()
+#else
 /* Keep it simple, execute a real memory barrier on both sides.  */
 static inline void smp_mb_global_init(void) {}
 #define smp_mb_global()            smp_mb()
 #define smp_mb_placeholder()       smp_mb()
+#endif
 
 #endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index ae90b9963d..728c3541db 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -33,6 +33,7 @@ util-obj-y += throttle.o
 util-obj-y += getauxval.o
 util-obj-y += readline.o
 util-obj-y += rcu.o
+util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
 util-obj-y += qemu-coroutine-sleep.o
 util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
diff --git a/util/sys_membarrier.c b/util/sys_membarrier.c
new file mode 100644
index 0000000000..8dcb53e63e
--- /dev/null
+++ b/util/sys_membarrier.c
@@ -0,0 +1,50 @@
+/*
+ * Process-global memory barriers
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ */
+
+#include <qemu/osdep.h>
+#include <qemu/sys_membarrier.h>
+#include <qemu/error-report.h>
+
+#ifdef CONFIG_LINUX
+#include <linux/membarrier.h>
+#include <sys/syscall.h>
+
+static int
+membarrier(int cmd, int flags)
+{
+    return syscall(__NR_membarrier, cmd, flags);
+}
+#endif
+
+void smp_mb_global(void)
+{
+#if defined CONFIG_WIN32
+    FlushProcessWriteBuffers();
+#elif defined CONFIG_LINUX
+    membarrier(MEMBARRIER_CMD_SHARED, 0);
+#else
+#error --enable-membarrier is not supported on this operating system.
+#endif
+}
+
+void smp_mb_global_init(void)
+{
+#ifdef CONFIG_LINUX
+    int ret = membarrier(MEMBARRIER_CMD_QUERY, 0);
+    if (ret < 0) {
+        error_report("This QEMU binary requires the membarrier system call.");
+        error_report("Please upgrade your system to a newer version of Linux");
+        exit(1);
+    }
+    if (!(ret & MEMBARRIER_CMD_SHARED)) {
+        error_report("This QEMU binary requires MEMBARRIER_CMD_SHARED support.");
+        error_report("Please upgrade your system to a newer version of Linux");
+        exit(1);
+    }
+#endif
+}
-- 
2.14.3
