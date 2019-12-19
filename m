Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CD7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F23E218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F23E218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvhe-0003yb-Gi
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ihvGY-00013A-9Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ihvGV-0003QJ-E1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:50:53 -0500
Received: from mail.ispras.ru ([83.149.199.45]:35720)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ihvGU-0003Hl-QM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:50:51 -0500
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id D1F4F540022;
 Thu, 19 Dec 2019 15:50:48 +0300 (MSK)
Subject: [PATCH] replay: record and replay random number sources
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Dec 2019 15:50:48 +0300
Message-ID: <157675984852.14505.15709141760677102489.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Record/replay feature of icount allows deterministic running of execution
scenarios. Some CPUs and peripheral devices read random numbers from
external sources making deterministic execution impossible.
This patch adds recording and replaying of random read operations
into guest-random module, which is used by the virtual hardware.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 docs/replay.txt          |    1 +
 include/sysemu/replay.h  |    7 +++++++
 replay/Makefile.objs     |    3 ++-
 replay/replay-internal.h |    2 ++
 replay/replay-random.c   |   44 ++++++++++++++++++++++++++++++++++++++++++++
 replay/replay.c          |    2 +-
 stubs/replay.c           |    9 +++++++++
 util/guest-random.c      |   13 +++++++++++--
 8 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100644 replay/replay-random.c

diff --git a/docs/replay.txt b/docs/replay.txt
index ce97c3f72f..f4619a62a3 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -67,6 +67,7 @@ Modifications of qemu include:
  * network filter for recording and replaying the packets
  * block driver for making block layer deterministic
  * serial port input record and replay
+ * recording of random numbers obtained from the external sources
 
 Locking and thread synchronisation
 ----------------------------------
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 8df517298c..5471bb514d 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -117,6 +117,13 @@ int64_t replay_read_clock(ReplayClockKind kind);
             ? replay_save_clock((clock), (value), cpu_get_icount_raw_locked()) \
         : (value))
 
+/* Processing data from random generators */
+
+/* Saves the values from the random number generator */
+void replay_save_random(int ret, void *buf, size_t len);
+/* Loads the saved values for the random number generator */
+int replay_read_random(void *buf, size_t len);
+
 /* Events */
 
 /*! Called when qemu shutdown is requested. */
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
index cee6539a23..939be964a9 100644
--- a/replay/Makefile.objs
+++ b/replay/Makefile.objs
@@ -6,4 +6,5 @@ common-obj-y += replay-input.o
 common-obj-y += replay-char.o
 common-obj-y += replay-snapshot.o
 common-obj-y += replay-net.o
-common-obj-y += replay-audio.o
\ No newline at end of file
+common-obj-y += replay-audio.o
+common-obj-y += replay-random.o
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 55fca1ac6b..33ac551e78 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -34,6 +34,8 @@ enum ReplayEvents {
     EVENT_AUDIO_OUT,
     /* for audio in event */
     EVENT_AUDIO_IN,
+    /* for random number generator */
+    EVENT_RANDOM,
     /* for clock read/writes */
     /* some of greater codes are reserved for clocks */
     EVENT_CLOCK,
diff --git a/replay/replay-random.c b/replay/replay-random.c
new file mode 100644
index 0000000000..afc7a0fccc
--- /dev/null
+++ b/replay/replay-random.c
@@ -0,0 +1,44 @@
+/*
+ * replay-random.c
+ *
+ * Copyright (c) 2010-2020 Institute for System Programming
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
+
+void replay_save_random(int ret, void *buf, size_t len)
+{
+    g_assert(replay_mutex_locked());
+
+    replay_save_instructions();
+    replay_put_event(EVENT_RANDOM);
+    replay_put_dword(ret);
+    replay_put_array(buf, len);
+}
+
+int replay_read_random(void *buf, size_t len)
+{
+    int ret = 0;
+    g_assert(replay_mutex_locked());
+
+    replay_account_executed_instructions();
+    if (replay_next_event_is(EVENT_RANDOM)) {
+        size_t buf_size = 0;
+        ret = replay_get_dword();
+        replay_get_array(buf, &buf_size);
+        replay_finish_event();
+        g_assert(buf_size == len);
+    } else {
+        error_report("Missing random event in the replay log");
+        exit(1);
+    }
+    return ret;
+}
diff --git a/replay/replay.c b/replay/replay.c
index 5cc25bd2f8..706c7b4f4b 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02008
+#define REPLAY_VERSION              0xe02009
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
diff --git a/stubs/replay.c b/stubs/replay.c
index 10b3925e2f..5974ec1f50 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -79,3 +79,12 @@ void replay_mutex_lock(void)
 void replay_mutex_unlock(void)
 {
 }
+
+void replay_save_random(int ret, void *buf, size_t len)
+{
+}
+
+int replay_read_random(void *buf, size_t len)
+{
+    return 0;
+}
diff --git a/util/guest-random.c b/util/guest-random.c
index 9453968bd7..086115bd67 100644
--- a/util/guest-random.c
+++ b/util/guest-random.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #include "crypto/random.h"
+#include "sysemu/replay.h"
 
 
 static __thread GRand *thread_rand;
@@ -44,13 +45,21 @@ static int glib_random_bytes(void *buf, size_t len)
 
 int qemu_guest_getrandom(void *buf, size_t len, Error **errp)
 {
+    int ret;
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        return replay_read_random(buf, len);
+    }
     if (unlikely(deterministic)) {
         /* Deterministic implementation using Glib's Mersenne Twister.  */
-        return glib_random_bytes(buf, len);
+        ret = glib_random_bytes(buf, len);
     } else {
         /* Non-deterministic implementation using crypto routines.  */
-        return qcrypto_random_bytes(buf, len, errp);
+        ret = qcrypto_random_bytes(buf, len, errp);
+    }
+    if (replay_mode == REPLAY_MODE_RECORD) {
+        replay_save_random(ret, buf, len);
     }
+    return ret;
 }
 
 void qemu_guest_getrandom_nofail(void *buf, size_t len)


