Received: from eggs.gnu.org ([2001:4830:134:3::10]:33623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cc7qN-0000KX-OH
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cc7qL-0005N8-Jk
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:19 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cc7qL-0005MS-AL
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:17 -0500
Received: by mail-wr0-x242.google.com with SMTP id o16so14577459wra.2
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 01:50:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Feb 2017 10:50:06 +0100
Message-Id: <20170210095012.16039-2-pbonzini@redhat.com>
In-Reply-To: <20170210095012.16039-1-pbonzini@redhat.com>
References: <20170210095012.16039-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] cpus: remove ugly cast on sigbus_handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org

The cast is there because sigbus_handler is invoked via sigfd_handler.
But it feels just wrong to use struct qemu_signalfd_siginfo in the
prototype of a function that is passed to sigaction.

Instead, do a simple-minded conversion of qemu_signalfd_siginfo to
siginfo_t.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c                  | 12 +++---------
 include/qemu/compatfd.h | 42 ------------------------------------------
 include/qemu/osdep.h    | 26 ++++++++++++++++++++++++++
 main-loop.c             |  5 +----
 os-win32.c              |  7 +++++++
 util/compatfd.c         |  1 -
 util/oslib-posix.c      | 33 +++++++++++++++++++++++++++++++++
 7 files changed, 70 insertions(+), 56 deletions(-)
 delete mode 100644 include/qemu/compatfd.h

diff --git a/cpus.c b/cpus.c
index 71a82e5..b28e08e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -49,10 +49,6 @@
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
 
-#ifndef _WIN32
-#include "qemu/compatfd.h"
-#endif
-
 #ifdef CONFIG_LINUX
 
 #include <sys/prctl.h>
@@ -794,11 +790,9 @@ static void sigbus_reraise(void)
     abort();
 }
 
-static void sigbus_handler(int n, struct qemu_signalfd_siginfo *siginfo,
-                           void *ctx)
+static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
 {
-    if (kvm_on_sigbus(siginfo->ssi_code,
-                      (void *)(intptr_t)siginfo->ssi_addr)) {
+    if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
         sigbus_reraise();
     }
 }
@@ -809,7 +803,7 @@ static void qemu_init_sigbus(void)
 
     memset(&action, 0, sizeof(action));
     action.sa_flags = SA_SIGINFO;
-    action.sa_sigaction = (void (*)(int, siginfo_t*, void*))sigbus_handler;
+    action.sa_sigaction = sigbus_handler;
     sigaction(SIGBUS, &action, NULL);
 
     prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0);
diff --git a/include/qemu/compatfd.h b/include/qemu/compatfd.h
deleted file mode 100644
index aa12ee9..0000000
--- a/include/qemu/compatfd.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * signalfd/eventfd compatibility
- *
- * Copyright IBM, Corp. 2008
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- */
-
-#ifndef QEMU_COMPATFD_H
-#define QEMU_COMPATFD_H
-
-
-struct qemu_signalfd_siginfo {
-    uint32_t ssi_signo;   /* Signal number */
-    int32_t  ssi_errno;   /* Error number (unused) */
-    int32_t  ssi_code;    /* Signal code */
-    uint32_t ssi_pid;     /* PID of sender */
-    uint32_t ssi_uid;     /* Real UID of sender */
-    int32_t  ssi_fd;      /* File descriptor (SIGIO) */
-    uint32_t ssi_tid;     /* Kernel timer ID (POSIX timers) */
-    uint32_t ssi_band;    /* Band event (SIGIO) */
-    uint32_t ssi_overrun; /* POSIX timer overrun count */
-    uint32_t ssi_trapno;  /* Trap number that caused signal */
-    int32_t  ssi_status;  /* Exit status or signal (SIGCHLD) */
-    int32_t  ssi_int;     /* Integer sent by sigqueue(2) */
-    uint64_t ssi_ptr;     /* Pointer sent by sigqueue(2) */
-    uint64_t ssi_utime;   /* User CPU time consumed (SIGCHLD) */
-    uint64_t ssi_stime;   /* System CPU time consumed (SIGCHLD) */
-    uint64_t ssi_addr;    /* Address that generated signal
-                             (for hardware-generated signals) */
-    uint8_t  pad[48];     /* Pad size to 128 bytes (allow for
-                             additional fields in the future) */
-};
-
-int qemu_signalfd(const sigset_t *mask);
-
-#endif
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 689f253..5201dbd 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -290,6 +290,32 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #  define QEMU_VMALLOC_ALIGN getpagesize()
 #endif
 
