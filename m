Received: from eggs.gnu.org ([208.118.235.92]:33105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKl-0001Iq-B8
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKh-0003gB-Hl
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:23 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:33263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnKg-0003e9-8U
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:19 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:34 +0800
Message-Id: <20181225140449.15786-2-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v9 01/16] Fix segmentation fault when
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
Cc: lifei1214@126.com, Paolo Bonzini <pbonzini@redhat.com>

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
2.13.7
