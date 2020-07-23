Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A65C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20E820709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrxhBLBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20E820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybKy-0006oD-5L
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jybHs-0003LS-Fn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:29:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jybHo-0005PW-73
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595510963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69upIEPR5Rocv0K1dpgi2tOtNkX5hv5N+Y3yZWXm1yc=;
 b=QrxhBLBSSGAs1RMHQfHcuLLQV+FcGUz7A9E0Pe55jF8BrUe209pUvSt/w0aJg7LyXX6oy1
 9Dz7Hg9kkXktxOWHxXatlJtKeK++bIkaqnZk9bpuy1qQWdxgtpa17qXtLyuks5+lolUD4y
 c/IeU0psgXch//0ltYNYHyg/fJwBa2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-RvDGOi_xOhG01FzAFjr62g-1; Thu, 23 Jul 2020 09:29:19 -0400
X-MC-Unique: RvDGOi_xOhG01FzAFjr62g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C7F48014D7;
 Thu, 23 Jul 2020 13:29:18 +0000 (UTC)
Received: from turbo.com (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 801D85DEBA;
 Thu, 23 Jul 2020 13:29:16 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] trace: Add support for recorder back-end
Date: Thu, 23 Jul 2020 15:29:02 +0200
Message-Id: <20200723132903.1980743-2-dinechin@redhat.com>
In-Reply-To: <20200723132903.1980743-1-dinechin@redhat.com>
References: <20200723132903.1980743-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recorder library provides support for low-cost continuous
recording of events, which can then be replayed. This makes it
possible to collect data after the fact, for example to show the
events that led to a crash or unexpected condition.

In this series, minimal recorder support in qemu is implemented using
the existing tracing interface. For each trace, a corresponding
recorder is created with a generic name and a default size of 8 entries.

In addition, it is possible to explicitly enable recorders that are
not qemu traces, for example in order to use actually record events
rather than trace them, or to use the real-time graphing capabilities.
For that reason, a limited set of recorder-related macros are defined
as no-ops even if the recorder trace backend is not configured.

Recorder-specific features, notably the ability to perform a
post-mortem dump and to group traces by topic, are not integrated in
this series, as doing so would require modifying the trace
infrastructure, which is a non-objective here. This may be the topic
of later series if there is any interest for it.

HMP COMMAND:
The 'recorder' hmp command has been added, which supports two
sub-commands:
* recorder dump: Dump the current state of the recorder. You can
  give that command a recorder name, to only dump that recorder.
* recorder trace: Set traces using the recorder_trace_set() syntax.
  You can use "recorder trace help" to list all available recorders.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 MAINTAINERS                           |  1 +
 configure                             | 14 ++++++++
 hmp-commands.hx                       | 23 +++++++++++-
 monitor/misc.c                        | 25 +++++++++++++
 scripts/tracetool/backend/recorder.py | 52 +++++++++++++++++++++++++++
 trace/Makefile.objs                   |  1 +
 trace/control.c                       |  5 +++
 trace/recorder.c                      | 27 ++++++++++++++
 trace/recorder.h                      | 32 +++++++++++++++++
 util/module.c                         |  6 ++++
 10 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 scripts/tracetool/backend/recorder.py
 create mode 100644 trace/recorder.c
 create mode 100644 trace/recorder.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3395abd4e1..764b5915d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2484,6 +2484,7 @@ F: stubs/
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
+R: Christophe de Dinechin <dinechin@redhat.com>
 F: trace/
 F: trace-events
 F: docs/qemu-option-trace.rst.inc
diff --git a/configure b/configure
index 4bd80ed507..3770ff873d 100755
--- a/configure
+++ b/configure
@@ -7761,6 +7761,20 @@ fi
 if have_backend "log"; then
   echo "CONFIG_TRACE_LOG=y" >> $config_host_mak
 fi
+if have_backend "recorder"; then
+    recorder_minver="1.0.10"
+    if $pkg_config --atleast-version=$recorder_minver recorder ; then
+        recorder_cflags="$($pkg_config --cflags recorder)"
+        recorder_libs="$($pkg_config --libs recorder)"
+        LIBS="$recorder_libs $LIBS"
+        libs_qga="$recorder_libs $libs_qga"
+        QEMU_CFLAGS="$QEMU_CFLAGS $recorder_cflags"
+        zstd="yes"
+        echo "CONFIG_TRACE_RECORDER=y" >> $config_host_mak
+    else
+        feature_not_found "recorder" "Install recorder-devel package"
+    fi
+fi
 if have_backend "ust"; then
   echo "CONFIG_TRACE_UST=y" >> $config_host_mak
 fi
