Received: from eggs.gnu.org ([2001:4830:134:3::10]:50553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=847f9958e=marcolso@amazon.com>)
	id 1gM6Jf-00087F-Jk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 02:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=847f9958e=marcolso@amazon.com>)
	id 1gM6JZ-0004Dn-R6
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 02:07:21 -0500
From: Marc Olson <marcolso@amazon.com>
Date: Sun, 11 Nov 2018 23:06:38 -0800
Message-Id: <1542006398-30037-3-git-send-email-marcolso@amazon.com>
In-Reply-To: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
Subject: [Qemu-devel] [PATCH v3 3/3] blkdebug: Add latency injection rule
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Marc Olson <marcolso@amazon.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Add a new rule type for blkdebug that instead of returning an error, can
inject latency to an IO.

Signed-off-by: Marc Olson <marcolso@amazon.com>
---
 block/blkdebug.c           | 79 +++++++++++++++++++++++++++++++++++++++++++---
 docs/devel/blkdebug.txt    | 35 ++++++++++++++------
 qapi/block-core.json       | 31 ++++++++++++++++++
 tests/qemu-iotests/071     | 63 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/071.out | 31 ++++++++++++++++++
 5 files changed, 226 insertions(+), 13 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 7739849..6b1f2d6 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -65,6 +65,7 @@ typedef struct BlkdebugSuspendedReq {
 
 enum {
     ACTION_INJECT_ERROR,
+    ACTION_INJECT_DELAY,
     ACTION_SET_STATE,
     ACTION_SUSPEND,
 };
@@ -81,6 +82,9 @@ typedef struct BlkdebugRule {
             int immediately;
         } inject_error;
         struct {
+            int64_t latency;
+        } delay;
+        struct {
             int new_state;
         } set_state;
         struct {
@@ -123,6 +127,34 @@ static QemuOptsList inject_error_opts = {
     },
 };
 
+static QemuOptsList inject_delay_opts = {
+    .name = "inject-delay",
+    .head = QTAILQ_HEAD_INITIALIZER(inject_delay_opts.head),
+    .desc = {
+        {
+            .name = "event",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "state",
+            .type = QEMU_OPT_NUMBER,
+        },
+        {
+            .name = "latency",
+            .type = QEMU_OPT_NUMBER,
+        },
+        {
+            .name = "sector",
+            .type = QEMU_OPT_NUMBER,
+        },
+        {
+            .name = "once",
+            .type = QEMU_OPT_BOOL,
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList set_state_opts = {
     .name = "set-state",
     .head = QTAILQ_HEAD_INITIALIZER(set_state_opts.head),
@@ -145,6 +177,7 @@ static QemuOptsList set_state_opts = {
 
 static QemuOptsList *config_groups[] = {
     &inject_error_opts,
+    &inject_delay_opts,
     &set_state_opts,
     NULL
 };
@@ -194,6 +227,11 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
             qemu_opt_get_bool(opts, "immediately", 0);
         break;
 
+    case ACTION_INJECT_DELAY:
+        rule->options.delay.latency =
+            qemu_opt_get_number(opts, "latency", 100) * SCALE_US;
+        break;
+
     case ACTION_SET_STATE:
         rule->options.set_state.new_state =
             qemu_opt_get_number(opts, "new_state", 0);
@@ -226,6 +264,12 @@ static void remove_rule(BlkdebugRule *rule)
     g_free(rule);
 }
 
+static void remove_active_rule(BDRVBlkdebugState *s, BlkdebugRule *rule)
+{
+    QSIMPLEQ_REMOVE(&s->active_rules, rule, BlkdebugRule, active_next);
+    remove_rule(rule);
+}
+
 static int read_config(BDRVBlkdebugState *s, const char *filename,
                        QDict *options, Error **errp)
 {
@@ -264,6 +308,14 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
         goto fail;
     }
 
+    d.action = ACTION_INJECT_DELAY;
+    qemu_opts_foreach(&inject_delay_opts, add_rule, &d, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
     d.action = ACTION_SET_STATE;
     qemu_opts_foreach(&set_state_opts, add_rule, &d, &local_err);
     if (local_err) {
@@ -275,6 +327,7 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
     ret = 0;
 fail:
     qemu_opts_reset(&inject_error_opts);
+    qemu_opts_reset(&inject_delay_opts);
     qemu_opts_reset(&set_state_opts);
     if (f) {
         fclose(f);
@@ -474,7 +527,8 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
 {
     BDRVBlkdebugState *s = bs->opaque;
     BlkdebugRule *rule = NULL;
-    BlkdebugRule *error_rule = NULL;
+    BlkdebugRule *error_rule = NULL, *delay_rule = NULL;
+    int64_t latency;
     int error;
     bool immediately;
     int ret = 0;
@@ -484,20 +538,36 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
             (bytes && rule->offset >= offset &&
              rule->offset < offset + bytes))
         {
-            if (rule->action == ACTION_INJECT_ERROR) {
+            if (!error_rule && rule->action == ACTION_INJECT_ERROR) {
                 error_rule = rule;
+            } else if (!delay_rule && rule->action == ACTION_INJECT_DELAY) {
+                delay_rule = rule;
+            }
+
+            if (error_rule && delay_rule) {
                 break;
             }
         }
     }
 
+    if (delay_rule) {
+        latency = delay_rule->options.delay.latency;
+
+        if (delay_rule->once) {
+            remove_active_rule(s, delay_rule);
+        }
+
+        if (latency != 0) {
+            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, latency);
+        }
+    }
+
     if (error_rule) {
         immediately = error_rule->options.inject_error.immediately;
         error = error_rule->options.inject_error.error;
 
         if (error_rule->once) {
-            QSIMPLEQ_REMOVE(&s->active_rules, error_rule, BlkdebugRule, active_next);
-            remove_rule(error_rule);
+            remove_active_rule(s, error_rule);
         }
 
         if (error && !immediately) {
@@ -697,6 +767,7 @@ static bool process_rule(BlockDriverState *bs, struct BlkdebugRule *rule,
     /* Take the action */
     switch (rule->action) {
     case ACTION_INJECT_ERROR:
+    case ACTION_INJECT_DELAY:
         if (!injected) {
             QSIMPLEQ_INIT(&s->active_rules);
             injected = true;
diff --git a/docs/devel/blkdebug.txt b/docs/devel/blkdebug.txt
index 43d8e8f..1719835 100644
--- a/docs/devel/blkdebug.txt
+++ b/docs/devel/blkdebug.txt
@@ -24,7 +24,7 @@ This way, all error paths can be tested to make sure they are correct.
 Rules
 -----
 The blkdebug block driver takes a list of "rules" that tell the error injection
-engine when to fail an I/O request.
+engine when to either fail or add latency to an I/O request.
 
 Each I/O request is evaluated against the rules.  If a rule matches the request
 then its "action" is executed.
@@ -33,24 +33,35 @@ Rules can be placed in a configuration file; the configuration file
 follows the same .ini-like format used by QEMU's -readconfig option, and
 each section of the file represents a rule.
 
-The following configuration file defines a single rule:
+The following configuration file defines multiple rules:
 
   $ cat blkdebug.conf
   [inject-error]
   event = "read_aio"
   errno = "28"
 
-This rule fails all aio read requests with ENOSPC (28).  Note that the errno
-value depends on the host.  On Linux, see
+  [inject-delay]
+  event = "read_aio"
+  sector = "2048"
+  latency = "500000"
+
+The error rule fails all aio read requests with ENOSPC (28).  Note that the
+errno value depends on the host.  On Linux, see
 /usr/include/asm-generic/errno-base.h for errno values.
 
+The delay rule adds 500 ms of latency to a read I/O request containing sector
+2048.
+
+An error rule and a delay rule can overlap, and both will execute. Only one
+rule of a given type will be executed for each I/O.
+
 Invoke QEMU as follows:
 
   $ qemu-system-x86_64
         -drive if=none,cache=none,file=blkdebug:blkdebug.conf:test.img,id=drive0 \
         -device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0
 
-Rules support the following attributes:
+All rules support the following attributes:
 
   event - which type of operation to match (e.g. read_aio, write_aio,
           flush_to_os, flush_to_disk).  See the "Events" section for
@@ -60,21 +71,27 @@ Rules support the following attributes:
           rule to match.  See the "State transitions" section for information
           on states.
 
-  errno - the numeric errno value to return when a request matches this rule.
-          The errno values depend on the host since the numeric values are not
-          standarized in the POSIX specification.
-
   sector - (optional) a sector number that the request must overlap in order to
            match this rule
 
   once - (optional, default "off") only execute this action on the first
          matching request
 
+Error injection rules support the following additional attributes:
+
+  errno - the numeric errno value to return when a request matches this rule.
+          The errno values depend on the host since the numeric values are not
+          standarized in the POSIX specification.
+
   immediately - (optional, default "off") return a NULL BlockAIOCB
                 pointer and fail without an errno instead.  This
                 exercises the code path where BlockAIOCB fails and the
                 caller's BlockCompletionFunc is not invoked.
 
+Delay rules support the following additional attribute:
+
+  latency - the delay to add to an I/O request, in microseconds.
+
 Events
 ------
 Block drivers provide information about the type of I/O request they are about
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d4fe710..72f7861 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3057,6 +3057,34 @@
             '*immediately': 'bool' } }
 
 ##
+# @BlkdebugDelayOptions:
+#
+# Describes a single latency injection for blkdebug.
+#
+# @event:       trigger event
+#
+# @state:       the state identifier blkdebug needs to be in to
+#               actually trigger the event; defaults to "any"
+#
+# @latency:     The delay to add to an I/O, in microseconds.
+#
+# @sector:      specifies the sector index which has to be affected
+#               in order to actually trigger the event; defaults to "any
+#               sector"
+#
+# @once:        disables further events after this one has been
+#               triggered; defaults to false
+#
+# Since: 3.1
+##
+{ 'struct': 'BlkdebugDelayOptions',
+  'data': { 'event': 'BlkdebugEvent',
+            '*state': 'int',
+            '*latency': 'int',
+            '*sector': 'int',
+            '*once': 'bool' } }
+
+##
 # @BlkdebugSetStateOptions:
 #
 # Describes a single state-change event for blkdebug.
@@ -3115,6 +3143,8 @@
 #
 # @inject-error:    array of error injection descriptions
 #
+# @inject-delay:    array of delay injection descriptions
+#
 # @set-state:       array of state-change descriptions
 #
 # Since: 2.9
@@ -3126,6 +3156,7 @@
             '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
             '*opt-discard': 'int32', '*max-discard': 'int32',
             '*inject-error': ['BlkdebugInjectErrorOptions'],
+            '*inject-delay': ['BlkdebugDelayOptions'],
             '*set-state': ['BlkdebugSetStateOptions'] } }
 
 ##
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 48b4955..976f747 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -100,6 +100,69 @@ $QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.inject-error.event
          -c 'read -P 42 0x38000 512'
 
 echo
+echo "=== Testing blkdebug latency through filename ==="
+echo
+
+$QEMU_IO -c "open -o file.driver=blkdebug,file.inject-delay.event=write_aio,file.inject-delay.latency=10000 $TEST_IMG" \
+         -c 'aio_write -P 42 0x28000 512' \
+         -c 'aio_read -P 42 0x38000 512' \
+         | _filter_qemu_io
+
+echo
+echo "=== Testing blkdebug latency through file blockref ==="
+echo
+
+$QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.inject-delay.event=write_aio,file.inject-delay.latency=10000,file.image.filename=$TEST_IMG" \
+         -c 'aio_write -P 42 0x28000 512' \
+         -c 'aio_read -P 42 0x38000 512' \
+         | _filter_qemu_io
+
+# Using QMP is synchronous by default, so even though we would
+# expect reordering due to using the aio_* commands, they are
+# not. The purpose of this test is to verify that the driver
+# can be setup via QMP, and IO can complete. See the qemu-io
+# test above to prove delay functionality
+echo
+echo "=== Testing blkdebug on existing block device ==="
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+    "arguments": {
+        "node-name": "drive0",
+        "driver": "file",
+        "filename": "$TEST_IMG"
+    }
+}
+{ "execute": "blockdev-add",
+    "arguments": {
+        "driver": "$IMGFMT",
+        "node-name": "drive0-debug",
+        "file": {
+            "driver": "blkdebug",
+            "image": "drive0",
+            "inject-delay": [{
+                "event": "write_aio",
+                "latency": 10000
+            }]
+        }
+    }
+}
+{ "execute": "human-monitor-command",
+    "arguments": {
+        "command-line": 'qemu-io drive0-debug "aio_write 0 512"'
+    }
+}
+{ "execute": "human-monitor-command",
+    "arguments": {
+        "command-line": 'qemu-io drive0-debug "aio_read 0 512"'
+    }
+}
+{ "execute": "quit" }
+EOF
+
+echo
 echo "=== Testing blkdebug on existing block device ==="
 echo
 
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index 1d5e28d..1952990 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -36,6 +36,37 @@ read failed: Input/output error
 
 read failed: Input/output error
 
+=== Testing blkdebug latency through filename ===
+
+read 512/512 bytes at offset 229376
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 163840
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing blkdebug latency through file blockref ===
+
+read 512/512 bytes at offset 229376
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 163840
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing blkdebug on existing block device ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": ""}
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": ""}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
 === Testing blkdebug on existing block device ===
 
 Testing:
-- 
2.7.4
