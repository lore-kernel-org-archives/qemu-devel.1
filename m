Received: from eggs.gnu.org ([2001:4830:134:3::10]:41009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1je-0007Tt-Kk
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jd-0002Sl-3p
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:38 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jc-0002SJ-U7
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:37 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so11632635wmr.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:18 +0100
Message-Id: <20170113131731.1246-4-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/16] test-thread-pool: use generic AioContext
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

Once the thread pool starts using aio_co_wake, it will also need
qemu_get_current_aio_context().  Make test-thread-pool create
an AioContext with qemu_init_main_loop, so that stubs/iothread.c
and tests/iothread.c can provide the rest.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-thread-pool.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tests/test-thread-pool.c b/tests/test-thread-pool.c
index 8dbf66a..91b4ec5 100644
--- a/tests/test-thread-pool.c
+++ b/tests/test-thread-pool.c
@@ -6,6 +6,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 
 static AioContext *ctx;
 static ThreadPool *pool;
@@ -224,15 +225,9 @@ static void test_cancel_async(void)
 int main(int argc, char **argv)
 {
     int ret;
-    Error *local_error = NULL;
 
-    init_clocks();
-
-    ctx = aio_context_new(&local_error);
-    if (!ctx) {
-        error_reportf_err(local_error, "Failed to create AIO Context: ");
-        exit(1);
-    }
+    qemu_init_main_loop(&error_abort);
+    ctx = qemu_get_current_aio_context();
     pool = aio_get_thread_pool(ctx);
 
     g_test_init(&argc, &argv, NULL);
@@ -245,6 +240,5 @@ int main(int argc, char **argv)
 
     ret = g_test_run();
 
-    aio_context_unref(ctx);
     return ret;
 }
-- 
2.9.3
