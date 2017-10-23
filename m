Received: from eggs.gnu.org ([2001:4830:134:3::10]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHG-0005eC-0O
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHF-00008X-1z
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHE-000073-SG
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AAF9C0587CC
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:49 +0200
Message-Id: <20171023160800.20540-11-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 10/21] migrate: HMP migate_continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

HMP equivalent to the just added migrate-continue
Unpause a migrate paused at a given state.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp-commands.hx | 12 ++++++++++++
 hmp.c           | 13 +++++++++++++
 hmp.h           |  1 +
 3 files changed, 26 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19932..4afd57cf5f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -959,7 +959,19 @@ STEXI
 @item migrate_cancel
 @findex migrate_cancel
 Cancel the current VM migration.
+ETEXI
 
+    {
+        .name       = "migrate_continue",
+        .args_type  = "state:s",
+        .params     = "state",
+        .help       = "Continue migration from the given paused state",
+        .cmd        = hmp_migrate_continue,
+    },
+STEXI
+@item migrate_continue @var{state}
+@findex migrate_continue
+Continue migration from the paused state @var{state}
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index ec61329ebb..41fcce6f5a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1495,6 +1495,19 @@ void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
     qmp_migrate_cancel(NULL);
 }
 
+void hmp_migrate_continue(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    const char *state = qdict_get_str(qdict, "state");
+    int val = qapi_enum_parse(&MigrationStatus_lookup, state, -1, &err);
+
+    if (val >= 0) {
+        qmp_migrate_continue(val, &err);
+    }
+
+    hmp_handle_error(mon, &err);
+}
+
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
diff --git a/hmp.h b/hmp.h
index 3605003e4c..a6f56b1f29 100644
--- a/hmp.h
+++ b/hmp.h
@@ -68,6 +68,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
+void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_speed(Monitor *mon, const QDict *qdict);
-- 
2.13.6
