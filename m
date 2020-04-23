Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA4C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548E32075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xonPnbJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548E32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTSf-0004ji-HC
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTH2-0001aZ-Jj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGw-0008QJ-Qt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTGw-0008Jm-4O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CVBN064314;
 Thu, 23 Apr 2020 04:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=QsaZ5aTtmV9PMzyZHx1/gu+3JGuwP5JfVPR57SCrq90=;
 b=xonPnbJAQA0oakKmNyVdQ8n3d3gSnDlVnG3kt8QoxcIr3t6932nIO9lNHODEmmutJmkQ
 aL8uWMYNosZe9bIz9lj0K3GiRad8P3AtohKig6MQU5w65FUbt7mEhMSxbT7kMbr71n8H
 BcLB4lksMM3O2np9MI2KWrMzfYdMEmFNO3qoda4i6xnQFIQ9ZooJ8vnbJp4SfC1y+8N4
 t6SwvdNFvHCf6wSyphyla04d7GPnDlyHQK6j3KWb6W7pWXbczffbbG49BDMiaCMruGXh
 DY/jT2yH6R52BWAzyGlyH8O7ivaTwRd5hI9I8eJsKSH1PLKMAZWZX+5GpnPvs2ah9Ks0 vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 30grpgtru6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DW31168898;
 Thu, 23 Apr 2020 04:15:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 30gb942hft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:26 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4FP3B018041;
 Thu, 23 Apr 2020 04:15:25 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:15:24 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 32/36] multi-process/mon: stub functions to enable
 QMP module for remote process
Date: Wed, 22 Apr 2020 21:14:07 -0700
Message-Id: <2683f2ca1ff09e6569641fc05b2551868a2e7d0f.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

QMP module doesn't need some functions to run independently on the
remote processes. However, these functions are necessary for
compilation. Therefore, these functions are stub'ed out. The
stub functions raise an assert if QEMU is built in debug mode
(--enable-debug).

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 MAINTAINERS            |   4 +
 accel/stubs/tcg-stub.c |  10 +++
 configure              |   4 +
 include/qemu-common.h  |   8 ++
 stubs/gdbstub.c        |  23 ++++++
 stubs/migration.c      | 162 +++++++++++++++++++++++++++++++++++++++++
 stubs/monitor.c        |  31 ++++++++
 stubs/net-stub.c       |  69 ++++++++++++++++++
 stubs/qapi-misc.c      |  41 +++++++++++
 stubs/qapi-target.c    |  56 ++++++++++++++
 stubs/ui-stub.c        | 130 +++++++++++++++++++++++++++++++++
 stubs/vl-stub.c        |  92 +++++++++++++++++++++++
 12 files changed, 630 insertions(+)
 create mode 100644 stubs/migration.c
 create mode 100644 stubs/qapi-misc.c
 create mode 100644 stubs/qapi-target.c
 create mode 100644 stubs/ui-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a4b5e16be..216291f545 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1996,6 +1996,8 @@ F: blockdev-hmp-cmds.c
 F: block/qapi.c
 F: qapi/block*.json
 F: qapi/transaction.json
+F: stubs/qapi-misc.c
+F: stubs/qapi-target.c
 T: git https://repo.or.cz/qemu/armbru.git block-next
 
 Dirty Bitmaps
@@ -2120,6 +2122,7 @@ F: ui/
 F: include/ui/
 F: qapi/ui.json
 F: util/drm.c
+F: stubs/ui-stub.c
 
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -2152,6 +2155,7 @@ F: include/monitor/hmp-target.h
 F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
 F: util/qemu-print.c
+F: stubs/migration.c
 
 Network device backends
 M: Jason Wang <jasowang@redhat.com>
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 2e4e8741fb..cdbceb5fff 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -119,4 +119,14 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
 void page_collection_unlock(struct page_collection *set)
 {
 }
+
+void dump_exec_info(void)
+{
+    qemu_debug_assert(0);
+}
+
+void dump_opcount_info(void)
+{
+    qemu_debug_assert(0);
+}
 #endif
diff --git a/configure b/configure
index 913c78d4ef..cd90cc5d02 100755
--- a/configure
+++ b/configure
@@ -7562,6 +7562,10 @@ if test "$mpqemu" = "yes" ; then
   echo "CONFIG_MPQEMU=y" >> $config_host_mak
 fi
 
