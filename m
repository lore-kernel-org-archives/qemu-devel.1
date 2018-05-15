Received: from eggs.gnu.org ([2001:4830:134:3::10]:58431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZ3-0003Tf-MO
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZ2-0001zX-Pn
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjZ2-0001zN-Lb
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39EE140203F4
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:41:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:40:10 +0200
Message-Id: <20180515234017.2277-34-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 33/40] hmp/migration: add migrate_recover command
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

From: Peter Xu <peterx@redhat.com>

Sister command to migrate-recover in QMP.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-22-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp-commands.hx | 13 +++++++++++++
 hmp.c           | 10 ++++++++++
 hmp.h           |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index a7051ee391..2fa387d341 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -957,7 +957,20 @@ STEXI
 @findex migrate_incoming
 Continue an incoming migration using the @var{uri} (that has the same syntax
 as the -incoming option).
+ETEXI
 
+    {
+        .name       = "migrate_recover",
+        .args_type  = "uri:s",
+        .params     = "uri",
+        .help       = "Continue a paused incoming postcopy migration",
+        .cmd        = hmp_migrate_recover,
+    },
+
+STEXI
+@item migrate_recover @var{uri}
+@findex migrate_recover
+Continue a paused incoming postcopy migration using the @var{uri}.
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index a7aa878788..2a36c1cf8d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1517,6 +1517,16 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    const char *uri = qdict_get_str(qdict, "uri");
+
+    qmp_migrate_recover(uri, &err);
+
+    hmp_handle_error(mon, &err);
+}
+
 /* Kept for backwards compatibility */
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict)
 {
diff --git a/hmp.h b/hmp.h
index 4e2ec375b0..b6b56c8161 100644
--- a/hmp.h
+++ b/hmp.h
@@ -68,6 +68,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
+void hmp_migrate_recover(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_speed(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict);
-- 
2.17.0
