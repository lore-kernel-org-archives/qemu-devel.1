Received: from eggs.gnu.org ([2001:4830:134:3::10]:59849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoV-00057S-1R
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoS-0006M6-10
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoR-0006Lm-S2
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C6F4D142B
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 12:00:07 +0100
Message-Id: <20180307110010.2205-22-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 21/24] migration: Transmit initial package
 through the multifd channels
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
 migration/ram.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1aab96bd5e..4efac0c20c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,6 +52,8 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "migration/block.h"
+#include "sysemu/sysemu.h"
+#include "qemu/uuid.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -491,12 +493,30 @@ static void multifd_send_sync_main(void)
     trace_multifd_send_sync_main();
 }
 
+typedef struct {
+    uint32_t version;
+    unsigned char uuid[16]; /* QemuUUID */
+    uint8_t id;
+} __attribute__((packed)) MultiFDInit_t;
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
+    MultiFDInit_t msg;
+    Error *local_err = NULL;
+    size_t ret;
 
     trace_multifd_send_thread_start(p->id);
 
+    msg.version = 1;
+    msg.id = p->id;
+    memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
+    ret = qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), &local_err);
+    if (ret != 0) {
+        terminate_multifd_send_threads(local_err);
+        return NULL;
+    }
+
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
@@ -730,12 +750,32 @@ bool multifd_recv_all_channels_created(void)
 void multifd_recv_new_channel(QIOChannel *ioc)
 {
     MultiFDRecvParams *p;
-    /* we need to invent channels id's until we transmit */
-    /* we will remove this on a later patch */
-    static int i = 0;
+    MultiFDInit_t msg;
+    Error *local_err = NULL;
+    size_t ret;
 
-    p = &multifd_recv_state->params[i];
-    i++;
+    ret = qio_channel_read_all(ioc, (char *)&msg, sizeof(msg), &local_err);
+    if (ret != 0) {
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
+
+    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
+        char *uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
+        error_setg(&local_err, "multifd: received uuid '%s' and expected "
+                   "uuid '%s' for channel %hhd", msg.uuid, uuid, msg.id);
+        g_free(uuid);
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
+
+    p = &multifd_recv_state->params[msg.id];
+    if (p->c != NULL) {
+        error_setg(&local_err, "multifd: received id '%d' already setup'",
+                   msg.id);
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
     p->c = ioc;
     socket_recv_channel_ref(ioc);
 
-- 
2.14.3
