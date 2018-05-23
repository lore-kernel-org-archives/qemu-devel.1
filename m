Received: from eggs.gnu.org ([2001:4830:134:3::10]:53468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZb-0002WW-83
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZT-0007K1-PJ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:49 +0200
Message-Id: <20180523131155.12359-41-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 40/46] job: Introduce qapi/job.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This adds a separate schema file for all job-related definitions that
aren't tied to the block layer.

For a start, move the enums JobType, JobStatus and JobVerb.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json  | 90 +-----------------------------------------------
 qapi/job.json         | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json |  1 +
 MAINTAINERS           |  1 +
 Makefile              |  9 +++++
 Makefile.objs         |  4 +++
 6 files changed, 110 insertions(+), 89 deletions(-)
 create mode 100644 qapi/job.json

diff --git a/qapi/block-core.json b/qapi/block-core.json
index bb964b4319..7dfa77a05c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -6,6 +6,7 @@
 
 { 'include': 'common.json' }
 { 'include': 'crypto.json' }
+{ 'include': 'job.json' }
 { 'include': 'sockets.json' }
 
 ##
@@ -1050,95 +1051,6 @@
   'data': ['top', 'full', 'none', 'incremental'] }
 
 ##
-# @JobType:
-#
-# Type of a background job.
-#
-# @commit: block commit job type, see "block-commit"
-#
-# @stream: block stream job type, see "block-stream"
-#
-# @mirror: drive mirror job type, see "drive-mirror"
-#
-# @backup: drive backup job type, see "drive-backup"
-#
-# Since: 1.7
-##
-{ 'enum': 'JobType',
-  'data': ['commit', 'stream', 'mirror', 'backup'] }
-
-##
-# @JobVerb:
-#
-# Represents command verbs that can be applied to a job.
-#
-# @cancel: see @block-job-cancel
-#
-# @pause: see @block-job-pause
-#
-# @resume: see @block-job-resume
-#
-# @set-speed: see @block-job-set-speed
-#
-# @complete: see @block-job-complete
-#
-# @dismiss: see @block-job-dismiss
-#
-# @finalize: see @block-job-finalize
-#
-# Since: 2.12
-##
-{ 'enum': 'JobVerb',
-  'data': ['cancel', 'pause', 'resume', 'set-speed', 'complete', 'dismiss',
-           'finalize' ] }
-
-##
-# @JobStatus:
-#
-# Indicates the present state of a given job in its lifetime.
-#
-# @undefined: Erroneous, default state. Should not ever be visible.
-#
-# @created: The job has been created, but not yet started.
-#
-# @running: The job is currently running.
-#
-# @paused: The job is running, but paused. The pause may be requested by
-#          either the QMP user or by internal processes.
-#
-# @ready: The job is running, but is ready for the user to signal completion.
-#         This is used for long-running jobs like mirror that are designed to
-#         run indefinitely.
-#
-# @standby: The job is ready, but paused. This is nearly identical to @paused.
-#           The job may return to @ready or otherwise be canceled.
-#
-# @waiting: The job is waiting for other jobs in the transaction to converge
-#           to the waiting state. This status will likely not be visible for
-#           the last job in a transaction.
-#
-# @pending: The job has finished its work, but has finalization steps that it
-#           needs to make prior to completing. These changes may require
-#           manual intervention by the management process if manual was set
-#           to true. These changes may still fail.
-#
-# @aborting: The job is in the process of being aborted, and will finish with
-#            an error. The job will afterwards report that it is @concluded.
-#            This status may not be visible to the management process.
-#
-# @concluded: The job has finished all work. If manual was set to true, the job
-#             will remain in the query list until it is dismissed.
-#
-# @null: The job is in the process of being dismantled. This state should not
-#        ever be visible externally.
-#
-# Since: 2.12
-##
-{ 'enum': 'JobStatus',
-  'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
-           'waiting', 'pending', 'aborting', 'concluded', 'null' ] }
-
-##
 # @BlockJobInfo:
 #
 # Information about a long-running block device operation.
