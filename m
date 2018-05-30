Received: from eggs.gnu.org ([2001:4830:134:3::10]:40466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fNxeX-0000cD-36
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fNxeS-0006uP-Fh
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:21 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:41051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fNxeS-0006uD-A4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:16 -0400
Received: by mail-pf0-x243.google.com with SMTP id v63-v6so8745120pfk.8
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 02:44:16 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Wed, 30 May 2018 17:43:34 +0800
Message-Id: <1527673416-31268-11-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
References: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v4 10/12] migration: create a dedicated thread
 to release rdma resource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com, aviadye@mellanox.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

ibv_dereg_mr wait for a long time for big memory size virtual server.

The test result is:
  10GB  326ms
  20GB  699ms
  30GB  1021ms
  40GB  1387ms
  50GB  1712ms
  60GB  2034ms
  70GB  2457ms
  80GB  2807ms
  90GB  3107ms
  100GB 3474ms
  110GB 3735ms
  120GB 4064ms
  130GB 4567ms
  140GB 4886ms

this will cause the guest os hang for a while when migration finished.
So create a dedicated thread to release rdma resource.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/rdma.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index dfa4f77..1b9e261 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2979,12 +2979,12 @@ static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
     }
 }
 
-static int qio_channel_rdma_close(QIOChannel *ioc,
-                                  Error **errp)
+static void *qio_channel_rdma_close_thread(void *arg)
 {
-    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    QIOChannelRDMA *rioc = arg;
     RDMAContext *rdmain, *rdmaout;
-    trace_qemu_rdma_close();
+
+    rcu_register_thread();
 
     rdmain = rioc->rdmain;
     if (rdmain) {
@@ -3009,6 +3009,19 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
     g_free(rdmain);
     g_free(rdmaout);
 
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static int qio_channel_rdma_close(QIOChannel *ioc,
+                                  Error **errp)
+{
+    QemuThread t;
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    trace_qemu_rdma_close();
+
+    qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close_thread,
+                           rioc, QEMU_THREAD_DETACHED);
     return 0;
 }
 
-- 
1.8.3.1
