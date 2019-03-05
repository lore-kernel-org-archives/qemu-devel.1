Received: from eggs.gnu.org ([209.51.188.92]:43541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14GL-0003Dr-H8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14GE-0000qC-Fl
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:13:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h14GD-0000ne-SZ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:13:10 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Mar 2019 15:12:19 +0800
Message-Id: <1551769940-22739-13-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
References: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 12/13] hmp: Add hmp_announce_self
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add an HMP command to trigger self annocements.
Unlike the QMP command (which takes a set of parameters), the HMP
command reuses the set of parameters used for migration.

Signend-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hmp-commands.hx  | 16 ++++++++++++++++
 hmp.c            |  5 +++++
 hmp.h            |  1 +
 tests/test-hmp.c |  1 +
 4 files changed, 23 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index e5fbc2c..9b40359 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -939,6 +939,22 @@ stops because the size limit is reached.
 ETEXI
 
     {
+        .name       = "announce_self",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Trigger GARP/RARP announcements",
+        .cmd        = hmp_announce_self,
+    },
+
+STEXI
+@item announce_self
+@findex announce_self
+Trigger a round of GARP/RARP broadcasts; this is useful for explicitly updating the
+network infrastructure after a reconfiguration or some forms of migration.
+The timings of the round are set by the migration announce parameters.
+ETEXI
+
+    {
         .name       = "migrate",
         .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
         .params     = "[-d] [-b] [-i] [-r] uri",
diff --git a/hmp.c b/hmp.c
index f3db0bf..5f13b16 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1570,6 +1570,11 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
 
 }
 
+void hmp_announce_self(Monitor *mon, const QDict *qdict)
+{
+    qmp_announce_self(migrate_announce_params(), NULL);
+}
+
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
 {
     qmp_migrate_cancel(NULL);
diff --git a/hmp.h b/hmp.h
index 5f1addc..e0f32f0 100644
--- a/hmp.h
+++ b/hmp.h
@@ -46,6 +46,7 @@ void hmp_sync_profile(Monitor *mon, const QDict *qdict);
 void hmp_system_reset(Monitor *mon, const QDict *qdict);
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
 void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
+void hmp_announce_self(Monitor *mon, const QDict *qdict);
 void hmp_cpu(Monitor *mon, const QDict *qdict);
 void hmp_memsave(Monitor *mon, const QDict *qdict);
 void hmp_pmemsave(Monitor *mon, const QDict *qdict);
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 1a3a9c5..8c49d2f 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -20,6 +20,7 @@
 static int verbose;
 
 static const char *hmp_cmds[] = {
+    "announce_self",
     "boot_set ndc",
     "chardev-add null,id=testchardev1",
     "chardev-send-break testchardev1",
-- 
2.5.0
