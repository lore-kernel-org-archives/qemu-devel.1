Received: from eggs.gnu.org ([2001:4830:134:3::10]:59832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZ8k-0002Ka-Rt
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZ8i-000781-3j
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:06:10 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50275 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gNZ8h-00074O-1b
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:06:08 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Fri, 16 Nov 2018 16:00:20 +0800
Message-ID: <a0b5db8a85704b69e3829b4422ca72793ac21e80.1542384802.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542384802.git.xiezhide@huawei.com>
References: <cover.1542384802.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 5/6] fsdev-throttle-qmp: qmp interface for
 fsdev io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, eblake@redhat.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

provides two interfaces:
1. set the IO limits for the required fsdev device
2. query info of all the fsdev devices.

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 Makefile                    | 27 ++++++++-----
 Makefile.objs               | 12 ++++--
 fsdev/qemu-fsdev-dummy.c    | 11 +++++
 fsdev/qemu-fsdev-throttle.c | 98 ++++++++++++++++++++++++++++++++++++++++++---
 fsdev/qemu-fsdev-throttle.h |  6 ++-
 fsdev/qemu-fsdev.c          | 29 ++++++++++++++
 qapi/fsdev.json             | 96 ++++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json       |  1 +
 qmp.c                       | 13 ++++++
 9 files changed, 272 insertions(+), 21 deletions(-)
 create mode 100644 qapi/fsdev.json

diff --git a/Makefile b/Makefile
index b546e98..e2c0e92 100644
--- a/Makefile
+++ b/Makefile
@@ -95,6 +95,7 @@ GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
 GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
 GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
 GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
+GENERATED_FILES += qapi/qapi-types-fsdev.h qapi/qapi-types-fsdev.c
 GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
 GENERATED_FILES += qapi/qapi-types-job.h qapi/qapi-types-job.c
 GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
@@ -103,10 +104,10 @@ GENERATED_FILES += qapi/qapi-types-net.h qapi/qapi-types-net.c
 GENERATED_FILES += qapi/qapi-types-rocker.h qapi/qapi-types-rocker.c
 GENERATED_FILES += qapi/qapi-types-run-state.h qapi/qapi-types-run-state.c
 GENERATED_FILES += qapi/qapi-types-sockets.h qapi/qapi-types-sockets.c
+GENERATED_FILES += qapi/qapi-types-tlimits.h qapi/qapi-types-tlimits.c
 GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
 GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
 GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
-GENERATED_FILES += qapi/qapi-types-tlimits.h qapi/qapi-types-tlimits.c
 GENERATED_FILES += qapi/qapi-types-ui.h qapi/qapi-types-ui.c
 GENERATED_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
 GENERATED_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
@@ -115,6 +116,7 @@ GENERATED_FILES += qapi/qapi-visit-block.h qapi/qapi-visit-block.c
 GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
 GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
 GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
+GENERATED_FILES += qapi/qapi-visit-fsdev.h qapi/qapi-visit-fsdev.c
 GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
 GENERATED_FILES += qapi/qapi-visit-job.h qapi/qapi-visit-job.c
 GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
@@ -123,10 +125,10 @@ GENERATED_FILES += qapi/qapi-visit-net.h qapi/qapi-visit-net.c
 GENERATED_FILES += qapi/qapi-visit-rocker.h qapi/qapi-visit-rocker.c
 GENERATED_FILES += qapi/qapi-visit-run-state.h qapi/qapi-visit-run-state.c
 GENERATED_FILES += qapi/qapi-visit-sockets.h qapi/qapi-visit-sockets.c
+GENERATED_FILES += qapi/qapi-visit-tlimits.h qapi/qapi-visit-tlimits.c
 GENERATED_FILES += qapi/qapi-visit-tpm.h qapi/qapi-visit-tpm.c
 GENERATED_FILES += qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
 GENERATED_FILES += qapi/qapi-visit-transaction.h qapi/qapi-visit-transaction.c
-GENERATED_FILES += qapi/qapi-visit-tlimits.h qapi/qapi-visit-tlimits.c
 GENERATED_FILES += qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
 GENERATED_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_FILES += qapi/qapi-commands-block-core.h qapi/qapi-commands-block-core.c
