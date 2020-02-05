Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5022C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 05:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC132072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 05:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC132072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izCoo-0007bq-Jt
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 00:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1izCn4-0006bZ-PO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 23:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1izCn2-0007gm-JN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 23:59:54 -0500
Received: from [107.174.27.60] (port=48574 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1izCn2-0007Uh-BC; Tue, 04 Feb 2020 23:59:52 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 2F84DAE807DF;
 Tue,  4 Feb 2020 23:57:50 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu v6] spapr: OF CI networking
Date: Wed,  5 Feb 2020 15:59:14 +1100
Message-Id: <20200205045914.11733-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203032943.121178-1-aik@ozlabs.ru>
References: <20200203032943.121178-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a *hack* to demonstrate the idea.

I am connecting the OF CI's "net" device to a corresponding network
backend. Unlike blockdev with its simple API allowing to just read
from a device, network requires a client and in presence of
an existing device in QEMU, having another device-agnostinc receiver
from the netdev backend is quite tricky.

Is this something that should never ever be done in such paravirtual
setup? Is there a better way to do this within the existing QEMU besides
implementing drivers in the guest space?

This one manages to get DHCP config working in GRUB (compiled separately
and loaded via "-kernel") but this is very unstable - needs syncronization,
correct qemu_flush_queued_packets/qemu_purge_queued_packets in places,
etc.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_of_client.c | 150 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 142 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_of_client.c b/hw/ppc/spapr_of_client.c
index 31555c356de8..a05d891eb452 100644
--- a/hw/ppc/spapr_of_client.c
+++ b/hw/ppc/spapr_of_client.c
@@ -15,6 +15,7 @@
 #include "elf.h"
 #include "hw/ppc/ppc.h"
 #include "hw/loader.h"
+#include "net/net.h"
 #include "trace.h"
 
 #define ALIGN(x, a) (((x) + (a) - 1) & ~((a) - 1))
@@ -211,12 +212,23 @@ static const uint8_t of_client_blob[] = {
     0x4e, 0x80, 0x00, 0x20
 };
 
+typedef uint8_t SpaprOfNetBuffer[2048];
+typedef struct {
+    int head, tail, used;
+    SpaprOfNetBuffer b[32];
+} SpaprOfNetBuffers;
+
 typedef struct {
     DeviceState *dev;
     CharBackend *cbe;
     BlockBackend *blk;
     uint64_t blk_pos;
     uint16_t blk_physical_block_size;
+    NICState *nic;
+    NICConf nicconf;
+    SpaprOfNetBuffers *netbufs;
+    NetClientState *ncpeer;
+    char *params;
     char *path; /* the path used to open the instance */
     uint32_t phandle;
 } SpaprOfInstance;
@@ -612,6 +624,75 @@ static DeviceState *of_client_find_qom_dev(BusState *bus, const char *path)
     return NULL;
 }
 