diff --git a/hmp-commands.hx b/hmp-commands.hx
index d548a3ab74..f164ff6d65 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -302,6 +302,28 @@ SRST
   Open, close, or flush the trace file.  If no argument is given, the
   status of the trace file is displayed.
 ERST
+#endif
+
+#if defined(CONFIG_TRACE_RECORDER)
+    {
+        .name       = "recorder",
+        .args_type  = "op:s?,arg:s?",
+        .params     = "trace|dump [arg]",
+        .help       = "trace selected recorders or print recorder dump",
+        .cmd        = hmp_recorder,
+    },
+
+SRST
+``trace`` *cmds*
+  Activate or deactivate tracing for individual recorder traces.
+  See recorder_trace_set(3) for the syntax of *cmds*
+  For example, to activate trace ``foo`` and disable alll traces
+  ending in ``_warning``, use ``foo:.*_warning=0``.
+  Using ``help`` will list available traces and their current setting.
+``dump`` [*name*]
+  Dump the recorder. If *name* is given, only the specific named recorder
+  will be dumped.
+ERST
 #endif
 
     {
@@ -1828,4 +1850,3 @@ ERST
         .sub_table  = hmp_info_cmds,
         .flags      = "p",
     },
-
diff --git a/monitor/misc.c b/monitor/misc.c
index e847b58a8c..aff72158d7 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -60,6 +60,7 @@
 #ifdef CONFIG_TRACE_SIMPLE
 #include "trace/simple.h"
 #endif
+#include "trace/recorder.h"
 #include "exec/memory.h"
 #include "exec/exec-all.h"
 #include "qemu/option.h"
@@ -226,6 +227,30 @@ static void hmp_trace_file(Monitor *mon, const QDict *qdict)
 }
 #endif
 
