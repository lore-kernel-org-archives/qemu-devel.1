Received: from eggs.gnu.org ([2001:4830:134:3::10]:49812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkPW4-0002Ds-T0
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkPW4-0007We-7a
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:51:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dkPW4-0007WM-1C
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:51:52 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 23 Aug 2017 14:51:08 +0800
Message-Id: <1503471071-2233-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1503471071-2233-1-git-send-email-peterx@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 5/8] hmp: support "without_bql"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Introducing new option "without_bql" for HMP commands.  It works just
like QMP "without-bql", but for HMP commands.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor.c b/monitor.c
index 3d4ecff..c26c797 100644
--- a/monitor.c
+++ b/monitor.c
@@ -125,6 +125,8 @@ typedef struct mon_cmd_t {
     const char *args_type;
     const char *params;
     const char *help;
+    /* Whether this command can be run without taking BQL? */
+    bool without_bql;
     void (*cmd)(Monitor *mon, const QDict *qdict);
     /* @sub_table is a list of 2nd level of commands. If it does not exist,
      * cmd should be used. If it exists, sub_table[?].cmd should be
@@ -3154,6 +3156,14 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
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
