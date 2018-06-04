Received: from eggs.gnu.org ([2001:4830:134:3::10]:47509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0a-0004TA-3Z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0Y-00078s-Vd
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPh0Y-00078d-PS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:14 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  4 Jun 2018 06:21:56 +0200
Message-Id: <20180604042156.13812-6-quintela@redhat.com>
In-Reply-To: <20180604042156.13812-1-quintela@redhat.com>
References: <20180604042156.13812-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] migration: not wait
 RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

When cancel migration during RDMA precopy, the source qemu main thread hangs sometime.

The backtrace is:
    (gdb) bt
    #0  0x00007f249eabd43d in write () from /lib64/libpthread.so.0
    #1  0x00007f24a1ce98e4 in rdma_get_cm_event (channel=0x4675d10, event=0x7ffe2f643dd0) at src/cma.c:2189
    #2  0x00000000007b6166 in qemu_rdma_cleanup (rdma=0x6784000) at migration/rdma.c:2296
    #3  0x00000000007b7cae in qio_channel_rdma_close (ioc=0x3bfcc30, errp=0x0) at migration/rdma.c:2999
    #4  0x00000000008db60e in qio_channel_close (ioc=0x3bfcc30, errp=0x0) at io/channel.c:273
    #5  0x00000000007a8765 in channel_close (opaque=0x3bfcc30) at migration/qemu-file-channel.c:98
    #6  0x00000000007a71f9 in qemu_fclose (f=0x527c000) at migration/qemu-file.c:334
    #7  0x0000000000795b96 in migrate_fd_cleanup (opaque=0x3b46280) at migration/migration.c:1162
    #8  0x000000000093a71b in aio_bh_call (bh=0x3db7a20) at util/async.c:90
    #9  0x000000000093a7b2 in aio_bh_poll (ctx=0x3b121c0) at util/async.c:118
    #10 0x000000000093f2ad in aio_dispatch (ctx=0x3b121c0) at util/aio-posix.c:436
    #11 0x000000000093ab41 in aio_ctx_dispatch (source=0x3b121c0, callback=0x0, user_data=0x0)
        at util/async.c:261
    #12 0x00007f249f73c7aa in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
    #13 0x000000000093dc5e in glib_pollfds_poll () at util/main-loop.c:215
    #14 0x000000000093dd4e in os_host_main_loop_wait (timeout=28000000) at util/main-loop.c:263
    #15 0x000000000093de05 in main_loop_wait (nonblocking=0) at util/main-loop.c:522
    #16 0x00000000005bc6a5 in main_loop () at vl.c:1944
    #17 0x00000000005c39b5 in main (argc=56, argv=0x7ffe2f6443f8, envp=0x3ad0030) at vl.c:4752

It does not get the RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect sometime.

According to IB Spec once active side send DREQ message, it should wait for DREP message
and only once it arrived it should trigger a DISCONNECT event. DREP message can be dropped
due to network issues.
For that case the spec defines a DREP_timeout state in the CM state machine, if the DREP is
dropped we should get a timeout and a TIMEWAIT_EXIT event will be trigger.
Unfortunately the current kernel CM implementation doesn't include the DREP_timeout state
and in above scenario we will not get DISCONNECT or TIMEWAIT_EXIT events.

So it should not invoke rdma_get_cm_event which may hang forever, and the event channel
is also destroyed in qemu_rdma_cleanup.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c       | 12 ++----------
 migration/trace-events |  1 -
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 60779221b1..05aee3d591 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2267,8 +2267,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
 
 static void qemu_rdma_cleanup(RDMAContext *rdma)
 {
-    struct rdma_cm_event *cm_event;
-    int ret, idx;
+    int idx;
 
     if (rdma->cm_id && rdma->connected) {
         if ((rdma->error_state ||
@@ -2282,14 +2281,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
             qemu_rdma_post_send_control(rdma, NULL, &head);
         }
 
-        ret = rdma_disconnect(rdma->cm_id);
-        if (!ret) {
-            trace_qemu_rdma_cleanup_waiting_for_disconnect();
-            ret = rdma_get_cm_event(rdma->channel, &cm_event);
-            if (!ret) {
-                rdma_ack_cm_event(cm_event);
-            }
-        }
+        rdma_disconnect(rdma->cm_id);
         trace_qemu_rdma_cleanup_disconnect();
         rdma->connected = false;
     }
diff --git a/migration/trace-events b/migration/trace-events
index 3c798ddd11..4a768eaaeb 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -146,7 +146,6 @@ qemu_rdma_accept_pin_state(bool pin) "%d"
 qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
 qemu_rdma_block_for_wrid_miss(const char *wcompstr, int wcomp, const char *gcompstr, uint64_t req) "A Wanted wrid %s (%d) but got %s (%" PRIu64 ")"
 qemu_rdma_cleanup_disconnect(void) ""
-qemu_rdma_cleanup_waiting_for_disconnect(void) ""
 qemu_rdma_close(void) ""
 qemu_rdma_connect_pin_all_requested(void) ""
 qemu_rdma_connect_pin_all_outcome(bool pin) "%d"
-- 
2.17.0
