Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095EDC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1358208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1358208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcx5q-0003AU-21
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcwh1-0001cF-VO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcwh0-0007ry-9D
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hcwh0-0007ik-0A
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 54FFB307ACE6
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:49:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2D2F52FE;
 Mon, 17 Jun 2019 18:49:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 836161133020; Mon, 17 Jun 2019 20:49:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:49:01 +0200
Message-Id: <20190617184903.19436-15-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 17 Jun 2019 18:49:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/16] monitor: Split Monitor.flags into
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Monitor.flags contains three different flags: One to distinguish HMP
from QMP; one specific to HMP (MONITOR_USE_READLINE) that is ignored
with QMP; and another one specific to QMP (MONITOR_USE_PRETTY) that is
ignored with HMP.

Split the flags field into three bools and move them to the right
subclass. Flags are still in use for the monitor_init() interface.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20190613153405.24769-14-kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/hmp.c              |  6 +++---
 monitor/misc.c             |  2 +-
 monitor/monitor-internal.h |  8 +++++---
 monitor/monitor.c          | 14 +++++++++-----
 monitor/qmp.c              |  7 ++++---
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 86e86c1cf1..07f827c90c 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1397,12 +1397,12 @@ static void monitor_readline_flush(void *opaque)
 void monitor_init_hmp(Chardev *chr, int flags)
 {
     MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
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
index 002aba1030..10f24673f8 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -121,7 +121,7 @@ char *qmp_human_monitor_command(const char *command_l=
ine, bool has_cpu_index,
     Monitor *old_mon;
     MonitorHMP hmp =3D {};
=20
-    monitor_data_init(&hmp.common, 0, true, false);
+    monitor_data_init(&hmp.common, false, true, false);
=20
     old_mon =3D cur_mon;
     cur_mon =3D &hmp.common;
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index b4996c14ac..03ea0239ef 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -86,8 +86,8 @@ typedef struct HMPCommand {
 struct Monitor {
     CharBackend chr;
     int reset_seen;
-    int flags;
     int suspend_cnt;            /* Needs to be accessed atomically */
+    bool is_qmp;
     bool skip_flush;
     bool use_io_thread;
=20
@@ -112,6 +112,7 @@ struct Monitor {
=20
 struct MonitorHMP {
     Monitor common;
+    bool use_readline;
     /*
      * State used only in the thread "owning" the monitor.
      * If @use_io_thread, this is @mon_iothread. (This does not actually=
 happen
@@ -125,6 +126,7 @@ struct MonitorHMP {
 typedef struct {
     Monitor common;
     JSONMessageParser parser;
+    bool pretty;
     /*
      * When a client connects, we're in capabilities negotiation mode.
      * @commands is &qmp_cap_negotiation_commands then.  When command
@@ -148,7 +150,7 @@ typedef struct {
  */
 static inline bool monitor_is_qmp(const Monitor *mon)
 {
-    return mon->flags & MONITOR_USE_CONTROL;
+    return mon->is_qmp;
 }
=20
 typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
@@ -165,7 +167,7 @@ void monitor_init_qmp(Chardev *chr, int flags);
 void monitor_init_hmp(Chardev *chr, int flags);
=20
 int monitor_puts(Monitor *mon, const char *str);
-void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
+void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index db3d5ece99..3f4808240a 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -78,14 +78,18 @@ bool monitor_cur_is_qmp(void)
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
@@ -521,17 +525,17 @@ static void monitor_iothread_init(void)
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
index 7c3d081a72..940649f688 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -87,8 +87,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rs=
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
@@ -373,9 +372,11 @@ void monitor_init_qmp(Chardev *chr, int flags)
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
2.21.0


