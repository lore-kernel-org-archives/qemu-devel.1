Received: from eggs.gnu.org ([2001:4830:134:3::10]:51855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOvd-0006N0-J0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOvc-0006pO-SW
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOvc-0006of-Ld
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:16 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:25 +0800
Message-Id: <1505375436-28439-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-1-git-send-email-peterx@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 04/15] monitor: move skip_flush into
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

It's part of the data init.  Collect it.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 9239f7a..8b32519 100644
--- a/monitor.c
+++ b/monitor.c
@@ -568,13 +568,14 @@ static void monitor_qapi_event_init(void)
 
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
@@ -594,8 +595,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     Monitor *old_mon, hmp;
 
-    monitor_data_init(&hmp);
-    hmp.skip_flush = true;
+    monitor_data_init(&hmp, true);
 
     old_mon = cur_mon;
     cur_mon = &hmp;
@@ -4098,7 +4098,7 @@ void monitor_init(Chardev *chr, int flags)
     }
 
     mon = g_malloc(sizeof(*mon));
-    monitor_data_init(mon);
+    monitor_data_init(mon, false);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
-- 
2.7.4
