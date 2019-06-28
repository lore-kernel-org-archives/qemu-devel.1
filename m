Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF0C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F3820644
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="7SkZLZ7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F3820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqri-0000fJ-5H
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41648)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGU-0000Ce-HA
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGM-0001cW-P6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:46:05 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hgqGM-0001RW-Af
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:45:58 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id DB90596F56;
 Fri, 28 Jun 2019 12:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1561725940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52GqakeBEYFuvvGGQuIdSqZ3Pd2SaMwkpCLAurtIDyg=;
 b=7SkZLZ7XEke4O7AOVq6ydDJvywXeJk21MVckEuIUo9UyHE7CxYoqQtR7anet/Z+d8NRMxH
 XPj3/QDGts+0akfBL3wM8HhmIwZzDLRIXZyoZnvqyVUQ83mCJJpA0J52kZ1tHQ3ZOg4TwA
 6430zKi5d7vd8Wsp9JbZzUfRI7SpeKM=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 14:45:32 +0200
Message-Id: <20190628124534.10679-4-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628124534.10679-1-damien.hedde@greensocs.com>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1561725940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52GqakeBEYFuvvGGQuIdSqZ3Pd2SaMwkpCLAurtIDyg=;
 b=ykKUVV1gK/kbs7YSwkkom+VSz6gJJj0xjK1aUiUlxFduHTPem34+XQCXe7v2j7itLMurD3
 ohwRM7l9mG4mIATddPZGjPvdT36jBvuXXwOtQiw7nVPwjliTqqJO0xWoJzRJU2P0ZlHhau
 F/2+KXU2XOI6BHGFbbhXRbV5we7EBsc=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1561725940; a=rsa-sha256; cv=none;
 b=qvW0Rfe6Z6xbscss3SxZT9uzqT1+cH5Hu+dz5nZVqW0I9xeIaV8lSX1ycUA4gO+kTtc7oY
 U+B18rch+XLrufL4965dnzMqyWAiSk9r4x3kIXVNvTyrVmfmODpYlPVbujEdaRGKMoZ4+B
 2fOEiRN1+66MJlLUXxXdEn3JE6ZC4Zk=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH 3/5] add qmp time-notify event triggering
 system
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, ehabkost@redhat.com,
 mark.burton@greensocs.com, armbru@redhat.com, sakisp@xilinx.com,
 edgari@xilinx.com, crosa@redhat.com, pbonzini@redhat.com,
 luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds an event triggering mechanism composed of:
 + an event that is catchable by qmp clients
 + a command to create such events

When triggered the event TIME_NOTIFICATION is signaled. Optionnaly the
virtual machine is also paused (put in debug state). The virtual machine =
can
then be restarted by the _cont_ command.

To create an event, an id and the deadline in virtual clock nanoseconds
should be given to the "time-notify" qmp command. The event will be
triggered at the given time which may be absolute or relative to the
current virtual clock time.

This allows to write qmp clients that can pause the vm, do some actions
then restart the vm.

This is based on the work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 monitor/Makefile.objs         |   1 +
 monitor/qmp-cmd-time-notify.c | 116 ++++++++++++++++++++++++++++++++++
 monitor/trace-events          |   4 ++
 qapi/misc.json                |  48 ++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 monitor/qmp-cmd-time-notify.c

diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index e91a8581cd..f4c7293460 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y +=3D misc.o
 common-obj-y +=3D monitor.o qmp.o hmp.o
 common-obj-y +=3D qmp-cmds.o hmp-cmds.o
