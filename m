Received: from eggs.gnu.org ([2001:4830:134:3::10]:49845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGa-0003hX-BL
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGV-00057S-AR
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:35:04 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42604)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGU-000574-VN
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:59 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 26 Jan 2017 15:35:02 +0300
Message-ID: <20170126123502.5412.80317.stgit@PASHA-ISP>
In-Reply-To: <20170126123411.5412.44769.stgit@PASHA-ISP>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 9/9] replay: add record/replay for audio
 passthrough
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

This patch adds recording and replaying audio data. Is saves synchronization
information for audio out and inputs from the microphone.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 audio/audio.c            |   11 +++++-
 audio/audio.h            |    5 +++
 audio/mixeng.c           |   31 ++++++++++++++++++
 docs/replay.txt          |    7 ++++
 include/sysemu/replay.h  |    7 ++++
 replay/Makefile.objs     |    1 +
 replay/replay-audio.c    |   79 ++++++++++++++++++++++++++++++++++++++++++++++
 replay/replay-internal.h |    4 ++
 8 files changed, 142 insertions(+), 3 deletions(-)
 create mode 100644 replay/replay-audio.c

diff --git a/audio/audio.c b/audio/audio.c
index 1ee95a5..79c0788 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
+#include "sysemu/replay.h"
 
 #define AUDIO_CAP "audio"
 #include "audio_int.h"
