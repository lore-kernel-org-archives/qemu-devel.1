Received: from eggs.gnu.org ([2001:4830:134:3::10]:33609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzq-0000LB-Sj
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzp-0000mh-Ib
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dUSzp-0000lJ-BG
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AC25C057FAB
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:20:40 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Jul 2017 15:20:24 +0800
Message-Id: <20170710072027.7948-3-famz@redhat.com>
In-Reply-To: <20170710072027.7948-1-famz@redhat.com>
References: <20170710072027.7948-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/5] iothread: Don't error on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

aio_context_set_poll_params is called unconditionally from iothread
initialization code and the contract is that if max_ns == 0 polling is
disabled, or otherwise windows reports and error. The current default
being non-zero will always make win32 to exit on an "-object iothread"
option, which is not nice.

Default to zero on windows and keep going.

(While we are at it, move the definition to the header, because it will
be shared with iothread-group.)

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/sysemu/iothread.h | 12 ++++++++++++
 iothread.c                |  6 ------
 util/aio-win32.c          |  4 +++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index eecfc19..37f033b 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -39,4 +39,16 @@ char *iothread_get_id(IOThread *iothread);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 void iothread_stop_all(void);
 
+#ifndef _WIN32
+/* Benchmark results from 2016 on NVMe SSD drives show max polling times around
+ * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
+ * workloads.
+ */
+#define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
+#else
+/* Our aio implementation on Windows doesn't support polling, don't enable it
+ * by default. */
+#define IOTHREAD_POLL_MAX_NS_DEFAULT 0
+#endif
+
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index f5a01bb..ce56724 100644
--- a/iothread.c
+++ b/iothread.c
@@ -30,12 +30,6 @@ typedef ObjectClass IOThreadClass;
 #define IOTHREAD_CLASS(klass) \
    OBJECT_CLASS_CHECK(IOThreadClass, klass, TYPE_IOTHREAD)
 
-/* Benchmark results from 2016 on NVMe SSD drives show max polling times around
- * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
- * workloads.
- */
-#define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
-
 static __thread IOThread *my_iothread;
 
 AioContext *qemu_get_current_aio_context(void)
diff --git a/util/aio-win32.c b/util/aio-win32.c
index d8a1b20..3d2de11 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -403,5 +403,7 @@ void aio_context_setup(AioContext *ctx)
 void aio_context_set_poll_params(AioContext *ctx, AioContextPollParams params,
                                  Error **errp)
 {
-    error_setg(errp, "AioContext polling is not implemented on Windows");
+    if (params.max_ns) {
+        error_setg(errp, "AioContext polling is not implemented on Windows");
+    }
 }
-- 
2.9.4
