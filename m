Received: from eggs.gnu.org ([2001:4830:134:3::10]:37535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjVy-0007TX-G6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjVt-0005yD-I6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:33:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ejjVt-0005wH-AS
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:33:09 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu,  8 Feb 2018 18:31:32 +0800
Message-Id: <20180208103132.28452-29-peterx@redhat.com>
In-Reply-To: <20180208103132.28452-1-peterx@redhat.com>
References: <20180208103132.28452-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 28/28] migration/hmp: add migrate_pause
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Wrapper for QMP command "migrate-pause".

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp-commands.hx | 14 ++++++++++++++
 hmp.c           |  9 +++++++++
 hmp.h           |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7563f3eaa0..32549702ee 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -969,6 +969,20 @@ STEXI
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
index 4062d3fdba..ae6266cb21 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1529,6 +1529,15 @@ void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
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
index 0d53fe78d9..0aa8dca738 100644
--- a/hmp.h
+++ b/hmp.h
@@ -71,6 +71,7 @@ void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
 void hmp_migrate_recover(Monitor *mon, const QDict *qdict);
+void hmp_migrate_pause(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_speed(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict);
-- 
2.14.3
