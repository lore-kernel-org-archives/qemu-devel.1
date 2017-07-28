Received: from eggs.gnu.org ([2001:4830:134:3::10]:47330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0Jc-0001NQ-JC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0Jb-0001Yv-Li
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0Jb-0001YC-Cy
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:07 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:30 +0800
Message-Id: <1501229198-30588-22-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 21/29] migration: new cmd MIG_CMD_RECV_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Add a new vm command MIG_CMD_RECV_BITMAP to request received bitmap for
one ramblock.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c     | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/savevm.h     |  1 +
 migration/trace-events |  1 +
 3 files changed, 61 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 386788d..0ab13c0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -78,6 +78,7 @@ enum qemu_vm_cmd {
                                       were previously sent during
                                       precopy but are dirty. */
     MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
+    MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
     MIG_CMD_MAX
 };
 
@@ -95,6 +96,7 @@ static struct mig_cmd_args {
     [MIG_CMD_POSTCOPY_RAM_DISCARD] = {
                                    .len = -1, .name = "POSTCOPY_RAM_DISCARD" },
     [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
+    [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
 };
 
@@ -929,6 +931,19 @@ void qemu_savevm_send_postcopy_run(QEMUFile *f)
     qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_RUN, 0, NULL);
 }
 
+void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
+{
+    size_t len;
+    char buf[512];
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
@@ -1705,6 +1720,47 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
 }
 
 /*
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
+    return 0;
+}
+
+/*
  * Process an incoming 'QEMU_VM_COMMAND'
  * 0           just a normal return
  * LOADVM_QUIT All good, but exit the loop
@@ -1777,6 +1833,9 @@ static int loadvm_process_command(QEMUFile *f)
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         return loadvm_postcopy_ram_handle_discard(mis, len);
+
+    case MIG_CMD_RECV_BITMAP:
+        return loadvm_handle_recv_bitmap(mis, len);
     }
 
     return 0;
diff --git a/migration/savevm.h b/migration/savevm.h
index 295c4a1..8126b1c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -46,6 +46,7 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
 void qemu_savevm_send_postcopy_advise(QEMUFile *f);
 void qemu_savevm_send_postcopy_listen(QEMUFile *f);
 void qemu_savevm_send_postcopy_run(QEMUFile *f);
+void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
 
 void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint16_t len,
diff --git a/migration/trace-events b/migration/trace-events
index dbb4971..ca7b43f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -34,6 +34,7 @@ savevm_send_open_return_path(void) ""
 savevm_send_ping(uint32_t val) "%x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
+savevm_send_recv_bitmap(char *name) "%s"
 savevm_state_setup(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
-- 
2.7.4
