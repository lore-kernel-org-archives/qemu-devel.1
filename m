Received: from eggs.gnu.org ([2001:4830:134:3::10]:43460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5siG-0004IE-QW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5siF-0000n5-LA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5siF-0000mf-GW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:27 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Apr 2018 20:49:13 +0800
Message-Id: <20180410124913.10832-3-peterx@redhat.com>
In-Reply-To: <20180410124913.10832-1-peterx@redhat.com>
References: <20180410124913.10832-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

cur_mon was only used in main loop so we don't really need that to be
per-thread variable.  Now it's possible that we have more than one
thread to operate on it.  Let's start to let it be per-thread variable.

In case we'll create threads within a valid cur_mon setup, we'd better
let the child threads to inherit the cur_mon from parent thread too.  Do
that for both posix and win32 threads.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/monitor/monitor.h   | 2 +-
 include/qemu/thread-win32.h | 1 +
 monitor.c                   | 2 +-
 stubs/monitor.c             | 2 +-
 tests/test-util-sockets.c   | 2 +-
 util/qemu-thread-posix.c    | 6 ++++++
 util/qemu-thread-win32.c    | 6 ++++++
 7 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index d6ab70cae2..2ef5e04b37 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -6,7 +6,7 @@
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
 
-extern Monitor *cur_mon;
+extern __thread Monitor *cur_mon;
 
 /* flags for monitor_init */
 /* 0x01 unused */
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index 3a05e3b3aa..f4d4cd96a1 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -39,6 +39,7 @@ typedef struct QemuThreadData QemuThreadData;
 struct QemuThread {
     QemuThreadData *data;
     unsigned tid;
+    Monitor *current_monitor;
 };
 
 /* Only valid for joinable threads.  */
diff --git a/monitor.c b/monitor.c
index 51f4cf480f..5035e42364 100644
--- a/monitor.c
+++ b/monitor.c
@@ -266,7 +266,7 @@ static mon_cmd_t info_cmds[];
 
 QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
-Monitor *cur_mon;
+__thread Monitor *cur_mon;
 
 static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
 
diff --git a/stubs/monitor.c b/stubs/monitor.c
index e018c8f594..3890771bb5 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -3,7 +3,7 @@
 #include "qemu-common.h"
 #include "monitor/monitor.h"
 
-Monitor *cur_mon = NULL;
+__thread Monitor *cur_mon;
 
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index acadd85e8f..6195a3ac36 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -69,7 +69,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
  * stubs/monitor.c is defined, to make sure monitor.o is discarded
  * otherwise we get duplicate syms at link time.
  */
-Monitor *cur_mon;
+__thread Monitor *cur_mon;
 void monitor_init(Chardev *chr, int flags) {}
 
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 3ae96210d6..8d13da1b09 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,6 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
+#include "monitor/monitor.h"
 #include "trace.h"
 
 static bool name_threads;
@@ -486,6 +487,7 @@ typedef struct {
     void *(*start_routine)(void *);
     void *arg;
     char *name;
+    Monitor *current_monitor;
 } QemuThreadArgs;
 
 static void *qemu_thread_start(void *args)
@@ -494,6 +496,9 @@ static void *qemu_thread_start(void *args)
     void *(*start_routine)(void *) = qemu_thread_args->start_routine;
     void *arg = qemu_thread_args->arg;
 
+    /* Inherit the cur_mon pointer from father thread */
+    cur_mon = qemu_thread_args->current_monitor;
+
     /* Attempt to set the threads name; note that this is for debug, so
      * we're not going to fail if we can't set it.
      */
@@ -533,6 +538,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     qemu_thread_args->name = g_strdup(name);
     qemu_thread_args->start_routine = start_routine;
     qemu_thread_args->arg = arg;
+    qemu_thread_args->current_monitor = cur_mon;
 
     err = pthread_create(&thread->thread, &attr,
                          qemu_thread_start, qemu_thread_args);
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index ab60c0d557..b5197dbc78 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -19,6 +19,7 @@
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
+#include "monitor/monitor.h"
 #include "trace.h"
 #include <process.h>
 
@@ -298,6 +299,7 @@ struct QemuThreadData {
     void             *arg;
     short             mode;
     NotifierList      exit;
+    Monitor          *current_monitor;
 
     /* Only used for joinable threads. */
     bool              exited;
@@ -339,6 +341,9 @@ static unsigned __stdcall win32_start_routine(void *arg)
     void *(*start_routine)(void *) = data->start_routine;
     void *thread_arg = data->arg;
 
+    /* Inherit the cur_mon pointer from father thread */
+    cur_mon = data->current_monitor;
+
     qemu_thread_data = data;
     qemu_thread_exit(start_routine(thread_arg));
     abort();
@@ -401,6 +406,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     data->arg = arg;
     data->mode = mode;
     data->exited = false;
+    data->current_monitor = cur_mon;
     notifier_list_init(&data->exit);
 
     if (data->mode != QEMU_THREAD_DETACHED) {
-- 
2.14.3
