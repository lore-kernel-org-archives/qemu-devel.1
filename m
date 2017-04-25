Received: from eggs.gnu.org ([2001:4830:134:3::10]:47685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xeW-00045Q-G0
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xeU-00034i-BD
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:25:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2xeU-00034T-4Y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:24:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2813D3DE3E
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:24:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 25 Apr 2017 12:24:43 +0200
Message-Id: <20170425102446.4008-4-quintela@redhat.com>
In-Reply-To: <20170425102446.4008-1-quintela@redhat.com>
References: <20170425102446.4008-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] monitor: Move hmp_savevm from savevm.c to
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

It is a monitor command, and has nothing migration specific in it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                   | 5 +++++
 hmp.h                   | 1 +
 include/sysemu/sysemu.h | 1 -
 migration/savevm.c      | 5 -----
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hmp.c b/hmp.c
index f6b8738..a82a952 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1281,6 +1281,11 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
     }
 }
 
+void hmp_savevm(Monitor *mon, const QDict *qdict)
+{
+    save_vmstate(qdict_get_try_str(qdict, "name"));
+}
+
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
 {
     qmp_migrate_cancel(NULL);
diff --git a/hmp.h b/hmp.h
index 385332c..b302c8d 100644
--- a/hmp.h
+++ b/hmp.h
@@ -64,6 +64,7 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict);
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
 void hmp_drive_backup(Monitor *mon, const QDict *qdict);
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
+void hmp_savevm(Monitor *mon, const QDict *qdict);
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index b6daf9d..914c36c 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -75,7 +75,6 @@ void qemu_remove_exit_notifier(Notifier *notify);
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
-void hmp_savevm(Monitor *mon, const QDict *qdict);
 int save_vmstate(const char *name);
 int load_vmstate(const char *name);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
diff --git a/migration/savevm.c b/migration/savevm.c
index ff934aa..bbff4d8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2171,11 +2171,6 @@ int save_vmstate(const char *name)
     return ret;
 }
 
-void hmp_savevm(Monitor *mon, const QDict *qdict)
-{
-    save_vmstate(qdict_get_try_str(qdict, "name"));
-}
-
 void qmp_xen_save_devices_state(const char *filename, Error **errp)
 {
     QEMUFile *f;
-- 
2.9.3
