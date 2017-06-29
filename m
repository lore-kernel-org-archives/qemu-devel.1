Received: from eggs.gnu.org ([2001:4830:134:3::10]:32906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dQb6V-0008Um-Ry
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dQb6U-00032L-Np
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:11:35 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dQb6U-00031x-Dw
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:11:34 -0400
Received: by mail-wr0-x243.google.com with SMTP id z45so37152726wrb.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 08:11:34 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 29 Jun 2017 11:10:55 -0400
Message-Id: <1498749056-38565-6-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1498749056-38565-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1498749056-38565-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v6 5/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This patch introduces hmp interfaces for the fsdev
devices.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 hmp-commands-info.hx | 18 ++++++++++++++
 hmp-commands.hx      | 19 +++++++++++++++
 hmp.c                | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hmp.h                |  4 ++++
 4 files changed, 107 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ae16901..f23b627 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -84,6 +84,24 @@ STEXI
 Show block device statistics.
 ETEXI
 
+#if defined(CONFIG_VIRTFS)
+
+    {
+        .name       = "query-fsdev-iothrottle",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show fsdev device throttle information",
+        .cmd        = hmp_fsdev_get_io_throttle,
+    },
+
+#endif
+
+STEXI
+@item info fsdev throttle
+@findex fsdevthrottleinfo
+Show fsdev device throttleinfo.
+ETEXI
+
     {
         .name       = "block-jobs",
         .args_type  = "",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index e763606..c60fd7e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1662,6 +1662,25 @@ STEXI
 Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
 ETEXI
 
+#if defined(CONFIG_VIRTFS)
+
+    {
+        .name       = "fsdev-set-io-throttle",
+        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
+        .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
+        .help       = "change I/O throttle limits for a fs devices",
+        .cmd        = hmp_fsdev_set_io_throttle,
+    },
+
+#endif
+
+STEXI
+@item fsdev_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+@findex fsdev_set_io_throttle
+Change I/O throttle limits for a fs devices to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+ETEXI
+
+
     {
         .name       = "set_password",
         .args_type  = "protocol:s,password:s,connected:s?",
diff --git a/hmp.c b/hmp.c
index 220d301..b1c698b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1776,6 +1776,72 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+#ifdef CONFIG_VIRTFS
+
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    IOThrottle throttle;
+
+    hmp_initialize_io_throttle(&throttle, qdict);
+    qmp_fsdev_set_io_throttle(&throttle, &err);
+    hmp_handle_error(mon, &err);
+}
+
+static void print_fsdev_throttle_config(Monitor *mon, IOThrottle *fscfg,
+                                       Error *err)
+{
+    if (fscfg->bps  || fscfg->bps_rd  || fscfg->bps_wr  ||
+        fscfg->iops || fscfg->iops_rd || fscfg->iops_wr)
+    {
+        monitor_printf(mon, "%s", fscfg->id);
+        monitor_printf(mon, "    I/O throttling:"
+                        " bps=%" PRId64
+                        " bps_rd=%" PRId64  " bps_wr=%" PRId64
+                        " bps_max=%" PRId64
+                        " bps_rd_max=%" PRId64
+                        " bps_wr_max=%" PRId64
+                        " iops=%" PRId64 " iops_rd=%" PRId64
+                        " iops_wr=%" PRId64
+                        " iops_max=%" PRId64
+                        " iops_rd_max=%" PRId64
+                        " iops_wr_max=%" PRId64
+                        " iops_size=%" PRId64,
+                        fscfg->bps,
+                        fscfg->bps_rd,
+                        fscfg->bps_wr,
+                        fscfg->bps_max,
+                        fscfg->bps_rd_max,
+                        fscfg->bps_wr_max,
+                        fscfg->iops,
+                        fscfg->iops_rd,
+                        fscfg->iops_wr,
+                        fscfg->iops_max,
+                        fscfg->iops_rd_max,
+                        fscfg->iops_wr_max,
+                        fscfg->iops_size);
+   }
+   hmp_handle_error(mon, &err);
+}
+
+void hmp_fsdev_get_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    IOThrottleList *fs9p_list, *info;
+    fs9p_list = qmp_query_fsdev_io_throttle(&err);
+
+    for (info = fs9p_list; info; info = info->next) {
+        if (info != fs9p_list) {
+            monitor_printf(mon, "\n");
+        }
+        print_fsdev_throttle_config(mon, info->value, err);
+        qapi_free_IOThrottle(info->value);
+    }
+    qapi_free_IOThrottleList(fs9p_list);
+}
+
+#endif
+
 void hmp_block_stream(Monitor *mon, const QDict *qdict)
 {
     Error *error = NULL;
diff --git a/hmp.h b/hmp.h
index d8b94ce..05e72f2 100644
--- a/hmp.h
+++ b/hmp.h
@@ -81,6 +81,10 @@ void hmp_set_password(Monitor *mon, const QDict *qdict);
 void hmp_expire_password(Monitor *mon, const QDict *qdict);
 void hmp_eject(Monitor *mon, const QDict *qdict);
 void hmp_change(Monitor *mon, const QDict *qdict);
+#ifdef CONFIG_VIRTFS
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict);
+void hmp_fsdev_get_io_throttle(Monitor *mon, const QDict *qdict);
+#endif
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
 void hmp_block_stream(Monitor *mon, const QDict *qdict);
 void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict);
-- 
1.8.3.1