@@ -134,6 +136,7 @@ GENERATED_FILES += qapi/qapi-commands-block.h qapi/qapi-commands-block.c
 GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
 GENERATED_FILES += qapi/qapi-commands-common.h qapi/qapi-commands-common.c
 GENERATED_FILES += qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto.c
+GENERATED_FILES += qapi/qapi-commands-fsdev.h qapi/qapi-commands-fsdev.c
 GENERATED_FILES += qapi/qapi-commands-introspect.h qapi/qapi-commands-introspect.c
 GENERATED_FILES += qapi/qapi-commands-job.h qapi/qapi-commands-job.c
 GENERATED_FILES += qapi/qapi-commands-migration.h qapi/qapi-commands-migration.c
@@ -142,10 +145,10 @@ GENERATED_FILES += qapi/qapi-commands-net.h qapi/qapi-commands-net.c
 GENERATED_FILES += qapi/qapi-commands-rocker.h qapi/qapi-commands-rocker.c
 GENERATED_FILES += qapi/qapi-commands-run-state.h qapi/qapi-commands-run-state.c
 GENERATED_FILES += qapi/qapi-commands-sockets.h qapi/qapi-commands-sockets.c
+GENERATED_FILES += qapi/qapi-commands-tlimits.h qapi/qapi-commands-tlimits.c
 GENERATED_FILES += qapi/qapi-commands-tpm.h qapi/qapi-commands-tpm.c
 GENERATED_FILES += qapi/qapi-commands-trace.h qapi/qapi-commands-trace.c
 GENERATED_FILES += qapi/qapi-commands-transaction.h qapi/qapi-commands-transaction.c
-GENERATED_FILES += qapi/qapi-commands-tlimits.h qapi/qapi-commands-tlimits.c
 GENERATED_FILES += qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
 GENERATED_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_FILES += qapi/qapi-events-block-core.h qapi/qapi-events-block-core.c
@@ -153,6 +156,7 @@ GENERATED_FILES += qapi/qapi-events-block.h qapi/qapi-events-block.c
 GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
 GENERATED_FILES += qapi/qapi-events-common.h qapi/qapi-events-common.c
 GENERATED_FILES += qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
+GENERATED_FILES += qapi/qapi-events-fsdev.h qapi/qapi-events-fsdev.c
 GENERATED_FILES += qapi/qapi-events-introspect.h qapi/qapi-events-introspect.c
 GENERATED_FILES += qapi/qapi-events-job.h qapi/qapi-events-job.c
 GENERATED_FILES += qapi/qapi-events-migration.h qapi/qapi-events-migration.c
@@ -161,10 +165,10 @@ GENERATED_FILES += qapi/qapi-events-net.h qapi/qapi-events-net.c
 GENERATED_FILES += qapi/qapi-events-rocker.h qapi/qapi-events-rocker.c
 GENERATED_FILES += qapi/qapi-events-run-state.h qapi/qapi-events-run-state.c
 GENERATED_FILES += qapi/qapi-events-sockets.h qapi/qapi-events-sockets.c
+GENERATED_FILES += qapi/qapi-events-tlimits.h qapi/qapi-events-tlimits.c
 GENERATED_FILES += qapi/qapi-events-tpm.h qapi/qapi-events-tpm.c
 GENERATED_FILES += qapi/qapi-events-trace.h qapi/qapi-events-trace.c
 GENERATED_FILES += qapi/qapi-events-transaction.h qapi/qapi-events-transaction.c
-GENERATED_FILES += qapi/qapi-events-tlimits.h qapi/qapi-events-tlimits.c
 GENERATED_FILES += qapi/qapi-events-ui.h qapi/qapi-events-ui.c
 GENERATED_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
 GENERATED_FILES += qapi/qapi-doc.texi
@@ -591,6 +595,7 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
+               $(SRC_PATH)/qapi/fsdev.json \
                $(SRC_PATH)/qapi/introspect.json \
                $(SRC_PATH)/qapi/job.json \
                $(SRC_PATH)/qapi/migration.json \
