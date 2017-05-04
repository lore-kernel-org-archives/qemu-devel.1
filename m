Received: from eggs.gnu.org ([2001:4830:134:3::10]:45324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DG3-0008I8-N2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DG2-0000i7-U5
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6DG2-0000hE-LI
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 979BFBDD4
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 09:41:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  4 May 2017 11:40:50 +0200
Message-Id: <20170504094053.2329-8-quintela@redhat.com>
In-Reply-To: <20170504094053.2329-1-quintela@redhat.com>
References: <20170504094053.2329-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] monitor: Move hmp_delvm from savevm.c to
 hmp.c
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

It really uses block/* stuff, not migration one.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c                   | 13 +++++++++++++
 hmp.h                   |  1 +
 include/sysemu/sysemu.h |  1 -
 migration/savevm.c      | 13 -------------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hmp.c b/hmp.c
index a82a952..bb739ce 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1286,6 +1286,19 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
     save_vmstate(qdict_get_try_str(qdict, "name"));
 }
 
+void hmp_delvm(Monitor *mon, const QDict *qdict)
+{
+    BlockDriverState *bs;
+    Error *err;
+    const char *name = qdict_get_str(qdict, "name");
+
+    if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
+        error_reportf_err(err,
+                          "Error while deleting snapshot on device '%s': ",
+                          bdrv_get_device_name(bs));
+    }
+}
+
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
 {
     qmp_migrate_cancel(NULL);
diff --git a/hmp.h b/hmp.h
index b302c8d..6a402b1 100644
--- a/hmp.h
+++ b/hmp.h
@@ -65,6 +65,7 @@ void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
 void hmp_drive_backup(Monitor *mon, const QDict *qdict);
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
 void hmp_savevm(Monitor *mon, const QDict *qdict);
+void hmp_delvm(Monitor *mon, const QDict *qdict);
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 914c36c..e4f355ceb 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -77,7 +77,6 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
 int save_vmstate(const char *name);
 int load_vmstate(const char *name);
-void hmp_delvm(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
 
 void qemu_announce_self(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 8345255..9e0bd9d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2304,19 +2304,6 @@ int load_vmstate(const char *name)
     return 0;
 }
 
-void hmp_delvm(Monitor *mon, const QDict *qdict)
-{
-    BlockDriverState *bs;
-    Error *err;
-    const char *name = qdict_get_str(qdict, "name");
-
-    if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
-        error_reportf_err(err,
-                          "Error while deleting snapshot on device '%s': ",
-                          bdrv_get_device_name(bs));
-    }
-}
-
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
 {
     BlockDriverState *bs, *bs1;
-- 
2.9.3
