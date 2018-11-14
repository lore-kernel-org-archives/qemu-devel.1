Received: from eggs.gnu.org ([2001:4830:134:3::10]:39068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMrYi-00076m-0r
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMrYe-0003iK-RI
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:34:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3103 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gMrYd-0003hM-UL
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:34:00 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Wed, 14 Nov 2018 17:28:15 +0800
Message-ID: <37e2a76b4020a5f9e48fe3b7c36d8e4bfb111569.1542187291.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542187291.git.xiezhide@huawei.com>
References: <cover.1542187291.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/4] fsdev-throttle-qmp: move struct
 ThrottleLimits to new file
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

this patch move ThrottleLimits to new file and rename struct
field with common format

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 Makefile              |   9 +++
 Makefile.objs         |   4 ++
 blockdev.c            |  51 +---------------
 qapi/block-core.json  | 122 +-------------------------------------
 qapi/qapi-schema.json |   1 +
 qapi/tlimits.json     |  89 ++++++++++++++++++++++++++++
 util/throttle.c       | 161 +++++++++++++++++++++++++-------------------------
 7 files changed, 187 insertions(+), 250 deletions(-)
 create mode 100644 qapi/tlimits.json

diff --git a/Makefile b/Makefile
index f294718..8990081 100644
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
@@ -598,6 +602,7 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
+               $(SRC_PATH)/qapi/tlimits.json \
                $(SRC_PATH)/qapi/ui.json
 
 qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
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
diff --git a/blockdev.c b/blockdev.c
index fce5d8f..0683c07 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2701,56 +2701,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
         goto out;
     }
 
