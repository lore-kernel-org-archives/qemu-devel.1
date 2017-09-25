Received: from eggs.gnu.org ([2001:4830:134:3::10]:52174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwN1b-0004S1-Jb
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 02:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwN1a-00052T-RA
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 02:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwN1a-00051v-Lu
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 02:37:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B830381E11
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:37:49 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 25 Sep 2017 14:37:27 +0800
Message-Id: <1506321449-24013-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1506321449-24013-1-git-send-email-peterx@redhat.com>
References: <1506321449-24013-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] iothread: provide helpers for internal
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

IOThread is a general framework that contains IO loop environment and a
real thread behind.  It's also good to be used internally inside qemu.
Provide some helpers for it to create iothreads to be used internally.

Put all the internal used iothreads into the internal object container.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/iothread.h |  8 ++++++++
 iothread.c                | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index d2985b3..b07663f 100644
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
index 44c8944..33f996e 100644
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
2.7.4
