Received: from eggs.gnu.org ([209.51.188.92]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gwmA5-00007F-MB
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gwmA1-0004x3-M9
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:05:05 -0500
Received: from mail.ispras.ru ([83.149.199.45]:36014)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gwm9z-0004tU-K8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:05:00 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 21 Feb 2019 14:05:00 +0300
Message-ID: <155074710068.32129.4777541306210676226.stgit@pasha-VirtualBox>
In-Reply-To: <155074704329.32129.17530905097298071558.stgit@pasha-VirtualBox>
References: <155074704329.32129.17530905097298071558.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v13 10/25] qapi: introduce replay.json for
 record/replay-related stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch adds replay.json file. It will be
used for adding record/replay-related data structures and commands.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>

--

v10:
 - minor changes
v13:
 - rebased to the new QAPI files
---
 MAINTAINERS             |    1 +
 include/sysemu/replay.h |    2 +-
 qapi/Makefile.objs      |    2 +-
 qapi/misc.json          |   18 ------------------
 qapi/qapi-schema.json   |    1 +
 qapi/replay.json        |   26 ++++++++++++++++++++++++++
 6 files changed, 30 insertions(+), 20 deletions(-)
 create mode 100644 qapi/replay.json

diff --git a/MAINTAINERS b/MAINTAINERS
index b1d786cfd8..97526f17d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2126,6 +2126,7 @@ F: net/filter-replay.c
 F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
+F: qapi/replay.json
 
 IOVA Tree
 M: Peter Xu <peterx@redhat.com>
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index b3f593f2f0..3fe14b5f57 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -13,7 +13,7 @@
  */
 
 #include "sysemu.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-replay.h"
 #include "qapi/qapi-types-ui.h"
 
 /* replay clock kinds */
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 87e4df1660..907fafaf1b 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -6,7 +6,7 @@ util-obj-y += qmp-event.o
 util-obj-y += qapi-util.o
 
 QAPI_COMMON_MODULES = block-core block char common crypto introspect
-QAPI_COMMON_MODULES += job migration misc net rdma rocker run-state
+QAPI_COMMON_MODULES += job migration misc net replay rdma rocker run-state
 QAPI_COMMON_MODULES += sockets tpm trace transaction ui
 QAPI_TARGET_MODULES = target
 QAPI_MODULES = $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..00cf0e0bba 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2876,24 +2876,6 @@
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
 
-##
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
 ##
 # @xen-load-devices-state:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index db61bfd688..61efb34f06 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -96,5 +96,6 @@
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
+{ 'include': 'replay.json' }
 { 'include': 'misc.json' }
 { 'include': 'target.json' }
diff --git a/qapi/replay.json b/qapi/replay.json
new file mode 100644
index 0000000000..9e13551d20
--- /dev/null
+++ b/qapi/replay.json
@@ -0,0 +1,26 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = Record/replay
+##
+
+{ 'include': 'common.json' }
+
+##
+# @ReplayMode:
+#
+# Mode of the replay subsystem.
+#
+# @none: normal execution mode. Replay or record are not enabled.
+#
+# @record: record mode. All non-deterministic data is written into the
+#          replay log.
+#
+# @play: replay mode. Non-deterministic data required for system execution
+#        is read from the log.
+#
+# Since: 2.5
+##
+{ 'enum': 'ReplayMode',
+  'data': [ 'none', 'record', 'play' ] }
