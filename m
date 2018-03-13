Received: from eggs.gnu.org ([2001:4830:134:3::10]:58694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsij-0006Ne-Eo
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsii-0004AK-HW
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:37 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsii-00049c-9l
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:36 -0400
Received: by mail-wr0-x243.google.com with SMTP id o8so2599343wra.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:10 +0100
Message-Id: <20180313224719.4954-61-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 60/69] replay: make locking visible outside
 replay code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Alex Bennée <alex.bennee@linaro.org>

The replay_mutex_lock/unlock/locked functions are now going to be used
for ensuring lock-step behaviour between the two threads. Make them
public API functions and also provide stubs for non-QEMU builds on
common paths.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20180227095242.1060.16601.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/replay.h  | 13 +++++++++++++
 replay/replay-internal.c |  2 +-
 replay/replay-internal.h |  6 +++---
 stubs/replay.c           |  8 ++++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 401de12130..3ced6bc231 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -48,6 +48,19 @@ extern ReplayMode replay_mode;
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
+
 /* Replay process control functions */
 
 /*! Enables recording or saving event log with specified parameters */
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 0d7e1d6bc4..7cdefeaa04 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -181,7 +181,7 @@ void replay_mutex_destroy(void)
     qemu_mutex_destroy(&lock);
 }
 
-static bool replay_mutex_locked(void)
+bool replay_mutex_locked(void)
 {
     return replay_locked;
 }
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 8e4c701751..41eee66e9b 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -100,12 +100,12 @@ int64_t replay_get_qword(void);
 void replay_get_array(uint8_t *buf, size_t *size);
 void replay_get_array_alloc(uint8_t **buf, size_t *size);
 
-/* Mutex functions for protecting replay log file */
+/* Mutex functions for protecting replay log file and ensuring
+ * synchronisation between vCPU and main-loop threads. */
 
 void replay_mutex_init(void);
 void replay_mutex_destroy(void);
-void replay_mutex_lock(void);
-void replay_mutex_unlock(void);
+bool replay_mutex_locked(void);
 
 /*! Checks error status of the file. */
 void replay_check_error(void);
diff --git a/stubs/replay.c b/stubs/replay.c
index 9c8aa48c9c..04279abb2c 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -72,3 +72,11 @@ uint64_t blkreplay_next_id(void)
 {
     return 0;
 }
+
+void replay_mutex_lock(void)
+{
+}
+
+void replay_mutex_unlock(void)
+{
+}
-- 
2.14.3
