Received: from eggs.gnu.org ([2001:4830:134:3::10]:50842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugh-0003mr-0I
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugd-0000Hj-RC
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:31 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45270)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugd-0000HK-FR
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:27 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:26:27 +0300
Message-ID: <20171031112627.10516.92024.stgit@pasha-VirtualBox>
In-Reply-To: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 16/26] replay: make locking visible outside
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

The replay_mutex_lock/unlock/locked functions are now going to be used
for ensuring lock-step behaviour between the two threads. Make them
public API functions and also provide stubs for non-QEMU builds on
common paths.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 include/sysemu/replay.h  |   14 ++++++++++++++
 replay/replay-internal.c |    5 ++---
 replay/replay-internal.h |    5 ++---
 stubs/replay.c           |   15 +++++++++++++++
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index b86d6bb..9973849 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -47,6 +47,20 @@ extern ReplayMode replay_mode;
 /* Name of the initial VM snapshot */
 extern char *replay_snapshot;
=20
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
=20
 /*! Enables recording or saving event log with specified parameters */
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 157c863..e6b2fdb 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -181,7 +181,7 @@ void replay_mutex_destroy(void)
=20
 static __thread bool replay_locked;
=20
-static bool replay_mutex_locked(void)
+bool replay_mutex_locked(void)
 {
     return replay_locked;
 }
@@ -204,7 +204,7 @@ void replay_mutex_unlock(void)
 void replay_save_instructions(void)
 {
     if (replay_file && replay_mode =3D=3D REPLAY_MODE_RECORD) {
-        replay_mutex_lock();
+        g_assert(replay_mutex_locked());
         int diff =3D (int)(replay_get_current_step() - replay_state.curr=
ent_step);
=20
         /* Time can only go forward */
@@ -215,6 +215,5 @@ void replay_save_instructions(void)
             replay_put_dword(diff);
             replay_state.current_step +=3D diff;
         }
-        replay_mutex_unlock();
     }
 }
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 8e4c701..f5f8e96 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -100,12 +100,11 @@ int64_t replay_get_qword(void);
 void replay_get_array(uint8_t *buf, size_t *size);
 void replay_get_array_alloc(uint8_t **buf, size_t *size);
=20
-/* Mutex functions for protecting replay log file */
+/* Mutex functions for protecting replay log file and ensuring
+ * synchronisation between vCPU and main-loop threads. */
=20
 void replay_mutex_init(void);
 void replay_mutex_destroy(void);
-void replay_mutex_lock(void);
-void replay_mutex_unlock(void);
=20
 /*! Checks error status of the file. */
 void replay_check_error(void);
diff --git a/stubs/replay.c b/stubs/replay.c
index 9991ee5..cb050ef 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -73,3 +73,18 @@ uint64_t blkreplay_next_id(void)
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
