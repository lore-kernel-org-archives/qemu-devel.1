Received: from eggs.gnu.org ([2001:4830:134:3::10]:58704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsik-0006Oi-Aq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsij-0004Au-DH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:38 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsij-0004AO-5x
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:37 -0400
Received: by mail-wm0-x241.google.com with SMTP id h76so872886wme.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:11 +0100
Message-Id: <20180313224719.4954-62-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 61/69] replay: don't destroy mutex at exit
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

Replay mutex is held by vCPU thread and destroy function is called
from atexit of the main thread. Therefore we cannot destroy it safely.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180227095254.1060.96971.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-internal.c | 5 -----
 replay/replay-internal.h | 1 -
 replay/replay.c          | 1 -
 3 files changed, 7 deletions(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 7cdefeaa04..fa7bba6dfd 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -176,11 +176,6 @@ void replay_mutex_init(void)
     qemu_mutex_init(&lock);
 }
 
-void replay_mutex_destroy(void)
-{
-    qemu_mutex_destroy(&lock);
-}
-
 bool replay_mutex_locked(void)
 {
     return replay_locked;
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 41eee66e9b..d4037058e4 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -104,7 +104,6 @@ void replay_get_array_alloc(uint8_t **buf, size_t *size);
  * synchronisation between vCPU and main-loop threads. */
 
 void replay_mutex_init(void);
-void replay_mutex_destroy(void);
 bool replay_mutex_locked(void);
 
 /*! Checks error status of the file. */
diff --git a/replay/replay.c b/replay/replay.c
index 9cddb6bfc9..5d05ee0460 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -358,7 +358,6 @@ void replay_finish(void)
     replay_snapshot = NULL;
 
     replay_finish_events();
-    replay_mutex_destroy();
 }
 
 void replay_add_blocker(Error *reason)
-- 
2.14.3