@@ -1113,7 +1114,7 @@ static void audio_reset_timer (AudioState *s)
 {
     if (audio_is_timer_needed ()) {
         if (!timer_pending(s->ts)) {
-            timer_mod (s->ts,
+            timer_mod(s->ts,
                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
         }
     }
@@ -1389,6 +1390,7 @@ static void audio_run_out (AudioState *s)
 
         prev_rpos = hw->rpos;
         played = hw->pcm_ops->run_out (hw, live);
+        replay_audio_out(&played);
         if (audio_bug (AUDIO_FUNC, hw->rpos >= hw->samples)) {
             dolog ("hw->rpos=%d hw->samples=%d played=%d\n",
                    hw->rpos, hw->samples, played);
@@ -1452,9 +1454,12 @@ static void audio_run_in (AudioState *s)
 
     while ((hw = audio_pcm_hw_find_any_enabled_in (hw))) {
         SWVoiceIn *sw;
-        int captured, min;
+        int captured = 0, min;
 
-        captured = hw->pcm_ops->run_in (hw);
+        if (replay_mode != REPLAY_MODE_PLAY) {
+            captured = hw->pcm_ops->run_in(hw);
+        }
+        replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples);
 
         min = audio_pcm_hw_find_min_in (hw);
         hw->total_samples_captured += captured - min;
diff --git a/audio/audio.h b/audio/audio.h
index c3c5198..f4339a1 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -166,4 +166,9 @@ int wav_start_capture (CaptureState *s, const char *path, int freq,
 bool audio_is_cleaning_up(void);
 void audio_cleanup(void);
 
+void audio_sample_to_uint64(void *samples, int pos,
+                            uint64_t *left, uint64_t *right);
+void audio_sample_from_uint64(void *samples, int pos,
+                            uint64_t left, uint64_t right);
+
 #endif /* QEMU_AUDIO_H */
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 66c0328..c23508e 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -267,6 +267,37 @@ f_sample *mixeng_clip[2][2][2][3] = {
     }
 };
 
+
+void audio_sample_to_uint64(void *samples, int pos,
+                            uint64_t *left, uint64_t *right)
+{
+    struct st_sample *sample = samples;
+    sample += pos;
+#ifdef FLOAT_MIXENG
+    error_report(
+        "Coreaudio and floating point samples are not supported by replay yet");
+    abort();
+#else
+    *left = sample->l;
+    *right = sample->r;
+#endif
+}
+
+void audio_sample_from_uint64(void *samples, int pos,
+                            uint64_t left, uint64_t right)
+{
+    struct st_sample *sample = samples;
+    sample += pos;
+#ifdef FLOAT_MIXENG
+    error_report(
+        "Coreaudio and floating point samples are not supported by replay yet");
+    abort();
+#else
+    sample->l = left;
+    sample->r = right;
+#endif
+}
+
 /*
  * August 21, 1998
  * Copyright 1998 Fabrice Bellard.
diff --git a/docs/replay.txt b/docs/replay.txt
index 03e1931..486c1e0 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -225,3 +225,10 @@ recording the virtual machine this filter puts all packets coming from
 the outer world into the log. In replay mode packets from the log are
 injected into the network device. All interactions with network backend
 in replay mode are disabled.
+
+Audio devices
+-------------
+
+Audio data is recorded and replay automatically. The command line for recording
+and replaying must contain identical specifications of audio hardware, e.g.:
+ -soundhw ac97
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 740b425..073ec59 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -152,6 +152,13 @@ void replay_unregister_net(ReplayNetState *rns);
 void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
                              const struct iovec *iov, int iovcnt);
 
+/* Audio */
+
+/*! Saves/restores number of played samples of audio out operation. */
+void replay_audio_out(int *played);
+/*! Saves/restores recorded samples of audio in operation. */
+void replay_audio_in(int *recorded, void *samples, int *wpos, int size);
+
 /* VM state operations */
 
 /*! Called at the start of execution.
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
index b2afd40..cee6539 100644
--- a/replay/Makefile.objs
+++ b/replay/Makefile.objs
@@ -6,3 +6,4 @@ common-obj-y += replay-input.o
 common-obj-y += replay-char.o
 common-obj-y += replay-snapshot.o
 common-obj-y += replay-net.o
+common-obj-y += replay-audio.o
\ No newline at end of file
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
new file mode 100644
index 0000000..3d83743
--- /dev/null
+++ b/replay/replay-audio.c
@@ -0,0 +1,79 @@
+/*
+ * replay-audio.c
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/replay.h"
+#include "replay-internal.h"
+#include "sysemu/sysemu.h"
+#include "audio/audio.h"
+
+void replay_audio_out(int *played)
+{
+    if (replay_mode == REPLAY_MODE_RECORD) {
+        replay_save_instructions();
+        replay_mutex_lock();
+        replay_put_event(EVENT_AUDIO_OUT);
+        replay_put_dword(*played);
+        replay_mutex_unlock();
+    } else if (replay_mode == REPLAY_MODE_PLAY) {
+        replay_account_executed_instructions();
+        replay_mutex_lock();
+        if (replay_next_event_is(EVENT_AUDIO_OUT)) {
+            *played = replay_get_dword();
+            replay_finish_event();
+            replay_mutex_unlock();
+        } else {
+            replay_mutex_unlock();
+            error_report("Missing audio out event in the replay log");
+            abort();
+        }
+    }
+}
+
+void replay_audio_in(int *recorded, void *samples, int *wpos, int size)
+{
+    int pos;
+    uint64_t left, right;
+    if (replay_mode == REPLAY_MODE_RECORD) {
+        replay_save_instructions();
+        replay_mutex_lock();
+        replay_put_event(EVENT_AUDIO_IN);
+        replay_put_dword(*recorded);
+        replay_put_dword(*wpos);
+        for (pos = (*wpos - *recorded + size) % size ; pos != *wpos
+             ; pos = (pos + 1) % size) {
+            audio_sample_to_uint64(samples, pos, &left, &right);
+            replay_put_qword(left);
+            replay_put_qword(right);
+        }
+        replay_mutex_unlock();
+    } else if (replay_mode == REPLAY_MODE_PLAY) {
+        replay_account_executed_instructions();
+        replay_mutex_lock();
+        if (replay_next_event_is(EVENT_AUDIO_IN)) {
+            *recorded = replay_get_dword();
+            *wpos = replay_get_dword();
+            for (pos = (*wpos - *recorded + size) % size ; pos != *wpos
+                 ; pos = (pos + 1) % size) {
+                left = replay_get_qword();
+                right = replay_get_qword();
+                audio_sample_from_uint64(samples, pos, left, right);
+            }
+            replay_finish_event();
+            replay_mutex_unlock();
+        } else {
+            replay_mutex_unlock();
+            error_report("Missing audio in event in the replay log");
+            abort();
+        }
+    }
+}
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index c26d079..ed66ed8 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -29,6 +29,10 @@ enum ReplayEvents {
     /* for character device read all event */
     EVENT_CHAR_READ_ALL,
     EVENT_CHAR_READ_ALL_ERROR,
+    /* for audio out event */
+    EVENT_AUDIO_OUT,
+    /* for audio in event */
+    EVENT_AUDIO_IN,
     /* for clock read/writes */
     /* some of greater codes are reserved for clocks */
     EVENT_CLOCK,