+static bool network_device_get_mac(DeviceState *qdev, MACAddr *mac)
+{
+    const char *macstr;
+
+    macstr = object_property_get_str(OBJECT(qdev), "mac", NULL);
+    if (!macstr) {
+        return false;
+    }
+
+    return sscanf(macstr, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+                  &mac->a[0], &mac->a[1], &mac->a[2],
+                  &mac->a[3], &mac->a[4], &mac->a[5]) == 6;
+}
+
+static int of_client_net_can_receive(NetClientState *nc)
+{
+    SpaprOfInstance *inst = qemu_get_nic_opaque(nc);
+    SpaprOfNetBuffers *nb = inst->netbufs;
+
+    return nb->used < ARRAY_SIZE(nb->b);
+}
+
+static ssize_t of_client_net_receive(NetClientState *nc, const uint8_t *buf,
+                                     size_t size)
+{
+    SpaprOfInstance *inst = qemu_get_nic_opaque(nc);
+    SpaprOfNetBuffers *nb = inst->netbufs;
+    int next;
+
+    next = (nb->head + 1) % ARRAY_SIZE(nb->b);
+    g_assert(next != nb->tail);
+    g_assert(size <= ARRAY_SIZE(nb->b[0]));
+
+    memcpy(nb->b[next], buf, size);
+    nb->head = next;
+    ++nb->used;
+
+    return size;
+}
+
+static ssize_t of_client_net_read(SpaprOfInstance *inst, uint8_t *buf,
+                                  size_t size)
+{
+    SpaprOfNetBuffers *nb = inst->netbufs;
+
+    if (!nb->used) {
+        return 0;
+    }
+    g_assert(nb->head != nb->tail);
+    memcpy(buf, nb->b[nb->tail], size);
+    nb->tail = (nb->tail + 1) % ARRAY_SIZE(nb->b);
+    --nb->used;
+
+    return size;
+}
+
+static ssize_t of_client_net_write(SpaprOfInstance *inst, uint8_t *buf,
+                                   size_t size)
+{
+    return qemu_send_packet(qemu_get_queue(inst->nic), buf, size);
+}
+
+static NetClientInfo of_client_net_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState),
+    .can_receive = of_client_net_can_receive,
+    .receive = of_client_net_receive,
+};
+
 static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
 {
     int offset;
@@ -625,11 +706,6 @@ static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
     }
 
     split_path(path, &node, &unit, &part);
-    if (part && strcmp(part, "0")) {
-        error_report("Error: Do not do partitions now");
-        g_free(part);
-        part = NULL;
-    }
 
     offset = of_client_fdt_path_offset(spapr->fdt_blob, node, unit);
     if (offset < 0) {
@@ -649,6 +725,7 @@ static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
         g_free(tmp);
     }
     inst->path = g_strdup(path);
+    inst->params = part;
     g_hash_table_insert(spapr->of_instances,
                         GINT_TO_POINTER(spapr->of_instance_last),
                         inst);
@@ -659,6 +736,8 @@ static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
                                                       "chardev", NULL);
         const char *blkstr = object_property_get_str(OBJECT(inst->dev),
                                                      "drive", NULL);
+        const char *ncstr = object_property_get_str(OBJECT(inst->dev),
+                                                    "netdev", NULL);
 
         if (cdevstr) {
             Chardev *cdev = qemu_chr_find(cdevstr);
@@ -673,6 +752,28 @@ static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
             conf.blk = inst->blk;
             blkconf_blocksizes(&conf);
             inst->blk_physical_block_size = conf.physical_block_size;
+        } else if (ncstr && network_device_get_mac(inst->dev,
+                                                   &inst->nicconf.macaddr)) {
+            /*
+             * We already have a NIC hooked to a netdev bachend. To bypass
+             * the NIC, we temporarily replace the netdev's peer to our
+             * OF NIC and revert it back when the instance is closed.
+             */
+            inst->nicconf.peers.ncs[0] = qemu_find_netdev(ncstr);
+            if (inst->nicconf.peers.ncs[0]) {
+                inst->nicconf.peers.queues = 1;
+                inst->ncpeer = inst->nicconf.peers.ncs[0]->peer;
+                qemu_flush_queued_packets(inst->ncpeer);
+                inst->nicconf.peers.ncs[0]->peer = NULL;
+                inst->nic = qemu_new_nic(&of_client_net_info, &inst->nicconf,
+                                         "OF1275-CI", "ofnet", inst);
+                qemu_purge_queued_packets(inst->nicconf.peers.ncs[0]);
+            }
+            if (inst->nic) {
+                qemu_format_nic_info_str(qemu_get_queue(inst->nic),
+                                         inst->nicconf.macaddr.a);
+                inst->netbufs = g_malloc0(sizeof(inst->netbufs[0]));
+            }
         }
     }
 
