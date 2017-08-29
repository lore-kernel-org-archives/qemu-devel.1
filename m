Received: from eggs.gnu.org ([2001:4830:134:3::10]:47291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC5-0000qE-0B
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC1-00053G-Aq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33132
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUC1-00052v-6A
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8D3017766
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:44 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2wv93-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:44 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:15:44 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:47 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-13-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 12/79] replication: Make --disable-replication
 compile again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Broken in commit daa33c5.

Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-id: 1493298053-17140-1-git-send-email-armbru@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 38bb54f323bf7c83496b6a044cfd28896e997a00)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 migration/colo.c | 12 ++++++++++++
 monitor.c        |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index c19eb3f..963c802 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -153,6 +153,7 @@ void qmp_xen_set_replication(bool enable, bool primary,
                              bool has_failover, bool failover,
                              Error **errp)
 {
+#ifdef CONFIG_REPLICATION
     ReplicationMode mode = primary ?
                            REPLICATION_MODE_PRIMARY :
                            REPLICATION_MODE_SECONDARY;
@@ -171,10 +172,14 @@ void qmp_xen_set_replication(bool enable, bool primary,
         }
         replication_stop_all(failover, failover ? NULL : errp);
     }
+#else
+    abort();
+#endif
 }
 
 ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
 {
+#ifdef CONFIG_REPLICATION
     Error *err = NULL;
     ReplicationStatus *s = g_new0(ReplicationStatus, 1);
 
@@ -189,11 +194,18 @@ ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
 
     error_free(err);
     return s;
+#else
+    abort();
+#endif
 }
 
 void qmp_xen_colo_do_checkpoint(Error **errp)
 {
+#ifdef CONFIG_REPLICATION
     replication_do_checkpoint_all(errp);
+#else
+    abort();
+#endif
 }
 
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
diff --git a/monitor.c b/monitor.c
index be282ec..2799a37 100644
--- a/monitor.c
+++ b/monitor.c
@@ -974,6 +974,11 @@ static void qmp_unregister_commands_hack(void)
 #ifndef CONFIG_SPICE
     qmp_unregister_command(&qmp_commands, "query-spice");
 #endif
+#ifndef CONFIG_REPLICATION
+    qmp_unregister_command(&qmp_commands, "xen-set-replication");
+    qmp_unregister_command(&qmp_commands, "query-xen-replication-status");
+    qmp_unregister_command(&qmp_commands, "xen-colo-do-checkpoint");
+#endif
 #ifndef TARGET_I386
     qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
 #endif
-- 
2.7.4
