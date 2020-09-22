Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB3CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EE920B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EE920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhOA-0003aE-Dd
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKhDV-0001CV-IL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:16:17 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47560)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKhDT-0006Qz-8a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:16:17 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id C4A7641741D2;
 Tue, 22 Sep 2020 12:16:12 +0000 (UTC)
Subject: [PATCH v5 06/15] replay: introduce info hmp/qmp command
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 22 Sep 2020 15:16:12 +0300
Message-ID: <160077697246.10249.1086815779731659715.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
References: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 08:15:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, wrampazz@redhat.com, pavel.dovgalyuk@ispras.ru,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch introduces 'info replay' monitor command and
corresponding qmp request.
These commands request the current record/replay mode, replay log file
name, and the instruction count (number of recorded/replayed
instructions).  The instruction count can be used with the
replay_seek/replay_break commands added in the next two patches.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands-info.hx      |   11 +++++++++++
 include/monitor/hmp.h     |    1 +
 qapi/block-core.json      |    3 ++-
 qapi/replay.json          |   39 +++++++++++++++++++++++++++++++++++++++
 replay/meson.build        |    1 +
 replay/replay-debugging.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 replay/replay-debugging.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 30209e3903..117ba25f91 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -881,4 +881,15 @@ SRST
     Show SEV information.
 ERST
 
+    {
+        .name       = "replay",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show record/replay information",
+        .cmd        = hmp_info_replay,
+    },
 
+SRST
+  ``info replay``
+    Display the record/replay information: mode and the current icount.
+ERST
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index c986cfd28b..a790589b9e 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -130,5 +130,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_info_replay(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e25aff4e4b..26d098ea0b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -29,7 +29,8 @@
 #
 # @icount: Current instruction count. Appears when execution record/replay
 #          is enabled. Used for "time-traveling" to match the moment
-#          in the recorded execution with the snapshots. (since 5.2)
+#          in the recorded execution with the snapshots. This counter may
+#          be obtained through @query-replay command (since 5.2)
 #
 # Since: 1.3
 #
diff --git a/qapi/replay.json b/qapi/replay.json
index 9e13551d20..e6b3f6001d 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -24,3 +24,42 @@
 ##
 { 'enum': 'ReplayMode',
   'data': [ 'none', 'record', 'play' ] }
+
+##
+# @ReplayInfo:
+#
+# Record/replay information.
+#
+# @mode: current mode.
+#
+# @filename: name of the record/replay log file.
+#            It is present only in record or replay modes, when the log
+#            is recorded or replayed.
+#
+# @icount: current number of executed instructions.
+#
+# Since: 5.2
+#
+##
+{ 'struct': 'ReplayInfo',
+  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'icount': 'int' } }
+
+##
+# @query-replay:
+#
+# Retrieve the record/replay information.
+# It includes current instruction count which may be used for
+# @replay-break and @replay-seek commands.
+#
+# Returns: record/replay information.
+#
+# Since: 5.2
+#
+# Example:
+#
+# -> { "execute": "query-replay" }
+# <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
+#
+##
+{ 'command': 'query-replay',
+  'returns': 'ReplayInfo' }
diff --git a/replay/meson.build b/replay/meson.build
index 8783aea7c8..f91163fb1e 100644
--- a/replay/meson.build
+++ b/replay/meson.build
@@ -9,4 +9,5 @@ softmmu_ss.add(files(
   'replay-net.c',
   'replay-audio.c',
   'replay-random.c',
+  'replay-debugging.c',
 ))
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
new file mode 100644
index 0000000000..51a6de4e81
--- /dev/null
+++ b/replay/replay-debugging.c
@@ -0,0 +1,43 @@
+/*
+ * replay-debugging.c
+ *
+ * Copyright (c) 2010-2020 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "sysemu/replay.h"
+#include "replay-internal.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+#include "qapi/qapi-commands-replay.h"
+
+void hmp_info_replay(Monitor *mon, const QDict *qdict)
+{
+    if (replay_mode == REPLAY_MODE_NONE) {
+        monitor_printf(mon, "Record/replay is not active\n");
+    } else {
+        monitor_printf(mon,
+            "%s execution '%s': instruction count = %"PRId64"\n",
+            replay_mode == REPLAY_MODE_RECORD ? "Recording" : "Replaying",
+            replay_get_filename(), replay_get_current_icount());
+    }
+}
+
+ReplayInfo *qmp_query_replay(Error **errp)
+{
+    ReplayInfo *retval = g_new0(ReplayInfo, 1);
+
+    retval->mode = replay_mode;
+    if (replay_get_filename()) {
+        retval->filename = g_strdup(replay_get_filename());
+        retval->has_filename = true;
+    }
+    retval->icount = replay_get_current_icount();
+    return retval;
+}


