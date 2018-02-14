Received: from eggs.gnu.org ([2001:4830:134:3::10]:54000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA7-0008Mt-5S
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA4-00078s-E9
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elzA4-00078J-09
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:56 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Feb 2018 15:39:37 +0000
Message-Id: <20180214153938.5410-10-dgilbert@redhat.com>
In-Reply-To: <20180214153938.5410-1-dgilbert@redhat.com>
References: <20180214153938.5410-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] migration: allow send_rq to fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com

From: Peter Xu <peterx@redhat.com>

We will not allow failures to happen when sending data from destination
to source via the return path. However it is possible that there can be
errors along the way.  This patch allows the migrate_send_rp_message()
to return error when it happens, and further extended it to
migrate_send_rp_req_pages().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180208103132.28452-9-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 35 ++++++++++++++++++++++++++++-------
 migration/migration.h |  2 +-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e2a5a832c6..913f658c3e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -205,17 +205,35 @@ static void deferred_incoming_migration(Error **errp)
  * Send a message on the return channel back to the source
  * of the migration.
  */
-static void migrate_send_rp_message(MigrationIncomingState *mis,
-                                    enum mig_rp_message_type message_type,
-                                    uint16_t len, void *data)
+static int migrate_send_rp_message(MigrationIncomingState *mis,
+                                   enum mig_rp_message_type message_type,
+                                   uint16_t len, void *data)
 {
+    int ret = 0;
+
     trace_migrate_send_rp_message((int)message_type, len);
     qemu_mutex_lock(&mis->rp_mutex);
+
+    /*
+     * It's possible that the file handle got lost due to network
+     * failures.
+     */
+    if (!mis->to_src_file) {
+        ret = -EIO;
+        goto error;
+    }
+
     qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
     qemu_put_be16(mis->to_src_file, len);
     qemu_put_buffer(mis->to_src_file, data, len);
     qemu_fflush(mis->to_src_file);
+
+    /* It's possible that qemu file got error during sending */
+    ret = qemu_file_get_error(mis->to_src_file);
+
+error:
     qemu_mutex_unlock(&mis->rp_mutex);
+    return ret;
 }
 
 /* Request a range of pages from the source VM at the given
@@ -225,11 +243,12 @@ static void migrate_send_rp_message(MigrationIncomingState *mis,
  *   Start: Address offset within the RB
  *   Len: Length in bytes required - must be a multiple of pagesize
  */
-void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
-                               ram_addr_t start, size_t len)
+int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
+                              ram_addr_t start, size_t len)
 {
     uint8_t bufc[12 + 1 + 255]; /* start (8), len (4), rbname up to 256 */
     size_t msglen = 12; /* start + len */
+    enum mig_rp_message_type msg_type;
 
     *(uint64_t *)bufc = cpu_to_be64((uint64_t)start);
     *(uint32_t *)(bufc + 8) = cpu_to_be32((uint32_t)len);
@@ -241,10 +260,12 @@ void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
         bufc[msglen++] = rbname_len;
         memcpy(bufc + msglen, rbname, rbname_len);
         msglen += rbname_len;
-        migrate_send_rp_message(mis, MIG_RP_MSG_REQ_PAGES_ID, msglen, bufc);
+        msg_type = MIG_RP_MSG_REQ_PAGES_ID;
     } else {
-        migrate_send_rp_message(mis, MIG_RP_MSG_REQ_PAGES, msglen, bufc);
+        msg_type = MIG_RP_MSG_REQ_PAGES;
     }
+
+    return migrate_send_rp_message(mis, msg_type, msglen, bufc);
 }
 
 void qemu_start_incoming_migration(const char *uri, Error **errp)
diff --git a/migration/migration.h b/migration/migration.h
index 75c72d3c8f..f515b8994f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -230,7 +230,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
                           uint32_t value);
 void migrate_send_rp_pong(MigrationIncomingState *mis,
                           uint32_t value);
-void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
+int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 
 #endif
-- 
2.14.3
