Received: from eggs.gnu.org ([2001:4830:134:3::10]:39199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMrZK-0007bS-99
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMrZG-0003uO-CP
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:34:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50944 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gMrZF-0003qr-Ai
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:34:38 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Wed, 14 Nov 2018 17:28:46 +0800
Message-ID: <f1dab1731a9d219e5ba0d7846b72ef8f8607f965.1542187291.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542187291.git.xiezhide@huawei.com>
References: <cover.1542187291.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/4] fsdev-throttle-qmp: hmp interface for
 fsdev io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, eblake@redhat.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

introduces io throttling hmp interfaces for the fsdev devices

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 hmp-commands-info.hx | 15 ++++++++++
 hmp-commands.hx      | 15 ++++++++++
 hmp.c                | 83 +++++++++++++++++++++++++++++++++++++++++++++++-----
 hmp.h                |  4 +++
 qapi/tlimits.json    |  2 +-
 5 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cbee8b9..eaf0ff5 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -100,6 +100,21 @@ STEXI
 Show progress of ongoing block device operations.
 ETEXI
 
+#if defined(CONFIG_VIRTFS)
+     {
+        .name       = "fsdev_iothrottle",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show fsdev iothrottle information",
+        .cmd        = hmp_info_fsdev_iothrottle,
+    },
+#endif
+STEXI
+@item info fsdev_iothrottle
+@findex fsdev_iothrottle
+Show fsdev device throttle info.
+ETEXI
+
     {
         .name       = "registers",
         .args_type  = "cpustate_all:-a",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index db0c681..40ca7fe 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1716,6 +1716,21 @@ Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_
 @var{device} can be a block device name, a qdev ID or a QOM path.
 ETEXI
 
+#if defined(CONFIG_VIRTFS)
+     {
+        .name       = "fsdev_set_io_throttle",
+        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
+        .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
+        .help       = "change I/O throttle limits for a fs devices",
+        .cmd        = hmp_fsdev_set_io_throttle,
+    },
+#endif
+STEXI
+@item fsdev_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+@findex fsdev_set_io_throttle
+Change I/O throttle limits for a fs devices to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+ETEXI
+
     {
         .name       = "set_password",
         .args_type  = "protocol:s,password:s,connected:s?",
diff --git a/hmp.c b/hmp.c
index 7828f93..4cc4146 100644
--- a/hmp.c
+++ b/hmp.c
@@ -38,6 +38,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-tpm.h"
 #include "qapi/qapi-commands-ui.h"
+#include "qapi/qapi-commands-fsdev.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
@@ -1886,18 +1887,23 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+static void hmp_initialize_throttle_limits(ThrottleLimits *iot,
+                                           const QDict *qdict)
+{
+    iot->bps = qdict_get_int(qdict, "bps");
+    iot->bps_rd = qdict_get_int(qdict, "bps_rd");
+    iot->bps_wr = qdict_get_int(qdict, "bps_wr");
+    iot->iops = qdict_get_int(qdict, "iops");
+    iot->iops_rd = qdict_get_int(qdict, "iops_rd");
+    iot->iops_wr = qdict_get_int(qdict, "iops_wr");
+}
+
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
+    ThrottleLimits *tlimits;
     char *device = (char *) qdict_get_str(qdict, "device");
-    BlockIOThrottle throttle = {
-        .bps = qdict_get_int(qdict, "bps"),
-        .bps_rd = qdict_get_int(qdict, "bps_rd"),
-        .bps_wr = qdict_get_int(qdict, "bps_wr"),
-        .iops = qdict_get_int(qdict, "iops"),
-        .iops_rd = qdict_get_int(qdict, "iops_rd"),
-        .iops_wr = qdict_get_int(qdict, "iops_wr"),
-    };
+    BlockIOThrottle throttle = {0};
 
     /* qmp_block_set_io_throttle has separate parameters for the
      * (deprecated) block device name and the qdev ID but the HMP
@@ -1910,10 +1916,71 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
         throttle.id = device;
     }
 
+    tlimits = qapi_BlockIOThrottle_base(&throttle);
+    hmp_initialize_throttle_limits(tlimits, qdict);
     qmp_block_set_io_throttle(&throttle, &err);
     hmp_handle_error(mon, &err);
 }
 
+#ifdef CONFIG_VIRTFS
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    ThrottleLimits *tlimits;
+    FsdevIOThrottle throttle = {
+        .has_id = true,
+        .id = (char *) qdict_get_str(qdict, "device"),
+    };
+
+    tlimits = qapi_FsdevIOThrottle_base(&throttle);
+    hmp_initialize_throttle_limits(tlimits, qdict);
+    qmp_fsdev_set_io_throttle(&throttle, &err);
+    hmp_handle_error(mon, &err);
+}
+
+static void print_fsdev_throttle_config(Monitor *mon, FsdevIOThrottle *fscfg)
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
+                   fscfg->bps,
+                   fscfg->bps_rd,
+                   fscfg->bps_wr,
+                   fscfg->bps_max,
+                   fscfg->bps_rd_max,
+                   fscfg->bps_wr_max,
+                   fscfg->iops,
+                   fscfg->iops_rd,
+                   fscfg->iops_wr,
+                   fscfg->iops_max,
+                   fscfg->iops_rd_max,
+                   fscfg->iops_wr_max,
+                   fscfg->iops_size);
+}
+
+void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict)
+{
+    FsdevIOThrottleList *fsdev_list, *info;
+    fsdev_list = qmp_query_fsdev_io_throttle(NULL);
+
+    for (info = fsdev_list; info; info = info->next) {
+        print_fsdev_throttle_config(mon, info->value);
+    }
+    qapi_free_FsdevIOThrottleList(fsdev_list);
+}
+#endif
+
 void hmp_block_stream(Monitor *mon, const QDict *qdict)
 {
     Error *error = NULL;
diff --git a/hmp.h b/hmp.h
index 5f1addc..9330e11 100644
--- a/hmp.h
+++ b/hmp.h
@@ -91,6 +91,10 @@ void hmp_block_job_cancel(Monitor *mon, const QDict *qdict);
 void hmp_block_job_pause(Monitor *mon, const QDict *qdict);
 void hmp_block_job_resume(Monitor *mon, const QDict *qdict);
 void hmp_block_job_complete(Monitor *mon, const QDict *qdict);
+#ifdef CONFIG_VIRTFS
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict);
+void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict);
+#endif
 void hmp_migrate(Monitor *mon, const QDict *qdict);
 void hmp_device_add(Monitor *mon, const QDict *qdict);
 void hmp_device_del(Monitor *mon, const QDict *qdict);
diff --git a/qapi/tlimits.json b/qapi/tlimits.json
index 6bcbaf6..76b13c5 100644
--- a/qapi/tlimits.json
+++ b/qapi/tlimits.json
@@ -74,7 +74,7 @@
 #
 # @iops_size: an I/O size in bytes (Since 1.7)
 #
-# Since: 4.0
+# Since: 2.11
 #
 ##
 { 'struct': 'ThrottleLimits',
-- 
2.7.4
