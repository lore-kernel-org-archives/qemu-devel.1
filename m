Received: from eggs.gnu.org ([2001:4830:134:3::10]:58700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDK-0004km-7I
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDJ-0001Rq-13
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDI-0001RW-RX
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BB24F1207
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:49 +0200
Message-Id: <20180509112406.6183-25-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 24/41] migration: new cmd MIG_CMD_RECV_BITMAP
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

From: Peter Xu <peterx@redhat.com>

Add a new vm command MIG_CMD_RECV_BITMAP to request received bitmap for
one ramblock.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-12-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c     | 61 ++++++++++++++++++++++++++++++++++++++++++
 migration/savevm.h     |  1 +
 migration/trace-events |  2 ++
 3 files changed, 64 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6ee69d8283..9f4a95d411 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -81,6 +81,7 @@ enum qemu_vm_cmd {
                                       were previously sent during
                                       precopy but are dirty. */
     MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
+    MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
     MIG_CMD_MAX
 };
 
@@ -98,6 +99,7 @@ static struct mig_cmd_args {
     [MIG_CMD_POSTCOPY_RAM_DISCARD] = {
                                    .len = -1, .name = "POSTCOPY_RAM_DISCARD" },
     [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
+    [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
 };
 
@@ -956,6 +958,19 @@ void qemu_savevm_send_postcopy_run(QEMUFile *f)
     qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_RUN, 0, NULL);
 }
 
+void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
+{
+    size_t len;
+    char buf[256];
+
+    trace_savevm_send_recv_bitmap(block_name);
+
+    buf[0] = len = strlen(block_name);
+    memcpy(buf + 1, block_name, len);
+
+    qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
+}
+
 bool qemu_savevm_state_blocked(Error **errp)
 {
     SaveStateEntry *se;
@@ -1801,6 +1816,49 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     return ret;
 }
 
+/*
+ * Handle request that source requests for recved_bitmap on
+ * destination. Payload format:
+ *
+ * len (1 byte) + ramblock_name (<255 bytes)
+ */
+static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
+                                     uint16_t len)
+{
+    QEMUFile *file = mis->from_src_file;
+    RAMBlock *rb;
+    char block_name[256];
+    size_t cnt;
+
+    cnt = qemu_get_counted_string(file, block_name);
+    if (!cnt) {
+        error_report("%s: failed to read block name", __func__);
+        return -EINVAL;
+    }
+
+    /* Validate before using the data */
+    if (qemu_file_get_error(file)) {
+        return qemu_file_get_error(file);
+    }
+
+    if (len != cnt + 1) {
+        error_report("%s: invalid payload length (%d)", __func__, len);
+        return -EINVAL;
+    }
+
+    rb = qemu_ram_block_by_name(block_name);
+    if (!rb) {
+        error_report("%s: block '%s' not found", __func__, block_name);
+        return -EINVAL;
+    }
+
+    /* TODO: send the bitmap back to source */
+
+    trace_loadvm_handle_recv_bitmap(block_name);
+
+    return 0;
+}
+
 /*
  * Process an incoming 'QEMU_VM_COMMAND'
  * 0           just a normal return
@@ -1874,6 +1932,9 @@ static int loadvm_process_command(QEMUFile *f)
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         return loadvm_postcopy_ram_handle_discard(mis, len);
+
+    case MIG_CMD_RECV_BITMAP:
+        return loadvm_handle_recv_bitmap(mis, len);
     }
 
     return 0;
diff --git a/migration/savevm.h b/migration/savevm.h
index cf4f0d37ca..b8cee00d41 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -47,6 +47,7 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
 void qemu_savevm_send_postcopy_advise(QEMUFile *f);
 void qemu_savevm_send_postcopy_listen(QEMUFile *f);
 void qemu_savevm_send_postcopy_run(QEMUFile *f);
+void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
 
 void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint16_t len,
diff --git a/migration/trace-events b/migration/trace-events
index 7f836499d1..5bee6d525a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -12,6 +12,7 @@ loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
 loadvm_handle_cmd_packaged_main(int ret) "%d"
 loadvm_handle_cmd_packaged_received(int ret) "%d"
+loadvm_handle_recv_bitmap(char *s) "%s"
 loadvm_postcopy_handle_advise(void) ""
 loadvm_postcopy_handle_listen(void) ""
 loadvm_postcopy_handle_run(void) ""
@@ -34,6 +35,7 @@ savevm_send_open_return_path(void) ""
 savevm_send_ping(uint32_t val) "0x%x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
+savevm_send_recv_bitmap(char *name) "%s"
 savevm_state_setup(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
-- 
2.17.0
