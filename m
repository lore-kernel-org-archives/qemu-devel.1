Received: from eggs.gnu.org ([2001:4830:134:3::10]:52197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dsRZi-0006q1-19
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dsRZg-000212-Pb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:50 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dsRZg-0001zr-F0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:48 -0400
Received: by mail-wm0-x242.google.com with SMTP id 187so2884675wmn.0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 03:40:48 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 14 Sep 2017 06:40:10 -0400
Message-Id: <1505385610-35529-7-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v11 6/6] fsdev: hmp interface for throttling
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands-info.hx | 18 ++++++++++++++++
 hmp-commands.hx      | 19 +++++++++++++++++
 hmp.c                | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hmp.h                |  4 ++++
 4 files changed, 100 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 4ab7fce..54f1968 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -84,6 +84,24 @@ STEXI
 Show block device statistics.
 ETEXI
 
+#if defined(CONFIG_VIRTFS)
+
+    {
+        .name       = "fsdev_iothrottle",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show fsdev iothrottle information",
+        .cmd        = hmp_info_fsdev_iothrottle,
+    },
+
+#endif
+
+STEXI
+@item info fsdev_iothrottle
+@findex fsdev_iothrottle
+Show fsdev device throttle info.
+ETEXI
+
     {
         .name       = "block-jobs",
         .args_type  = "",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19..aef9f79 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1680,6 +1680,25 @@ STEXI
 Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
 ETEXI
 
+#if defined(CONFIG_VIRTFS)
+
+    {
+        .name       = "fsdev_set_io_throttle",
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
index acaf0e6..ceec6c9 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1778,6 +1778,65 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+#ifdef CONFIG_VIRTFS
+
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    ThrottleLimits throttle = {
+        .has_id = true,
+        .id = (char *) qdict_get_str(qdict, "device"),
+    };
+
+    hmp_initialize_throttle_limits(&throttle, qdict);
+    qmp_fsdev_set_io_throttle(&throttle, &err);
+    hmp_handle_error(mon, &err);
+}
+
+static void print_fsdev_throttle_config(Monitor *mon, ThrottleLimits *fscfg)
+{
+    monitor_printf(mon, "%s", fscfg->id);
+    monitor_printf(mon, "    I/O throttling:"
+                   " bps=%" PRId64
+                   " bps_rd=%" PRId64  " bps_wr=%" PRId64
+                   " bps_max=%" PRId64
+                   " bps_rd_max=%" PRId64
+                   " bps_wr_max=%" PRId64
+                   " iops=%" PRId64 " iops_rd=%" PRId64
+                   " iops_wr=%" PRId64
+                   " iops_max=%" PRId64
+                   " iops_rd_max=%" PRId64
+                   " iops_wr_max=%" PRId64
+                   " iops_size=%" PRId64
+                   "\n",
+                   fscfg->bps_total,
+                   fscfg->bps_read,
+                   fscfg->bps_write,
+                   fscfg->bps_total_max,
+                   fscfg->bps_read_max,
+                   fscfg->bps_write_max,
+                   fscfg->iops_total,
+                   fscfg->iops_read,
+                   fscfg->iops_write,
+                   fscfg->iops_total_max,
+                   fscfg->iops_read_max,
+                   fscfg->iops_write_max,
+                   fscfg->iops_size);
+}
+
+void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict)
+{
+    ThrottleLimitsList *fsdev_list, *info;
+    fsdev_list = qmp_query_fsdev_io_throttle(NULL);
+
+    for (info = fsdev_list; info; info = info->next) {
+        print_fsdev_throttle_config(mon, info->value);
+    }
+    qapi_free_ThrottleLimitsList(fsdev_list);
+}
+
+#endif
+
 void hmp_block_stream(Monitor *mon, const QDict *qdict)
 {
     Error *error = NULL;
diff --git a/hmp.h b/hmp.h
index 1ff4552..d700d7d 100644
--- a/hmp.h
+++ b/hmp.h
@@ -81,6 +81,10 @@ void hmp_set_password(Monitor *mon, const QDict *qdict);
 void hmp_expire_password(Monitor *mon, const QDict *qdict);
 void hmp_eject(Monitor *mon, const QDict *qdict);
 void hmp_change(Monitor *mon, const QDict *qdict);
+#ifdef CONFIG_VIRTFS
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict);
+void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict);
+#endif
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
 void hmp_block_stream(Monitor *mon, const QDict *qdict);
 void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict);
-- 
1.8.3.1
