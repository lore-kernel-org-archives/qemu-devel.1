Received: from eggs.gnu.org ([2001:4830:134:3::10]:51777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM787-0000o6-0D
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM786-00045K-7J
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:54:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eM786-000452-0j
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:54:58 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Dec 2017 14:53:07 +0800
Message-Id: <20171205065307.21853-29-peterx@redhat.com>
In-Reply-To: <20171205065307.21853-1-peterx@redhat.com>
References: <20171205065307.21853-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 28/28] hmp/migration: add migrate_recover
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp-commands.hx | 13 +++++++++++++
 hmp.c           | 10 ++++++++++
 hmp.h           |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 32fdd52212..79e28c5228 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -992,7 +992,20 @@ STEXI
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
index c7e1022283..4e2a88bbc2 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1519,6 +1519,16 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
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
index a6f56b1f29..81c6837550 100644
--- a/hmp.h
+++ b/hmp.h
@@ -70,6 +70,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
+void hmp_migrate_recover(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_speed(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict);
-- 
2.14.3
