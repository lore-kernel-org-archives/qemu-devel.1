Received: from eggs.gnu.org ([2001:4830:134:3::10]:39539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMVVC-0004jg-7h
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMVV8-0004RB-07
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:00:58 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2345 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gMVV7-0004IA-1s
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:00:53 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Tue, 13 Nov 2018 10:00:25 +0000
Message-ID: <A02D6AA901860840B46E751C5E9E38B43CC96FCA@DGGEML532-MBX.china.huawei.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 3/3] fsdev-throttle-qmp: hmp interface for
 fsdev io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "berto@igalia.com" <berto@igalia.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>, Greg
	Kurz <groug@kaod.org>

introduces io throttling hmp interfaces for the fsdev devices

Signed-off-by: x00390961 <xiezhide@huawei.com>
---
 hmp-commands-info.hx | 15 ++++++++++
 hmp-commands.hx      | 15 ++++++++++
 hmp.c                | 83 +++++++++++++++++++++++++++++++++++++++++++++++-=
----
 hmp.h                |  4 +++
 4 files changed, 109 insertions(+), 8 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cbee8b9..eaf0ff5 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -100,6 +100,21 @@ STEXI
 Show progress of ongoing block device operations.
 ETEXI

+#if defined(CONFIG_VIRTFS)
+     {
+        .name       =3D "fsdev_iothrottle",
+        .args_type  =3D "",
+        .params     =3D "",
+        .help       =3D "show fsdev iothrottle information",
+        .cmd        =3D hmp_info_fsdev_iothrottle,
+    },
+#endif
+STEXI
+@item info fsdev_iothrottle
+@findex fsdev_iothrottle
+Show fsdev device throttle info.
+ETEXI
+
     {
         .name       =3D "registers",
         .args_type  =3D "cpustate_all:-a",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index db0c681..40ca7fe 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1716,6 +1716,21 @@ Change I/O throttle limits for a block drive to @var=
{bps} @var{bps_rd} @var{bps_
 @var{device} can be a block device name, a qdev ID or a QOM path.
 ETEXI

+#if defined(CONFIG_VIRTFS)
+     {
+        .name       =3D "fsdev_set_io_throttle",
+        .args_type  =3D "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l=
,iops_wr:l",
+        .params     =3D "device bps bps_rd bps_wr iops iops_rd iops_wr",
+        .help       =3D "change I/O throttle limits for a fs devices",
+        .cmd        =3D hmp_fsdev_set_io_throttle,
+    },
+#endif
+STEXI
+@item fsdev_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_w=
r} @var{iops} @var{iops_rd} @var{iops_wr}
+@findex fsdev_set_io_throttle
+Change I/O throttle limits for a fs devices to @var{bps} @var{bps_rd} @var=
{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+ETEXI
+
     {
         .name       =3D "set_password",
         .args_type  =3D "protocol:s,password:s,connected:s?",
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
+    iot->bps =3D qdict_get_int(qdict, "bps");
+    iot->bps_rd =3D qdict_get_int(qdict, "bps_rd");
+    iot->bps_wr =3D qdict_get_int(qdict, "bps_wr");
+    iot->iops =3D qdict_get_int(qdict, "iops");
+    iot->iops_rd =3D qdict_get_int(qdict, "iops_rd");
+    iot->iops_wr =3D qdict_get_int(qdict, "iops_wr");
+}
+
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err =3D NULL;
+    ThrottleLimits *tlimits;
     char *device =3D (char *) qdict_get_str(qdict, "device");
-    BlockIOThrottle throttle =3D {
-        .bps =3D qdict_get_int(qdict, "bps"),
-        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
-        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
-        .iops =3D qdict_get_int(qdict, "iops"),
-        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
-        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
-    };
+    BlockIOThrottle throttle =3D {0};

     /* qmp_block_set_io_throttle has separate parameters for the
      * (deprecated) block device name and the qdev ID but the HMP
@@ -1910,10 +1916,71 @@ void hmp_block_set_io_throttle(Monitor *mon, const =
QDict *qdict)
         throttle.id =3D device;
     }

+    tlimits =3D qapi_BlockIOThrottle_base(&throttle);
+    hmp_initialize_throttle_limits(tlimits, qdict);
     qmp_block_set_io_throttle(&throttle, &err);
     hmp_handle_error(mon, &err);
 }

+#ifdef CONFIG_VIRTFS
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    ThrottleLimits *tlimits;
+    FsdevIOThrottle throttle =3D {
+        .has_id =3D true,
+        .id =3D (char *) qdict_get_str(qdict, "device"),
+    };
+
+    tlimits =3D qapi_FsdevIOThrottle_base(&throttle);
+    hmp_initialize_throttle_limits(tlimits, qdict);
+    qmp_fsdev_set_io_throttle(&throttle, &err);
+    hmp_handle_error(mon, &err);
+}
+
+static void print_fsdev_throttle_config(Monitor *mon, FsdevIOThrottle *fsc=
fg)
+{
+    monitor_printf(mon, "%s", fscfg->id);
+    monitor_printf(mon, "    I/O throttling:"
+                   " bps=3D%" PRId64
+                   " bps_rd=3D%" PRId64  " bps_wr=3D%" PRId64
+                   " bps_max=3D%" PRId64
+                   " bps_rd_max=3D%" PRId64
+                   " bps_wr_max=3D%" PRId64
+                   " iops=3D%" PRId64 " iops_rd=3D%" PRId64
+                   " iops_wr=3D%" PRId64
+                   " iops_max=3D%" PRId64
+                   " iops_rd_max=3D%" PRId64
+                   " iops_wr_max=3D%" PRId64
+                   " iops_size=3D%" PRId64
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
+    fsdev_list =3D qmp_query_fsdev_io_throttle(NULL);
+
+    for (info =3D fsdev_list; info; info =3D info->next) {
+        print_fsdev_throttle_config(mon, info->value);
+    }
+    qapi_free_FsdevIOThrottleList(fsdev_list);
+}
+#endif
+
 void hmp_block_stream(Monitor *mon, const QDict *qdict)
 {
     Error *error =3D NULL;
diff --git a/hmp.h b/hmp.h
index 5f1addc..9330e11 100644
--- a/hmp.h
+++ b/hmp.h
@@ -91,6 +91,10 @@ void hmp_block_job_cancel(Monitor *mon, const QDict *qdi=
ct);
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
--
1.8.3.1
