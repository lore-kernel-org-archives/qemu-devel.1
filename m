Received: from eggs.gnu.org ([2001:4830:134:3::10]:40408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fNxeQ-0000Xb-82
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fNxeO-0006sp-6F
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:14 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:44726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fNxeO-0006sh-0O
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:12 -0400
Received: by mail-pg0-x230.google.com with SMTP id p21-v6so7899040pgd.11
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 02:44:11 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Wed, 30 May 2018 17:43:32 +0800
Message-Id: <1527673416-31268-9-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
References: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v4 08/12] migration: implement
 io_set_aio_fd_handler function for RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com, aviadye@mellanox.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

if qio_channel_rdma_readv return QIO_CHANNEL_ERR_BLOCK, the destination qemu
crash.

The backtrace is:
(gdb) bt
    #0  0x0000000000000000 in ?? ()
    #1  0x00000000008db50e in qio_channel_set_aio_fd_handler (ioc=0x38111e0, ctx=0x3726080,
        io_read=0x8db841 <qio_channel_restart_read>, io_write=0x0, opaque=0x38111e0) at io/channel.c:
    #2  0x00000000008db952 in qio_channel_set_aio_fd_handlers (ioc=0x38111e0) at io/channel.c:438
    #3  0x00000000008dbab4 in qio_channel_yield (ioc=0x38111e0, condition=G_IO_IN) at io/channel.c:47
    #4  0x00000000007a870b in channel_get_buffer (opaque=0x38111e0, buf=0x440c038 "", pos=0, size=327
        at migration/qemu-file-channel.c:83
    #5  0x00000000007a70f6 in qemu_fill_buffer (f=0x440c000) at migration/qemu-file.c:299
    #6  0x00000000007a79d0 in qemu_peek_byte (f=0x440c000, offset=0) at migration/qemu-file.c:562
    #7  0x00000000007a7a22 in qemu_get_byte (f=0x440c000) at migration/qemu-file.c:575
    #8  0x00000000007a7c78 in qemu_get_be32 (f=0x440c000) at migration/qemu-file.c:655
    #9  0x00000000007a0508 in qemu_loadvm_state (f=0x440c000) at migration/savevm.c:2126
    #10 0x0000000000794141 in process_incoming_migration_co (opaque=0x0) at migration/migration.c:366
    #11 0x000000000095c598 in coroutine_trampoline (i0=84033984, i1=0) at util/coroutine-ucontext.c:1
    #12 0x00007f9c0db56d40 in ?? () from /lib64/libc.so.6
    #13 0x00007f96fe858760 in ?? ()
    #14 0x0000000000000000 in ?? ()

RDMA QIOChannel not implement io_set_aio_fd_handler. so
qio_channel_set_aio_fd_handler will access NULL pointer.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 92e4d30..dfa4f77 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2963,6 +2963,21 @@ static GSource *qio_channel_rdma_create_watch(QIOChannel *ioc,
     return source;
 }
 
+static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
+                                                  AioContext *ctx,
+                                                  IOHandler *io_read,
+                                                  IOHandler *io_write,
+                                                  void *opaque)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    if (io_read) {
+        aio_set_fd_handler(ctx, rioc->rdmain->comp_channel->fd,
+                           false, io_read, io_write, NULL, opaque);
+    } else {
+        aio_set_fd_handler(ctx, rioc->rdmaout->comp_channel->fd,
+                           false, io_read, io_write, NULL, opaque);
+    }
+}
 
 static int qio_channel_rdma_close(QIOChannel *ioc,
                                   Error **errp)
@@ -3822,6 +3837,7 @@ static void qio_channel_rdma_class_init(ObjectClass *klass,
     ioc_klass->io_set_blocking = qio_channel_rdma_set_blocking;
     ioc_klass->io_close = qio_channel_rdma_close;
     ioc_klass->io_create_watch = qio_channel_rdma_create_watch;
+    ioc_klass->io_set_aio_fd_handler = qio_channel_rdma_set_aio_fd_handler;
 }
 
 static const TypeInfo qio_channel_rdma_info = {
-- 
1.8.3.1