@@ -599,8 +604,8 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
-               $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/tlimits.json \
+               $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
@@ -612,6 +617,7 @@ qapi/qapi-types-block.c qapi/qapi-types-block.h \
 qapi/qapi-types-char.c qapi/qapi-types-char.h \
 qapi/qapi-types-common.c qapi/qapi-types-common.h \
 qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
+qapi/qapi-types-fsdev.c qapi/qapi-types-fsdev.h \
 qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
 qapi/qapi-types-job.c qapi/qapi-types-job.h \
 qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
@@ -620,10 +626,10 @@ qapi/qapi-types-net.c qapi/qapi-types-net.h \
 qapi/qapi-types-rocker.c qapi/qapi-types-rocker.h \
 qapi/qapi-types-run-state.c qapi/qapi-types-run-state.h \
 qapi/qapi-types-sockets.c qapi/qapi-types-sockets.h \
+qapi/qapi-types-tlimits.c qapi/qapi-types-tlimits.h \
 qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
-qapi/qapi-types-tlimits.c qapi/qapi-types-tlimits.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
 qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
 qapi/qapi-visit.c qapi/qapi-visit.h \
@@ -632,6 +638,7 @@ qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
 qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
 qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
 qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
+qapi/qapi-visit-fsdev.c qapi/qapi-visit-fsdev.h \
 qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
 qapi/qapi-visit-job.c qapi/qapi-visit-job.h \
 qapi/qapi-visit-migration.c qapi/qapi-visit-migration.h \
@@ -640,10 +647,10 @@ qapi/qapi-visit-net.c qapi/qapi-visit-net.h \
 qapi/qapi-visit-rocker.c qapi/qapi-visit-rocker.h \
 qapi/qapi-visit-run-state.c qapi/qapi-visit-run-state.h \
 qapi/qapi-visit-sockets.c qapi/qapi-visit-sockets.h \
+qapi/qapi-visit-tlimits.c qapi/qapi-visit-tlimits.h \
 qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
-qapi/qapi-visit-tlimits.c qapi/qapi-visit-tlimits.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
 qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
@@ -651,6 +658,7 @@ qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
 qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
 qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
 qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
+qapi/qapi-commands-fsdev.c qapi/qapi-commands-fsdev.h \
 qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
 qapi/qapi-commands-job.c qapi/qapi-commands-job.h \
 qapi/qapi-commands-migration.c qapi/qapi-commands-migration.h \
@@ -659,10 +667,10 @@ qapi/qapi-commands-net.c qapi/qapi-commands-net.h \
 qapi/qapi-commands-rocker.c qapi/qapi-commands-rocker.h \
 qapi/qapi-commands-run-state.c qapi/qapi-commands-run-state.h \
 qapi/qapi-commands-sockets.c qapi/qapi-commands-sockets.h \
+qapi/qapi-commands-tlimits.c qapi/qapi-commands-tlimits.h \
 qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
-qapi/qapi-commands-tlimits.c qapi/qapi-commands-tlimits.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
 qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
@@ -670,6 +678,7 @@ qapi/qapi-events-block.c qapi/qapi-events-block.h \
 qapi/qapi-events-char.c qapi/qapi-events-char.h \
 qapi/qapi-events-common.c qapi/qapi-events-common.h \
 qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
+qapi/qapi-events-fsdev.c qapi/qapi-events-fsdev.h \
 qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
 qapi/qapi-events-job.c qapi/qapi-events-job.h \
 qapi/qapi-events-migration.c qapi/qapi-events-migration.h \
@@ -678,10 +687,10 @@ qapi/qapi-events-net.c qapi/qapi-events-net.h \
 qapi/qapi-events-rocker.c qapi/qapi-events-rocker.h \
 qapi/qapi-events-run-state.c qapi/qapi-events-run-state.h \
 qapi/qapi-events-sockets.c qapi/qapi-events-sockets.h \
+qapi/qapi-events-tlimits.c qapi/qapi-events-tlimits.h \
 qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
-qapi/qapi-events-tlimits.c qapi/qapi-events-tlimits.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
 qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
