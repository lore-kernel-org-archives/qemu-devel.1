Received: from eggs.gnu.org ([2001:4830:134:3::10]:40915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db5fc-0000UN-PE
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db5fY-00070M-5K
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1db5fX-0006xK-VA
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:51:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 28 Jul 2017 15:45:50 +0200
Message-Id: <1501249552-788-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1501249552-788-1-git-send-email-armbru@redhat.com>
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] replay: Define ReplayMode without QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

ReplayMode is defined in the QAPI schema, but not used there.  Of the
stuff QAPI generates for it only the typedef is actually used.  Use of
QAPI is pointless and only complicates things, so don't.

Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/sysemu/replay.h |  6 ++++++
 qapi-schema.json        | 18 ------------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index fa14d0e..621bc61 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -42,6 +42,12 @@ typedef enum ReplayCheckpoint ReplayCheckpoint;
 
 typedef struct ReplayNetState ReplayNetState;
 
+typedef enum {
+    REPLAY_MODE_NONE,           /* replay / record disabled */
+    REPLAY_MODE_RECORD,         /* recording to replay log */
+    REPLAY_MODE_PLAY,           /* replaying log */
+} ReplayMode;
+
 extern ReplayMode replay_mode;
 
 /* Name of the initial VM snapshot */
diff --git a/qapi-schema.json b/qapi-schema.json
index 9c6c3e1..9b6f6cb 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6258,24 +6258,6 @@
 { 'include': 'qapi/rocker.json' }
 
 ##
-# @ReplayMode:
-#
-# Mode of the replay subsystem.
-#
-# @none: normal execution mode. Replay or record are not enabled.
-#
-# @record: record mode. All non-deterministic data is written into the
-#          replay log.
-#
-# @play: replay mode. Non-deterministic data required for system execution
-#        is read from the log.
-#
-# Since: 2.5
-##
-{ 'enum': 'ReplayMode',
-  'data': [ 'none', 'record', 'play' ] }
-
-##
 # @xen-load-devices-state:
 #
 # Load the state of all devices from file. The RAM and the block devices
-- 
2.7.5