diff --git a/qapi/job.json b/qapi/job.json
new file mode 100644
index 0000000000..a472c0cb29
--- /dev/null
+++ b/qapi/job.json
@@ -0,0 +1,94 @@
+# -*- Mode: Python -*-
+
+##
+# == Background jobs
+##
+
+##
+# @JobType:
+#
+# Type of a background job.
+#
+# @commit: block commit job type, see "block-commit"
+#
+# @stream: block stream job type, see "block-stream"
+#
+# @mirror: drive mirror job type, see "drive-mirror"
+#
+# @backup: drive backup job type, see "drive-backup"
+#
+# Since: 1.7
+##
+{ 'enum': 'JobType',
+  'data': ['commit', 'stream', 'mirror', 'backup'] }
+
+##
+# @JobStatus:
+#
+# Indicates the present state of a given job in its lifetime.
+#
+# @undefined: Erroneous, default state. Should not ever be visible.
+#
+# @created: The job has been created, but not yet started.
+#
+# @running: The job is currently running.
+#
+# @paused: The job is running, but paused. The pause may be requested by
+#          either the QMP user or by internal processes.
+#
+# @ready: The job is running, but is ready for the user to signal completion.
+#         This is used for long-running jobs like mirror that are designed to
+#         run indefinitely.
+#
+# @standby: The job is ready, but paused. This is nearly identical to @paused.
+#           The job may return to @ready or otherwise be canceled.
+#
+# @waiting: The job is waiting for other jobs in the transaction to converge
+#           to the waiting state. This status will likely not be visible for
+#           the last job in a transaction.
+#
+# @pending: The job has finished its work, but has finalization steps that it
+#           needs to make prior to completing. These changes may require
+#           manual intervention by the management process if manual was set
+#           to true. These changes may still fail.
+#
+# @aborting: The job is in the process of being aborted, and will finish with
+#            an error. The job will afterwards report that it is @concluded.
+#            This status may not be visible to the management process.
+#
+# @concluded: The job has finished all work. If manual was set to true, the job
+#             will remain in the query list until it is dismissed.
+#
+# @null: The job is in the process of being dismantled. This state should not
+#        ever be visible externally.
+#
+# Since: 2.12
+##
+{ 'enum': 'JobStatus',
+  'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
+           'waiting', 'pending', 'aborting', 'concluded', 'null' ] }
+
+##
+# @JobVerb:
+#
+# Represents command verbs that can be applied to a job.
+#
+# @cancel: see @block-job-cancel
+#
+# @pause: see @block-job-pause
+#
+# @resume: see @block-job-resume
+#
+# @set-speed: see @block-job-set-speed
+#
+# @complete: see @block-job-complete
+#
+# @dismiss: see @block-job-dismiss
+#
+# @finalize: see @block-job-finalize
+#
+# Since: 2.12
+##
+{ 'enum': 'JobVerb',
+  'data': ['cancel', 'pause', 'resume', 'set-speed', 'complete', 'dismiss',
+           'finalize' ] }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 25bce78352..65b6dc2f6f 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -84,6 +84,7 @@
 { 'include': 'crypto.json' }
 { 'include': 'block.json' }
 { 'include': 'char.json' }
+{ 'include': 'job.json' }
 { 'include': 'net.json' }
 { 'include': 'rocker.json' }
 { 'include': 'tpm.json' }
diff --git a/MAINTAINERS b/MAINTAINERS
index 9fba3307d9..d49c16cdd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1375,6 +1375,7 @@ F: block/backup.c
 F: block/commit.c
 F: block/stream.c
 F: block/mirror.c
+F: qapi/job.json
 T: git git://github.com/codyprime/qemu-kvm-jtc.git block
 
 Block QAPI, monitor, command line
diff --git a/Makefile b/Makefile
index 35554b5bef..6d588d1f71 100644
--- a/Makefile
+++ b/Makefile
@@ -98,6 +98,7 @@ GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
 GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
 GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
 GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
+GENERATED_FILES += qapi/qapi-types-job.h qapi/qapi-types-job.c
 GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
 GENERATED_FILES += qapi/qapi-types-misc.h qapi/qapi-types-misc.c
 GENERATED_FILES += qapi/qapi-types-net.h qapi/qapi-types-net.c
@@ -116,6 +117,7 @@ GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
 GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
 GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
 GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
+GENERATED_FILES += qapi/qapi-visit-job.h qapi/qapi-visit-job.c
 GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
 GENERATED_FILES += qapi/qapi-visit-misc.h qapi/qapi-visit-misc.c
 GENERATED_FILES += qapi/qapi-visit-net.h qapi/qapi-visit-net.c
@@ -133,6 +135,7 @@ GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
 GENERATED_FILES += qapi/qapi-commands-common.h qapi/qapi-commands-common.c
 GENERATED_FILES += qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto.c
 GENERATED_FILES += qapi/qapi-commands-introspect.h qapi/qapi-commands-introspect.c
+GENERATED_FILES += qapi/qapi-commands-job.h qapi/qapi-commands-job.c
 GENERATED_FILES += qapi/qapi-commands-migration.h qapi/qapi-commands-migration.c
 GENERATED_FILES += qapi/qapi-commands-misc.h qapi/qapi-commands-misc.c
 GENERATED_FILES += qapi/qapi-commands-net.h qapi/qapi-commands-net.c