+common-obj-y +=3D qmp-cmd-time-notify.o
diff --git a/monitor/qmp-cmd-time-notify.c b/monitor/qmp-cmd-time-notify.=
c
new file mode 100644
index 0000000000..de13b2d3a1
--- /dev/null
+++ b/monitor/qmp-cmd-time-notify.c
@@ -0,0 +1,116 @@
+/*
+ * qmp-cmd-time-notify.c
+ *
+ * Copyright (c) 2016,2019 GreenSocs SAS
+ *
+ * Authors:
+ *    Fred Konrad
+ *    Damien Hedde
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-events-misc.h"
+#include "qemu/timer.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/cpus.h"
+#include "trace.h"
+
+typedef struct TimeNotifEntry TimeNotifEntry;
+static QLIST_HEAD(, TimeNotifEntry) events =3D QLIST_HEAD_INITIALIZER(ev=
ents);
+static QEMUTimer *timer;
+
+struct TimeNotifEntry {
+    uint64_t time_ns;
+    int64_t id;
+    bool pause;
+    QLIST_ENTRY(TimeNotifEntry) node;
+};
+
+static void mod_next_event_timer(void)
+{
+    if (QLIST_EMPTY(&events)) {
+        return;
+    }
+
+    timer_mod(timer, QLIST_FIRST(&events)->time_ns);
+}
+
+static void trigger_notif(void *opaque)
+{
+    TimeNotifEntry *entry;
+    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    bool do_stop;
+
+    entry =3D QLIST_FIRST(&events);
+    assert(entry && entry->time_ns <=3D current_time);
+    do_stop =3D entry->pause;
+
+    QLIST_REMOVE(entry, node);
+    qapi_event_send_time_notification(entry->id, current_time);
+    trace_qmp_time_notify_trigger(entry->id, current_time, entry->pause)=
;
+    g_free(entry);
+
+    mod_next_event_timer();
+
+    if (do_stop) {
+        qemu_system_vmstop_request_prepare();
+        qemu_system_vmstop_request(RUN_STATE_DEBUG);
+        /*
+         * FIXME: should not return to device code in case
+         * vm_stop() has been requested.
+         */
+        cpu_stop_current();
+    }
+}
+
+void qmp_time_notify(int64_t event_id, int64_t time_ns,
+                     bool has_relative, bool relative,
+                     bool has_pause, bool pause,
+                     Error **errp)
+{
+    TimeNotifEntry *new_entry, *entry, *prev =3D NULL;
+
+    if (!timer) {
+        timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, trigger_notif, NULL);
+    }
+
+    if (time_ns < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "time_ns",
+                "must be positive");
+    }
+
+    new_entry =3D g_new0(TimeNotifEntry, 1);
+    new_entry->id =3D event_id;
+    new_entry->time_ns =3D time_ns;
+    new_entry->pause =3D has_pause && pause;
+    if (has_relative && relative) {
+        new_entry->time_ns +=3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+    trace_qmp_time_notify_schedule(new_entry->id, new_entry->time_ns,
+                                   new_entry->pause);
+
+    /* find the event just before the new one */
+    QLIST_FOREACH(entry, &events, node) {
+        if (entry->time_ns > new_entry->time_ns) {
+            break;
+        }
+        prev =3D entry;
+    }
+
+    /* then insert the new entry */
+    if (prev) {
+        QLIST_INSERT_AFTER(prev, new_entry, node);
+    } else {
+        QLIST_INSERT_HEAD(&events, new_entry, node);
+        mod_next_event_timer();
+    }
+}
diff --git a/monitor/trace-events b/monitor/trace-events
index 0365ac4d99..73f375db68 100644
--- a/monitor/trace-events
+++ b/monitor/trace-events
@@ -13,3 +13,7 @@ monitor_suspend(void *ptr, int cnt) "mon %p: %d"
 monitor_qmp_cmd_in_band(const char *id) "%s"
 monitor_qmp_cmd_out_of_band(const char *id) "%s"
 handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
+
+# qmp-cmd-time-notify.c
+qmp_time_notify_trigger(int64_t id, uint64_t time, int pause) "event #%"=
PRId64" at %"PRIu64" ns pause %d"
+qmp_time_notify_schedule(int64_t id, uint64_t time, int pause) "event #%=
"PRId64" at %"PRIu64" ns pause %d"
diff --git a/qapi/misc.json b/qapi/misc.json
index 255236b96f..8e84f4d4d3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3195,3 +3195,51 @@
 { 'command': 'gpio-set',
   'data': { 'path': 'str', '*gpio': 'str', '*number': 'int', 'value': 'b=
ool' }
 }
+
+##
+# @time-notify:
+#
+# Schedule a TIME_NOTIFICATION which will optionally stop qemu when trig=
gered.
+#
+# @time_ns:  The virtual guest clock at which do the notification.
+#
+# @relative: Optional boolean telling if time_ns is relative to current =
time.
+#            Defaults to False.
+#
+# @event_id: An ID, to track the notification.
+#
+# @pause: Optional boolean telling whether to pause qemu when notificati=
on is
+#         hit. Defaults to False.
+#
+# Returns: nothing in case of success
+#
+# Since 4.1
+#
+# Example:
+#
+# -> { "execute": "time-notify",
+#      "arguments": { "event_id": 5,
+#                      "time_ns": 10000000,
+#                      "pause": true} }
+# <- { "return": {} }
+#
+##
+{ 'command': 'time-notify',
+  'data': {'event_id': 'int', 'time_ns': 'int', '*relative': 'bool',
+           '*pause': 'bool'}
+}
+
+##
+# @TIME_NOTIFICATION:
+#
+# Emitted when notification deadline is hit
+#
+# @time_ns:  The current virtual guest clock time.
+#
+# @event_id: The id given when setting up the notification.
+#
+# Since: 4.1
+#
+##
+{ 'event': 'TIME_NOTIFICATION',
+  'data': { 'event_id': 'int', 'time_ns': 'int'} }
--=20
2.22.0