diff --git a/Makefile.objs b/Makefile.objs
index 682e6ba..1c4bf88 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -9,6 +9,7 @@ util-obj-y += qapi/qapi-types-block.o
 util-obj-y += qapi/qapi-types-char.o
 util-obj-y += qapi/qapi-types-common.o
 util-obj-y += qapi/qapi-types-crypto.o
+util-obj-y += qapi/qapi-types-fsdev.o
 util-obj-y += qapi/qapi-types-introspect.o
 util-obj-y += qapi/qapi-types-job.o
 util-obj-y += qapi/qapi-types-migration.o
@@ -17,10 +18,10 @@ util-obj-y += qapi/qapi-types-net.o
 util-obj-y += qapi/qapi-types-rocker.o
 util-obj-y += qapi/qapi-types-run-state.o
 util-obj-y += qapi/qapi-types-sockets.o
+util-obj-y += qapi/qapi-types-tlimits.o
 util-obj-y += qapi/qapi-types-tpm.o
 util-obj-y += qapi/qapi-types-trace.o
 util-obj-y += qapi/qapi-types-transaction.o
-util-obj-y += qapi/qapi-types-tlimits.o
 util-obj-y += qapi/qapi-types-ui.o
 util-obj-y += qapi/qapi-builtin-visit.o
 util-obj-y += qapi/qapi-visit.o
@@ -29,6 +30,7 @@ util-obj-y += qapi/qapi-visit-block.o
 util-obj-y += qapi/qapi-visit-char.o
 util-obj-y += qapi/qapi-visit-common.o
 util-obj-y += qapi/qapi-visit-crypto.o
+util-obj-y += qapi/qapi-visit-fsdev.o
 util-obj-y += qapi/qapi-visit-introspect.o
 util-obj-y += qapi/qapi-visit-job.o
 util-obj-y += qapi/qapi-visit-migration.o
@@ -37,10 +39,10 @@ util-obj-y += qapi/qapi-visit-net.o
 util-obj-y += qapi/qapi-visit-rocker.o
 util-obj-y += qapi/qapi-visit-run-state.o
 util-obj-y += qapi/qapi-visit-sockets.o
+util-obj-y += qapi/qapi-visit-tlimits.o
 util-obj-y += qapi/qapi-visit-tpm.o
 util-obj-y += qapi/qapi-visit-trace.o
 util-obj-y += qapi/qapi-visit-transaction.o
-util-obj-y += qapi/qapi-visit-tlimits.o
 util-obj-y += qapi/qapi-visit-ui.o
 util-obj-y += qapi/qapi-events.o
 util-obj-y += qapi/qapi-events-block-core.o
@@ -48,6 +50,7 @@ util-obj-y += qapi/qapi-events-block.o
 util-obj-y += qapi/qapi-events-char.o
 util-obj-y += qapi/qapi-events-common.o
 util-obj-y += qapi/qapi-events-crypto.o
+util-obj-y += qapi/qapi-events-fsdev.o
 util-obj-y += qapi/qapi-events-introspect.o
 util-obj-y += qapi/qapi-events-job.o
 util-obj-y += qapi/qapi-events-migration.o
@@ -56,10 +59,10 @@ util-obj-y += qapi/qapi-events-net.o
 util-obj-y += qapi/qapi-events-rocker.o
 util-obj-y += qapi/qapi-events-run-state.o
 util-obj-y += qapi/qapi-events-sockets.o
+util-obj-y += qapi/qapi-events-tlimits.o
 util-obj-y += qapi/qapi-events-tpm.o
 util-obj-y += qapi/qapi-events-trace.o
 util-obj-y += qapi/qapi-events-transaction.o
-util-obj-y += qapi/qapi-events-tlimits.o
 util-obj-y += qapi/qapi-events-ui.o
 util-obj-y += qapi/qapi-introspect.o
 
@@ -146,6 +149,7 @@ common-obj-y += qapi/qapi-commands-block.o
 common-obj-y += qapi/qapi-commands-char.o
 common-obj-y += qapi/qapi-commands-common.o
 common-obj-y += qapi/qapi-commands-crypto.o