-    throttle_config_init(&cfg);
-    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
-    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
-    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
-
-    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
-    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
-    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
-
-    if (arg->has_bps_max) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
-    }
-    if (arg->has_bps_rd_max) {
-        cfg.buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
-    }
-    if (arg->has_bps_wr_max) {
-        cfg.buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
-    }
-    if (arg->has_iops_max) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
-    }
-    if (arg->has_iops_rd_max) {
-        cfg.buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
-    }
-    if (arg->has_iops_wr_max) {
-        cfg.buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
-    }
-
-    if (arg->has_bps_max_length) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
-    }
-    if (arg->has_bps_rd_max_length) {
-        cfg.buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
-    }
-    if (arg->has_bps_wr_max_length) {
-        cfg.buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
-    }
-    if (arg->has_iops_max_length) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
-    }
-    if (arg->has_iops_rd_max_length) {
-        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
-    }
-    if (arg->has_iops_wr_max_length) {
-        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
-    }
-
-    if (arg->has_iops_size) {
-        cfg.op_size = arg->iops_size;
-    }
+    throttle_limits_to_config(qapi_BlockIOThrottle_base(arg), &cfg, errp);
 
     if (!throttle_is_valid(&cfg, errp)) {
         goto out;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d4fe710..05296b0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -8,6 +8,7 @@
 { 'include': 'crypto.json' }
 { 'include': 'job.json' }
 { 'include': 'sockets.json' }
+{ 'include': 'tlimits.json' }
 
 ##
 # @SnapshotInfo:
@@ -2155,130 +2156,13 @@
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
-# @bps: total throughput limit in bytes per second
-#
-# @bps_rd: read throughput limit in bytes per second
-#
-# @bps_wr: write throughput limit in bytes per second
-#
-# @iops: total I/O operations per second
-#
-# @iops_rd: read I/O operations per second
-#
-# @iops_wr: write I/O operations per second
-#
-# @bps_max: total throughput limit during bursts,
-#                     in bytes (Since 1.7)
-#
-# @bps_rd_max: read throughput limit during bursts,
-#                        in bytes (Since 1.7)
-#
-# @bps_wr_max: write throughput limit during bursts,
-#                        in bytes (Since 1.7)
-#
-# @iops_max: total I/O operations per second during bursts,
-#                      in bytes (Since 1.7)
-#
-# @iops_rd_max: read I/O operations per second during bursts,
-#                         in bytes (Since 1.7)
-#
-# @iops_wr_max: write I/O operations per second during bursts,
-#                         in bytes (Since 1.7)
-#
-# @bps_max_length: maximum length of the @bps_max burst
-#                            period, in seconds. It must only
-#                            be set if @bps_max is set as well.
-#                            Defaults to 1. (Since 2.6)
-#
-# @bps_rd_max_length: maximum length of the @bps_rd_max
-#                               burst period, in seconds. It must only
-#                               be set if @bps_rd_max is set as well.
-#                               Defaults to 1. (Since 2.6)
-#
-# @bps_wr_max_length: maximum length of the @bps_wr_max
-#                               burst period, in seconds. It must only
-#                               be set if @bps_wr_max is set as well.
-#                               Defaults to 1. (Since 2.6)
-#
-# @iops_max_length: maximum length of the @iops burst
-#                             period, in seconds. It must only
-#                             be set if @iops_max is set as well.
-#                             Defaults to 1. (Since 2.6)
-#
-# @iops_rd_max_length: maximum length of the @iops_rd_max
-#                                burst period, in seconds. It must only
-#                                be set if @iops_rd_max is set as well.
-#                                Defaults to 1. (Since 2.6)
-#
-# @iops_wr_max_length: maximum length of the @iops_wr_max
-#                                burst period, in seconds. It must only
-#                                be set if @iops_wr_max is set as well.
-#                                Defaults to 1. (Since 2.6)
-#
-# @iops_size: an I/O size in bytes (Since 1.7)
-#
 # @group: throttle group name (Since 2.4)
 #
 # Since: 1.1
 ##
 { 'struct': 'BlockIOThrottle',
-  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
-            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
-            '*bps_max': 'int', '*bps_rd_max': 'int',
-            '*bps_wr_max': 'int', '*iops_max': 'int',
-            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
-            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
-            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
-            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
-            '*iops_size': 'int', '*group': 'str' } }
-
-##
-# @ThrottleLimits:
-#
-# Limit parameters for throttling.
-# Since some limit combinations are illegal, limits should always be set in one
-# transaction. All fields are optional. When setting limits, if a field is
-# missing the current value is not changed.
-#
-# @iops-total:             limit total I/O operations per second
-# @iops-total-max:         I/O operations burst
-# @iops-total-max-length:  length of the iops-total-max burst period, in seconds
-#                          It must only be set if @iops-total-max is set as well.
-# @iops-read:              limit read operations per second
-# @iops-read-max:          I/O operations read burst
-# @iops-read-max-length:   length of the iops-read-max burst period, in seconds
-#                          It must only be set if @iops-read-max is set as well.
-# @iops-write:             limit write operations per second
-# @iops-write-max:         I/O operations write burst
-# @iops-write-max-length:  length of the iops-write-max burst period, in seconds
-#                          It must only be set if @iops-write-max is set as well.
-# @bps-total:              limit total bytes per second
-# @bps-total-max:          total bytes burst
-# @bps-total-max-length:   length of the bps-total-max burst period, in seconds.
-#                          It must only be set if @bps-total-max is set as well.
-# @bps-read:               limit read bytes per second
-# @bps-read-max:           total bytes read burst
-# @bps-read-max-length:    length of the bps-read-max burst period, in seconds
-#                          It must only be set if @bps-read-max is set as well.
-# @bps-write:              limit write bytes per second
-# @bps-write-max:          total bytes write burst
-# @bps-write-max-length:   length of the bps-write-max burst period, in seconds
-#                          It must only be set if @bps-write-max is set as well.
-# @iops-size:              when limiting by iops max size of an I/O in bytes
-#
-# Since: 2.11
-##
-{ 'struct': 'ThrottleLimits',
-  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
-            '*iops-total-max-length' : 'int', '*iops-read' : 'int',
-            '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
-            '*iops-write' : 'int', '*iops-write-max' : 'int',
-            '*iops-write-max-length' : 'int', '*bps-total' : 'int',
-            '*bps-total-max' : 'int', '*bps-total-max-length' : 'int',
-            '*bps-read' : 'int', '*bps-read-max' : 'int',
-            '*bps-read-max-length' : 'int', '*bps-write' : 'int',
-            '*bps-write-max' : 'int', '*bps-write-max-length' : 'int',
-            '*iops-size' : 'int' } }
+  'base': 'ThrottleLimits',
+  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }
 
 ##
 # @block-stream:
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2..13d7c0f 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -94,3 +94,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'tlimits.json' }
diff --git a/qapi/tlimits.json b/qapi/tlimits.json
new file mode 100644
index 0000000..6bcbaf6
--- /dev/null
+++ b/qapi/tlimits.json
@@ -0,0 +1,89 @@
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
+# @bps: total throughput limit in bytes per second
+#
+# @bps_rd: read throughput limit in bytes per second
+#
+# @bps_wr: write throughput limit in bytes per second
+#
+# @iops: total I/O operations per second
+#
+# @iops_rd: read I/O operations per second
+#
+# @iops_wr: write I/O operations per second
+#
+# @bps_max: total throughput limit during bursts,
+#                     in bytes (Since 1.7)
+#
+# @bps_rd_max: read throughput limit during bursts,
+#                        in bytes (Since 1.7)
+#
+# @bps_wr_max: write throughput limit during bursts,
+#                        in bytes (Since 1.7)
+#
+# @iops_max: total I/O operations per second during bursts,
+#                      in bytes (Since 1.7)
+#
+# @iops_rd_max: read I/O operations per second during bursts,
+#                         in bytes (Since 1.7)
+#
+# @iops_wr_max: write I/O operations per second during bursts,
+#                         in bytes (Since 1.7)
+#
+# @bps_max_length: maximum length of the @bps_max burst
+#                            period, in seconds. It must only
+#                            be set if @bps_max is set as well.
+#                            Defaults to 1. (Since 2.6)
+#
+# @bps_rd_max_length: maximum length of the @bps_rd_max
+#                               burst period, in seconds. It must only
+#                               be set if @bps_rd_max is set as well.
+#                               Defaults to 1. (Since 2.6)
+#
+# @bps_wr_max_length: maximum length of the @bps_wr_max
+#                               burst period, in seconds. It must only
+#                               be set if @bps_wr_max is set as well.
+#                               Defaults to 1. (Since 2.6)
+#
+# @iops_max_length: maximum length of the @iops burst
+#                             period, in seconds. It must only
+#                             be set if @iops_max is set as well.
+#                             Defaults to 1. (Since 2.6)
+#
+# @iops_rd_max_length: maximum length of the @iops_rd_max
+#                                burst period, in seconds. It must only
+#                                be set if @iops_rd_max is set as well.
+#                                Defaults to 1. (Since 2.6)
+#
+# @iops_wr_max_length: maximum length of the @iops_wr_max
+#                                burst period, in seconds. It must only
+#                                be set if @iops_wr_max is set as well.
+#                                Defaults to 1. (Since 2.6)
+#
+# @iops_size: an I/O size in bytes (Since 1.7)
+#
+# Since: 4.0
+#
+##
+{ 'struct': 'ThrottleLimits',
+  'data': { '*bps': 'int', '*bps_rd': 'int',
+            '*bps_wr': 'int', '*iops': 'int', '*iops_rd': 'int', '*iops_wr': 'int',
+            '*bps_max': 'int', '*bps_rd_max': 'int',
+            '*bps_wr_max': 'int', '*iops_max': 'int',
+            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
+            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
+            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
+            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
+            '*iops_size': 'int' } }
diff --git a/util/throttle.c b/util/throttle.c
index e7db2ad..b421e33 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -496,98 +496,97 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
 void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
                                Error **errp)
 {
-    if (arg->has_bps_total) {
-        cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps_total;
+    if (arg->has_bps) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
     }
-    if (arg->has_bps_read) {
-        cfg->buckets[THROTTLE_BPS_READ].avg  = arg->bps_read;
+    if (arg->has_bps_rd) {
+        cfg->buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
     }
-    if (arg->has_bps_write) {
-        cfg->buckets[THROTTLE_BPS_WRITE].avg = arg->bps_write;
+    if (arg->has_bps_wr) {
+        cfg->buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
     }
 
-    if (arg->has_iops_total) {
-        cfg->buckets[THROTTLE_OPS_TOTAL].avg = arg->iops_total;
+    if (arg->has_iops) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
     }
-    if (arg->has_iops_read) {
-        cfg->buckets[THROTTLE_OPS_READ].avg  = arg->iops_read;
+    if (arg->has_iops_rd) {
+        cfg->buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
     }
-    if (arg->has_iops_write) {
-        cfg->buckets[THROTTLE_OPS_WRITE].avg = arg->iops_write;
+    if (arg->has_iops_wr) {
+        cfg->buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
     }
 
-    if (arg->has_bps_total_max) {
-        cfg->buckets[THROTTLE_BPS_TOTAL].max = arg->bps_total_max;
+    if (arg->has_bps_max) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
     }
-    if (arg->has_bps_read_max) {
-        cfg->buckets[THROTTLE_BPS_READ].max = arg->bps_read_max;
+    if (arg->has_bps_rd_max) {
+        cfg->buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
     }
-    if (arg->has_bps_write_max) {
-        cfg->buckets[THROTTLE_BPS_WRITE].max = arg->bps_write_max;
+    if (arg->has_bps_wr_max) {
+        cfg->buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
     }
-    if (arg->has_iops_total_max) {
-        cfg->buckets[THROTTLE_OPS_TOTAL].max = arg->iops_total_max;
+    if (arg->has_iops_max) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
     }
-    if (arg->has_iops_read_max) {
-        cfg->buckets[THROTTLE_OPS_READ].max = arg->iops_read_max;
+    if (arg->has_iops_rd_max) {
+        cfg->buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
     }
-    if (arg->has_iops_write_max) {
-        cfg->buckets[THROTTLE_OPS_WRITE].max = arg->iops_write_max;
+    if (arg->has_iops_wr_max) {
+        cfg->buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
     }
 
-    if (arg->has_bps_total_max_length) {
-        if (arg->bps_total_max_length > UINT_MAX) {
+    if (arg->has_bps_max_length) {
+        if (arg->bps_max_length > UINT_MAX) {
             error_setg(errp, "bps-total-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_total_max_length;
+        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
     }
-    if (arg->has_bps_read_max_length) {
-        if (arg->bps_read_max_length > UINT_MAX) {
+    if (arg->has_bps_rd_max_length) {
+        if (arg->bps_rd_max_length > UINT_MAX) {
             error_setg(errp, "bps-read-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_READ].burst_length = arg->bps_read_max_length;
+        cfg->buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
     }
-    if (arg->has_bps_write_max_length) {
-        if (arg->bps_write_max_length > UINT_MAX) {
+    if (arg->has_bps_wr_max_length) {
+        if (arg->bps_wr_max_length > UINT_MAX) {
             error_setg(errp, "bps-write-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_write_max_length;
+        cfg->buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
     }
-    if (arg->has_iops_total_max_length) {
-        if (arg->iops_total_max_length > UINT_MAX) {
+    if (arg->has_iops_max_length) {
+        if (arg->iops_max_length > UINT_MAX) {
             error_setg(errp, "iops-total-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_total_max_length;
+        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
     }
-    if (arg->has_iops_read_max_length) {
-        if (arg->iops_read_max_length > UINT_MAX) {
+    if (arg->has_iops_rd_max_length) {
+        if (arg->iops_rd_max_length > UINT_MAX) {
             error_setg(errp, "iops-read-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_READ].burst_length = arg->iops_read_max_length;
+        cfg->buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
     }
-    if (arg->has_iops_write_max_length) {
-        if (arg->iops_write_max_length > UINT_MAX) {
+    if (arg->has_iops_wr_max_length) {
+        if (arg->iops_wr_max_length > UINT_MAX) {
             error_setg(errp, "iops-write-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_write_max_length;
+        cfg->buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
     }
 
     if (arg->has_iops_size) {
         cfg->op_size = arg->iops_size;
     }
-
     throttle_is_valid(cfg, errp);
 }
 
@@ -598,45 +597,45 @@ void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
  */
 void throttle_config_to_limits(ThrottleConfig *cfg, ThrottleLimits *var)
 {
-    var->bps_total               = cfg->buckets[THROTTLE_BPS_TOTAL].avg;
-    var->bps_read                = cfg->buckets[THROTTLE_BPS_READ].avg;
-    var->bps_write               = cfg->buckets[THROTTLE_BPS_WRITE].avg;
-    var->iops_total              = cfg->buckets[THROTTLE_OPS_TOTAL].avg;
-    var->iops_read               = cfg->buckets[THROTTLE_OPS_READ].avg;
-    var->iops_write              = cfg->buckets[THROTTLE_OPS_WRITE].avg;
-    var->bps_total_max           = cfg->buckets[THROTTLE_BPS_TOTAL].max;
-    var->bps_read_max            = cfg->buckets[THROTTLE_BPS_READ].max;
-    var->bps_write_max           = cfg->buckets[THROTTLE_BPS_WRITE].max;
-    var->iops_total_max          = cfg->buckets[THROTTLE_OPS_TOTAL].max;
-    var->iops_read_max           = cfg->buckets[THROTTLE_OPS_READ].max;
-    var->iops_write_max          = cfg->buckets[THROTTLE_OPS_WRITE].max;
-    var->bps_total_max_length    = cfg->buckets[THROTTLE_BPS_TOTAL].burst_length;
-    var->bps_read_max_length     = cfg->buckets[THROTTLE_BPS_READ].burst_length;
-    var->bps_write_max_length    = cfg->buckets[THROTTLE_BPS_WRITE].burst_length;
-    var->iops_total_max_length   = cfg->buckets[THROTTLE_OPS_TOTAL].burst_length;
-    var->iops_read_max_length    = cfg->buckets[THROTTLE_OPS_READ].burst_length;
-    var->iops_write_max_length   = cfg->buckets[THROTTLE_OPS_WRITE].burst_length;
-    var->iops_size               = cfg->op_size;
+    var->bps                    = cfg->buckets[THROTTLE_BPS_TOTAL].avg;
+    var->bps_rd                 = cfg->buckets[THROTTLE_BPS_READ].avg;
+    var->bps_wr                 = cfg->buckets[THROTTLE_BPS_WRITE].avg;
+    var->iops                   = cfg->buckets[THROTTLE_OPS_TOTAL].avg;
+    var->iops_rd                = cfg->buckets[THROTTLE_OPS_READ].avg;
+    var->iops_wr                = cfg->buckets[THROTTLE_OPS_WRITE].avg;
+    var->bps_max                = cfg->buckets[THROTTLE_BPS_TOTAL].max;
+    var->bps_rd_max             = cfg->buckets[THROTTLE_BPS_READ].max;
+    var->bps_wr_max             = cfg->buckets[THROTTLE_BPS_WRITE].max;
+    var->iops_max               = cfg->buckets[THROTTLE_OPS_TOTAL].max;
+    var->iops_rd_max            = cfg->buckets[THROTTLE_OPS_READ].max;
+    var->iops_wr_max            = cfg->buckets[THROTTLE_OPS_WRITE].max;
+    var->bps_max_length         = cfg->buckets[THROTTLE_BPS_TOTAL].burst_length;
+    var->bps_rd_max_length      = cfg->buckets[THROTTLE_BPS_READ].burst_length;
+    var->bps_wr_max_length      = cfg->buckets[THROTTLE_BPS_WRITE].burst_length;
+    var->iops_max_length        = cfg->buckets[THROTTLE_OPS_TOTAL].burst_length;
+    var->iops_rd_max_length     = cfg->buckets[THROTTLE_OPS_READ].burst_length;
+    var->iops_wr_max_length     = cfg->buckets[THROTTLE_OPS_WRITE].burst_length;
+    var->iops_size              = cfg->op_size;
 
-    var->has_bps_total = true;
-    var->has_bps_read = true;
-    var->has_bps_write = true;
-    var->has_iops_total = true;
-    var->has_iops_read = true;
-    var->has_iops_write = true;
-    var->has_bps_total_max = true;
-    var->has_bps_read_max = true;
-    var->has_bps_write_max = true;
-    var->has_iops_total_max = true;
-    var->has_iops_read_max = true;
-    var->has_iops_write_max = true;
-    var->has_bps_read_max_length = true;
-    var->has_bps_total_max_length = true;
-    var->has_bps_write_max_length = true;
-    var->has_iops_total_max_length = true;
-    var->has_iops_read_max_length = true;
-    var->has_iops_write_max_length = true;
-    var->has_iops_size = true;
+    var->has_bps                = true;
+    var->has_bps_rd             = true;
+    var->has_bps_wr             = true;
+    var->has_iops               = true;
+    var->has_iops_rd            = true;
+    var->has_iops_wr            = true;
+    var->has_bps_max            = true;
+    var->has_bps_rd_max         = true;
+    var->has_bps_wr_max         = true;
+    var->has_iops_max           = true;
+    var->has_iops_rd_max        = true;
+    var->has_iops_wr_max        = true;
+    var->has_bps_rd_max_length  = true;
+    var->has_bps_max_length     = true;
+    var->has_bps_wr_max_length  = true;
+    var->has_iops_max_length    = true;
+    var->has_iops_rd_max_length = true;
+    var->has_iops_wr_max_length = true;
+    var->has_iops_size          = true;
 }
 
 /* parse the throttle options
-- 
2.7.4
