Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E92C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2F82063F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2F82063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41964 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbT7N-0006gj-Ee
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60243)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbRlT-00010q-Jv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbRlR-0003z3-7c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbRlG-0003pF-06; Thu, 13 Jun 2019 11:35:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F991C047B7A;
 Thu, 13 Jun 2019 15:35:26 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8183961980;
 Thu, 13 Jun 2019 15:35:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:34:03 +0200
Message-Id: <20190613153405.24769-14-kwolf@redhat.com>
In-Reply-To: <20190613153405.24769-1-kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 15:35:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 13/15] monitor: Split Monitor.flags into
 separate bools
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Monitor.flags contains three different flags: One to distinguish HMP
from QMP; one specific to HMP (MONITOR_USE_READLINE) that is ignored
with QMP; and another one specific to QMP (MONITOR_USE_PRETTY) that is
ignored with HMP.

Split the flags field into three bools and move them to the right
subclass. Flags are still in use for the monitor_init() interface.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/monitor-internal.h |  8 +++++---
 monitor/hmp.c              |  6 +++---
 monitor/misc.c             |  2 +-
 monitor/monitor.c          | 14 +++++++++-----
 monitor/qmp.c              |  7 ++++---
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 30679d522e..260725e51b 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -90,8 +90,8 @@ typedef struct HMPCommand {
 struct Monitor {
     CharBackend chr;
     int reset_seen;
-    int flags;
     int suspend_cnt;            /* Needs to be accessed atomically */
+    bool is_qmp;
     bool skip_flush;
     bool use_io_thread;
=20
@@ -116,6 +116,7 @@ struct Monitor {
=20
 struct MonitorHMP {
     Monitor common;
+    bool use_readline;
     /*
      * State used only in the thread "owning" the monitor.
      * If @use_io_thread, this is @mon_iothread. (This does not actually=
 happen
@@ -129,6 +130,7 @@ struct MonitorHMP {
 typedef struct {
     Monitor common;
     JSONMessageParser parser;
+    bool pretty;
     /*
      * When a client connects, we're in capabilities negotiation mode.
      * @commands is &qmp_cap_negotiation_commands then.  When command
@@ -152,7 +154,7 @@ typedef struct {
  */
 static inline bool monitor_is_qmp(const Monitor *mon)
 {
-    return (mon->flags & MONITOR_USE_CONTROL);
+    return mon->is_qmp;
 }
=20
 typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
@@ -169,7 +171,7 @@ void monitor_init_qmp(Chardev *chr, int flags);
 void monitor_init_hmp(Chardev *chr, int flags);
=20
 int monitor_puts(Monitor *mon, const char *str);
-void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
+void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 3621b195ed..5ba8b6e8d5 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1396,12 +1396,12 @@ static void monitor_readline_flush(void *opaque)
 void monitor_init_hmp(Chardev *chr, int flags)
 {
     MonitorHMP *mon =3D g_malloc0(sizeof(*mon));
-    bool use_readline =3D flags & MONITOR_USE_READLINE;
=20
-    monitor_data_init(&mon->common, flags, false, false);
+    monitor_data_init(&mon->common, false, false, false);
     qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
=20
-    if (use_readline) {
+    mon->use_readline =3D flags & MONITOR_USE_READLINE;
+    if (mon->use_readline) {
         mon->rs =3D readline_init(monitor_readline_printf,
                                 monitor_readline_flush,
                                 mon,
diff --git a/monitor/misc.c b/monitor/misc.c
index dddbddb21f..10c056394e 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -134,7 +134,7 @@ char *qmp_human_monitor_command(const char *command_l=
ine, bool has_cpu_index,
     Monitor *old_mon;
     MonitorHMP hmp =3D {};
=20
-    monitor_data_init(&hmp.common, 0, true, false);
+    monitor_data_init(&hmp.common, false, true, false);
=20
     old_mon =3D cur_mon;
     cur_mon =3D &hmp.common;
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 6802b8e491..7325e4362b 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -80,14 +80,18 @@ bool monitor_cur_is_qmp(void)
  * Note: not all HMP monitors use readline, e.g., gdbserver has a
  * non-interactive HMP monitor, so readline is not used there.
  */
-static inline bool monitor_uses_readline(const Monitor *mon)
+static inline bool monitor_uses_readline(const MonitorHMP *mon)
 {
-    return mon->flags & MONITOR_USE_READLINE;
+    return mon->use_readline;
 }
=20
 static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
 {
-    return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
+    if (monitor_is_qmp(mon)) {
+        return false;
+    }
+
+    return !monitor_uses_readline(container_of(mon, MonitorHMP, common))=
;
 }
=20
 static void monitor_flush_locked(Monitor *mon);
@@ -523,17 +527,17 @@ static void monitor_iothread_init(void)
     mon_iothread =3D iothread_create("mon_iothread", &error_abort);
 }
=20
-void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
+void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread)
 {
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
     }
     qemu_mutex_init(&mon->mon_lock);
+    mon->is_qmp =3D is_qmp;
     mon->outbuf =3D qstring_new();
     mon->skip_flush =3D skip_flush;
     mon->use_io_thread =3D use_io_thread;
-    mon->flags =3D flags;
 }
=20
 void monitor_data_destroy(Monitor *mon)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 31fbcd59f7..3abc718ca3 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -86,8 +86,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rs=
p)
     const QObject *data =3D QOBJECT(rsp);
     QString *json;
=20
-    json =3D mon->common.flags & MONITOR_USE_PRETTY ?
-           qobject_to_json_pretty(data) : qobject_to_json(data);
+    json =3D mon->pretty ? qobject_to_json_pretty(data) : qobject_to_jso=
n(data);
     assert(json !=3D NULL);
=20
     qstring_append_chr(json, '\n');
@@ -372,9 +371,11 @@ void monitor_init_qmp(Chardev *chr, int flags)
     assert(!(flags & MONITOR_USE_READLINE));
=20
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(&mon->common, flags, false,
+    monitor_data_init(&mon->common, true, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTE=
XT));
=20
+    mon->pretty =3D flags & MONITOR_USE_PRETTY;
+
     qemu_mutex_init(&mon->qmp_queue_lock);
     mon->qmp_requests =3D g_queue_new();
=20
--=20
2.20.1


