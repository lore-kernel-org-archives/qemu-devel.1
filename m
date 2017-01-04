Received: from eggs.gnu.org ([2001:4830:134:3::10]:52453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli5-0007kR-TR
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli3-0000mF-Ja
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOli3-0000lq-DW
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:06 +0000
Message-Id: <20170104133414.6524-7-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 06/14] linux-aio: poll ring for completions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The Linux AIO userspace ABI includes a ring that is shared with the
kernel.  This allows userspace programs to process completions without
system calls.

Add an AioContext poll handler to check for completions in the ring.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-6-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/linux-aio.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index 69c4ed5..03ab741 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -255,6 +255,20 @@ static void qemu_laio_completion_cb(EventNotifier *e)
     }
 }
 
+static bool qemu_laio_poll_cb(void *opaque)
+{
+    EventNotifier *e = opaque;
+    LinuxAioState *s = container_of(e, LinuxAioState, e);
+    struct io_event *events;
+
+    if (!io_getevents_peek(s->ctx, &events)) {
+        return false;
+    }
+
+    qemu_laio_process_completions_and_submit(s);
+    return true;
+}
+
 static void laio_cancel(BlockAIOCB *blockacb)
 {
     struct qemu_laiocb *laiocb = (struct qemu_laiocb *)blockacb;
@@ -448,7 +462,8 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context)
     s->aio_context = new_context;
     s->completion_bh = aio_bh_new(new_context, qemu_laio_completion_bh, s);
     aio_set_event_notifier(new_context, &s->e, false,
-                           qemu_laio_completion_cb, NULL);
+                           qemu_laio_completion_cb,
+                           qemu_laio_poll_cb);
 }
 
 LinuxAioState *laio_init(void)
-- 
2.9.3
