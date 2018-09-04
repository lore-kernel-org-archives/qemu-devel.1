Received: from eggs.gnu.org ([2001:4830:134:3::10]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DG-0001H2-26
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DD-0006Lh-OC
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:38 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:40788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fx9DD-0006L0-DJ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:35 -0400
From: Fei Li <fli@suse.com>
Date: Tue,  4 Sep 2018 19:08:18 +0800
Message-Id: <20180904110822.12863-2-fli@suse.com>
In-Reply-To: <20180904110822.12863-1-fli@suse.com>
References: <20180904110822.12863-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH 1/5] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fli@suse.com

Currently, when qemu_signal_init() fails it only returns a non-zero
value but without propagating any Error. But its callers need a
non-null err when runs error_report_err(err), or else 0->msg occurs.

To avoid such segmentation fault, add a new Error parameter to make
the call trace to propagate the err to the final caller.

Signed-off-by: Fei Li <fli@suse.com>
---
 include/qemu/osdep.h |  2 +-
 util/compatfd.c      | 17 ++++++++++++-----
 util/main-loop.c     | 11 +++++++----
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index a91068df0e..09ed85fcb8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -421,7 +421,7 @@ struct qemu_signalfd_siginfo {
                              additional fields in the future) */
 };
 
-int qemu_signalfd(const sigset_t *mask);
+int qemu_signalfd(const sigset_t *mask, Error **errp);
 void sigaction_invoke(struct sigaction *action,
                       struct qemu_signalfd_siginfo *info);
 #endif
diff --git a/util/compatfd.c b/util/compatfd.c
index 980bd33e52..65501de622 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
+#include "qapi/error.h"
 
 #include <sys/syscall.h>
 
@@ -65,7 +66,7 @@ static void *sigwait_compat(void *opaque)
     }
 }
 
-static int qemu_signalfd_compat(const sigset_t *mask)
+static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
 {
     struct sigfd_compat_info *info;
     QemuThread thread;
@@ -73,11 +74,13 @@ static int qemu_signalfd_compat(const sigset_t *mask)
 
     info = malloc(sizeof(*info));
     if (info == NULL) {
+        error_setg(errp, "Failed to malloc in %s", __func__);
         errno = ENOMEM;
         return -1;
     }
 
     if (pipe(fds) == -1) {
+        error_setg(errp, "Failed to create a pipe in %s", __func__);
         free(info);
         return -1;
     }
@@ -94,17 +97,21 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     return fds[0];
 }
 
-int qemu_signalfd(const sigset_t *mask)
+int qemu_signalfd(const sigset_t *mask, Error **errp)
 {
-#if defined(CONFIG_SIGNALFD)
     int ret;
+    Error *local_err = NULL;
 
+#if defined(CONFIG_SIGNALFD)
     ret = syscall(SYS_signalfd, -1, mask, _NSIG / 8);
     if (ret != -1) {
         qemu_set_cloexec(ret);
         return ret;
     }
 #endif
-
-    return qemu_signalfd_compat(mask);
+    ret = qemu_signalfd_compat(mask, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+    return ret;
 }
diff --git a/util/main-loop.c b/util/main-loop.c
index affe0403c5..20f6ad3849 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -71,10 +71,11 @@ static void sigfd_handler(void *opaque)
     }
 }
 
-static int qemu_signal_init(void)
+static int qemu_signal_init(Error **errp)
 {
     int sigfd;
     sigset_t set;
+    Error *local_err = NULL;
 
     /*
      * SIG_IPI must be blocked in the main thread and must not be caught
@@ -94,9 +95,10 @@ static int qemu_signal_init(void)
     pthread_sigmask(SIG_BLOCK, &set, NULL);
 
     sigdelset(&set, SIG_IPI);
-    sigfd = qemu_signalfd(&set);
+    sigfd = qemu_signalfd(&set, &local_err);
     if (sigfd == -1) {
         fprintf(stderr, "failed to create signalfd\n");
+        error_propagate(errp, local_err);
         return -errno;
     }
 
@@ -109,7 +111,7 @@ static int qemu_signal_init(void)
 
 #else /* _WIN32 */
 
-static int qemu_signal_init(void)
+static int qemu_signal_init(Error **errp)
 {
     return 0;
 }
@@ -148,8 +150,9 @@ int qemu_init_main_loop(Error **errp)
 
     init_clocks(qemu_timer_notify_cb);
 
-    ret = qemu_signal_init();
+    ret = qemu_signal_init(&local_error);
     if (ret) {
+        error_propagate(errp, local_error);
         return ret;
     }
 
-- 
2.13.7
