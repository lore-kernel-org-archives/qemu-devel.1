Received: from eggs.gnu.org ([2001:4830:134:3::10]:35249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpK5-0007JU-3h
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpK4-0003H8-7J
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpK4-0003Gp-1D
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:20 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:40 +0800
Message-Id: <20180502104740.12123-25-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 24/24] migration/hmp: add migrate_pause
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

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp.h           |  1 +
 hmp.c           |  9 +++++++++
 hmp-commands.hx | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

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
diff --git a/hmp.c b/hmp.c
index 4ac2126969..35a23d8cb8 100644
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
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 8facba7b4d..579d501bd4 100644
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
-- 
2.14.3