+common-obj-y += qapi/qapi-commands-fsdev.o
 common-obj-y += qapi/qapi-commands-introspect.o
 common-obj-y += qapi/qapi-commands-job.o
 common-obj-y += qapi/qapi-commands-migration.o
@@ -154,10 +158,10 @@ common-obj-y += qapi/qapi-commands-net.o
 common-obj-y += qapi/qapi-commands-rocker.o
 common-obj-y += qapi/qapi-commands-run-state.o
 common-obj-y += qapi/qapi-commands-sockets.o
+common-obj-y += qapi/qapi-commands-tlimits.o
 common-obj-y += qapi/qapi-commands-tpm.o
 common-obj-y += qapi/qapi-commands-trace.o
 common-obj-y += qapi/qapi-commands-transaction.o
-common-obj-y += qapi/qapi-commands-tlimits.o
 common-obj-y += qapi/qapi-commands-ui.o
 common-obj-y += qapi/qapi-introspect.o
 common-obj-y += qmp.o hmp.o
diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
index 489cd29..9a90960 100644
--- a/fsdev/qemu-fsdev-dummy.c
+++ b/fsdev/qemu-fsdev-dummy.c
@@ -14,8 +14,19 @@
 #include "qemu-fsdev.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
+#include "qapi/qapi-commands-fsdev.h"
 
 int qemu_fsdev_add(QemuOpts *opts, Error **errp)
 {
     return 0;
 }
+
+void qmp_fsdev_set_io_throttle(FsdevIOThrottle *arg, Error **errp)
+{
+    return;
+}
+
+FsdevIOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    return NULL;
+}
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 6a4108a..720fea9 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -17,6 +17,7 @@
 #include "qemu-fsdev-throttle.h"
 #include "qemu/iov.h"
 #include "qemu/option.h"
+#include "qemu/main-loop.h"
 #include "qemu/throttle-options.h"
 
 static void fsdev_throttle_read_timer_cb(void *opaque)
@@ -31,6 +32,94 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
     qemu_co_enter_next(&fst->throttled_reqs[true], NULL);
 }
 
