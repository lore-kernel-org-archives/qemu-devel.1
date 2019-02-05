Received: from eggs.gnu.org ([209.51.188.92]:52179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvyD-0008GE-I7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvyC-0008Q3-88
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:41 -0500
Received: from mail.ispras.ru ([83.149.199.45]:33544)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvyB-0008PB-BW
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:40 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Feb 2019 11:20:39 +0300
Message-ID: <154935483903.7509.2641437081687401076.stgit@pasha-VirtualBox>
In-Reply-To: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>
References: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v12 10/25] qapi: introduce replay.json for
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
---
 MAINTAINERS             |    1 +
 Makefile.objs           |    4 ++--
 include/sysemu/replay.h |    2 +-
 qapi/misc.json          |   18 ------------------
 qapi/qapi-schema.json   |    1 +
 qapi/replay.json        |   26 ++++++++++++++++++++++++++
 6 files changed, 31 insertions(+), 21 deletions(-)
 create mode 100644 qapi/replay.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a76845581..330b5f6181 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2131,6 +2131,7 @@ F: net/filter-replay.c
 F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
+F: qapi/replay.json
 
 IOVA Tree
 M: Peter Xu <peterx@redhat.com>
diff --git a/Makefile.objs b/Makefile.objs
index 67a054b08a..098691fad3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,6 +1,6 @@
 QAPI_MODULES = block-core block char common crypto introspect job migration
-QAPI_MODULES += misc net rdma rocker run-state sockets tpm trace transaction
-QAPI_MODULES += ui
+QAPI_MODULES += misc net rdma replay rocker run-state sockets tpm trace
+QAPI_MODULES += transaction ui
 
 #######################################################################
 # Common libraries for tools and emulators
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 426274ecf8..8eef451700 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3160,24 +3160,6 @@
 { 'event': 'RTC_CHANGE',
   'data': { 'offset': 'int' } }
 
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
index 1845aa78ff..ac4b136f3e 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -96,4 +96,5 @@
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
+{ 'include': 'replay.json' }
 { 'include': 'misc.json' }
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
