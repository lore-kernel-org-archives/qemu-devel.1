Received: from eggs.gnu.org ([2001:4830:134:3::10]:49200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fmfaC-0003Md-RL
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fmfaB-0008IC-OE
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:30:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:33953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fmfaB-0008I0-GB
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:29:59 -0400
Received: by mail-pg1-x535.google.com with SMTP id y5-v6so6251375pgv.1
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 06:29:59 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Mon,  6 Aug 2018 21:29:34 +0800
Message-Id: <1533562177-16447-9-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v6 08/11] migration: implement the shutdown for
 RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

Because RDMA QIOChannel not implement shutdown function,
If the to_dst_file was set error, the return path thread
will wait forever. and the migration thread will wait
return path thread exit.

the backtrace of return path thread is:

(gdb) bt
    #0  0x00007f372a76bb0f in ppoll () from /lib64/libc.so.6
    #1  0x000000000071dc24 in qemu_poll_ns (fds=0x7ef7091d0580, nfds=2, timeout=100000000)
        at qemu-timer.c:325
    #2  0x00000000006b2fba in qemu_rdma_wait_comp_channel (rdma=0xd424000)
        at migration/rdma.c:1501
    #3  0x00000000006b3191 in qemu_rdma_block_for_wrid (rdma=0xd424000, wrid_requested=4000,
        byte_len=0x7ef7091d0640) at migration/rdma.c:1580
    #4  0x00000000006b3638 in qemu_rdma_exchange_get_response (rdma=0xd424000,
        head=0x7ef7091d0720, expecting=3, idx=0) at migration/rdma.c:1726
    #5  0x00000000006b3ad6 in qemu_rdma_exchange_recv (rdma=0xd424000, head=0x7ef7091d0720,
        expecting=3) at migration/rdma.c:1903
    #6  0x00000000006b5d03 in qemu_rdma_get_buffer (opaque=0x6a57dc0, buf=0x5c80030 "", pos=8,
        size=32768) at migration/rdma.c:2714
    #7  0x00000000006a9635 in qemu_fill_buffer (f=0x5c80000) at migration/qemu-file.c:232
    #8  0x00000000006a9ecd in qemu_peek_byte (f=0x5c80000, offset=0)
        at migration/qemu-file.c:502
    #9  0x00000000006a9f1f in qemu_get_byte (f=0x5c80000) at migration/qemu-file.c:515
    #10 0x00000000006aa162 in qemu_get_be16 (f=0x5c80000) at migration/qemu-file.c:591
    #11 0x00000000006a46d3 in source_return_path_thread (
        opaque=0xd826a0 <current_migration.37100>) at migration/migration.c:1331
    #12 0x00007f372aa49e25 in start_thread () from /lib64/libpthread.so.0
    #13 0x00007f372a77635d in clone () from /lib64/libc.so.6

the backtrace of migration thread is:

(gdb) bt
    #0  0x00007f372aa4af57 in pthread_join () from /lib64/libpthread.so.0
    #1  0x00000000007d5711 in qemu_thread_join (thread=0xd826f8 <current_migration.37100+88>)
        at util/qemu-thread-posix.c:504
    #2  0x00000000006a4bc5 in await_return_path_close_on_source (
        ms=0xd826a0 <current_migration.37100>) at migration/migration.c:1460
    #3  0x00000000006a53e4 in migration_completion (s=0xd826a0 <current_migration.37100>,
        current_active_state=4, old_vm_running=0x7ef7089cf976, start_time=0x7ef7089cf980)
        at migration/migration.c:1695
    #4  0x00000000006a5c54 in migration_thread (opaque=0xd826a0 <current_migration.37100>)
        at migration/migration.c:1837
    #5  0x00007f372aa49e25 in start_thread () from /lib64/libpthread.so.0
    #6  0x00007f372a77635d in clone () from /lib64/libc.so.6

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 673f126..1affc46 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3039,6 +3039,45 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
     return 0;
 }
 
+static int
+qio_channel_rdma_shutdown(QIOChannel *ioc,
+                            QIOChannelShutdown how,
+                            Error **errp)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    RDMAContext *rdmain, *rdmaout;
+
+    rcu_read_lock();
+
+    rdmain = atomic_rcu_read(&rioc->rdmain);
+    rdmaout = atomic_rcu_read(&rioc->rdmain);
+
+    switch (how) {
+    case QIO_CHANNEL_SHUTDOWN_READ:
+        if (rdmain) {
+            rdmain->error_state = -1;
+        }
+        break;
+    case QIO_CHANNEL_SHUTDOWN_WRITE:
+        if (rdmaout) {
+            rdmaout->error_state = -1;
+        }
+        break;
+    case QIO_CHANNEL_SHUTDOWN_BOTH:
+    default:
+        if (rdmain) {
+            rdmain->error_state = -1;
+        }
+        if (rdmaout) {
+            rdmaout->error_state = -1;
+        }
+        break;
+    }
+
+    rcu_read_unlock();
+    return 0;
+}
+
 /*
  * Parameters:
  *    @offset == 0 :
@@ -3865,6 +3904,7 @@ static void qio_channel_rdma_class_init(ObjectClass *klass,
     ioc_klass->io_close = qio_channel_rdma_close;
     ioc_klass->io_create_watch = qio_channel_rdma_create_watch;
     ioc_klass->io_set_aio_fd_handler = qio_channel_rdma_set_aio_fd_handler;
+    ioc_klass->io_shutdown = qio_channel_rdma_shutdown;
 }
 
 static const TypeInfo qio_channel_rdma_info = {
-- 
1.8.3.1
