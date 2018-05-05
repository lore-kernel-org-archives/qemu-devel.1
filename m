Received: from eggs.gnu.org ([2001:4830:134:3::10]:58414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyIF-0008Qs-BB
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyIC-000896-7A
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:11 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fEyIC-00087t-1U
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:08 -0400
Received: by mail-pf0-x242.google.com with SMTP id f189so19575124pfa.7
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 07:36:07 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  5 May 2018 22:35:33 +0800
Message-Id: <1525530936-21835-4-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
References: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/6] migration: remove unnecessary variables
 len in QIOChannelRDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

Because qio_channel_rdma_writev and qio_channel_rdma_readv maybe invoked
by different threads concurrently, this patch removes unnecessary variables
len in QIOChannelRDMA and use local variable instead.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrangéberrange@redhat.com>
---
 migration/rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c745427..f5c1d02 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -404,7 +404,6 @@ struct QIOChannelRDMA {
     QIOChannel parent;
     RDMAContext *rdma;
     QEMUFile *file;
-    size_t len;
     bool blocking; /* XXX we don't actually honour this yet */
 };
 
@@ -2640,6 +2639,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
     int ret;
     ssize_t done = 0;
     size_t i;
+    size_t len = 0;
 
     CHECK_ERROR_STATE();
 
@@ -2659,10 +2659,10 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         while (remaining) {
             RDMAControlHeader head;
 
-            rioc->len = MIN(remaining, RDMA_SEND_INCREMENT);
-            remaining -= rioc->len;
+            len = MIN(remaining, RDMA_SEND_INCREMENT);
+            remaining -= len;
 
-            head.len = rioc->len;
+            head.len = len;
             head.type = RDMA_CONTROL_QEMU_FILE;
 
             ret = qemu_rdma_exchange_send(rdma, &head, data, NULL, NULL, NULL);
@@ -2672,8 +2672,8 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
                 return ret;
             }
 
-            data += rioc->len;
-            done += rioc->len;
+            data += len;
+            done += len;
         }
     }
 
@@ -2768,8 +2768,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
             }
         }
     }
-    rioc->len = done;
-    return rioc->len;
+    return done;
 }
 
 /*
-- 
1.8.3.1
