Received: from eggs.gnu.org ([2001:4830:134:3::10]:59703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZ8V-0002A4-Me
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZ8S-0006fh-Vv
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50196 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gNZ8R-0006bP-W5
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:52 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Fri, 16 Nov 2018 16:00:06 +0800
Message-ID: <2aadccc4e1230fdd81f0963ed5cdfef77d5c03d8.1542384802.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542384802.git.xiezhide@huawei.com>
References: <cover.1542384802.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 4/6] fsdev-throttle-qmp: Move ThrottleLimits
 into a new file for future reuse
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

Move ThrottleLimits into a new file for future reuse.

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 Makefile              |  9 +++++++++
 Makefile.objs         |  4 ++++
 qapi/block-core.json  | 49 +----------------------------------------------
 qapi/qapi-schema.json |  1 +
 qapi/tlimits.json     | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 48 deletions(-)
 create mode 100644 qapi/tlimits.json

diff --git a/Makefile b/Makefile
index f294718..b546e98 100644
--- a/Makefile
+++ b/Makefile
@@ -106,6 +106,7 @@ GENERATED_FILES += qapi/qapi-types-sockets.h qapi/qapi-types-sockets.c
 GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
 GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
 GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
+GENERATED_FILES += qapi/qapi-types-tlimits.h qapi/qapi-types-tlimits.c
 GENERATED_FILES += qapi/qapi-types-ui.h qapi/qapi-types-ui.c
 GENERATED_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
 GENERATED_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
@@ -125,6 +126,7 @@ GENERATED_FILES += qapi/qapi-visit-sockets.h qapi/qapi-visit-sockets.c
 GENERATED_FILES += qapi/qapi-visit-tpm.h qapi/qapi-visit-tpm.c
 GENERATED_FILES += qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
 GENERATED_FILES += qapi/qapi-visit-transaction.h qapi/qapi-visit-transaction.c
+GENERATED_FILES += qapi/qapi-visit-tlimits.h qapi/qapi-visit-tlimits.c
 GENERATED_FILES += qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
 GENERATED_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_FILES += qapi/qapi-commands-block-core.h qapi/qapi-commands-block-core.c
@@ -143,6 +145,7 @@ GENERATED_FILES += qapi/qapi-commands-sockets.h qapi/qapi-commands-sockets.c
 GENERATED_FILES += qapi/qapi-commands-tpm.h qapi/qapi-commands-tpm.c
 GENERATED_FILES += qapi/qapi-commands-trace.h qapi/qapi-commands-trace.c
 GENERATED_FILES += qapi/qapi-commands-transaction.h qapi/qapi-commands-transaction.c
+GENERATED_FILES += qapi/qapi-commands-tlimits.h qapi/qapi-commands-tlimits.c
 GENERATED_FILES += qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
 GENERATED_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_FILES += qapi/qapi-events-block-core.h qapi/qapi-events-block-core.c
@@ -161,6 +164,7 @@ GENERATED_FILES += qapi/qapi-events-sockets.h qapi/qapi-events-sockets.c
 GENERATED_FILES += qapi/qapi-events-tpm.h qapi/qapi-events-tpm.c
 GENERATED_FILES += qapi/qapi-events-trace.h qapi/qapi-events-trace.c
 GENERATED_FILES += qapi/qapi-events-transaction.h qapi/qapi-events-transaction.c
+GENERATED_FILES += qapi/qapi-events-tlimits.h qapi/qapi-events-tlimits.c
 GENERATED_FILES += qapi/qapi-events-ui.h qapi/qapi-events-ui.c
 GENERATED_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
 GENERATED_FILES += qapi/qapi-doc.texi
@@ -596,6 +600,7 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
                $(SRC_PATH)/qapi/tpm.json \
+               $(SRC_PATH)/qapi/tlimits.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
@@ -618,6 +623,7 @@ qapi/qapi-types-sockets.c qapi/qapi-types-sockets.h \
 qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
+qapi/qapi-types-tlimits.c qapi/qapi-types-tlimits.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
 qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
 qapi/qapi-visit.c qapi/qapi-visit.h \
@@ -637,6 +643,7 @@ qapi/qapi-visit-sockets.c qapi/qapi-visit-sockets.h \
 qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
+qapi/qapi-visit-tlimits.c qapi/qapi-visit-tlimits.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
 qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
