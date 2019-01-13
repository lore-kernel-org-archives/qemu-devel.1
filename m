Received: from eggs.gnu.org ([209.51.188.92]:39995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRj-0002tz-Kg
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRi-000300-Rc
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:03 -0500
Received: from m50-110.126.com ([123.125.50.110]:42735)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRi-0002vO-8o
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:02 -0500
From: Fei Li <lifei1214@126.com>
Date: Sun, 13 Jan 2019 22:08:45 +0800
Message-Id: <20190113140849.38339-2-lifei1214@126.com>
In-Reply-To: <20190113140849.38339-1-lifei1214@126.com>
References: <20190113140849.38339-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 1/5] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Fei Li <fli@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Fei Li <fli@suse.com>

When qemu_signal_init() fails in qemu_init_main_loop(), we return
without setting an error.  Its callers crash then when they try to
report the error with error_report_err().

To avoid such segmentation fault, add a new Error parameter to make
the call trace to propagate the err to the final caller.

Fixes: 2f78e491d7b46542158ce0b8132ee4e05bc0ade4
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 util/main-loop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/main-loop.c b/util/main-loop.c
index affe0403c5..443cb4cfe8 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -71,7 +71,7 @@ static void sigfd_handler(void *opaque)
     }
 }
 
-static int qemu_signal_init(void)
+static int qemu_signal_init(Error **errp)
 {
     int sigfd;
     sigset_t set;
@@ -96,7 +96,7 @@ static int qemu_signal_init(void)
     sigdelset(&set, SIG_IPI);
     sigfd = qemu_signalfd(&set);
     if (sigfd == -1) {
-        fprintf(stderr, "failed to create signalfd\n");
+        error_setg_errno(errp, errno, "failed to create signalfd");
         return -errno;
     }
 
@@ -109,7 +109,7 @@ static int qemu_signal_init(void)
 
 #else /* _WIN32 */
 
-static int qemu_signal_init(void)
+static int qemu_signal_init(Error **errp)
 {
     return 0;
 }
@@ -148,7 +148,7 @@ int qemu_init_main_loop(Error **errp)
 
     init_clocks(qemu_timer_notify_cb);
 
-    ret = qemu_signal_init();
+    ret = qemu_signal_init(errp);
     if (ret) {
         return ret;
     }
-- 
2.17.2 (Apple Git-113)