+typedef struct {
+    FsThrottle *fst;
+    bool is_write;
+} RestartData;
+
+static bool coroutine_fn throttle_co_restart_queue(FsThrottle *fst,
+                                                   bool is_write)
+{
+    return qemu_co_queue_next(&fst->throttled_reqs[is_write]);
+}
+
+static void schedule_next_request(FsThrottle *fst, bool is_write)
+{
+    bool must_wait = throttle_schedule_timer(&fst->ts, &fst->tt, is_write);
+    if (!must_wait) {
+        if (qemu_in_coroutine() &&
+            throttle_co_restart_queue(fst, is_write)) {
+            return;
+        } else {
+            int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+            timer_mod(fst->tt.timers[is_write], now);
+        }
+    }
+}
+
+static void coroutine_fn throttle_restart_queue_entry(void *opaque)
+{
+    RestartData *data = opaque;
+    bool is_write = data->is_write;
+    bool empty_queue = !throttle_co_restart_queue(data->fst, is_write);
+    if (empty_queue) {
+        schedule_next_request(data->fst, is_write);
+    }
+}
+
+static void throttle_restart_queues(FsThrottle *fst)
+{
+    Coroutine *co;
+    RestartData rd = {
+        .fst = fst,
+        .is_write = true
+    };
+     co = qemu_coroutine_create(throttle_restart_queue_entry, &rd);
+    aio_co_enter(fst->ctx, co);
+     rd.is_write = false;
+     co = qemu_coroutine_create(throttle_restart_queue_entry, &rd);
+    aio_co_enter(fst->ctx, co);
+}
+
+static void coroutine_fn fsdev_throttle_config(FsThrottle *fst)
+{
+    if (throttle_enabled(&fst->cfg)) {
+        throttle_config(&fst->ts, QEMU_CLOCK_REALTIME, &fst->cfg);
+    } else {
+        throttle_restart_queues(fst);
+    }
+}
+
+void fsdev_set_io_throttle(FsdevIOThrottle *arg, FsThrottle *fst, Error **errp)
+{
+    ThrottleConfig cfg;
+
+    throttle_get_config(&fst->ts, &cfg);
+    throttle_limits_to_config(qapi_FsdevIOThrottle_base(arg), &cfg, errp);
+
+    if (*errp == NULL) {
+        fst->cfg = cfg;
+        if (!throttle_timers_are_initialized(&fst->tt)) {
+            fsdev_throttle_init(fst);
+        } else {
+            fsdev_throttle_config(fst);
+        }
+    }
+}
+
+void fsdev_get_io_throttle(FsThrottle *fst, FsdevIOThrottle **fs9pcfg,
+                           char *fsdevice)
+{
+    ThrottleConfig cfg = fst->cfg;
+    ThrottleLimits *tlimits;
+    FsdevIOThrottle *fscfg = g_malloc(sizeof(*fscfg));
+    tlimits = qapi_FsdevIOThrottle_base(fscfg);
+    fscfg->has_id = true;
+    fscfg->id = g_strdup(fsdevice);
+    throttle_config_to_limits(&cfg, tlimits);
+    *fs9pcfg = fscfg;
+}
+
 void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
 {
     throttle_parse_options(&fst->cfg, opts);
@@ -41,8 +130,9 @@ void fsdev_throttle_init(FsThrottle *fst)
 {
     if (throttle_enabled(&fst->cfg)) {
         throttle_init(&fst->ts);
+        fst->ctx = qemu_get_aio_context();
         throttle_timers_init(&fst->tt,
-                             qemu_get_aio_context(),
+                             fst->ctx,
                              QEMU_CLOCK_REALTIME,
                              fsdev_throttle_read_timer_cb,
                              fsdev_throttle_write_timer_cb,
@@ -63,11 +153,7 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
         }
 
         throttle_account(&fst->ts, is_write, iov_size(iov, iovcnt));
-
-        if (!qemu_co_queue_empty(&fst->throttled_reqs[is_write]) &&
-            !throttle_schedule_timer(&fst->ts, &fst->tt, is_write)) {
-            qemu_co_queue_next(&fst->throttled_reqs[is_write]);
-        }
+        schedule_next_request(fst, is_write);
     }
 }
 
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index 4e83bda..7107769 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -15,15 +15,15 @@
 #ifndef _FSDEV_THROTTLE_H
 #define _FSDEV_THROTTLE_H
 
-#include "block/aio.h"
-#include "qemu/main-loop.h"
 #include "qemu/coroutine.h"
 #include "qemu/throttle.h"
+#include "qapi/qapi-types-fsdev.h"
 
 typedef struct FsThrottle {
     ThrottleState ts;
     ThrottleTimers tt;
     ThrottleConfig cfg;
+    AioContext *ctx;
     CoQueue      throttled_reqs[2];
 } FsThrottle;
 
@@ -35,4 +35,6 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
                                             struct iovec *, int);
 
 void fsdev_throttle_cleanup(FsThrottle *);
+void fsdev_set_io_throttle(FsdevIOThrottle *, FsThrottle *, Error **errp);
+void fsdev_get_io_throttle(FsThrottle *, FsdevIOThrottle **iothp, char *);
 #endif /* _FSDEV_THROTTLE_H */
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 7a3b87c..609d8fc 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -17,6 +17,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qapi/qapi-commands-fsdev.h"
 
 static QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry) fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
@@ -99,3 +100,31 @@ FsDriverEntry *get_fsdev_fsentry(char *id)
     }
     return NULL;
 }
