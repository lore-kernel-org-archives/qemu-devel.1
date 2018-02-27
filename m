Received: from eggs.gnu.org ([2001:4830:134:3::10]:39688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbwE-0001LU-QV
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbwA-00052G-T5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:52:46 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57444)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbwA-00051w-Fx
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:52:42 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 27 Feb 2018 12:52:42 +0300
Message-ID: <20180227095242.1060.16601.stgit@pasha-VirtualBox>
In-Reply-To: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
References: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 12/22] replay: make locking visible outside
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

The replay_mutex_lock/unlock/locked functions are now going to be used
for ensuring lock-step behaviour between the two threads. Make them
public API functions and also provide stubs for non-QEMU builds on
common paths.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

--

v7: - removed abort() from stubs to allow calling from utils
    - removed exported replay_mutex_locked()
---
 include/sysemu/replay.h  |   13 +++++++++++++
 replay/replay-internal.c |    2 +-
 replay/replay-internal.h |    6 +++---
 stubs/replay.c           |    8 ++++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 5462555..291bcbc 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -46,6 +46,19 @@ extern ReplayMode replay_mode;
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
+
 /* Replay process control functions */
=20
 /*! Enables recording or saving event log with specified parameters */
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 0d7e1d6..7cdefea 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -181,7 +181,7 @@ void replay_mutex_destroy(void)
     qemu_mutex_destroy(&lock);
 }
=20
-static bool replay_mutex_locked(void)
+bool replay_mutex_locked(void)
 {
     return replay_locked;
 }
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 8e4c701..41eee66 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -100,12 +100,12 @@ int64_t replay_get_qword(void);
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
+bool replay_mutex_locked(void);
=20
 /*! Checks error status of the file. */
 void replay_check_error(void);
diff --git a/stubs/replay.c b/stubs/replay.c
index 9991ee5..18ba0bb 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -73,3 +73,11 @@ uint64_t blkreplay_next_id(void)
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
