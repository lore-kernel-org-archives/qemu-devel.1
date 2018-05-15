Received: from eggs.gnu.org ([2001:4830:134:3::10]:58465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZ7-0003YE-Vj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZ6-00021K-Rh
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjZ6-000210-J5
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2752C40201A0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:41:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:40:13 +0200
Message-Id: <20180515234017.2277-37-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 36/40] migration/hmp: add migrate_pause command
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

Wrapper for QMP command "migrate-pause".

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-25-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp-commands.hx | 14 ++++++++++++++
 hmp.c           |  9 +++++++++
 hmp.h           |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2fa387d341..0734fea931 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -971,6 +971,20 @@ STEXI
 @item migrate_recover @var{uri}
 @findex migrate_recover
 Continue a paused incoming postcopy migration using the @var{uri}.
+ETEXI
+
+    {
+        .name       = "migrate_pause",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Pause an ongoing migration (postcopy-only)",
+        .cmd        = hmp_migrate_pause,
+    },
+
+STEXI
+@item migrate_pause
+@findex migrate_pause
+Pause an ongoing migration.  Currently it only supports postcopy.
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index 2a36c1cf8d..ef93f4878b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1527,6 +1527,15 @@ void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+void hmp_migrate_pause(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    qmp_migrate_pause(&err);
+
+    hmp_handle_error(mon, &err);
+}
+
 /* Kept for backwards compatibility */
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict)
 {
diff --git a/hmp.h b/hmp.h
index b6b56c8161..20f27439d3 100644
--- a/hmp.h
+++ b/hmp.h
@@ -69,6 +69,7 @@ void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
 void hmp_migrate_recover(Monitor *mon, const QDict *qdict);
+void hmp_migrate_pause(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_speed(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict);
-- 
2.17.0
