Received: from eggs.gnu.org ([2001:4830:134:3::10]:54846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMAgI-0002k5-JA
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMAgH-0002l4-Rm
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:42:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Dec 2017 10:41:39 +0000
Message-Id: <20171205104141.28882-8-stefanha@redhat.com>
In-Reply-To: <20171205104141.28882-1-stefanha@redhat.com>
References: <20171205104141.28882-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] iothread: add iothread_by_id() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Encapsulate IOThread QOM object lookup so that callers don't need to
know how and where IOThread objects live.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h | 1 +
 iothread.c                | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 110329b2b4..55de1715c7 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -42,6 +42,7 @@ typedef struct {
    OBJECT_CHECK(IOThread, obj, TYPE_IOTHREAD)
 
 char *iothread_get_id(IOThread *iothread);
+IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 void iothread_stop_all(void);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
diff --git a/iothread.c b/iothread.c
index 27a4288578..e7b93e02a3 100644
--- a/iothread.c
+++ b/iothread.c
@@ -380,3 +380,10 @@ void iothread_destroy(IOThread *iothread)
 {
     object_unparent(OBJECT(iothread));
 }
+
+/* Lookup IOThread by its id.  Only finds user-created objects, not internal
+ * iothread_create() objects. */
+IOThread *iothread_by_id(const char *id)
+{
+    return IOTHREAD(object_resolve_path_type(id, TYPE_IOTHREAD, NULL));
+}
-- 
2.14.3
