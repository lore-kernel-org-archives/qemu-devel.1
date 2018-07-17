Received: from eggs.gnu.org ([2001:4830:134:3::10]:57885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffN5E-0007Nv-Eo
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffN5B-00033S-8b
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:19:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ffN5B-00032z-27
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:19:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EED07D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 10:19:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 17 Jul 2018 11:19:44 +0100
Message-Id: <20180717101944.11691-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3] trace/simple: fix hang in child after
 fork(2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>

The simple trace backend spawns a write-out thread which is used to
asynchronously flush the in-memory ring buffer to disk.

fork(2) does not clone all threads, only the thread that invoked
fork(2).  As a result there is no write-out thread in the child process!

This causes a hang during shutdown when atexit(3) handler installed by
the simple trace backend waits for the non-existent write-out thread.

This patch uses pthread_atfork(3) to terminate the write-out thread
before fork and restart it in both the parent and child after fork.
This solves a hang in qemu-iotests 147 due to qemu-nbd --fork usage.

Reported-by: Cornelia Huck <cohuck@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v3:
 * Hold trace_lock across fork() to prevent possibility of another
   thread holding it and disappearing [Paolo]

 trace/simple.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/trace/simple.c b/trace/simple.c
index 701dec639c..a4300b6ff1 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -39,9 +39,11 @@
 static GMutex trace_lock;
 static GCond trace_available_cond;
 static GCond trace_empty_cond;
+static GThread *trace_writeout_thread;
 
 static bool trace_available;
 static bool trace_writeout_enabled;
+static bool trace_writeout_running;
 
 enum {
     TRACE_BUF_LEN = 4096 * 64,
@@ -142,15 +144,34 @@ static void flush_trace_file(bool wait)
     g_mutex_unlock(&trace_lock);
 }
 
-static void wait_for_trace_records_available(void)
+/**
+ * Wait to be kicked by flush_trace_file()
+ *
+ * Returns: true if the writeout thread should continue
+ *          false if the writeout thread should terminate
+ */
+static bool wait_for_trace_records_available(void)
 {
+    bool running;
+
     g_mutex_lock(&trace_lock);
-    while (!(trace_available && trace_writeout_enabled)) {
+    for (;;) {
+        running = trace_writeout_running;
+        if (!running) {
+            break;
+        }
+
+        if (trace_available && trace_writeout_enabled) {
+            break;
+        }
+
         g_cond_signal(&trace_empty_cond);
         g_cond_wait(&trace_available_cond, &trace_lock);
     }
     trace_available = false;
     g_mutex_unlock(&trace_lock);
+
+    return running;
 }
 
 static gpointer writeout_thread(gpointer opaque)
@@ -165,9 +186,7 @@ static gpointer writeout_thread(gpointer opaque)
     size_t unused __attribute__ ((unused));
     uint64_t type = TRACE_RECORD_TYPE_EVENT;
 
-    for (;;) {
-        wait_for_trace_records_available();
-
+    while (wait_for_trace_records_available()) {
         if (g_atomic_int_get(&dropped_events)) {
             dropped.rec.event = DROPPED_EVENT_ID,
             dropped.rec.timestamp_ns = get_clock();
@@ -398,18 +417,61 @@ static GThread *trace_thread_create(GThreadFunc fn)
     return thread;
 }
 
+#ifndef _WIN32
+static void stop_writeout_thread(void)
+{
+    g_mutex_lock(&trace_lock);
+    trace_writeout_running = false;
+    g_cond_signal(&trace_available_cond);
+    g_mutex_unlock(&trace_lock);
+
+    g_thread_join(trace_writeout_thread);
+    trace_writeout_thread = NULL;
+
+    /* Hold trace_lock across fork!  Since threads aren't cloned by fork() the
+     * mutex would be held in the child process and cause a deadlock.
+     * Acquiring the mutex here prevents other threads from being in a
+     * trace_lock critical region when fork() occurs.
+     */
+    g_mutex_lock(&trace_lock);
+}
+
+static void restart_writeout_thread(void)
+{
+    trace_writeout_running = true;
+    trace_writeout_thread = trace_thread_create(writeout_thread);
+    if (!trace_writeout_thread) {
+        warn_report("unable to initialize simple trace backend");
+    }
+
+    /* This relies on undefined behavior in the fork() child (it's fine in the
+     * fork() parent).  g_mutex_unlock() on a mutex acquired by another thread
+     * is undefined (see glib documentation).
+     */
+    g_mutex_unlock(&trace_lock);
+}
+#endif /* !_WIN32 */
+
 bool st_init(void)
 {
-    GThread *thread;
-
     trace_pid = getpid();
+    trace_writeout_running = true;
 
-    thread = trace_thread_create(writeout_thread);
-    if (!thread) {
+    trace_writeout_thread = trace_thread_create(writeout_thread);
+    if (!trace_writeout_thread) {
         warn_report("unable to initialize simple trace backend");
         return false;
     }
 
+#ifndef _WIN32
+    /* Terminate writeout thread across fork and restart it in parent and
+     * child afterwards.
+     */
+    pthread_atfork(stop_writeout_thread,
+                   restart_writeout_thread,
+                   restart_writeout_thread);
+#endif
+
     atexit(st_flush_trace_buffer);
     return true;
 }
-- 
2.17.1
