Received: from eggs.gnu.org ([2001:4830:134:3::10]:57120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CLB-0003z5-J3
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CLA-0006wy-Lt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:42:25 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42426)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CLA-0006w9-9C
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:42:24 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 04 May 2017 11:42:27 +0300
Message-ID: <20170504084227.7488.16343.stgit@PASHA-ISP>
In-Reply-To: <20170504084135.7488.24715.stgit@PASHA-ISP>
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v9 09/10] replay: save prior value of the host
 clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds saving/restoring of the host clock field 'last'.
It is used in host clock calculation and therefore clock may
become incorrect when using restored vmstate.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 include/qemu/timer.h     |   14 ++++++++++++++
 replay/replay-internal.h |    2 ++
 replay/replay-snapshot.c |    3 +++
 util/qemu-timer.c        |   12 ++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 8a1eb74839..5e9adbbf01 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -251,6 +251,20 @@ bool qemu_clock_run_timers(QEMUClockType type);
  */
 bool qemu_clock_run_all_timers(void);
 
+/**
+ * qemu_clock_get_last:
+ *
+ * Returns last clock query time.
+ */
+uint64_t qemu_clock_get_last(QEMUClockType type);
+/**
+ * qemu_clock_set_last:
+ *
+ * Sets last clock query time.
+ */
+void qemu_clock_set_last(QEMUClockType type, uint64_t last);
+
+
 /*
  * QEMUTimerList
  */
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index ed66ed803c..738983e76a 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -77,6 +77,8 @@ typedef struct ReplayState {
         This counter is global, because requests from different
         block devices should not get overlapping ids. */
     uint64_t block_request_id;
+    /*! Prior value of the host clock */
+    uint64_t host_clock_last;
 } ReplayState;
 extern ReplayState replay_state;
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 438d82ec33..1a0b76b9ca 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -24,12 +24,14 @@ static void replay_pre_save(void *opaque)
 {
     ReplayState *state = opaque;
     state->file_offset = ftell(replay_file);
+    state->host_clock_last = qemu_clock_get_last(QEMU_CLOCK_HOST);
 }
 
 static int replay_post_load(void *opaque, int version_id)
 {
     ReplayState *state = opaque;
     fseek(replay_file, state->file_offset, SEEK_SET);
+    qemu_clock_set_last(QEMU_CLOCK_HOST, state->host_clock_last);
     /* If this was a vmstate, saved in recording mode,
        we need to initialize replay data fields. */
     replay_fetch_data_kind();
@@ -51,6 +53,7 @@ static const VMStateDescription vmstate_replay = {
         VMSTATE_UINT32(has_unread_data, ReplayState),
         VMSTATE_UINT64(file_offset, ReplayState),
         VMSTATE_UINT64(block_request_id, ReplayState),
+        VMSTATE_UINT64(host_clock_last, ReplayState),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 82d56507a2..2ed1bf2778 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -622,6 +622,18 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
     }
 }
 
+uint64_t qemu_clock_get_last(QEMUClockType type)
+{
+    QEMUClock *clock = qemu_clock_ptr(type);
+    return clock->last;
+}
+
+void qemu_clock_set_last(QEMUClockType type, uint64_t last)
+{
+    QEMUClock *clock = qemu_clock_ptr(type);
+    clock->last = last;
+}
+
 void qemu_clock_register_reset_notifier(QEMUClockType type,
                                         Notifier *notifier)
 {
