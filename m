Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B4C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B809C20896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B809C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hah7k-0002fh-VD
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hah1L-0005oL-5t
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hah1J-0000uX-Rl
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hah1H-0000sn-0P; Tue, 11 Jun 2019 09:40:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F9E244BD1;
 Tue, 11 Jun 2019 13:40:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-58.ams2.redhat.com [10.36.117.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACCD519C59;
 Tue, 11 Jun 2019 13:40:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 15:40:34 +0200
Message-Id: <20190611134043.9524-3-kwolf@redhat.com>
In-Reply-To: <20190611134043.9524-1-kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 11 Jun 2019 13:40:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/11] monitor: Split monitor_init in HMP
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 86 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/monitor.c b/monitor.c
index 70ce9e8a77..bb23cc0450 100644
--- a/monitor.c
+++ b/monitor.c
@@ -702,7 +702,7 @@ static void handle_hmp_command(Monitor *mon, const ch=
ar *cmdline);
=20
 static void monitor_iothread_init(void);
=20
-static void monitor_data_init(Monitor *mon, bool skip_flush,
+static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
                               bool use_io_thread)
 {
     if (use_io_thread && !mon_iothread) {
@@ -717,6 +717,7 @@ static void monitor_data_init(Monitor *mon, bool skip=
_flush,
     mon->skip_flush =3D skip_flush;
     mon->use_io_thread =3D use_io_thread;
     mon->qmp.qmp_requests =3D g_queue_new();
+    mon->flags =3D flags;
 }
=20
 static void monitor_data_destroy(Monitor *mon)
@@ -740,7 +741,7 @@ char *qmp_human_monitor_command(const char *command_l=
ine, bool has_cpu_index,
     char *output =3D NULL;
     Monitor *old_mon, hmp;
=20
-    monitor_data_init(&hmp, true, false);
+    monitor_data_init(&hmp, 0, true, false);
=20
     old_mon =3D cur_mon;
     cur_mon =3D &hmp;
@@ -4603,19 +4604,48 @@ static void monitor_qmp_setup_handlers_bh(void *o=
paque)
     monitor_list_append(mon);
 }
=20
-void monitor_init(Chardev *chr, int flags)
+static void monitor_init_qmp(Chardev *chr, int flags)
 {
     Monitor *mon =3D g_malloc(sizeof(*mon));
-    bool use_readline =3D flags & MONITOR_USE_READLINE;
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
@@ -4624,36 +4654,18 @@ void monitor_init(Chardev *chr, int flags)
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


