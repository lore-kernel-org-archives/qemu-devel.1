Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BFFC38BE6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D555020CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zn4z+O7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D555020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kyb-0001V8-Up
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmi-0007ch-OQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmg-0003nF-1G
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmf-0003kw-OR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqUPP017525;
 Mon, 24 Feb 2020 20:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=zLulNEkGTL6hvzFyUvsPGZwgerJXllkvju3Y73iqWZY=;
 b=Zn4z+O7TmUCpg2da5a3b0kOvAlJQlifth2YLeqTAP3P+U92jbm0loXaFeEAEUTO0at9n
 lgPxnIicAh9jrIcOnPbKxGXl5w0x66UJt15v8r+KZdtO44cgTQrcwvRWpFxolVXh8yHT
 nWR35Kt6xfTHLuTrW20iyRMxawYBEjs6OLxsp1c9XeAULfAsEsAztBmTYyl+XuOEY2Ay
 d6kDFCeyLhjlHNRFA9L2G9KmWW77DhPtBDnNugN8ii95xK0B4p9ekXav/WvMusxqNWOT
 P0T/LSTJ/V06UpLPqRslhx3XXTENQHgdRUzEEdcv/KN0U9j6EtmGi3al2+oJT32hZ7wr gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yavxrhyj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq5mi171139;
 Mon, 24 Feb 2020 20:56:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2ybdshkscj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:52 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKuo60009640;
 Mon, 24 Feb 2020 20:56:50 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:50 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 35/50] multi-process/mon: stub functions to enable QMP
 module for remote process
Date: Mon, 24 Feb 2020 15:55:26 -0500
Message-Id: <e7020dab604bc6ed90d3b2e0fca8954745dd98dd.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

QMP module doesn't need some functions to run independently on the
remote processes. However, these functions are necessary for
compilation. Therefore, these functions are stub'ed out. The
stub functions raise an assert if QEMU is built in debug mode
(--enable-debug).

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 accel/stubs/tcg-stub.c |  10 +++
 configure              |   4 ++
 include/qemu-common.h  |   8 +++
 stubs/gdbstub.c        |  23 +++++++
 stubs/migration.c      | 162 +++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/monitor.c        |  31 ++++++++++
 stubs/net-stub.c       |  69 +++++++++++++++++++++
 stubs/qapi-misc.c      |  41 +++++++++++++
 stubs/qapi-target.c    |  55 +++++++++++++++++
 stubs/ui-stub.c        | 130 +++++++++++++++++++++++++++++++++++++++
 stubs/vl-stub.c        |  92 ++++++++++++++++++++++++++++
 11 files changed, 625 insertions(+)
 create mode 100644 stubs/migration.c
 create mode 100644 stubs/qapi-misc.c
 create mode 100644 stubs/qapi-target.c
 create mode 100644 stubs/ui-stub.c

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 9b55fb0..c2d72fe 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -119,3 +119,13 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
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
diff --git a/configure b/configure
index ab1e344..53a2a4b 100755
--- a/configure
+++ b/configure
@@ -7512,6 +7512,10 @@ if test "$mpqemu" = "yes" ; then
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
index 082da59..09da824 100644
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
index 2b7aee5..1e65b54 100644
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
index 0000000..28ccf80
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
index a34dc87..190445c 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qapi-emit-events.h"
 #include "monitor/monitor.h"
@@ -10,6 +11,24 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 #include "monitor/hmp.h"
+#include "monitor/qdev.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/sysemu.h"
+
+#include "qapi/qapi-types-block-core.h"
+#include "qapi/qapi-commands-block-core.h"
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
 
 __thread Monitor *cur_mon;
 
@@ -17,11 +36,13 @@ __thread Monitor *cur_mon;
 
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
+    qemu_debug_assert(0);
     abort();
 }
 
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
+    qemu_debug_assert(0);
     error_setg(errp, "only QEMU supports file descriptor passing");
     return -1;
 }
@@ -32,29 +53,39 @@ void monitor_init_qmp(Chardev *chr, bool pretty)
 
 void monitor_init_hmp(Chardev *chr, bool use_readline)
 {
+    qemu_debug_assert(0);
 }
 
 void qapi_event_emit(QAPIEvent event, QDict *qdict)
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
index cb2274b..962827e 100644
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
+void qmp_netdev_add(QDict *qdict, QObject **ret, Error **errp)
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
index 0000000..3eeedd9
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
index 0000000..5d224e4
--- /dev/null
+++ b/stubs/qapi-target.c
@@ -0,0 +1,55 @@
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
+#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+#endif
diff --git a/stubs/ui-stub.c b/stubs/ui-stub.c
new file mode 100644
index 0000000..a5a63ea
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
index fff72be..606f078 100644
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
1.8.3.1