+if test "$debug" = "yes" ; then
+  echo "CONFIG_DEBUG=y" >> $config_host_mak
+fi
+
 if test "$bochs" = "yes" ; then
   echo "CONFIG_BOCHS=y" >> $config_host_mak
 fi
diff --git a/include/qemu-common.h b/include/qemu-common.h
index d0142f29ac..b76e309d98 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -10,6 +10,8 @@
 #ifndef QEMU_COMMON_H
 #define QEMU_COMMON_H
 
+#include <assert.h>
+
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
 /* Copyright string for -version arguments, About dialogs, etc */
@@ -135,4 +137,10 @@ void page_size_init(void);
  * returned. */
 bool dump_in_progress(void);
 
+#ifdef CONFIG_DEBUG
+#define qemu_debug_assert(x) assert(x)
+#else
+#define qemu_debug_assert(x)
+#endif
+
 #endif
diff --git a/stubs/gdbstub.c b/stubs/gdbstub.c
index 2b7aee50d3..1e65b54755 100644
--- a/stubs/gdbstub.c
+++ b/stubs/gdbstub.c
@@ -1,6 +1,29 @@
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "exec/gdbstub.h"       /* xml_builtin */
 
+#pragma weak gdbserver_start
+
 const char *const xml_builtin[][2] = {
   { NULL, NULL }
 };