+#ifdef CONFIG_TRACE_RECORDER
+static void hmp_recorder(Monitor *mon, const QDict *qdict)
+{
+    const char *op = qdict_get_try_str(qdict, "op");
+    const char *arg = qdict_get_try_str(qdict, "arg");
+
+    if (!op) {
+        monitor_printf(mon, "missing recorder command\"%s\"\n", op);
+        help_cmd(mon, "recorder");
+    } else if (!strcmp(op, "trace")) {
+        recorder_trace_set(arg);
+    } else if (!strcmp(op, "dump")) {
+        if (!arg || !*arg) {
+            recorder_dump();
+        } else {
+            recorder_dump_for(arg);
+        }
+    } else {
+        monitor_printf(mon, "unexpected recorder command \"%s\"\n", op);
+        help_cmd(mon, "recorder");
+    }
+}
+#endif
+
 static void hmp_info_help(Monitor *mon, const QDict *qdict)
 {
     help_cmd(mon, "info");
diff --git a/scripts/tracetool/backend/recorder.py b/scripts/tracetool/backend/recorder.py
new file mode 100644
index 0000000000..82d983ff31
--- /dev/null
+++ b/scripts/tracetool/backend/recorder.py
@@ -0,0 +1,52 @@
+# -*- coding: utf-8 -*-
+
+"""
+Trace back-end for recorder library
+"""
+
+__author__     = "Christophe de Dinechin <christophe@dinechin.org>"
+__copyright__  = "Copyright 2020, Christophe de Dinechin and Red Hat"
+__license__    = "GPL version 2 or (at your option) any later version"
+
+__maintainer__ = "Christophe de Dinechin"
+__email__      = "christophe@dinechin.org"
+
+
+from tracetool import out
+
+PUBLIC = True
+
+def generate_h_begin(events, group):
+    out('#include <recorder/recorder.h>', '')
+
+    for event in events:
+        out('RECORDER_DECLARE(%(name)s);', name=event.name)
+
+
+def generate_h(event, group):
+    argnames = ", ".join(event.args.names())
+    if len(event.args) > 0:
+        argnames = ", " + argnames
+
+    out('    record(%(event)s, %(fmt)s %(argnames)s);',
+        event=event.name,
+        fmt=event.fmt.rstrip("\n"),
+        argnames=argnames)
+
+
+def generate_h_backend_dstate(event, group):
+    out('    RECORDER_TWEAK(%(event_id)s) || \\', event_id=event.name)
+
+def generate_c_begin(events, group):
+    out('#include "qemu/osdep.h"',
+        '#include "trace/control.h"',
+        '#include "trace/simple.h"',
+        '#include <recorder/recorder.h>',
+        '')
+
+    for event in events:
+        out('RECORDER_DEFINE(%(name)s, 8,',
+            '                "Tracetool recorder for %(api)s(%(args)s)");',
+            name=event.name,
+            api=event.api(),
+            args=event.args)
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index c544509adf..13667e98d5 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -54,6 +54,7 @@ $(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/
 
 util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
 util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
+util-obj-$(CONFIG_TRACE_RECORDER) += recorder.o
 util-obj-y += control.o
 obj-y += control-target.o
 util-obj-y += qmp.o
diff --git a/trace/control.c b/trace/control.c
index 2ffe000818..71f170f73b 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -23,6 +23,7 @@
 #ifdef CONFIG_TRACE_SYSLOG
 #include <syslog.h>
 #endif
+#include "trace/recorder.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
@@ -282,6 +283,10 @@ bool trace_init_backends(void)
     openlog(NULL, LOG_PID, LOG_DAEMON);
 #endif
 
+#ifdef CONFIG_TRACE_RECORDER
+    recorder_trace_init();
+#endif
+
     return true;
 }
 
diff --git a/trace/recorder.c b/trace/recorder.c
new file mode 100644
index 0000000000..c47abc363c
--- /dev/null
+++ b/trace/recorder.c
@@ -0,0 +1,27 @@
+/*
+ * Recorder-based trace backend
+ *
+ * Copyright Red Hat 2020
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "trace/recorder.h"
+
+RECORDER_CONSTRUCTOR
+void recorder_trace_init(void)
+{
+    const char *traces = getenv("RECORDER_TRACES");
+    recorder_trace_set(traces);
+
+    /*
+     * Allow a dump in case we receive some unhandled signal
+     * For example, send USR2 to a hung process to get a dump
+     */
+    if (traces) {
+        recorder_dump_on_common_signals(0, 0);
+    }
+}
diff --git a/trace/recorder.h b/trace/recorder.h
new file mode 100644
index 0000000000..e69f633437
--- /dev/null
+++ b/trace/recorder.h
@@ -0,0 +1,32 @@
+/*
+ * Recorder-based trace backend
+ *
+ * Copyright Red Hat 2020
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef TRACE_RECORDER_H
+#define TRACE_RECORDER_H
+
+#ifdef CONFIG_TRACE_RECORDER
+
+#include <recorder/recorder.h>
+
+extern void recorder_trace_init(void);
+
+#else
+
+/* Disable recorder macros */
+#define RECORDER(Name, Size, Description)
+#define RECORDER_DEFINE(Name, Size, Description)
+#define RECORDER_DECLARE(Name)
+#define RECORD(Name, ...)
+#define record(Name, ...)
+#define recorder_trace_init()
+
+#endif /* CONFIG_TRACE_RECORDER */
+
+#endif /* TRACE_RECORDER_H */
diff --git a/util/module.c b/util/module.c
index 0ab00851f0..03179a09aa 100644
--- a/util/module.c
+++ b/util/module.c
@@ -22,6 +22,8 @@
 #ifdef CONFIG_MODULE_UPGRADES
 #include "qemu-version.h"
 #endif
+#include "trace/recorder.h"
+
 
 typedef struct ModuleEntry
 {
@@ -150,6 +152,10 @@ static int module_load_file(const char *fname)
         g_module_close(g_module);
         ret = -EINVAL;
     } else {
+#ifdef CONFIG_TRACE_RECORDER
+        /* New recorders may have been pulled in, activate them if necessary */
+        recorder_trace_init();
+#endif
         QTAILQ_FOREACH(e, &dso_init_list, node) {
             e->init();
             register_module_init(e->init, e->type);
-- 
2.26.2


