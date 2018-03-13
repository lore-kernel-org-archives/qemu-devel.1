Received: from eggs.gnu.org ([2001:4830:134:3::10]:58611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsig-0006KK-7i
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsie-000475-SR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:34 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsie-00046i-Kq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:32 -0400
Received: by mail-wr0-x243.google.com with SMTP id m12so2473691wrm.13
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:07 +0100
Message-Id: <20180313224719.4954-58-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 57/69] replay: save prior value of the host clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds saving/restoring of the host clock field 'last'.
It is used in host clock calculation and therefore clock may
become incorrect when using restored vmstate.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180227095226.1060.50975.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 include/qemu/timer.h     | 14 ++++++++++++++
 replay/replay-internal.h |  2 ++
 replay/replay-snapshot.c |  3 +++
 util/qemu-timer.c        | 12 ++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 3b5a54b014..39ea907e65 100644
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
index 3ebb19912a..be96d7e879 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -78,6 +78,8 @@ typedef struct ReplayState {
         This counter is global, because requests from different
         block devices should not get overlapping ids. */
     uint64_t block_request_id;
+    /*! Prior value of the host clock */
+    uint64_t host_clock_last;
 } ReplayState;
 extern ReplayState replay_state;
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 7075986ab5..e0b2204765 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -25,6 +25,7 @@ static int replay_pre_save(void *opaque)
 {
     ReplayState *state = opaque;
     state->file_offset = ftell(replay_file);
+    state->host_clock_last = qemu_clock_get_last(QEMU_CLOCK_HOST);
 
     return 0;
 }
@@ -33,6 +34,7 @@ static int replay_post_load(void *opaque, int version_id)
 {
     ReplayState *state = opaque;
     fseek(replay_file, state->file_offset, SEEK_SET);
+    qemu_clock_set_last(QEMU_CLOCK_HOST, state->host_clock_last);
     /* If this was a vmstate, saved in recording mode,
        we need to initialize replay data fields. */
     replay_fetch_data_kind();
@@ -54,6 +56,7 @@ static const VMStateDescription vmstate_replay = {
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
-- 
2.14.3
