Received: from eggs.gnu.org ([2001:4830:134:3::10]:57267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ7-0006g1-Kt
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ6-00072T-Lf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:05 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SJ6-00071s-FU
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:04 -0400
Received: by mail-wm0-x242.google.com with SMTP id h76so15483410wme.4
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:37:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:41 +0200
Message-Id: <1522071403-52486-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/16] iothread: fix breakage on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

OOB can enable iothread for parsing even on Windows.  We need some tunes
to enable that on Windows otherwise it'll break Windows users.  This
patch fixes the breakage on Windows with qemu-system-ppc.exe.

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180322085630.23654-1-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 iothread.c       | 4 ++++
 util/aio-win32.c | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/iothread.c b/iothread.c
index 1b3463c..e675c38 100644
--- a/iothread.c
+++ b/iothread.c
@@ -31,11 +31,15 @@ typedef ObjectClass IOThreadClass;
 #define IOTHREAD_CLASS(klass) \
    OBJECT_CLASS_CHECK(IOThreadClass, klass, TYPE_IOTHREAD)
 
+#ifdef CONFIG_POSIX
 /* Benchmark results from 2016 on NVMe SSD drives show max polling times around
  * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
  * workloads.
  */
 #define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
+#else
+#define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
+#endif
 
 static __thread IOThread *my_iothread;
 
diff --git a/util/aio-win32.c b/util/aio-win32.c
index d6d5e02..a67b00c 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -410,5 +410,7 @@ void aio_context_setup(AioContext *ctx)
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
-    error_setg(errp, "AioContext polling is not implemented on Windows");
+    if (max_ns) {
+        error_setg(errp, "AioContext polling is not implemented on Windows");
+    }
 }
-- 
1.8.3.1
