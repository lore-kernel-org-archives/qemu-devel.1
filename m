Received: from eggs.gnu.org ([2001:4830:134:3::10]:45246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euE8v-0004MD-So
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euE8u-0006O9-DM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:16:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euE8u-0006N1-9o
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:16:48 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 17:15:33 +0800
Message-Id: <20180309091535.13315-22-peterx@redhat.com>
In-Reply-To: <20180309091535.13315-1-peterx@redhat.com>
References: <20180309091535.13315-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 21/23] hmp/migration: add migrate_recover
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Sister command to migrate-recover in QMP.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp-commands.hx | 13 +++++++++++++
 hmp.c           | 10 ++++++++++
 hmp.h           |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index defba474d6..6758c1f6ed 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -955,7 +955,20 @@ STEXI
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
index 4ac4fbcb74..0e189e157b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1502,6 +1502,16 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
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
index b89733876d..5cf02a169a 100644
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
2.14.3
