Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC52CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D34520684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oXEVFY3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D34520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZZw-0006yX-0E
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9r-0000Y2-LN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9p-0004vh-DS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9n-0004ro-8h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94M5P099569;
 Thu, 24 Oct 2019 09:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=2Q/cmWeIRc1SHebJ+dlA8HdCfrEYFIIgUk1kTs8jfCI=;
 b=oXEVFY3RrYH8Vmge+yg0CIchF9Y63AfhCoyW8X8owGiLAJKmUu/Q8QhRp/WWyiMi7Mc8
 nyfSov6kMtRVAfP0SCHXAyPZJscHIrcnlUiw1f2zEZjDGOv3UeFSq41jFTLfQ4zmtkBp
 09ouygl/DptuuVwLL8tDT/xJuHx1yPs4W2wguwCdlBBSiX/oh8D0CTMYExnOy5jCOuaM
 VGRwGULlhHq/g+bnaMPoWLVqn4hs/R1aXi/+vYYEiDCGYbuLEkBk+eafnBarkpp5BGSB
 8swzWMuRN+KUyVqq4f5t0SQUT/X+/jtaOcOj6vJeQHmXHUBtNaUk8swi1K4OtKnCdJy5 pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2vqteq2ak1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98LlY047154;
 Thu, 24 Oct 2019 09:11:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2vu0fnu8kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:39 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9Bba4012334;
 Thu, 24 Oct 2019 09:11:38 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:37 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 40/49] multi-process/mig: build migration module in the
 remote process
Date: Thu, 24 Oct 2019 05:09:21 -0400
Message-Id: <b222bbe3dc46e78335d55363fdf4254847175399.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add Makefile support to enable migration in remote process

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v4

 Makefile.objs           |  4 ++++
 Makefile.target         |  1 +
 migration/Makefile.objs | 12 +++++++++++-
 net/Makefile.objs       |  2 ++
 replay/Makefile.objs    |  2 +-
 stubs/migration.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/net-stub.c        | 21 +++++++++++++++++++++
 stubs/qapi-misc.c       |  2 ++
 stubs/replay.c          |  8 ++++++++
 stubs/vl-stub.c         | 22 ++++++++++++++++++++++
 vl-parse.c              |  3 +++
 vl.c                    |  2 --
 12 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index c72db88..ebb1938 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -79,6 +79,8 @@ common-obj-y += qdev-monitor.o device-hotplug.o
 common-obj-$(CONFIG_WIN32) += os-win32.o
 common-obj-$(CONFIG_POSIX) += os-posix.o
 
+remote-pci-obj-$(CONFIG_POSIX) += os-posix.o
+
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += migration/
@@ -110,6 +112,8 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 
 common-obj-y += vl-parse.o
 
+remote-pci-obj-$(CONFIG_MPQEMU) += net/
+
 ######################################################################
 # qapi
 
diff --git a/Makefile.target b/Makefile.target
index 8010998..b60a837 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -225,6 +225,7 @@ all-remote-pci-obj-y += memory.o
 all-remote-pci-obj-y += exec.o
 all-remote-pci-obj-y += ioport.o
 all-remote-pci-obj-y += cpus.o
+all-remote-pci-obj-y += migration/ram.o
 
 remote-pci-obj-y :=
 remote-lsi-obj-y :=
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 016b6ab..c9682c6 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -14,4 +14,14 @@ common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
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
diff --git a/net/Makefile.objs b/net/Makefile.objs
index c5d076d..a8ad986 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -30,3 +30,5 @@ common-obj-$(CONFIG_WIN32) += tap-win32.o
 vde.o-libs = $(VDE_LIBS)
 
 common-obj-$(CONFIG_CAN_BUS) += can/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += announce.o
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
index cee6539..c64b968 100644
--- a/replay/Makefile.objs
+++ b/replay/Makefile.objs
@@ -6,4 +6,4 @@ common-obj-y += replay-input.o
 common-obj-y += replay-char.o
 common-obj-y += replay-snapshot.o
 common-obj-y += replay-net.o
-common-obj-y += replay-audio.o
\ No newline at end of file
+common-obj-y += replay-audio.o
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
index 4a966ff..6fcd995 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "sysemu/replay.h"
 
 ReplayMode replay_mode;
@@ -97,3 +98,10 @@ void replay_account_executed_instructions(void)
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
index 606f078..460d1f3 100644
--- a/stubs/vl-stub.c
+++ b/stubs/vl-stub.c
@@ -169,3 +169,25 @@ int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
 
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
index 011a9ef..1c8ecbe 100644
--- a/vl-parse.c
+++ b/vl-parse.c
@@ -41,6 +41,9 @@
 
 #include "vl.h"
 
+int only_migratable; /* turn it off unless user states otherwise */
+bool enable_mlock;
+
 /***********************************************************/
 /* QEMU Block devices */
 
diff --git a/vl.c b/vl.c
index a6a0db8..8a26d81 100644
--- a/vl.c
+++ b/vl.c
@@ -148,7 +148,6 @@ const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
 const char *mem_path = NULL;
 int mem_prealloc = 0; /* force preallocation of physical target memory */
-bool enable_mlock = false;
 bool enable_cpu_pm = false;
 int nb_nics;
 NICInfo nd_table[MAX_NICS];
@@ -189,7 +188,6 @@ const char *prom_envs[MAX_PROM_ENVS];
 int boot_menu;
 bool boot_strict;
 uint8_t *boot_splash_filedata;
-int only_migratable; /* turn it off unless user states otherwise */
 bool wakeup_suspend_enabled;
 
 int icount_align_option;
-- 
1.8.3.1


