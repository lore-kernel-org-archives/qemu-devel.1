Received: from eggs.gnu.org ([2001:4830:134:3::10]:46426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhOJ-0001WR-Bx
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhOE-0005Dn-HU
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1djhOE-0005DW-BM
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:50 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 21 Aug 2017 15:44:23 +0800
Message-Id: <1503301464-27886-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1503301464-27886-1-git-send-email-peterx@redhat.com>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 5/6] hmp: support "without_bql"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Introducing new option "without_bql" for HMP commands.  It works just
like QMP "without-bql", but for HMP commands.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor.c b/monitor.c
index 18504ef..475a3a6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -124,6 +124,8 @@ typedef struct mon_cmd_t {
     const char *args_type;
     const char *params;
     const char *help;
+    /* Whether this command can be run without taking BQL? */
+    bool without_bql;
     void (*cmd)(Monitor *mon, const QDict *qdict);
     /* @sub_table is a list of 2nd level of commands. If it does not exist,
      * cmd should be used. If it exists, sub_table[?].cmd should be
@@ -3146,6 +3148,14 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
         return;
     }
 
+    if (cmd->without_bql) {
+        /*
+         * This is similar to QMP's "without-bql".  See comments in
+         * do_qmp_dispatch().
+         */
+        take_bql = false;
+    }
+
     if (take_bql) {
         qemu_mutex_lock_iothread();
     }
-- 
2.7.4
