Received: from eggs.gnu.org ([2001:4830:134:3::10]:50666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672db908=marcolso@amazon.com>)
	id 1ft4Mm-0002Ag-TQ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 01:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672db908=marcolso@amazon.com>)
	id 1ft4Mj-00034a-Mq
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 01:10:36 -0400
From: Marc Olson <marcolso@amazon.com>
Date: Thu, 23 Aug 2018 22:06:25 -0700
Message-Id: <1535087186-9643-1-git-send-email-marcolso@amazon.com>
Subject: [Qemu-devel] [PATCH] blkdebug: Add support for latency rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marc Olson <marcolso@amazon.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Allow rules to be created to inject latency into I/O operations.

Signed-off-by: Marc Olson <marcolso@amazon.com>
---
 block/blkdebug.c        | 101 ++++++++++++++++++++++++++++++++++++++----------
 docs/devel/blkdebug.txt |  30 ++++++++++----
 2 files changed, 103 insertions(+), 28 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index e216699..762e438 100644
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
@@ -475,36 +521,50 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
     BlkdebugRule *rule = NULL;
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
             break;
         }
     }
 
-    if (!rule || !rule->options.inject.error) {
+    if (!rule ||
+        (rule->action == ACTION_INJECT_ERROR && !rule->options.inject.error) ||
+        (rule->action == ACTION_DELAY && !rule->options.delay.latency)) {
         return 0;
     }
 
-    immediately = rule->options.inject.immediately;
-    error = rule->options.inject.error;
-
-    if (rule->options.inject.once) {
+    if (rule->once) {
         QSIMPLEQ_REMOVE(&s->active_rules, rule, BlkdebugRule, active_next);
         remove_rule(rule);
     }
 
-    if (!immediately) {
-        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
-        qemu_coroutine_yield();
+    switch (rule->action) {
+    case ACTION_INJECT_ERROR:
+        immediately = rule->options.inject.immediately;
+        error = rule->options.inject.error;
+
+        if (!immediately) {
+            aio_co_schedule(qemu_get_current_aio_context(),
+                            qemu_coroutine_self());
+            qemu_coroutine_yield();
+        }
+
+        ret = -error;
+        break;
+
+    case ACTION_DELAY:
+        if (rule->options.delay.latency) {
+            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, rule->options.delay.latency);
+        }
+        break;
     }
 
-    return -error;
+    return ret;
 }
 
 static int coroutine_fn
@@ -691,6 +751,7 @@ static bool process_rule(BlockDriverState *bs, struct BlkdebugRule *rule,
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
-- 
2.7.4
