Received: from eggs.gnu.org ([2001:4830:134:3::10]:59760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoO-00052h-MJ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoN-0006If-R0
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoN-0006IS-MB
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33D70EBFE6
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 12:00:04 +0100
Message-Id: <20180307110010.2205-19-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 18/24] migration: Add multifd traces for
 start/end thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 6 ++++++
 migration/trace-events | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 0266bd200c..b57d9fd667 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -492,6 +492,8 @@ static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
 
+    trace_multifd_send_thread_start(p->id);
+
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
@@ -507,6 +509,7 @@ static void *multifd_send_thread(void *opaque)
         }
         qemu_mutex_unlock(&p->mutex);
     }
+    trace_multifd_send_thread_end(p->id);
 
     return NULL;
 }
@@ -642,6 +645,8 @@ static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
 
+    trace_multifd_recv_thread_start(p->id);
+
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
@@ -658,6 +663,7 @@ static void *multifd_recv_thread(void *opaque)
         qemu_mutex_unlock(&p->mutex);
     }
 
+    trace_multifd_recv_thread_end(p->id);
     return NULL;
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 76075c26bc..db88fa699f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -79,6 +79,10 @@ ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
 multifd_send_sync_main(void) ""
 multifd_recv_sync_main(void) ""
+multifd_send_thread_start(int id) "%d"
+multifd_send_thread_end(int id) "%d"
+multifd_recv_thread_start(int id) "%d"
+multifd_recv_thread_end(int id) "%d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
