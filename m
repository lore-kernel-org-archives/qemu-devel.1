Received: from eggs.gnu.org ([2001:4830:134:3::10]:34540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt7-0003ay-2R
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt5-0001So-UV
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dSSt5-0001SL-Lt
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:27 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  4 Jul 2017 19:49:14 +0100
Message-Id: <20170704184915.31586-5-dgilbert@redhat.com>
In-Reply-To: <20170704184915.31586-1-dgilbert@redhat.com>
References: <20170704184915.31586-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] migration/rdma: Safely convert control
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

control_desc[] is an array of strings that correspond to a
series of message types; they're used only for error messages, but if
the message type is seriously broken then we could go off the end of
the array.

Convert the array to a function control_desc() that bound checks.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 54 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 7273ae9929..bfb0a43740 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -165,20 +165,6 @@ enum {
     RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
 };
 
-static const char *control_desc[] = {
-    [RDMA_CONTROL_NONE] = "NONE",
-    [RDMA_CONTROL_ERROR] = "ERROR",
-    [RDMA_CONTROL_READY] = "READY",
-    [RDMA_CONTROL_QEMU_FILE] = "QEMU FILE",
-    [RDMA_CONTROL_RAM_BLOCKS_REQUEST] = "RAM BLOCKS REQUEST",
-    [RDMA_CONTROL_RAM_BLOCKS_RESULT] = "RAM BLOCKS RESULT",
-    [RDMA_CONTROL_COMPRESS] = "COMPRESS",
-    [RDMA_CONTROL_REGISTER_REQUEST] = "REGISTER REQUEST",
-    [RDMA_CONTROL_REGISTER_RESULT] = "REGISTER RESULT",
-    [RDMA_CONTROL_REGISTER_FINISHED] = "REGISTER FINISHED",
-    [RDMA_CONTROL_UNREGISTER_REQUEST] = "UNREGISTER REQUEST",
-    [RDMA_CONTROL_UNREGISTER_FINISHED] = "UNREGISTER FINISHED",
-};
 
 /*
  * Memory and MR structures used to represent an IB Send/Recv work request.
@@ -251,6 +237,30 @@ typedef struct QEMU_PACKED RDMADestBlock {
     uint32_t padding;
 } RDMADestBlock;
 
+static const char *control_desc(unsigned int rdma_control)
+{
+    static const char *strs[] = {
+        [RDMA_CONTROL_NONE] = "NONE",
+        [RDMA_CONTROL_ERROR] = "ERROR",
+        [RDMA_CONTROL_READY] = "READY",
+        [RDMA_CONTROL_QEMU_FILE] = "QEMU FILE",
+        [RDMA_CONTROL_RAM_BLOCKS_REQUEST] = "RAM BLOCKS REQUEST",
+        [RDMA_CONTROL_RAM_BLOCKS_RESULT] = "RAM BLOCKS RESULT",
+        [RDMA_CONTROL_COMPRESS] = "COMPRESS",
+        [RDMA_CONTROL_REGISTER_REQUEST] = "REGISTER REQUEST",
+        [RDMA_CONTROL_REGISTER_RESULT] = "REGISTER RESULT",
+        [RDMA_CONTROL_REGISTER_FINISHED] = "REGISTER FINISHED",
+        [RDMA_CONTROL_UNREGISTER_REQUEST] = "UNREGISTER REQUEST",
+        [RDMA_CONTROL_UNREGISTER_FINISHED] = "UNREGISTER FINISHED",
+    };
+
+    if (rdma_control > RDMA_CONTROL_UNREGISTER_FINISHED) {
+        return "??BAD CONTROL VALUE??";
+    }
+
+    return strs[rdma_control];
+}
+
 static uint64_t htonll(uint64_t v)
 {
     union { uint32_t lv[2]; uint64_t llv; } u;
@@ -1632,7 +1642,7 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
                                    .num_sge = 1,
                                 };
 
-    trace_qemu_rdma_post_send_control(control_desc[head->type]);
+    trace_qemu_rdma_post_send_control(control_desc(head->type));
 
     /*
      * We don't actually need to do a memcpy() in here if we used
@@ -1711,16 +1721,16 @@ static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
     network_to_control((void *) rdma->wr_data[idx].control);
     memcpy(head, rdma->wr_data[idx].control, sizeof(RDMAControlHeader));
 
-    trace_qemu_rdma_exchange_get_response_start(control_desc[expecting]);
+    trace_qemu_rdma_exchange_get_response_start(control_desc(expecting));
 
     if (expecting == RDMA_CONTROL_NONE) {
-        trace_qemu_rdma_exchange_get_response_none(control_desc[head->type],
+        trace_qemu_rdma_exchange_get_response_none(control_desc(head->type),
                                              head->type);
     } else if (head->type != expecting || head->type == RDMA_CONTROL_ERROR) {
         error_report("Was expecting a %s (%d) control message"
                 ", but got: %s (%d), length: %d",
-                control_desc[expecting], expecting,
-                control_desc[head->type], head->type, head->len);
+                control_desc(expecting), expecting,
+                control_desc(head->type), head->type, head->len);
         if (head->type == RDMA_CONTROL_ERROR) {
             rdma->received_error = true;
         }
@@ -1830,7 +1840,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
             }
         }
 
-        trace_qemu_rdma_exchange_send_waiting(control_desc[resp->type]);
+        trace_qemu_rdma_exchange_send_waiting(control_desc(resp->type));
         ret = qemu_rdma_exchange_get_response(rdma, resp,
                                               resp->type, RDMA_WRID_DATA);
 
@@ -1842,7 +1852,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
         if (resp_idx) {
             *resp_idx = RDMA_WRID_DATA;
         }
-        trace_qemu_rdma_exchange_send_received(control_desc[resp->type]);
+        trace_qemu_rdma_exchange_send_received(control_desc(resp->type));
     }
 
     rdma->control_ready_expected = 1;
@@ -3392,7 +3402,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
             ret = -EIO;
             goto out;
         default:
-            error_report("Unknown control message %s", control_desc[head.type]);
+            error_report("Unknown control message %s", control_desc(head.type));
             ret = -EIO;
             goto out;
         }
-- 
2.13.0
