Received: from eggs.gnu.org ([2001:4830:134:3::10]:59611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQV-0003QQ-WE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQV-0005ij-4N
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:08 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQU-0005iS-VV
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:07 -0400
Received: by mail-wm0-x241.google.com with SMTP id g15so11029266wmc.2
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:28 +0200
Message-Id: <1496320911-51305-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/33] nbd: strict nbd_wr_syncv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

nbd_wr_syncv is called either from coroutine or from client negotiation
code, when socket is in blocking mode. So, -EAGAIN is impossible.

Furthermore, EAGAIN is confusing, as, what to read/write again? With
EAGAIN as a return code we don't know how much data is already
read or written by the function, so in case of EAGAIN the whole
communication is broken.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170516094533.6160-2-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/nbd/common.c b/nbd/common.c
index dccbb8e..4db45b3 100644
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
1.8.3.1
