Received: from eggs.gnu.org ([2001:4830:134:3::10]:41507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=779f33780=marcolso@amazon.com>)
	id 1fxLio-0002SV-Tp
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=779f33780=marcolso@amazon.com>)
	id 1fxLik-0001Au-CT
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:31:02 -0400
From: Marc Olson <marcolso@amazon.com>
Date: Tue,  4 Sep 2018 17:24:49 -0700
Message-Id: <1536107089-9829-1-git-send-email-marcolso@amazon.com>
In-Reply-To: <1535087186-9643-1-git-send-email-marcolso@amazon.com>
References: <1535087186-9643-1-git-send-email-marcolso@amazon.com>
Subject: [Qemu-devel] [PATCH v2] blkdebug: Add support for latency rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marc Olson <marcolso@amazon.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org

Sometimes storage devices can be slow to respond, due to media errors, firmware
issues, SSD garbage collection, etc. This patch adds a new rule type to
blkdebug that allows injection of latency to I/O operations. Similar to error
injection rules, latency rules can be specified with or without an offset, and
can also apply upon state transitions.

Signed-off-by: Marc Olson <marcolso@amazon.com>

---
v2:
- Change so that delay rules are executed before error rules
- Add QMP support
- Add tests
---
 block/blkdebug.c           | 119 +++++++++++++++++++++++++++++++++++----------
 docs/devel/blkdebug.txt    |  30 +++++++++---
 qapi/block-core.json       |  39 +++++++++++++--
 tests/qemu-iotests/071     |  63 ++++++++++++++++++++++++
 tests/qemu-iotests/071.out |  31 ++++++++++++
 5 files changed, 244 insertions(+), 38 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 0759452..1785fe3 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -65,6 +65,7 @@ typedef struct BlkdebugSuspendedReq {
 
 enum {
     ACTION_INJECT_ERROR,
+    ACTION_DELAY,
     ACTION_SET_STATE,
     ACTION_SUSPEND,
 };
@@ -73,14 +74,17 @@ typedef struct BlkdebugRule {
     BlkdebugEvent event;
     int action;
     int state;
+    int once;
+    int64_t offset;
     union {
         struct {
             int error;
             int immediately;
-            int once;
-            int64_t offset;
         } inject;
         struct {
+            int64_t latency;
+        } delay;
+        struct {
             int new_state;
         } set_state;
         struct {
@@ -123,6 +127,33 @@ static QemuOptsList inject_error_opts = {
     },
 };
 
+static QemuOptsList delay_opts = {
+    .name = "delay",
+    .head = QTAILQ_HEAD_INITIALIZER(delay_opts.head),
+    .desc = {
+        {
+            .name = "event",
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
@@ -145,6 +176,7 @@ static QemuOptsList set_state_opts = {
 
 static QemuOptsList *config_groups[] = {
     &inject_error_opts,
+    &delay_opts,
     &set_state_opts,
     NULL
 };
@@ -182,16 +214,21 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
         .state  = qemu_opt_get_number(opts, "state", 0),
     };
 
+    rule->once  = qemu_opt_get_bool(opts, "once", 0);
+    sector = qemu_opt_get_number(opts, "sector", -1);
+    rule->offset = sector == -1 ? -1 : sector * BDRV_SECTOR_SIZE;
+
     /* Parse action-specific options */
     switch (d->action) {
     case ACTION_INJECT_ERROR:
         rule->options.inject.error = qemu_opt_get_number(opts, "errno", EIO);
-        rule->options.inject.once  = qemu_opt_get_bool(opts, "once", 0);
         rule->options.inject.immediately =
             qemu_opt_get_bool(opts, "immediately", 0);
-        sector = qemu_opt_get_number(opts, "sector", -1);
-        rule->options.inject.offset =
-            sector == -1 ? -1 : sector * BDRV_SECTOR_SIZE;
+        break;
+
+    case ACTION_DELAY:
+        rule->options.delay.latency =
+            qemu_opt_get_number(opts, "latency", 100) * SCALE_US;
         break;
 
     case ACTION_SET_STATE:
@@ -264,6 +301,14 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
         goto fail;
     }
 
+    d.action = ACTION_DELAY;
+    qemu_opts_foreach(&delay_opts, add_rule, &d, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
     d.action = ACTION_SET_STATE;
     qemu_opts_foreach(&set_state_opts, add_rule, &d, &local_err);
     if (local_err) {
@@ -275,6 +320,7 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
     ret = 0;
 fail:
     qemu_opts_reset(&inject_error_opts);
+    qemu_opts_reset(&delay_opts);
     qemu_opts_reset(&set_state_opts);
     if (f) {
         fclose(f);
@@ -473,39 +519,61 @@ out:
 static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
 {
     BDRVBlkdebugState *s = bs->opaque;
-    BlkdebugRule *rule = NULL;
+    BlkdebugRule *rule = NULL, *delay_rule = NULL, *error_rule = NULL;
+    int64_t latency;
     int error;
     bool immediately;
+    int ret = 0;
 
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
-        uint64_t inject_offset = rule->options.inject.offset;
-
-        if (inject_offset == -1 ||
-            (bytes && inject_offset >= offset &&
-             inject_offset < offset + bytes))
+        if (rule->offset == -1 ||
+            (bytes && rule->offset >= offset &&
+             rule->offset < offset + bytes))
         {
-            break;
+            if (!error_rule && rule->action == ACTION_INJECT_ERROR) {
+                error_rule = rule;
+            } else if (!delay_rule && rule->action == ACTION_DELAY) {
+                delay_rule = rule;
+            }
+
+            if (error_rule && delay_rule) {
+                break;
+            }
         }
     }
 
-    if (!rule || !rule->options.inject.error) {
-        return 0;
-    }
+    if (delay_rule) {
+        latency = delay_rule->options.delay.latency;
 
-    immediately = rule->options.inject.immediately;
-    error = rule->options.inject.error;
+        if (delay_rule->once) {
+            QSIMPLEQ_REMOVE(&s->active_rules, delay_rule, BlkdebugRule, active_next);
+            remove_rule(delay_rule);
+        }
 
-    if (rule->options.inject.once) {
-        QSIMPLEQ_REMOVE(&s->active_rules, rule, BlkdebugRule, active_next);
-        remove_rule(rule);
+        if (latency != 0) {
+            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, latency);
+        }
     }
 
-    if (!immediately) {
-        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
-        qemu_coroutine_yield();
+    if (error_rule) {
+        error = error_rule->options.inject.error;
+        immediately = error_rule->options.inject.immediately;
+
+        if (error_rule->once) {
+            QSIMPLEQ_REMOVE(&s->active_rules, error_rule, BlkdebugRule, active_next);
+            remove_rule(error_rule);
+        }
+
+        if (error && !immediately) {
+            aio_co_schedule(qemu_get_current_aio_context(),
+                            qemu_coroutine_self());
+            qemu_coroutine_yield();
+        }
+
+        ret = -error;
     }
 
-    return -error;
+    return ret;
 }
 
 static int coroutine_fn
@@ -694,6 +762,7 @@ static bool process_rule(BlockDriverState *bs, struct BlkdebugRule *rule,
     /* Take the action */
     switch (rule->action) {
     case ACTION_INJECT_ERROR:
+    case ACTION_DELAY:
         if (!injected) {
             QSIMPLEQ_INIT(&s->active_rules);
             injected = true;
diff --git a/docs/devel/blkdebug.txt b/docs/devel/blkdebug.txt
index 43d8e8f..1befcf8 100644
--- a/docs/devel/blkdebug.txt
+++ b/docs/devel/blkdebug.txt
@@ -24,7 +24,7 @@ This way, all error paths can be tested to make sure they are correct.
 Rules
 -----
 The blkdebug block driver takes a list of "rules" that tell the error injection
-engine when to fail an I/O request.
+engine when to fail (inject-error) or add latency to (delay) an I/O request.
 
 Each I/O request is evaluated against the rules.  If a rule matches the request
 then its "action" is executed.
@@ -33,17 +33,25 @@ Rules can be placed in a configuration file; the configuration file
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
+  [delay]
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
 Invoke QEMU as follows:
 
   $ qemu-system-x86_64
@@ -60,21 +68,27 @@ Rules support the following attributes:
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
 
+Error injection rules support the following attributes:
+
+  errno - the numeric errno value to return when a request matches this rule.
+          The errno values depend on the host since the numeric values are not
+          standarized in the POSIX specification.
+
   immediately - (optional, default "off") return a NULL BlockAIOCB
                 pointer and fail without an errno instead.  This
                 exercises the code path where BlockAIOCB fails and the
                 caller's BlockCompletionFunc is not invoked.
 
+Delay rules support the following attribute:
+
+  latency - the delay to add to an I/O request, in microseconds.
+
 Events
 ------
 Block drivers provide information about the type of I/O request they are about
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4c7a37a..819e3f9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2941,11 +2941,11 @@
             'refblock_alloc_write_blocks', 'refblock_alloc_write_table',
             'refblock_alloc_switch_table', 'cluster_alloc',
             'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
-            'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_head',
-            'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
-            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
-            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write'] }
+            'flush_to_disk', 'preadv', 'pwritev_rmw_head',
+            'pwritev_rmw_after_head', 'pwritev_rmw_tail',
+            'pwritev_rmw_after_tail', 'pwritev', 'pwritev_zero', 'pwritev_done',
+            'empty_image_prepare', 'l1_shrink_write_table',
+            'l1_shrink_free_l2_clusters', 'cor_write'] }
 
 ##
 # @BlkdebugInjectErrorOptions:
@@ -2980,6 +2980,34 @@
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
+# Since: 3.0
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
@@ -3049,6 +3077,7 @@
             '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
             '*opt-discard': 'int32', '*max-discard': 'int32',
             '*inject-error': ['BlkdebugInjectErrorOptions'],
+            '*delay': ['BlkdebugDelayOptions'],
             '*set-state': ['BlkdebugSetStateOptions'] } }
 
 ##
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 48b4955..3d0610c 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -100,6 +100,69 @@ $QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.inject-error.event
          -c 'read -P 42 0x38000 512'
 
 echo
+echo "=== Testing blkdebug latency through filename ==="
+echo
+
+$QEMU_IO -c "open -o file.driver=blkdebug,file.delay.event=write_aio,file.delay.latency=10000 $TEST_IMG" \
+         -c 'aio_write -P 42 0x28000 512' \
+         -c 'aio_read -P 42 0x38000 512' \
+         | _filter_qemu_io
+
+echo
+echo "=== Testing blkdebug latency through file blockref ==="
+echo
+
+$QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.delay.event=write_aio,file.delay.latency=10000,file.image.filename=$TEST_IMG" \
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
+            "delay": [{
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
