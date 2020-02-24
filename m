Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C97C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227F9218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0V2S+LAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227F9218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LG4-0000f9-8Q
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn1-0008UN-K2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmz-00048q-J4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmz-0003y0-Ak
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKraUi164125;
 Mon, 24 Feb 2020 20:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=exSdLszfLnd9sxniF987sr8s2/2hVw2ZjwI3nI6ER98=;
 b=0V2S+LAnVJwDPhljo4U0v7K5Y7l/RYHS6T3XzaOVxiSOHGfulWgh7hxvlXX9Buihc2HW
 op2pYqCVcEJ8Xq0G8mqkr1+72U8ttvkFv/cZJpEpjQhfIsUKlOgp0i9Njyan7bJ25RbF
 YRIBRBwwiuwwYRu5gYrCGpokO6kLVL1zJyhQhEIn3bBDfkMZMqXL1LHX7mtuY/kqBUJd
 KZiKGTe/xLk03tVa1bMXhUHTYnv/VP87mCKo3+NbuOaIgLl2mNXyKqhJm9Yv1JreW4Ly
 6QBR5hI3bx64HYOLYz7lC6W9U8XbAKVXQfgH6DBoCTxa8tkVxUdZGnPGyaXvaXCWVZDB JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p98s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKudIX073056;
 Mon, 24 Feb 2020 20:57:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ybduv6dtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKuwdR030091;
 Mon, 24 Feb 2020 20:56:58 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:58 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 40/50] multi-process/mig: build migration module in the
 remote process
Date: Mon, 24 Feb 2020 15:55:31 -0500
Message-Id: <96a495711764282ff90504cec6734eff563ceb4d.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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

Add Makefile support to enable migration in remote process

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Makefile.objs           |  4 +++-
 Makefile.target         |  1 +
 migration/Makefile.objs | 13 ++++++++++++-
 net/Makefile.objs       |  2 ++
 softmmu/vl.c            |  2 --
 stubs/migration.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/net-stub.c        | 21 +++++++++++++++++++++
 stubs/qapi-misc.c       |  2 ++
 stubs/replay.c          |  8 ++++++++
 stubs/vl-stub.c         | 24 ++++++++++++++++++++++++
 vl-parse.c              |  3 +++
 11 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 4b5db09..65009da 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -74,6 +74,8 @@ common-obj-y += qdev-monitor.o device-hotplug.o
 common-obj-$(CONFIG_WIN32) += os-win32.o
 common-obj-$(CONFIG_POSIX) += os-posix.o
 
+remote-pci-obj-$(CONFIG_POSIX) += os-posix.o
+
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
@@ -104,11 +106,11 @@ common-obj-y += vl-parse.o
 
 #######################################################################
 # qapi
-
 common-obj-y += qapi/
 
 endif # CONFIG_SOFTMMU
 
+remote-pci-obj-$(CONFIG_MPQEMU) += net/
 remote-pci-obj-$(CONFIG_MPQEMU) += qapi/
 remote-pci-obj-$(CONFIG_MPQEMU) += blockdev-nbd.o
 remote-pci-obj-$(CONFIG_MPQEMU) += job-qmp.o
diff --git a/Makefile.target b/Makefile.target
index 4ead5c3..4012ae5 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -240,6 +240,7 @@ all-remote-pci-obj-y += exec.o
 all-remote-pci-obj-y += exec-vary.o
 all-remote-pci-obj-y += ioport.o
 all-remote-pci-obj-y += cpus.o
+all-remote-pci-obj-y += migration/ram.o
 endif
 
 remote-pci-obj-y :=
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index e7cdc76..21f9d8d 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -15,4 +15,15 @@ common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
 rdma.o-libs := $(RDMA_LIBS)
 
-remote-pci-obj-$(CONFIG_MPQEMU) += qemu-file.o vmstate.o qjson.o vmstate-types.o
+remote-pci-obj-$(CONFIG_MPQEMU) += migration.o socket.o fd.o exec.o
+remote-pci-obj-$(CONFIG_MPQEMU) += tls.o channel.o savevm.o
+remote-pci-obj-$(CONFIG_MPQEMU) += colo.o colo-failover.o
+remote-pci-obj-$(CONFIG_MPQEMU) += vmstate.o vmstate-types.o page_cache.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qemu-file.o global_state.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qemu-file-channel.o
+remote-pci-obj-$(CONFIG_MPQEMU) += xbzrle.o postcopy-ram.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qjson.o
+remote-pci-obj-$(CONFIG_MPQEMU) += block-dirty-bitmap.o
+remote-pci-obj-$(CONFIG_RDMA) += rdma.o
+remote-pci-obj-$(CONFIG_MPQEMU) += block.o
+remote-pci-obj-$(CONFIG_MPQEMU) += multifd.o
diff --git a/net/Makefile.objs b/net/Makefile.objs
index c5d076d..a8ad986 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -30,3 +30,5 @@ common-obj-$(CONFIG_WIN32) += tap-win32.o
 vde.o-libs = $(VDE_LIBS)
 
 common-obj-$(CONFIG_CAN_BUS) += can/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += announce.o
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4a4f52c..42d5682 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -128,7 +128,6 @@ const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
 const char *mem_path = NULL;
 int mem_prealloc = 0; /* force preallocation of physical target memory */
-bool enable_mlock = false;
 bool enable_cpu_pm = false;
 int nb_nics;
 NICInfo nd_table[MAX_NICS];
@@ -168,7 +167,6 @@ const char *prom_envs[MAX_PROM_ENVS];
 int boot_menu;
 bool boot_strict;
 uint8_t *boot_splash_filedata;