@@ -655,6 +662,7 @@ qapi/qapi-commands-sockets.c qapi/qapi-commands-sockets.h \
 qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
+qapi/qapi-commands-tlimits.c qapi/qapi-commands-tlimits.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
 qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
@@ -673,6 +681,7 @@ qapi/qapi-events-sockets.c qapi/qapi-events-sockets.h \
 qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
+qapi/qapi-events-tlimits.c qapi/qapi-events-tlimits.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
 qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
diff --git a/Makefile.objs b/Makefile.objs
index 1e1ff38..682e6ba 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -20,6 +20,7 @@ util-obj-y += qapi/qapi-types-sockets.o
 util-obj-y += qapi/qapi-types-tpm.o
 util-obj-y += qapi/qapi-types-trace.o
 util-obj-y += qapi/qapi-types-transaction.o
+util-obj-y += qapi/qapi-types-tlimits.o
 util-obj-y += qapi/qapi-types-ui.o
 util-obj-y += qapi/qapi-builtin-visit.o
 util-obj-y += qapi/qapi-visit.o
@@ -39,6 +40,7 @@ util-obj-y += qapi/qapi-visit-sockets.o
 util-obj-y += qapi/qapi-visit-tpm.o
 util-obj-y += qapi/qapi-visit-trace.o
 util-obj-y += qapi/qapi-visit-transaction.o
+util-obj-y += qapi/qapi-visit-tlimits.o
 util-obj-y += qapi/qapi-visit-ui.o
 util-obj-y += qapi/qapi-events.o
 util-obj-y += qapi/qapi-events-block-core.o
@@ -57,6 +59,7 @@ util-obj-y += qapi/qapi-events-sockets.o
 util-obj-y += qapi/qapi-events-tpm.o
 util-obj-y += qapi/qapi-events-trace.o
 util-obj-y += qapi/qapi-events-transaction.o
+util-obj-y += qapi/qapi-events-tlimits.o
 util-obj-y += qapi/qapi-events-ui.o
 util-obj-y += qapi/qapi-introspect.o
 
@@ -154,6 +157,7 @@ common-obj-y += qapi/qapi-commands-sockets.o
 common-obj-y += qapi/qapi-commands-tpm.o
 common-obj-y += qapi/qapi-commands-trace.o
 common-obj-y += qapi/qapi-commands-transaction.o
+common-obj-y += qapi/qapi-commands-tlimits.o
 common-obj-y += qapi/qapi-commands-ui.o
 common-obj-y += qapi/qapi-introspect.o
 common-obj-y += qmp.o hmp.o
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3abd6af..05296b0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -8,6 +8,7 @@
 { 'include': 'crypto.json' }
 { 'include': 'job.json' }
 { 'include': 'sockets.json' }
+{ 'include': 'tlimits.json' }
 
 ##
 # @SnapshotInfo:
@@ -2164,54 +2165,6 @@
   'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }
 
 ##
-# @ThrottleLimits:
-#
-# Limit parameters for throttling.
-# Since some limit combinations are illegal, limits should always be set in one
-# transaction. All fields are optional. When setting limits, if a field is
-# missing the current value is not changed.
-#
-# @iops:             limit total I/O operations per second
-# @iops_max:         I/O operations burst
-# @iops_max_length:  length of the iops_total_max burst period, in seconds
-#                          It must only be set if @iops_total_max is set as well.
-# @iops_rd:              limit read operations per second
-# @iops_rd_max:          I/O operations read burst
-# @iops_rd_max_length:   length of the iops_read_max burst period, in seconds
-#                          It must only be set if @iops_read_max is set as well.
-# @iops_wr:             limit write operations per second
-# @iops_wr_max:         I/O operations write burst
-# @iops_wr_max_length:  length of the iops_write_max burst period, in seconds
-#                          It must only be set if @iops_write_max is set as well.
-# @bps:              limit total bytes per second
-# @bps_max:          total bytes burst
-# @bps_max_length:   length of the bps_total_max burst period, in seconds.
-#                          It must only be set if @bps_total_max is set as well.
-# @bps_rd:               limit read bytes per second
-# @bps_rd_max:           total bytes read burst
-# @bps_rd_max_length:    length of the bps_read_max burst period, in seconds
-#                          It must only be set if @bps_read_max is set as well.
-# @bps_wr:              limit write bytes per second
-# @bps_wr_max:          total bytes write burst
-# @bps_wr_max_length:   length of the bps_write_max burst period, in seconds
-#                          It must only be set if @bps_write_max is set as well.
-# @iops_size:              when limiting by iops max size of an I/O in bytes
-#
-# Since: 2.11
-##
-{ 'struct': 'ThrottleLimits',
-  'data': { '*iops' : 'int', '*iops_max' : 'int',
-            '*iops_max_length' : 'int', '*iops_rd' : 'int',
-            '*iops_rd_max' : 'int', '*iops_rd_max_length' : 'int',
-            '*iops_wr' : 'int', '*iops_wr_max' : 'int',
-            '*iops_wr_max_length' : 'int', '*bps' : 'int',
-            '*bps_max' : 'int', '*bps_max_length' : 'int',
-            '*bps_rd' : 'int', '*bps_rd_max' : 'int',
-            '*bps_rd_max_length' : 'int', '*bps_wr' : 'int',
-            '*bps_wr_max' : 'int', '*bps_wr_max_length' : 'int',
-            '*iops_size' : 'int' } }
-
-##
 # @block-stream:
 #
 # Copy data from a backing file into a block device.
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2..e9f594e 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -90,6 +90,7 @@
 { 'include': 'tpm.json' }
 { 'include': 'ui.json' }
 { 'include': 'migration.json' }
