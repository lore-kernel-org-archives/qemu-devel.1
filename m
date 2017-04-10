Received: from eggs.gnu.org ([2001:4830:134:3::10]:34393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxatg-0003Xo-4z
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxatf-00028K-3X
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:06:28 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Apr 2017 23:05:36 +0800
Message-Id: <20170410150542.30376-5-famz@redhat.com>
In-Reply-To: <20170410150542.30376-1-famz@redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9 v3 04/10] coroutine: Extract
 qemu_aio_coroutine_enter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

It's a variant of qemu_coroutine_enter with an explicit AioContext
parameter.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/coroutine.h |  5 +++++
 util/qemu-coroutine.c    | 11 ++++++++---
 util/trace-events        |  2 +-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e60beaf..a4509bd 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -77,6 +77,11 @@ void qemu_coroutine_enter(Coroutine *coroutine);
 void qemu_coroutine_enter_if_inactive(Coroutine *co);
 
 /**
+ * Transfer control to a coroutine and associate it with ctx
+ */
+void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co);
+
+/**
  * Transfer control back to a coroutine's caller
  *
  * This function does not return until the coroutine is re-entered using
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 72412e5..486af9a 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -102,12 +102,12 @@ static void coroutine_delete(Coroutine *co)
     qemu_coroutine_delete(co);
 }
 
-void qemu_coroutine_enter(Coroutine *co)
+void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
 {
     Coroutine *self = qemu_coroutine_self();
     CoroutineAction ret;
 
-    trace_qemu_coroutine_enter(self, co, co->entry_arg);
+    trace_qemu_aio_coroutine_enter(ctx, self, co, co->entry_arg);
 
     if (co->caller) {
         fprintf(stderr, "Co-routine re-entered recursively\n");
@@ -115,7 +115,7 @@ void qemu_coroutine_enter(Coroutine *co)
     }
 
     co->caller = self;
-    co->ctx = qemu_get_current_aio_context();
+    co->ctx = ctx;
 
     /* Store co->ctx before anything that stores co.  Matches
      * barrier in aio_co_wake and qemu_co_mutex_wake.
@@ -139,6 +139,11 @@ void qemu_coroutine_enter(Coroutine *co)
     }
 }
 
+void qemu_coroutine_enter(Coroutine *co)
+{
+    qemu_aio_coroutine_enter(qemu_get_current_aio_context(), co);
+}
+
 void qemu_coroutine_enter_if_inactive(Coroutine *co)
 {
     if (!qemu_coroutine_entered(co)) {
diff --git a/util/trace-events b/util/trace-events
index ac27d94..b44ef4f 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -22,7 +22,7 @@ buffer_move(const char *buf, size_t len, const char *from) "%s: %zd bytes from %
 buffer_free(const char *buf, size_t len) "%s: capacity %zd"
 
 # util/qemu-coroutine.c
-qemu_coroutine_enter(void *from, void *to, void *opaque) "from %p to %p opaque %p"
+qemu_aio_coroutine_enter(void *ctx, void *from, void *to, void *opaque) "ctx %p from %p to %p opaque %p"
 qemu_coroutine_yield(void *from, void *to) "from %p to %p"
 qemu_coroutine_terminate(void *co) "self %p"
 
-- 
2.9.3