-int only_migratable; /* turn it off unless user states otherwise */
 bool wakeup_suspend_enabled;
 
 int icount_align_option;
diff --git a/stubs/migration.c b/stubs/migration.c
index 28ccf80..dbd12db 100644
--- a/stubs/migration.c
+++ b/stubs/migration.c
@@ -6,6 +6,35 @@
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-types-net.h"
+#include "net/filter.h"
+#include "net/colo-compare.h"
+
+#pragma weak qmp_query_migrate_capabilities
+#pragma weak qmp_query_migrate_parameters
+#pragma weak migrate_announce_params
+#pragma weak qmp_query_migrate
+#pragma weak qmp_migrate_set_capabilities
+#pragma weak qmp_migrate_set_parameters
+#pragma weak qmp_migrate_incoming
+#pragma weak qmp_migrate_recover
+#pragma weak qmp_migrate_pause
+#pragma weak qmp_migrate
+#pragma weak qmp_migrate_cancel
+#pragma weak qmp_migrate_continue
+#pragma weak qmp_migrate_set_cache_size
+#pragma weak qmp_query_migrate_cache_size
+#pragma weak qmp_migrate_set_speed
+#pragma weak qmp_migrate_set_downtime
+#pragma weak qmp_migrate_start_postcopy
+#pragma weak migration_global_dump
+#pragma weak save_snapshot
+#pragma weak qmp_xen_save_devices_state
+#pragma weak load_snapshot
+#pragma weak qmp_xen_set_replication
+#pragma weak qmp_query_xen_replication_status
+#pragma weak qmp_xen_colo_do_checkpoint
+#pragma weak qmp_query_colo_status
+#pragma weak qmp_x_colo_lost_heartbeat
 
 MigrationInfo *qmp_query_migrate(Error **errp)
 {
@@ -160,3 +189,23 @@ AnnounceParameters *migrate_announce_params(void)
 
     return NULL;
 }
+
+void colo_notify_filters_event(int event, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void colo_notify_compares_event(void *opaque, int event, Error **errp)
+{
+    qemu_debug_assert(0);
+}
+
+void colo_compare_register_notifier(Notifier *notify)
+{
+    qemu_debug_assert(0);
+}
+
+void colo_compare_unregister_notifier(Notifier *notify)
+{
+    qemu_debug_assert(0);
+}
diff --git a/stubs/net-stub.c b/stubs/net-stub.c
index 962827e..ddfd1e4 100644
--- a/stubs/net-stub.c
+++ b/stubs/net-stub.c
@@ -5,6 +5,8 @@
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-commands-rocker.h"
 
+#pragma weak qmp_announce_self
+
 int qemu_find_net_clients_except(const char *id, NetClientState **ncs,
                                  NetClientDriver type, int max)
 {
@@ -98,3 +100,22 @@ void netdev_add(QemuOpts *opts, Error **errp)
 {
     qemu_debug_assert(0);
 }
+
+NetClientState *qemu_get_queue(NICState *nic)
+{
+    qemu_debug_assert(0);
+
+    return NULL;
+}
+
+ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size)
+{
+    qemu_debug_assert(0);
+
+    return 0;
+}
+
+void qemu_foreach_nic(qemu_nic_foreach func, void *opaque)
+{
+    qemu_debug_assert(0);
+}
diff --git a/stubs/qapi-misc.c b/stubs/qapi-misc.c
index 3eeedd9..824eac1 100644
--- a/stubs/qapi-misc.c
+++ b/stubs/qapi-misc.c
@@ -5,6 +5,8 @@
 #include "./qapi/qapi-types-dump.h"
 #include "qapi/qapi-commands-dump.h"
 
+#pragma weak qmp_xen_load_devices_state
+
 void qmp_dump_guest_memory(bool paging, const char *file,
                            bool has_detach, bool detach,
                            bool has_begin, int64_t begin, bool has_length,
diff --git a/stubs/replay.c b/stubs/replay.c
index 9b53c0c..6fc7850 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "sysemu/replay.h"
 
 ReplayMode replay_mode;
@@ -106,3 +107,10 @@ void replay_account_executed_instructions(void)
 void replay_add_blocker(Error *reason)
 {
 }
+
+bool replay_can_snapshot(void)
+{
+    qemu_debug_assert(0);
+
+    return false;
+}
diff --git a/stubs/vl-stub.c b/stubs/vl-stub.c
index 606f078..5f308c1 100644
--- a/stubs/vl-stub.c
+++ b/stubs/vl-stub.c
@@ -14,6 +14,8 @@
 #include "disas/disas.h"
 #include "audio/audio.h"
 
+#pragma weak qemu_add_exit_notifier
+
 bool tcg_allowed;
 bool xen_allowed;
 bool boot_strict;
@@ -169,3 +171,25 @@ int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
 
     return -1;
 }
+
+void qemu_system_killed(int signal, pid_t pid)
+{
+    qemu_debug_assert(0);
+}
+
+void qemu_system_reset(ShutdownCause reason)
+{
+    qemu_debug_assert(0);
+}
+
+bool runstate_store(char *str, size_t size)
+{
+    qemu_debug_assert(0);
+
+    return false;
+}
+
+void qemu_add_exit_notifier(Notifier *notify)
+{
+    qemu_debug_assert(0);
+}
diff --git a/vl-parse.c b/vl-parse.c
index 1f6a3f0..423f4a0 100644
--- a/vl-parse.c
+++ b/vl-parse.c
@@ -27,6 +27,9 @@
 
 #include "vl.h"
 
+int only_migratable; /* turn it off unless user states otherwise */
+bool enable_mlock;
+
 /***********************************************************/
 /* QEMU Block devices */
 
-- 
1.8.3.1


