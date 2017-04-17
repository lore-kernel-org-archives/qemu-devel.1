Received: from eggs.gnu.org ([2001:4830:134:3::10]:52413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpl-0006JK-FK
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpk-0004bO-IV
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Cpk-0004aC-D7
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49B4964361
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:01:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:40 +0200
Message-Id: <20170417200041.2451-19-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 18/19] monitor: move hmp_savevm() to monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

hmp_loadvm is already there, so be consistent.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/sysemu/sysemu.h | 1 -
 migration/savevm.c      | 5 -----
 monitor.c               | 5 +++++
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 5f2f21d..146a0dc 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -75,7 +75,6 @@ void qemu_remove_exit_notifier(Notifier *notify);
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
-void hmp_savevm(Monitor *mon, const QDict *qdict);
 int save_vmstate(Monitor *mon, const char *name);
 int load_vmstate(const char *name);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
diff --git a/migration/savevm.c b/migration/savevm.c
index f628d01..cbd7e0d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2156,11 +2156,6 @@ int save_vmstate(Monitor *mon, const char *name)
     return ret;
 }
 
-void hmp_savevm(Monitor *mon, const QDict *qdict)
-{
-    save_vmstate(mon, qdict_get_try_str(qdict, "name"));
-}
-
 void qmp_xen_save_devices_state(const char *filename, Error **errp)
 {
     QEMUFile *f;
diff --git a/monitor.c b/monitor.c
index ceb0489..2fca4fb 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1854,6 +1854,11 @@ static void hmp_loadvm(Monitor *mon, const QDict *qdict)
     }
 }
 
+static void hmp_savevm(Monitor *mon, const QDict *qdict)
+{
+    save_vmstate(mon, qdict_get_try_str(qdict, "name"));
+}
+
 int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
-- 
2.9.3