@@ -680,7 +781,6 @@ trace_exit:
     trace_spapr_of_client_open(path, inst ? inst->phandle : 0, ret);
     g_free(node);
     g_free(unit);
-    g_free(part);
 
     return ret;
 }
@@ -760,7 +860,7 @@ static uint32_t of_client_instance_to_path(SpaprMachineState *spapr,
 static uint32_t of_client_write(SpaprMachineState *spapr, uint32_t ihandle,
                                 uint32_t buf, uint32_t len)
 {
-    char tmp[256];
+    char tmp[1025];
     int toread, toprint, cb = MIN(len, 1024);
     SpaprOfInstance *inst = (SpaprOfInstance *)
         g_hash_table_lookup(spapr->of_instances, GINT_TO_POINTER(ihandle));
@@ -777,6 +877,8 @@ static uint32_t of_client_write(SpaprMachineState *spapr, uint32_t ihandle,
                                                 toprint);
             } else if (inst->blk) {
                 trace_spapr_of_client_blk_write(ihandle, len);
+            } else if (inst->nic) {
+                toprint = of_client_net_write(inst, (uint8_t *) tmp, toread);
             }
         } else {
             /* We normally open stdout so this is fallback */
@@ -822,6 +924,8 @@ static uint32_t of_client_read(SpaprMachineState *spapr, uint32_t ihandle,
                 if (rc > 0) {
                     inst->blk_pos += rc;
                 }
+            } else if (inst->nic) {
+                ret = of_client_net_read(inst, buf, len);
             }
         }
     }
@@ -1214,6 +1318,15 @@ static void of_instance_free(gpointer data)
 {
     SpaprOfInstance *inst = (SpaprOfInstance *) data;
 
+    if (inst->ncpeer) {
+        qemu_flush_queued_packets(inst->nicconf.peers.ncs[0]->peer);
+        inst->nicconf.peers.ncs[0]->peer = inst->ncpeer;
+        qemu_flush_queued_packets(inst->nicconf.peers.ncs[0]->peer);
+
+        qemu_del_nic(inst->nic);
+    }
+    g_free(inst->netbufs);
+    g_free(inst->params);
     g_free(inst->path);
     g_free(inst);
 }
@@ -1355,7 +1468,7 @@ void spapr_of_client_dt(SpaprMachineState *spapr, void *fdt)
         _FDT(fdt_setprop_cell(fdt, offset, "real-mode?", 1));
     }
 
-    /* Add "disk" nodes to SCSI hosts */
+    /* Add "disk" nodes to SCSI hosts, same for "network" */
     for (offset = fdt_next_node(fdt, -1, NULL), phandle = 1;
          offset >= 0;
          offset = fdt_next_node(fdt, offset, NULL), ++phandle) {
@@ -1366,6 +1479,27 @@ void spapr_of_client_dt(SpaprMachineState *spapr, void *fdt)
             int disk_node_off = fdt_add_subnode(fdt, offset, "disk");
 
             fdt_setprop_string(fdt, disk_node_off, "device_type", "block");
+        } else if (strncmp(nodename, "ethernet@", 9) == 0 ||
+                   strncmp(nodename, "l-lan@", 6) == 0) {
+
+            char devpath[1024];
+            DeviceState *qdev;
+            MACAddr mac;
+
+            if (fdt_get_path(fdt, offset, devpath, sizeof(devpath) - 1) < 0) {
+                continue;
+            }
+
+            qdev = of_client_find_qom_dev(sysbus_get_default(), devpath);
+            if (!qdev) {
+                continue;
+            }
+            if (network_device_get_mac(qdev, &mac)) {
+                fdt_setprop(fdt, offset, "local-mac-address", mac.a,
+                            sizeof(mac));
+            }
+            fdt_setprop_string(fdt, offset, "device_type", "network");
+            fdt_setprop_cell(fdt, offset, "max-frame-size", 1024);
         }
     }
 
-- 
2.17.1


