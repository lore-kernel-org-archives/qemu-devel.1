Received: from eggs.gnu.org ([2001:4830:134:3::10]:39580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbvj-0000rm-TW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbvi-0004ha-Qz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:52:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57332)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbvi-0004hM-Hf
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:52:14 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 27 Feb 2018 12:52:14 +0300
Message-ID: <20180227095214.1060.32939.stgit@pasha-VirtualBox>
In-Reply-To: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
References: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 07/22] replay: fix save/load vm for
 non-empty queue
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

This patch does not allows saving/loading vmstate when
replay events queue is not empty. There is no reliable
way to save events queue, because it describes internal
coroutine state. Therefore saving and loading operations
should be deferred to another record/replay step.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

--

v2: fixed error_report calls
---
 include/sysemu/replay.h  |    3 +++
 migration/savevm.c       |   13 +++++++++++++
 replay/replay-snapshot.c |    6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index dc8ae7b..5462555 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -164,5 +164,8 @@ void replay_audio_in(int *recorded, void *samples, int *wpos, int size);
 /*! Called at the start of execution.
     Loads or saves initial vmstate depending on execution mode. */
 void replay_vmstate_init(void);
+/*! Called to ensure that replay state is consistent and VM snapshot
+    can be created */
+bool replay_can_snapshot(void);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 8e6d872..d98ea64 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -53,6 +53,7 @@
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
+#include "sysemu/replay.h"
 
 #ifndef ETH_P_RARP
 #define ETH_P_RARP 0x8035
@@ -2196,6 +2197,12 @@ int save_snapshot(const char *name, Error **errp)
     struct tm tm;
     AioContext *aio_context;
 
+    if (!replay_can_snapshot()) {
+        error_report("Record/replay does not allow making snapshot "
+                     "right now. Try once more later.");
+        return ret;
+    }
+
     if (!bdrv_all_can_snapshot(&bs)) {
         error_setg(errp, "Device '%s' is writable but does not support "
                    "snapshots", bdrv_get_device_name(bs));
@@ -2387,6 +2394,12 @@ int load_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (!replay_can_snapshot()) {
+        error_report("Record/replay does not allow loading snapshot "
+                     "right now. Try once more later.");
+        return -EINVAL;
+    }
+
     if (!bdrv_all_can_snapshot(&bs)) {
         error_setg(errp,
                    "Device '%s' is writable but does not support snapshots",
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index b2e1076..7075986 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -83,3 +83,9 @@ void replay_vmstate_init(void)
         }
     }
 }
+
+bool replay_can_snapshot(void)
+{
+    return replay_mode == REPLAY_MODE_NONE
+        || !replay_has_events();
+}