+struct qemu_signalfd_siginfo {
+    uint32_t ssi_signo;   /* Signal number */
+    int32_t  ssi_errno;   /* Error number (unused) */
+    int32_t  ssi_code;    /* Signal code */
+    uint32_t ssi_pid;     /* PID of sender */
+    uint32_t ssi_uid;     /* Real UID of sender */
+    int32_t  ssi_fd;      /* File descriptor (SIGIO) */
+    uint32_t ssi_tid;     /* Kernel timer ID (POSIX timers) */
+    uint32_t ssi_band;    /* Band event (SIGIO) */
+    uint32_t ssi_overrun; /* POSIX timer overrun count */
+    uint32_t ssi_trapno;  /* Trap number that caused signal */
+    int32_t  ssi_status;  /* Exit status or signal (SIGCHLD) */
+    int32_t  ssi_int;     /* Integer sent by sigqueue(2) */
+    uint64_t ssi_ptr;     /* Pointer sent by sigqueue(2) */
+    uint64_t ssi_utime;   /* User CPU time consumed (SIGCHLD) */
+    uint64_t ssi_stime;   /* System CPU time consumed (SIGCHLD) */
+    uint64_t ssi_addr;    /* Address that generated signal
+                             (for hardware-generated signals) */
+    uint8_t  pad[48];     /* Pad size to 128 bytes (allow for
+                             additional fields in the future) */
+};
+
+int qemu_signalfd(const sigset_t *mask);
+void sigaction_invoke(struct sigaction *action,
+                      struct qemu_signalfd_siginfo *info);
+
 int qemu_madvise(void *addr, size_t len, int advice);
 
 int qemu_open(const char *name, int flags, ...);
diff --git a/main-loop.c b/main-loop.c
index ad10bca..ca7bb07 100644
--- a/main-loop.c
+++ b/main-loop.c
@@ -34,8 +34,6 @@
 
 #ifndef _WIN32
 
-#include "qemu/compatfd.h"
-
 /* If we have signalfd, we mask out the signals we want to handle and then
  * use signalfd to listen for them.  We rely on whatever the current signal
  * handler is to dispatch the signals when we receive them.
@@ -63,8 +61,7 @@ static void sigfd_handler(void *opaque)
 
         sigaction(info.ssi_signo, NULL, &action);
         if ((action.sa_flags & SA_SIGINFO) && action.sa_sigaction) {
-            action.sa_sigaction(info.ssi_signo,
-                                (siginfo_t *)&info, NULL);
+            sigaction_invoke(&action, &info);
         } else if (action.sa_handler) {
             action.sa_handler(info.ssi_signo);
         }
diff --git a/os-win32.c b/os-win32.c
index ae98574..949829c 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -77,6 +77,13 @@ void os_setup_early_signal_handling(void)
     atexit(os_undo_timer_resolution);
 }
 
+void sigaction_invoke(struct sigaction *action,
+                      struct qemu_signalfd_siginfo *info)
+{
+    /* SA_SIGINFO not used on Windows.  */
+    abort();
+}
+
 /* Look for support files in the same directory as the executable.  */
 char *os_find_datadir(void)
 {
diff --git a/util/compatfd.c b/util/compatfd.c
index 9a43042..980bd33 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -15,7 +15,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qemu/compatfd.h"
 #include "qemu/thread.h"
 
 #include <sys/syscall.h>
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f631464..bba6b26 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -603,3 +603,36 @@ void qemu_free_stack(void *stack, size_t sz)
 
     munmap(stack, sz);
 }
+
+void sigaction_invoke(struct sigaction *action,
+                      struct qemu_signalfd_siginfo *info)
+{
+    siginfo_t si = { 0 };
+    si.si_signo = info->ssi_signo;
+    si.si_errno = info->ssi_errno;
+    si.si_code = info->ssi_code;
+
+    /* Convert the minimal set of fields defined by POSIX.
+     * Positive si_code values are reserved for kernel-generated
+     * signals, where the valid siginfo fields are determined by
+     * the signal number.  But according to POSIX, it is unspecified
+     * whether SI_USER and SI_QUEUE have values less than or equal to
+     * zero.
+     */
+    if (info->ssi_code == SI_USER || info->ssi_code == SI_QUEUE ||
+        info->ssi_code <= 0) {
+        /* SIGTERM, etc.  */
+        si.si_pid = info->ssi_pid;
+        si.si_uid = info->ssi_uid;
+    } else if (info->ssi_signo == SIGILL || info->ssi_signo == SIGFPE ||
+               info->ssi_signo == SIGSEGV || info->ssi_signo == SIGBUS) {
+        si.si_addr = (void *)(uintptr_t)info->ssi_addr;
+    } else if (info->ssi_signo == SIGCHLD) {
+        si.si_pid = info->ssi_pid;
+        si.si_status = info->ssi_status;
+        si.si_uid = info->ssi_uid;
+    } else if (info->ssi_signo == SIGPOLL) {
+        si.si_band = info->ssi_band;
+    }
+    action->sa_sigaction(info->ssi_signo, &si, NULL);
+}
-- 
1.8.3.1