+
+void qmp_fsdev_set_io_throttle(FsdevIOThrottle *arg, Error **errp)
+{
+    FsDriverEntry *fse;
+
+    fse = get_fsdev_fsentry(arg->has_id ? arg->id : NULL);
+    if (!fse) {
+        error_setg(errp, "Not a valid fsdev device");
+        return;
+    }
+
+    fsdev_set_io_throttle(arg, &fse->fst, errp);
+}
+
+FsdevIOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    FsdevIOThrottleList *head = NULL, *p_next;
+    struct FsDriverListEntry *fsle;
+
+    QTAILQ_FOREACH(fsle, &fsdriver_entries, next) {
+        p_next = g_new0(FsdevIOThrottleList, 1);
+        fsdev_get_io_throttle(&fsle->fse.fst, &p_next->value,
+                              fsle->fse.fsdev_id);
+        p_next->next = head;
+        head = p_next;
+    }
+    return head;
+}
diff --git a/qapi/fsdev.json b/qapi/fsdev.json
new file mode 100644
index 0000000..5c8e7de
--- /dev/null
+++ b/qapi/fsdev.json
@@ -0,0 +1,96 @@
+# -*- Mode: Python -*-
+
+##
+# == QAPI fsdev definitions
+##
+
+{ 'include': 'tlimits.json' }
+
+##
+# @FsdevIOThrottle:
+#
+# A set of parameters describing fsdev throttling.
+#
+# @id: device id
+#
+# Since: 3.2
+##
+{ 'struct': 'FsdevIOThrottle',
+  'base': 'ThrottleLimits',
+  'data': { '*id': 'str' } }
+
+##
+# @fsdev-set-io-throttle:
+#
+# Change I/O limits for a 9p/fsdev device.
+#
+# I/O limits can be enabled by setting throttle value to non-zero number.
+#
+# I/O limits can be disabled by setting all throttle values to 0.
+#
+# Returns: Nothing on success
+#          If @device is not a valid fsdev device, GenericError
+#
+# Since: 3.2
+#
+# Example:
+#
+# -> { "execute": "fsdev-set-io-throttle",
+#      "arguments": { "id": "id0-1-0",
+#                     "bps": 1000000,
+#                     "bps_rd": 0,
+#                     "bps_wr": 0,
+#                     "iops": 0,
+#                     "iops_rd": 0,
+#                     "iops_wr": 0,
+#                     "bps_max": 8000000,
+#                     "bps_rd_max": 0,
+#                     "bps_wr_max": 0,
+#                     "iops_max": 0,
+#                     "iops_rd_max": 0,
+#                     "iops_wr_max": 0,
+#                     "bps_max_length": 60,
+#                     "iops_size": 0 } }
+# <- { "returns": {} }
+##
+{ 'command': 'fsdev-set-io-throttle', 'boxed': true,
+  'data': 'FsdevIOThrottle' }
+##
+# @query-fsdev-io-throttle:
+#
+# Returns: a list of @IOThrottle describing I/O throttle
+#          values of each fsdev device
+#
+# Since: 3.2
+#
+# Example:
+#
+# -> { "Execute": "query-fsdev-io-throttle" }
+# <- { "returns" : [
+#          {
+#              "id": "id0-hd0",
+#              "bps":1000000,
+#              "bps_rd":0,
+#              "bps_wr":0,
+#              "iops":1000000,
+#              "iops_rd":0,
+#              "iops_wr":0,
+#              "bps_max": 8000000,
+#              "bps_rd_max": 0,
+#              "bps_wr_max": 0,
+#              "iops_max": 0,
+#              "iops_rd_max": 0,
+#              "iops_wr_max": 0,
+#              "bps_max_length": 0,
+#              "bps_rd_max_length": 0,
+#              "bps_wr_max_length": 0,
+#              "iops_max_length": 0,
+#              "iops_rd_max_length": 0,
+#              "iops_wr_max_length": 0,
+#              "iops_size": 0
+#            }
+#          ]
+#      }
+#
+##
+{ 'command': 'query-fsdev-io-throttle', 'returns': [ 'FsdevIOThrottle' ] }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index e9f594e..8fce6d9 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -95,3 +95,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'fsdev.json' }
diff --git a/qmp.c b/qmp.c
index e7c0a2f..3f3171a 100644
--- a/qmp.c
+++ b/qmp.c
@@ -32,6 +32,7 @@
 #include "qom/qom-qobject.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-commands-fsdev.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qdict.h"
@@ -737,3 +738,15 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 
     return mem_info;
 }
+
+#if defined(_WIN64) || defined(_WIN32) || defined(__FreeBSD__)
+void qmp_fsdev_set_io_throttle(FsdevIOThrottle *arg, Error **errp)
+{
+    return;
+}
+
+FsdevIOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    return NULL;
+}
+#endif
-- 
1.8.3.1
