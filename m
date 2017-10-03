Received: from eggs.gnu.org ([2001:4830:134:3::10]:36658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzSce-0001n0-Hc
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzScd-0005gp-LO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dzScd-0005fP-Fa
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  3 Oct 2017 15:12:24 -0400
Message-Id: <20171003191227.11845-3-stefanha@redhat.com>
In-Reply-To: <20171003191227.11845-1-stefanha@redhat.com>
References: <20171003191227.11845-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] iothread: provide helpers for internal use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Peter Xu <peterx@redhat.com>

IOThread is a general framework that contains IO loop environment and a
real thread behind.  It's also good to be used internally inside qemu.
Provide some helpers for it to create iothreads to be used internally.

Put all the internal used iothreads into the internal object container.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-id: 20170928025958.1420-3-peterx@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h |  8 ++++++++
 iothread.c                | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index d2985b30ba..b07663f0a1 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -46,4 +46,12 @@ AioContext *iothread_get_aio_context(IOThread *iothread);
 void iothread_stop_all(void);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
+/*
+ * Helpers used to allocate iothreads for internal use.  These
+ * iothreads will not be seen by monitor clients when query using
+ * "query-iothreads".
+ */
+IOThread *iothread_create(const char *id, Error **errp);
+void iothread_destroy(IOThread *iothread);
+
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index 59d0850988..0672a9196f 100644
--- a/iothread.c
+++ b/iothread.c
@@ -354,3 +354,19 @@ GMainContext *iothread_get_g_main_context(IOThread *iothread)
 
     return iothread->worker_context;
 }
+
+IOThread *iothread_create(const char *id, Error **errp)
+{
+    Object *obj;
+
+    obj = object_new_with_props(TYPE_IOTHREAD,
+                                object_get_internal_root(),
+                                id, errp, NULL);
+
+    return IOTHREAD(obj);
+}
+
+void iothread_destroy(IOThread *iothread)
+{
+    object_unparent(OBJECT(iothread));
+}
-- 
2.13.6
