Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627CCC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383A820644
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383A820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSnC-0005qa-FK
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59833)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbRkl-0000M8-Bn
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbRkg-0003Go-Hd
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbRkU-00033T-Lv; Thu, 13 Jun 2019 11:34:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06DAEC1EB217;
 Thu, 13 Jun 2019 15:34:26 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97BFD61090;
 Thu, 13 Jun 2019 15:34:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:33:52 +0200
Message-Id: <20190613153405.24769-3-kwolf@redhat.com>
In-Reply-To: <20190613153405.24769-1-kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 13 Jun 2019 15:34:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 02/15] monitor: Split monitor_init in HMP
 and QMP function
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

Instead of mixing HMP and QMP monitors in the same function, separate
the monitor creation function for both.

While in theory, one could pass both MONITOR_USE_CONTROL and
MONITOR_USE_READLINE before this patch and both flags would do
something, readline support is tightly coupled with HMP: QMP never feeds
its input to readline, and the tab completion function treats the input
as an HMP command. Therefore, this configuration is useless.

After this patch, the QMP path asserts that MONITOR_USE_READLINE is not
set. The HMP path can be used with or without MONITOR_USE_READLINE, like
before.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 89 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 37 deletions(-)

diff --git a/monitor.c b/monitor.c
index 9846a5623b..a70c1283b1 100644
--- a/monitor.c
+++ b/monitor.c
@@ -704,7 +704,7 @@ static void handle_hmp_command(Monitor *mon, const ch=
ar *cmdline);
=20
 static void monitor_iothread_init(void);
=20
-static void monitor_data_init(Monitor *mon, bool skip_flush,
+static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
                               bool use_io_thread)
 {
     if (use_io_thread && !mon_iothread) {
@@ -719,6 +719,7 @@ static void monitor_data_init(Monitor *mon, bool skip=
_flush,
     mon->skip_flush =3D skip_flush;
     mon->use_io_thread =3D use_io_thread;
     mon->qmp.qmp_requests =3D g_queue_new();
+    mon->flags =3D flags;
 }
=20
 static void monitor_data_destroy(Monitor *mon)
@@ -742,7 +743,7 @@ char *qmp_human_monitor_command(const char *command_l=
ine, bool has_cpu_index,
     char *output =3D NULL;
     Monitor *old_mon, hmp;
=20
-    monitor_data_init(&hmp, true, false);
+    monitor_data_init(&hmp, 0, true, false);
=20
     old_mon =3D cur_mon;
     cur_mon =3D &hmp;
@@ -4605,19 +4606,51 @@ static void monitor_qmp_setup_handlers_bh(void *o=
paque)
     monitor_list_append(mon);
 }
=20
-void monitor_init(Chardev *chr, int flags)
+static void monitor_init_qmp(Chardev *chr, int flags)
 {
     Monitor *mon =3D g_malloc(sizeof(*mon));
-    bool use_readline =3D flags & MONITOR_USE_READLINE;
+
+    /* Only HMP supports readline */
+    assert(!(flags & MONITOR_USE_READLINE));
=20
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(mon, false,
-                      (flags & MONITOR_USE_CONTROL)
-                      && qemu_chr_has_feature(chr,
-                                              QEMU_CHAR_FEATURE_GCONTEXT=
));
+    monitor_data_init(mon, flags, false,
+                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTE=
XT));
=20
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
-    mon->flags =3D flags;
+    qemu_chr_fe_set_echo(&mon->chr, true);
+
+    json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon, =
NULL);
+    if (mon->use_io_thread) {
+        /*
+         * Make sure the old iowatch is gone.  It's possible when
+         * e.g. the chardev is in client mode, with wait=3Don.
+         */
+        remove_fd_in_watch(chr);
+        /*
+         * We can't call qemu_chr_fe_set_handlers() directly here
+         * since chardev might be running in the monitor I/O
+         * thread.  Schedule a bottom half.
+         */
+        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+                                monitor_qmp_setup_handlers_bh, mon);
+        /* The bottom half will add @mon to @mon_list */
+    } else {
+        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
+                                 monitor_qmp_read, monitor_qmp_event,
+                                 NULL, mon, NULL, true);
+        monitor_list_append(mon);
+    }
+}
+
+static void monitor_init_hmp(Chardev *chr, int flags)
+{
+    Monitor *mon =3D g_malloc(sizeof(*mon));
+    bool use_readline =3D flags & MONITOR_USE_READLINE;
+
+    monitor_data_init(mon, flags, false, false);
+    qemu_chr_fe_init(&mon->chr, chr, &error_abort);
+
     if (use_readline) {
         mon->rs =3D readline_init(monitor_readline_printf,
                                 monitor_readline_flush,
@@ -4626,36 +4659,18 @@ void monitor_init(Chardev *chr, int flags)
         monitor_read_command(mon, 0);
     }
=20
-    if (monitor_is_qmp(mon)) {
-        qemu_chr_fe_set_echo(&mon->chr, true);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
-                                 mon, NULL);
-        if (mon->use_io_thread) {
-            /*
-             * Make sure the old iowatch is gone.  It's possible when
-             * e.g. the chardev is in client mode, with wait=3Don.
-             */
-            remove_fd_in_watch(chr);
-            /*
-             * We can't call qemu_chr_fe_set_handlers() directly here
-             * since chardev might be running in the monitor I/O
-             * thread.  Schedule a bottom half.
-             */
-            aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothrea=
d),
-                                    monitor_qmp_setup_handlers_bh, mon);
-            /* The bottom half will add @mon to @mon_list */
-            return;
-        } else {
-            qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
-                                     monitor_qmp_read, monitor_qmp_event=
,
-                                     NULL, mon, NULL, true);
-        }
+    qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
+                             monitor_event, NULL, mon, NULL, true);
+    monitor_list_append(mon);
+}
+
+void monitor_init(Chardev *chr, int flags)
+{
+    if (flags & MONITOR_USE_CONTROL) {
+        monitor_init_qmp(chr, flags);
     } else {
-        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_re=
ad,
-                                 monitor_event, NULL, mon, NULL, true);
+        monitor_init_hmp(chr, flags);
     }
-
-    monitor_list_append(mon);
 }
=20
 void monitor_cleanup(void)
--=20
2.20.1


