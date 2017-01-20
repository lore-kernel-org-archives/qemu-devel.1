Received: from eggs.gnu.org ([2001:4830:134:3::10]:45275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHh-000302-N2
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHh-00037x-0G
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHg-00037B-RG
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:28 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC6A961E53
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:08 +0100
Message-Id: <20170120164322.21851-4-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/17] test-thread-pool: use generic AioContext
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
Cc: stefanha@redhat.com, famz@redhat.com

Once the thread pool starts using aio_co_wake, it will also need
qemu_get_current_aio_context().  Make test-thread-pool create
an AioContext with qemu_init_main_loop, so that stubs/iothread.c
and tests/iothread.c can provide the rest.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