@@ -150,6 +153,7 @@ GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
 GENERATED_FILES += qapi/qapi-events-common.h qapi/qapi-events-common.c
 GENERATED_FILES += qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
 GENERATED_FILES += qapi/qapi-events-introspect.h qapi/qapi-events-introspect.c
+GENERATED_FILES += qapi/qapi-events-job.h qapi/qapi-events-job.c
 GENERATED_FILES += qapi/qapi-events-migration.h qapi/qapi-events-migration.c
 GENERATED_FILES += qapi/qapi-events-misc.h qapi/qapi-events-misc.c
 GENERATED_FILES += qapi/qapi-events-net.h qapi/qapi-events-net.c
@@ -582,6 +586,7 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
                $(SRC_PATH)/qapi/introspect.json \
+               $(SRC_PATH)/qapi/job.json \
                $(SRC_PATH)/qapi/migration.json \
                $(SRC_PATH)/qapi/misc.json \
                $(SRC_PATH)/qapi/net.json \
@@ -601,6 +606,7 @@ qapi/qapi-types-char.c qapi/qapi-types-char.h \
 qapi/qapi-types-common.c qapi/qapi-types-common.h \
 qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
 qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
+qapi/qapi-types-job.c qapi/qapi-types-job.h \
 qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
 qapi/qapi-types-misc.c qapi/qapi-types-misc.h \
 qapi/qapi-types-net.c qapi/qapi-types-net.h \
@@ -619,6 +625,7 @@ qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
 qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
 qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
 qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
+qapi/qapi-visit-job.c qapi/qapi-visit-job.h \
 qapi/qapi-visit-migration.c qapi/qapi-visit-migration.h \
 qapi/qapi-visit-misc.c qapi/qapi-visit-misc.h \
 qapi/qapi-visit-net.c qapi/qapi-visit-net.h \
@@ -636,6 +643,7 @@ qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
 qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
 qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
 qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
+qapi/qapi-commands-job.c qapi/qapi-commands-job.h \
 qapi/qapi-commands-migration.c qapi/qapi-commands-migration.h \
 qapi/qapi-commands-misc.c qapi/qapi-commands-misc.h \
 qapi/qapi-commands-net.c qapi/qapi-commands-net.h \
@@ -653,6 +661,7 @@ qapi/qapi-events-char.c qapi/qapi-events-char.h \
 qapi/qapi-events-common.c qapi/qapi-events-common.h \
 qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
 qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
+qapi/qapi-events-job.c qapi/qapi-events-job.h \
 qapi/qapi-events-migration.c qapi/qapi-events-migration.h \
 qapi/qapi-events-misc.c qapi/qapi-events-misc.h \
 qapi/qapi-events-net.c qapi/qapi-events-net.h \
diff --git a/Makefile.objs b/Makefile.objs
index 92b73fc272..3df8d58e49 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -10,6 +10,7 @@ util-obj-y += qapi/qapi-types-char.o
 util-obj-y += qapi/qapi-types-common.o
 util-obj-y += qapi/qapi-types-crypto.o
 util-obj-y += qapi/qapi-types-introspect.o
+util-obj-y += qapi/qapi-types-job.o
 util-obj-y += qapi/qapi-types-migration.o
 util-obj-y += qapi/qapi-types-misc.o
 util-obj-y += qapi/qapi-types-net.o
@@ -28,6 +29,7 @@ util-obj-y += qapi/qapi-visit-char.o
 util-obj-y += qapi/qapi-visit-common.o
 util-obj-y += qapi/qapi-visit-crypto.o
 util-obj-y += qapi/qapi-visit-introspect.o
+util-obj-y += qapi/qapi-visit-job.o
 util-obj-y += qapi/qapi-visit-migration.o
 util-obj-y += qapi/qapi-visit-misc.o
 util-obj-y += qapi/qapi-visit-net.o
@@ -45,6 +47,7 @@ util-obj-y += qapi/qapi-events-char.o
 util-obj-y += qapi/qapi-events-common.o
 util-obj-y += qapi/qapi-events-crypto.o
 util-obj-y += qapi/qapi-events-introspect.o
+util-obj-y += qapi/qapi-events-job.o
 util-obj-y += qapi/qapi-events-migration.o
 util-obj-y += qapi/qapi-events-misc.o
 util-obj-y += qapi/qapi-events-net.o
@@ -140,6 +143,7 @@ common-obj-y += qapi/qapi-commands-char.o
 common-obj-y += qapi/qapi-commands-common.o
 common-obj-y += qapi/qapi-commands-crypto.o
 common-obj-y += qapi/qapi-commands-introspect.o
+common-obj-y += qapi/qapi-commands-job.o
 common-obj-y += qapi/qapi-commands-migration.o
 common-obj-y += qapi/qapi-commands-misc.o
 common-obj-y += qapi/qapi-commands-net.o
-- 
2.13.6
