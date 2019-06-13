Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D1DC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285D7215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285D7215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSjW-0001O9-Gc
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59824)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbRkk-0000Lz-Gz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbRkg-0003Gm-Hr
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbRkU-00036Z-Rj; Thu, 13 Jun 2019 11:34:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E04C988E5B;
 Thu, 13 Jun 2019 15:34:40 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F15260FFE;
 Thu, 13 Jun 2019 15:34:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:33:55 +0200
Message-Id: <20190613153405.24769-6-kwolf@redhat.com>
In-Reply-To: <20190613153405.24769-1-kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 13 Jun 2019 15:34:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 05/15] monitor: Remove Monitor.cmd_table
 indirection
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

Monitor.cmd_table is initialised to point to mon_cmds and never changed
afterwards. We can remove the indirection and just reference mon_cmds
directly instead.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 572449f6db..5eacaa48a6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -193,7 +193,6 @@ struct Monitor {
     bool use_io_thread;
=20
     gchar *mon_cpu_path;
-    mon_cmd_t *cmd_table;
     QTAILQ_ENTRY(Monitor) entry;
=20
     /*
@@ -722,8 +721,6 @@ static void monitor_data_init(Monitor *mon, int flags=
, bool skip_flush,
     }
     qemu_mutex_init(&mon->mon_lock);
     mon->outbuf =3D qstring_new();
-    /* Use *mon_cmds by default. */
-    mon->cmd_table =3D mon_cmds;
     mon->skip_flush =3D skip_flush;
     mon->use_io_thread =3D use_io_thread;
     mon->flags =3D flags;
@@ -1026,7 +1023,7 @@ static void help_cmd(Monitor *mon, const char *name=
)
     }
=20
     /* 2. dump the contents according to parsed args */
-    help_cmd_dump(mon, mon->cmd_table, args, nb_args, 0);
+    help_cmd_dump(mon, mon_cmds, args, nb_args, 0);
=20
     free_cmdline_args(args, nb_args);
 }
@@ -3487,7 +3484,7 @@ static void handle_hmp_command(MonitorHMP *mon, con=
st char *cmdline)
=20
     trace_handle_hmp_command(mon, cmdline);
=20
-    cmd =3D monitor_parse_command(mon, cmdline, &cmdline, mon->common.cm=
d_table);
+    cmd =3D monitor_parse_command(mon, cmdline, &cmdline, mon_cmds);
     if (!cmd) {
         return;
     }
@@ -4134,7 +4131,7 @@ static void monitor_find_completion(void *opaque,
     }
=20
     /* 2. auto complete according to args */
-    monitor_find_completion_by_table(mon, mon->common.cmd_table, args, n=
b_args);
+    monitor_find_completion_by_table(mon, mon_cmds, args, nb_args);
=20
 cleanup:
     free_cmdline_args(args, nb_args);
--=20
2.20.1