+
+#ifdef CONFIG_USER_ONLY
+
+int gdbserver_start(int port)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
+
+#else
+
+int gdbserver_start(const char *device)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
+
+#endif
diff --git a/stubs/migration.c b/stubs/migration.c
new file mode 100644
index 0000000000..28ccf80f21
--- /dev/null
+++ b/stubs/migration.c
@@ -0,0 +1,162 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "migration/misc.h"
+#include "migration/snapshot.h"
+#include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-commands-migration.h"
+#include "qapi/qapi-types-net.h"
+
+MigrationInfo *qmp_query_migrate(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
+                                  Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+MigrationParameters *qmp_query_migrate_parameters(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_migrate_start_postcopy(Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_migrate_cancel(Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_migrate_continue(MigrationStatus state, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_migrate_set_downtime(double value, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_migrate_set_speed(int64_t value, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_migrate_set_cache_size(int64_t value, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+int64_t qmp_query_migrate_cache_size(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return 0;
+}
+
+void qmp_migrate(const char *uri, bool has_blk, bool blk,
+                 bool has_inc, bool inc, bool has_detach, bool detach,
+                 bool has_resume, bool resume, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_migrate_incoming(const char *uri, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_migrate_recover(const char *uri, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_migrate_pause(Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_x_colo_lost_heartbeat(Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
+                                Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_xen_set_replication(bool enable, bool primary,
+                             bool has_failover, bool failover,
+                             Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_xen_colo_do_checkpoint(Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+COLOStatus *qmp_query_colo_status(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void migration_global_dump(Monitor *mon)
+{
+    qemu_debug_assert(0);
+}
+
+int load_snapshot(const char *name, Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
+
+int save_snapshot(const char *name, Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
+
+AnnounceParameters *migrate_announce_params(void)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 4613bc23e0..79c5571b2d 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "../monitor/monitor-internal.h"
@@ -10,6 +11,25 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 #include "monitor/hmp.h"
+#include "monitor/qdev.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/sysemu.h"
+
+#include "qapi/qapi-types-block-core.h"
+#include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-emit-events.h"
+
+#pragma weak cur_mon
+#pragma weak monitor_vprintf
+#pragma weak monitor_get_fd
+#pragma weak monitor_init
+#pragma weak qapi_event_emit
+#pragma weak monitor_get_cpu_index
+#pragma weak monitor_printf
+#pragma weak monitor_cur_is_qmp
+#pragma weak qmp_device_list_properties
+#pragma weak monitor_init_qmp
+#pragma weak monitor_init_hmp
 
 #pragma weak hmp_handle_error
 #pragma weak cur_mon
@@ -22,34 +42,45 @@ __thread Monitor *cur_mon;
 
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
+    qemu_debug_assert(0);
     abort();
 }
 
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
+    qemu_debug_assert(0);
 }
 
 void monitor_fdsets_cleanup(void)
 {
+    qemu_debug_assert(0);
 }
 
 int monitor_get_cpu_index(void)
 {
+    qemu_debug_assert(0);
+
     return -ENOSYS;
 }
 int monitor_printf(Monitor *mon, const char *fmt, ...)
 {
+    qemu_debug_assert(0);
+
     return -ENOSYS;
 }
 
 bool monitor_cur_is_qmp(void)
 {
+    qemu_debug_assert(0);
+
     return false;
 }
 
 ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
                                                    Error **errp)
 {
+    qemu_debug_assert(0);
+
     return NULL;
 }
 
diff --git a/stubs/net-stub.c b/stubs/net-stub.c
index cb2274ba40..6660e83527 100644
--- a/stubs/net-stub.c
+++ b/stubs/net-stub.c
@@ -2,6 +2,9 @@
 #include "qemu-common.h"
 #include "net/net.h"
 
+#include "qapi/qapi-commands-net.h"
+#include "qapi/qapi-commands-rocker.h"
+
 int qemu_find_net_clients_except(const char *id, NetClientState **ncs,
                                  NetClientDriver type, int max)
 {
@@ -29,3 +32,69 @@ int qemu_find_nic_model(NICInfo *nd, const char * const *models,
     return -ENOSYS;
 }
 
+void qmp_set_link(const char *name, bool up, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_netdev_del(const char *id, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+RxFilterInfoList *qmp_query_rx_filter(bool has_name, const char *name,
+                                      Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_announce_self(AnnounceParameters *params, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+RockerSwitch *qmp_query_rocker(const char *name, Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+RockerPortList *qmp_query_rocker_ports(const char *name, Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+RockerOfDpaFlowList *qmp_query_rocker_of_dpa_flows(const char *name,
+                                                   bool has_tbl_id,
+                                                   uint32_t tbl_id,
+                                                   Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+RockerOfDpaGroupList *qmp_query_rocker_of_dpa_groups(const char *name,
+                                                     bool has_type,
+                                                     uint8_t type,
+                                                     Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_netdev_add(Netdev *arg, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void netdev_add(QemuOpts *opts, Error **errp)
+{
+    qemu_debug_assert(0);
+}
diff --git a/stubs/qapi-misc.c b/stubs/qapi-misc.c
new file mode 100644
index 0000000000..3eeedd997a
--- /dev/null
+++ b/stubs/qapi-misc.c
@@ -0,0 +1,41 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "qapi/qapi-commands-misc.h"
+#include "./qapi/qapi-types-dump.h"
+#include "qapi/qapi-commands-dump.h"
+
+void qmp_dump_guest_memory(bool paging, const char *file,
+                           bool has_detach, bool detach,
+                           bool has_begin, int64_t begin, bool has_length,
+                           int64_t length, bool has_format,
+                           DumpGuestMemoryFormat format, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+DumpQueryResult *qmp_query_dump(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_xen_load_devices_state(const char *filename, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+bool dump_in_progress(void)
+{
+    qemu_debug_assert(0);
+
+    return FALSE;
+}
diff --git a/stubs/qapi-target.c b/stubs/qapi-target.c
new file mode 100644
index 0000000000..7a16164dde
--- /dev/null
+++ b/stubs/qapi-target.c
@@ -0,0 +1,56 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "qapi/qapi-types-misc-target.h"
+#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-types-machine-target.h"
+#include "qapi/qapi-commands-machine-target.h"
+
+#if defined(TARGET_I386)
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+SevInfo *qmp_query_sev(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+SevCapability *qmp_query_sev_capabilities(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+#endif
+
+#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM)
+CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                                                     CpuModelInfo *model,
+                                                     Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+#endif
+
+#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || \
+    defined(TARGET_S390X) || defined(TARGET_MIPS)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+#endif
diff --git a/stubs/ui-stub.c b/stubs/ui-stub.c
new file mode 100644
index 0000000000..a5a63ead50
--- /dev/null
+++ b/stubs/ui-stub.c
@@ -0,0 +1,130 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "ui/console.h"
+#include "ui/input.h"
+#include "ui/qemu-spice.h"
+
+#include "qapi/qapi-types-ui.h"
+#include "qapi/qapi-commands-ui.h"
+
+void qmp_screendump(const char *filename, bool has_device, const char *device,
+                    bool has_head, int64_t head, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+VncInfo *qmp_query_vnc(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+VncInfo2List *qmp_query_vnc_servers(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+MouseInfoList *qmp_query_mice(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
+                  Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void qmp_input_send_event(bool has_device, const char *device,
+                          bool has_head, int64_t head,
+                          InputEventList *events, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void vnc_display_open(const char *id, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void vnc_display_add_client(const char *id, int csock, bool skipauth)
+{
+    qemu_debug_assert(0);
+}
+
+void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
+{
+    qemu_debug_assert(0);
+}
+
+void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down)
+{
+    qemu_debug_assert(0);
+}
+
+void qemu_input_event_sync(void)
+{
+    qemu_debug_assert(0);
+}
+
+void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
+                               uint32_t button_old, uint32_t button_new)
+{
+    qemu_debug_assert(0);
+}
+
+#ifdef CONFIG_SPICE
+
+int using_spice;
+
+SpiceInfo *qmp_query_spice(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
+                            const char *subject)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
+
+int qemu_spice_display_add_client(int csock, int skipauth, int tls)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
+
+int qemu_spice_set_passwd(const char *passwd, bool fail_if_conn,
+                          bool disconnect_if_conn)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
+
+int qemu_spice_set_pw_expire(time_t expires)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
+
+#endif
+
+int index_from_key(const char *key, size_t key_length)
+{
+    qemu_debug_assert(0);
+
+    return -ENOSYS;
+}
diff --git a/stubs/vl-stub.c b/stubs/vl-stub.c
index fff72be201..606f078274 100644
--- a/stubs/vl-stub.c
+++ b/stubs/vl-stub.c
@@ -8,6 +8,12 @@
 #include "disas/disas.h"
 #include "sysemu/runstate.h"
 
+#include "qapi/qapi-commands-ui.h"
+#include "qapi/qapi-commands-run-state.h"
+#include "sysemu/watchdog.h"
+#include "disas/disas.h"
+#include "audio/audio.h"
+
 bool tcg_allowed;
 bool xen_allowed;
 bool boot_strict;
@@ -21,6 +27,8 @@ int smp_threads = 1;
 int icount_align_option;
 int boot_menu;
 
+#pragma weak arch_type
+
 unsigned int max_cpus;
 const uint32_t arch_type;
 const char *mem_path;
@@ -33,6 +41,11 @@ ram_addr_t ram_size;
 MachineState *current_machine;
 QemuUUID qemu_uuid;
 
+int singlestep;
+const char *qemu_name;
+int no_shutdown;
+int autostart;
+
 int runstate_is_running(void)
 {
     return 0;
@@ -77,3 +90,82 @@ void x86_cpu_list(void)
 {
 }
 #endif
+
+void qemu_system_shutdown_request(ShutdownCause reason)
+{
+    qemu_debug_assert(0);
+}
+
+void qemu_system_reset_request(ShutdownCause reason)
+{
+    qemu_debug_assert(0);
+}
+
+void qemu_system_powerdown_request(void)
+{
+    qemu_debug_assert(0);
+}
+
+void qemu_exit_preconfig_request(void)
+{
+    qemu_debug_assert(0);
+}
+
+bool runstate_needs_reset(void)
+{
+    qemu_debug_assert(0);
+
+    return FALSE;
+}
+
+bool qemu_wakeup_suspend_enabled(void)
+{
+    qemu_debug_assert(0);
+
+    return FALSE;
+}
+
+void qemu_system_wakeup_request(WakeupReason reason, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+DisplayOptions *qmp_query_display_options(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+StatusInfo *qmp_query_status(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+void qmp_watchdog_set_action(WatchdogAction action, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+int select_watchdog_action(const char *p)
+{
+    qemu_debug_assert(0);
+
+    return -1;
+}
+
+void monitor_disas(Monitor *mon, CPUState *cpu,
+                   target_ulong pc, int nb_insn, int is_physical)
+{
+    qemu_debug_assert(0);
+}
+
+int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
+                      int freq, int bits, int nchannels)
+{
+    qemu_debug_assert(0);
+
+    return -1;
+}
-- 
2.25.GIT


