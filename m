Received: from eggs.gnu.org ([2001:4830:134:3::10]:57728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZj-0004rC-BF
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZh-00073z-V2
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJZh-00073B-P4
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:34 +0000
Message-Id: <20171219151144.11120-14-stefanha@redhat.com>
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 13/23] iothread: add iothread_by_id() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Encapsulate IOThread QOM object lookup so that callers don't need to
know how and where IOThread objects live.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171206144550.22295-8-stefanha@redhat.com
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
