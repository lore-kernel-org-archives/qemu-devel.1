Received: from eggs.gnu.org ([2001:4830:134:3::10]:45270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJV-0000iY-FN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJU-0005yS-E5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJU-0005yA-AN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD998401C9AE
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:07 -0500
Message-Id: <20180312183628.394722-17-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 16/36] monitor: move skip_flush into
 monitor_data_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

It's part of the data init.  Collect it.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-6-peterx@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index c18a2f2dc98..b5acc92b735 100644
--- a/monitor.c
+++ b/monitor.c
@@ -570,13 +570,14 @@ static void monitor_qapi_event_init(void)

 static void handle_hmp_command(Monitor *mon, const char *cmdline);

-static void monitor_data_init(Monitor *mon)
+static void monitor_data_init(Monitor *mon, bool skip_flush)
 {
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->out_lock);
     mon->outbuf = qstring_new();
     /* Use *mon_cmds by default. */
     mon->cmd_table = mon_cmds;
+    mon->skip_flush = skip_flush;
 }

 static void monitor_data_destroy(Monitor *mon)
@@ -597,8 +598,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     Monitor *old_mon, hmp;

-    monitor_data_init(&hmp);
-    hmp.skip_flush = true;
+    monitor_data_init(&hmp, true);

     old_mon = cur_mon;
     cur_mon = &hmp;
@@ -4039,7 +4039,7 @@ void monitor_init(Chardev *chr, int flags)
     }

     mon = g_malloc(sizeof(*mon));
-    monitor_data_init(mon);
+    monitor_data_init(mon, false);

     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
-- 
2.14.3
