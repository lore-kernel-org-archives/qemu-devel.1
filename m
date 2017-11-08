Received: from eggs.gnu.org ([2001:4830:134:3::10]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJSl-0000vW-Rx
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJSg-0007GO-WC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJSg-0007GC-Qj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:42 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:30 +0800
Message-Id: <20171108060130.3772-33-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 32/32] migration,
 hmp: new command "migrate_pause"
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

HMP version of QMP "migrate-pause".

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp-commands.hx | 14 ++++++++++++++
 hmp.c           |  9 +++++++++
 hmp.h           |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index ffcdc34652..0c9f0cc4f2 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -992,6 +992,20 @@ as the -incoming option).
 ETEXI
 
     {
+        .name       = "migrate_pause",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Pause a migration stream (only supported by postcopy)",
+        .cmd        = hmp_migrate_pause,
+    },
+
+STEXI
+@item migrate_pause
+@findex migrate_pause
+Pause an existing migration manually.  Currently it only support postcopy.
+ETEXI
+
+    {
         .name       = "migrate_set_cache_size",
         .args_type  = "value:o",
         .params     = "value",
diff --git a/hmp.c b/hmp.c
index c7e1022283..c1abba037f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1519,6 +1519,15 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
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
index a6f56b1f29..87d7c117eb 100644
--- a/hmp.h
+++ b/hmp.h
@@ -70,6 +70,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
+void hmp_migrate_pause(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_speed(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict);
-- 
2.13.6
