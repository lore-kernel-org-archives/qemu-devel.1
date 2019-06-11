Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D5C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8A7208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8A7208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahGU-0002el-AP
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 09:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hah1V-00062K-1Z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hah1T-0000yp-Vd
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:41:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hah1R-0000xI-3j; Tue, 11 Jun 2019 09:41:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F6803097031;
 Tue, 11 Jun 2019 13:41:08 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-58.ams2.redhat.com [10.36.117.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68213277A2;
 Tue, 11 Jun 2019 13:41:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 15:40:37 +0200
Message-Id: <20190611134043.9524-6-kwolf@redhat.com>
In-Reply-To: <20190611134043.9524-1-kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 11 Jun 2019 13:41:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 05/11] monitor: Move cmd_table to MonitorHMP
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

Monitor.cmd_table contains the handlers for HMP commands, so there is no
reason to keep it in the state shared with QMP. Move it to MonitorHMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/monitor.c b/monitor.c
index f8730e4462..56af8ed448 100644
--- a/monitor.c
+++ b/monitor.c
@@ -191,7 +191,6 @@ struct Monitor {
     bool use_io_thread;
=20
     gchar *mon_cpu_path;
-    mon_cmd_t *cmd_table;
     QTAILQ_ENTRY(Monitor) entry;
=20
     /*
@@ -219,6 +218,7 @@ struct MonitorHMP {
      * These members can be safely accessed without locks.
      */
     ReadLineState *rs;
+    mon_cmd_t *cmd_table;
 };
=20
 typedef struct {
@@ -720,13 +720,19 @@ static void monitor_data_init(Monitor *mon, int fla=
gs, bool skip_flush,
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->mon_lock);
     mon->outbuf =3D qstring_new();
-    /* Use *mon_cmds by default. */
-    mon->cmd_table =3D mon_cmds;
     mon->skip_flush =3D skip_flush;
     mon->use_io_thread =3D use_io_thread;
     mon->flags =3D flags;
 }
=20
+static void monitor_data_init_hmp(MonitorHMP *mon, int flags, bool skip_=
flush)
+{
+    monitor_data_init(&mon->common, flags, skip_flush, false);
+
+    /* Use *mon_cmds by default. */
+    mon->cmd_table =3D mon_cmds;
+}
+
 static void monitor_data_destroy_qmp(MonitorQMP *mon)
 {
     json_message_parser_destroy(&mon->parser);
@@ -757,7 +763,7 @@ char *qmp_human_monitor_command(const char *command_l=
ine, bool has_cpu_index,
     Monitor *old_mon;
     MonitorHMP hmp =3D {};
=20
-    monitor_data_init(&hmp.common, 0, true, false);
+    monitor_data_init_hmp(&hmp, 0, true);
=20
     old_mon =3D cur_mon;
     cur_mon =3D &hmp.common;
@@ -1002,6 +1008,7 @@ static void help_cmd_dump(Monitor *mon, const mon_c=
md_t *cmds,
=20
 static void help_cmd(Monitor *mon, const char *name)
 {
+    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
     char *args[MAX_ARGS];
     int nb_args =3D 0;
=20
@@ -1024,7 +1031,7 @@ static void help_cmd(Monitor *mon, const char *name=
)
     }
=20
     /* 2. dump the contents according to parsed args */
-    help_cmd_dump(mon, mon->cmd_table, args, nb_args, 0);
+    help_cmd_dump(mon, hmp_mon->cmd_table, args, nb_args, 0);
=20
     free_cmdline_args(args, nb_args);
 }
@@ -3479,7 +3486,7 @@ static void handle_hmp_command(MonitorHMP *mon, con=
st char *cmdline)
=20
     trace_handle_hmp_command(mon, cmdline);
=20
-    cmd =3D monitor_parse_command(mon, cmdline, &cmdline, mon->common.cm=
d_table);
+    cmd =3D monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table=
);
     if (!cmd) {
         return;
     }
@@ -4126,7 +4133,7 @@ static void monitor_find_completion(void *opaque,
     }
=20
     /* 2. auto complete according to args */
-    monitor_find_completion_by_table(mon, mon->common.cmd_table, args, n=
b_args);
+    monitor_find_completion_by_table(mon, mon->cmd_table, args, nb_args)=
;
=20
 cleanup:
     free_cmdline_args(args, nb_args);
@@ -4682,7 +4689,7 @@ static void monitor_init_hmp(Chardev *chr, int flag=
s)
     MonitorHMP *mon =3D g_malloc0(sizeof(*mon));
     bool use_readline =3D flags & MONITOR_USE_READLINE;
=20
-    monitor_data_init(&mon->common, flags, false, false);
+    monitor_data_init_hmp(mon, flags, false);
     qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
=20
     if (use_readline) {
--=20
2.20.1


