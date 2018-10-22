Received: from eggs.gnu.org ([2001:4830:134:3::10]:43699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gEY5c-00013K-Hf
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gEY5Y-00016C-Fx
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:40 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:59286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gEY5W-0000wp-Mf
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:36 -0400
From: Fei Li <fli@suse.com>
Date: Mon, 22 Oct 2018 19:08:53 +0800
Message-Id: <20181022110854.10284-2-fli@suse.com>
In-Reply-To: <20181022110854.10284-1-fli@suse.com>
References: <20181022110854.10284-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC 1/2] migration: fix the multifd code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com

When multifd is used during migration, if there is an error before
the destination receives all new channels, the destination does not
exit but keeps waiting in our current code. However, a segmentaion
fault will occur in the source when multifd_save_cleanup() is called
again as the multifd_send_state has been freed earlier in the first
error handling.  This can happen when migrate_fd_connect() fails and
multifd_fd_cleanup() is called, and then multifd_new_send_channel_
async() fails and multifd_save_cleanup() is called again.

If the QIOChannel *c of multifd_recv_state->params[i] (p->c) is not
initialized, there is no need to close the channel. Or else a
segmentation fault will occur in multifd_recv_terminate_threads()
when multifd_recv_initial_packet() fails.

Signed-off-by: Fei Li <fli@suse.com>
---
 migration/ram.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7e7deec4d8..2dd873ba35 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -907,6 +907,11 @@ static void multifd_send_terminate_threads(Error *err)
         }
     }
 
+    /* in case multifd_send_state has been freed earlier */
+    if (!multifd_send_state) {
+        return;
+    }
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -922,7 +927,7 @@ int multifd_save_cleanup(Error **errp)
     int i;
     int ret = 0;
 
-    if (!migrate_use_multifd()) {
+    if (!migrate_use_multifd() || !multifd_send_state) {
         return 0;
     }
     multifd_send_terminate_threads(NULL);
@@ -1070,6 +1075,10 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *local_err = NULL;
 
+    if (!multifd_send_state) {
+        return;
+    }
+
     if (qio_task_propagate_error(task, &local_err)) {
         if (multifd_save_cleanup(&local_err) != 0) {
             migrate_set_error(migrate_get_current(), local_err);
@@ -1131,7 +1140,7 @@ struct {
     uint64_t packet_num;
 } *multifd_recv_state;
 
-static void multifd_recv_terminate_threads(Error *err)
+static void multifd_recv_terminate_threads(Error *err, bool channel)
 {
     int i;
 
@@ -1145,6 +1154,11 @@ static void multifd_recv_terminate_threads(Error *err)
         }
     }
 
+    /* in case p->c is not initialized */
+    if (!channel) {
+        return;
+    }
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -1166,7 +1180,7 @@ int multifd_load_cleanup(Error **errp)
     if (!migrate_use_multifd()) {
         return 0;
     }
-    multifd_recv_terminate_threads(NULL);
+    multifd_recv_terminate_threads(NULL, true);
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -1269,7 +1283,7 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     if (local_err) {
-        multifd_recv_terminate_threads(local_err);
+        multifd_recv_terminate_threads(local_err, true);
     }
     qemu_mutex_lock(&p->mutex);
     p->running = false;
@@ -1331,7 +1345,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
 
     id = multifd_recv_initial_packet(ioc, &local_err);
     if (id < 0) {
-        multifd_recv_terminate_threads(local_err);
+        multifd_recv_terminate_threads(local_err, false);
         return false;
     }
 
@@ -1339,7 +1353,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
     if (p->c != NULL) {
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
-        multifd_recv_terminate_threads(local_err);
+        multifd_recv_terminate_threads(local_err, true);
         return false;
     }
     p->c = ioc;
-- 
2.13.7
