Received: from eggs.gnu.org ([2001:4830:134:3::10]:54406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZ3I-0001VF-UU
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZ3F-0004wD-9T
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:00 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:44396 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dAZ3E-0004u4-Rc
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:45:57 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 May 2017 12:45:29 +0300
Message-Id: <20170516094533.6160-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170516094533.6160-1-vsementsov@virtuozzo.com>
References: <20170516094533.6160-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/5] nbd: strict nbd_wr_syncv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

nbd_wr_syncv is called either from coroutine or from client negotiation
code, when socket is in blocking mode. So, -EAGAIN is impossible.

Furthermore, EAGAIN is confusing, as, what to read/write again? With
EAGAIN as a return code we don't know how much data is already
read or written by the function, so in case of EAGAIN the whole
communication is broken.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/nbd/common.c b/nbd/common.c
index dccbb8e9de..4db45b3ede 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -20,6 +20,10 @@
 #include "qapi/error.h"
 #include "nbd-internal.h"
 
+/* nbd_wr_syncv
+ * The function may be called from coroutine or from non-coroutine context.
+ * When called from non-coroutine context @ioc must be in blocking mode.
+ */
 ssize_t nbd_wr_syncv(QIOChannel *ioc,
                      struct iovec *iov,
                      size_t niov,
@@ -42,11 +46,8 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
             len = qio_channel_writev(ioc, local_iov, nlocal_iov, &local_err);
         }
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            if (qemu_in_coroutine()) {
-                qio_channel_yield(ioc, do_read ? G_IO_IN : G_IO_OUT);
-            } else {
-                return -EAGAIN;
-            }
+            assert(qemu_in_coroutine());
+            qio_channel_yield(ioc, do_read ? G_IO_IN : G_IO_OUT);
             continue;
         }
         if (len < 0) {
-- 
2.11.1
