Received: from eggs.gnu.org ([2001:4830:134:3::10]:59188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwO-0006lG-7H
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwM-0002ht-LT
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwM-0002hj-G8
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 077D8406E8D1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:54:00 +0100
Message-Id: <20180316115403.4148-13-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 12/15] migration: Transmit initial package
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

--

Be network agnostic.
Add error checking for all values.
---
 migration/ram.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 55af077abc..dd77c78016 100644
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
@@ -395,6 +397,16 @@ static void compress_threads_save_setup(void)
 
 /* Multiple fd's */
 
+#define MULTIFD_MAGIC 0x11223344U
+#define MULTIFD_VERSION 1
+
+typedef struct {
+    uint32_t magic;
+    uint32_t version;
+    unsigned char uuid[16]; /* QemuUUID */
+    uint8_t id;
+} __attribute__((packed)) MultiFDInit_t;
+
 struct MultiFDSendParams {
     uint8_t id;
     char *name;
@@ -408,6 +420,65 @@ struct MultiFDSendParams {
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
 
+static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
+{
+    MultiFDInit_t msg;
+    int ret;
+
+    msg.magic = cpu_to_be32(MULTIFD_MAGIC);
+    msg.version = cpu_to_be32(MULTIFD_VERSION);
+    msg.id = p->id;
+    memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
+
+    ret = qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp);
+    if (ret != 0) {
+        return -1;
+    }
+    return 0;
+}
+
+static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
+{
+    MultiFDInit_t msg;
+    int ret;
+
+    ret = qio_channel_read_all(c, (char *)&msg, sizeof(msg), errp);
+    if (ret != 0) {
+        return -1;
+    }
+
+    be32_to_cpus(&msg.magic);
+    be32_to_cpus(&msg.version);
+
+    if (msg.magic != MULTIFD_MAGIC) {
+        error_setg(errp, "multifd: recevied packet magic %d "
+                   "expected %d", msg.magic, MULTIFD_MAGIC);
+        return -1;
+    }
+
+    if (msg.version != MULTIFD_VERSION) {
+        error_setg(errp, "multifd: recevied packet version %d "
+                   "expected %d", msg.version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
+        char *uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
+        error_setg(errp, "multifd: received uuid '%s' and expected "
+                   "uuid '%s' for channel %hhd", msg.uuid, uuid, msg.id);
+        g_free(uuid);
+        return -1;
+    }
+
+    if (msg.id > migrate_multifd_channels()) {
+        error_setg(errp, "multifd: recevied channel version %d "
+                   "expected %d", msg.version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    return msg.id;
+}
+
 struct {
     MultiFDSendParams *params;
     /* number of created threads */
@@ -507,9 +578,15 @@ static void multifd_send_sync_main(void)
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
+    Error *local_err = NULL;
 
     trace_multifd_send_thread_start(p->id);
 
+    if (multifd_send_initial_packet(p, &local_err) < 0) {
+        multifd_send_terminate_threads(local_err);
+        return NULL;
+    }
+
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
@@ -754,12 +831,22 @@ bool multifd_recv_all_channels_created(void)
 void multifd_recv_new_channel(QIOChannel *ioc)
 {
     MultiFDRecvParams *p;
-    /* we need to invent channels id's until we transmit */
-    /* we will remove this on a later patch */
-    static int i;
+    Error *local_err = NULL;
+    int id;
 
-    p = &multifd_recv_state->params[i];
-    i++;
+    id = multifd_recv_initial_packet(ioc, &local_err);
+    if (id < 0) {
+        multifd_recv_terminate_threads(local_err);
+        return;
+    }
+
+    p = &multifd_recv_state->params[id];
+    if (p->c != NULL) {
+        error_setg(&local_err, "multifd: received id '%d' already setup'",
+                   id);
+        multifd_recv_terminate_threads(local_err);
+        return;
+    }
     p->c = ioc;
     object_ref(OBJECT(ioc));
 
-- 
2.14.3
