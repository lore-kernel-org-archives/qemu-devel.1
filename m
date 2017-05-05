Received: from eggs.gnu.org ([2001:4830:134:3::10]:52590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acQ-0001ld-Ko
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acP-0006kX-K1
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:50 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6acP-0006iW-Ej
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:49 -0400
Received: by mail-wm0-x230.google.com with SMTP id 142so2195248wma.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:37:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 May 2017 11:38:18 +0100
Message-Id: <20170505103822.20641-6-alex.bennee@linaro.org>
In-Reply-To: <20170505103822.20641-1-alex.bennee@linaro.org>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 5/9] replay: make locking visible
 outside replay code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The replay_mutex_lock/unlock/locked functions are now going to be used
for ensuring lock-step behaviour between the two threads. Make them
public API functions and also provide stubs for non-QEMU builds on
common paths.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/sysemu/replay.h  | 14 ++++++++++++++
 replay/replay-internal.c |  5 ++---
 replay/replay-internal.h |  5 ++---
 stubs/replay.c           | 15 +++++++++++++++
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index f1c0712795..08bffa2dc2 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -46,6 +46,20 @@ extern ReplayMode replay_mode;
 /* Name of the initial VM snapshot */
 extern char *replay_snapshot;
 
+/* Replay locking
+ *
+ * The locks are needed to protect the shared structures and log file
+ * when doing record/replay. They also are the main sync-point between
+ * the main-loop thread and the vCPU thread. This was a role
+ * previously filled by the BQL which has been busy trying to reduce
+ * its impact across the code. This ensures blocks of events stay
+ * sequential and reproducible.
+ */
+
+void replay_mutex_lock(void);
+void replay_mutex_unlock(void);
+bool replay_mutex_locked(void);
+
 /* Replay process control functions */
 
 /*! Enables recording or saving event log with specified parameters */
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 157c863e25..e6b2fdb6c1 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -181,7 +181,7 @@ void replay_mutex_destroy(void)
 
 static __thread bool replay_locked;
 
-static bool replay_mutex_locked(void)
+bool replay_mutex_locked(void)
 {
     return replay_locked;
 }
@@ -204,7 +204,7 @@ void replay_mutex_unlock(void)
 void replay_save_instructions(void)
 {
     if (replay_file && replay_mode == REPLAY_MODE_RECORD) {
-        replay_mutex_lock();
+        g_assert(replay_mutex_locked());
         int diff = (int)(replay_get_current_step() - replay_state.current_step);
 
         /* Time can only go forward */
@@ -215,6 +215,5 @@ void replay_save_instructions(void)
             replay_put_dword(diff);
             replay_state.current_step += diff;
         }
-        replay_mutex_unlock();
     }
 }
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index ed66ed803c..b0cf78f16f 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -97,12 +97,11 @@ int64_t replay_get_qword(void);
 void replay_get_array(uint8_t *buf, size_t *size);
 void replay_get_array_alloc(uint8_t **buf, size_t *size);
 
-/* Mutex functions for protecting replay log file */
+/* Mutex functions for protecting replay log file and ensuring
+ * synchronisation between vCPU and main-loop threads. */
 
 void replay_mutex_init(void);
 void replay_mutex_destroy(void);
-void replay_mutex_lock(void);
-void replay_mutex_unlock(void);
 
 /*! Checks error status of the file. */
 void replay_check_error(void);
diff --git a/stubs/replay.c b/stubs/replay.c
index 9c8aa48c9c..39c5746043 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -72,3 +72,18 @@ uint64_t blkreplay_next_id(void)
 {
     return 0;
 }
+
+void replay_mutex_lock(void)
+{
+    abort();
+}
+
+void replay_mutex_unlock(void)
+{
+    abort();
+}
+
+bool replay_mutex_locked(void)
+{
+    return false;
+}
-- 
2.11.0