+{ 'include': 'tlimits.json' }
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
diff --git a/qapi/tlimits.json b/qapi/tlimits.json
new file mode 100644
index 0000000..ad867de
--- /dev/null
+++ b/qapi/tlimits.json
@@ -0,0 +1,53 @@
+# -*- Mode: Python -*-
+
+##
+# == Throttle limits
+##
+
+##
+# @ThrottleLimits:
+#
+# Limit parameters for throttling.
+# Since some limit combinations are illegal, limits should always be set in one
+# transaction. All fields are optional. When setting limits, if a field is
+# missing the current value is not changed.
+#
+# @iops:             limit total I/O operations per second
+# @iops_max:         I/O operations burst
+# @iops_max_length:  length of the iops_total_max burst period, in seconds
+#                          It must only be set if @iops_total_max is set as well.
+# @iops_rd:              limit read operations per second
+# @iops_rd_max:          I/O operations read burst
+# @iops_rd_max_length:   length of the iops_read_max burst period, in seconds
+#                          It must only be set if @iops_read_max is set as well.
+# @iops_wr:             limit write operations per second
+# @iops_wr_max:         I/O operations write burst
+# @iops_wr_max_length:  length of the iops_write_max burst period, in seconds
+#                          It must only be set if @iops_write_max is set as well.
+# @bps:              limit total bytes per second
+# @bps_max:          total bytes burst
+# @bps_max_length:   length of the bps_total_max burst period, in seconds.
+#                          It must only be set if @bps_total_max is set as well.
+# @bps_rd:               limit read bytes per second
+# @bps_rd_max:           total bytes read burst
+# @bps_rd_max_length:    length of the bps_read_max burst period, in seconds
+#                          It must only be set if @bps_read_max is set as well.
+# @bps_wr:              limit write bytes per second
+# @bps_wr_max:          total bytes write burst
+# @bps_wr_max_length:    length of the bps_read_max burst period, in seconds
+#                          It must only be set if @bps_read_max is set as well.
+# @iops_size:              when limiting by iops max size of an I/O in bytes
+#
+# Since: 2.11
+##
+{ 'struct': 'ThrottleLimits',
+  'data': { '*iops' : 'int', '*iops_max' : 'int',
+            '*iops_max_length' : 'int', '*iops_rd' : 'int',
+            '*iops_rd_max' : 'int', '*iops_rd_max_length' : 'int',
+            '*iops_wr' : 'int', '*iops_wr_max' : 'int',
+            '*iops_wr_max_length' : 'int', '*bps' : 'int',
+            '*bps_max' : 'int', '*bps_max_length' : 'int',
+            '*bps_rd' : 'int', '*bps_rd_max' : 'int',
+            '*bps_rd_max_length' : 'int', '*bps_wr' : 'int',
+            '*bps_wr_max' : 'int', '*bps_wr_max_length' : 'int',
+            '*iops_size' : 'int' } }
-- 
1.8.3.1
