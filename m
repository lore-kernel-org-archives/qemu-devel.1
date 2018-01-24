Received: from eggs.gnu.org ([2001:4830:134:3::10]:55778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDnr-0001G3-4d
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDno-00075g-1r
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:40:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eeDnn-00074z-Rf
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:40:51 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 24 Jan 2018 13:39:39 +0800
Message-Id: <20180124053957.29145-6-peterx@redhat.com>
In-Reply-To: <20180124053957.29145-1-peterx@redhat.com>
References: <20180124053957.29145-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 05/23] monitor: move skip_flush into
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
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

It's part of the data init.  Collect it.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index b9da5e20d1..3a28a6d935 100644
--- a/monitor.c
+++ b/monitor.c
@@ -567,13 +567,14 @@ static void monitor_qapi_event_init(void)
 
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
@@ -4088,7 +4088,7 @@ void monitor_init(Chardev *chr, int flags)
     }
 
     mon = g_malloc(sizeof(*mon));
-    monitor_data_init(mon);
+    monitor_data_init(mon, false);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
-- 
2.14.3
