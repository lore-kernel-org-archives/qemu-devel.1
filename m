Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A55CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A4F21906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESYCUCpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A4F21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZKU-0000W8-Sr
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8k-0006QC-6R
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8i-0004BX-2m
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ8h-0004Ag-Qn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94ooa100039;
 Thu, 24 Oct 2019 09:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=mKVNftuaCcncsIMdPR3nxOIkecEr4x+cuilsoxsQJ2I=;
 b=ESYCUCpL9y1kAaychHLoYWomtsRHwXh/Hrf84/O0AiXyhyM4ZLoCP7ed9jktRbju0ei2
 dK8DcIWaUmyaAE8ww57MaXbPumfT39hVlWWtxXGqElwpgVlDTeihxPo98z6lHa5B6Vj7
 B7og2CtJm9GdUJhOBYbG4YVNzFG06TJLc9DKK2gx8z8zPbTiJsfRQbiIYbEaqWfi2x0W
 VlBu3HqhnWhgVTULtc3IVIZVZRxRPfIUMH0xqHEB+v/QiPOB4TY223GpK/WQk5TPoDVb
 ys2j2Vk1pnUynQPafXlchubmaaJoXr7JrQagYvPNdI8YExShcCNT5zk5KxS71pHuDRJC rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2vqteq2af0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97jnv170518;
 Thu, 24 Oct 2019 09:10:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2vtsk4868n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:31 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9AToU011816;
 Thu, 24 Oct 2019 09:10:29 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:29 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 15/49] multi-process: PCI BAR read/write handling for
 proxy & remote endpoints
Date: Thu, 24 Oct 2019 05:08:56 -0400
Message-Id: <91343147552944eb67fbb98bf619e7eeb98fe324.1571905346.git.jag.raman@oracle.com>
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

Proxy device object implements handler for PCI BAR writes and reads. The handler
uses BAR_WRITE/BAR_READ message to communicate to the remote process with the BAR address and
value to be written/read.
The remote process implements handler for BAR_WRITE/BAR_READ message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 77 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h | 21 ++++++++++--
 include/io/mpqemu-link.h      | 12 +++++++
 remote/remote-main.c          | 73 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index ca7dd1a..e1f62d7 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -275,6 +275,7 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
     PCIProxyDevClass *k = PCI_PROXY_DEV_GET_CLASS(dev);
     Error *local_err = NULL;
+    int r;
 
     if (k->realize) {
         k->realize(dev, &local_err);
@@ -283,7 +284,83 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
         }
     }
 
+    for (r = 0; r < PCI_NUM_REGIONS; r++) {
+        if (!dev->region[r].present) {
+            continue;
+        }
+
+        dev->region[r].dev = dev;
+
+        pci_register_bar(PCI_DEVICE(dev), r, dev->region[r].type,
+                         &dev->region[r].mr);
+    }
+
     dev->set_proxy_sock = set_proxy_sock;
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
 }
+
+static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
+                                bool write, hwaddr addr, uint64_t *val,
+                                unsigned size, bool memory)
+{
+    MPQemuLinkState *mpqemu_link = dev->mpqemu_link;
+    MPQemuMsg msg;
+    int wait;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+
+    msg.bytestream = 0;
+    msg.size = sizeof(msg.data1);
+    msg.data1.bar_access.addr = mr->addr + addr;
+    msg.data1.bar_access.size = size;
+    msg.data1.bar_access.memory = memory;
+
+    if (write) {
+        msg.cmd = BAR_WRITE;
+        msg.data1.bar_access.val = *val;
+    } else {
+        wait = GET_REMOTE_WAIT;
+
+        msg.cmd = BAR_READ;
+        msg.num_fds = 1;
+        msg.fds[0] = wait;
+    }
+
+    mpqemu_msg_send(mpqemu_link, &msg, mpqemu_link->com);
+
+    if (!write) {
+        *val = wait_for_remote(wait);
+        PUT_REMOTE_WAIT(wait);
+    }
+}
+
+void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    ProxyMemoryRegion *pmr = opaque;
+
+    send_bar_access_msg(pmr->dev, &pmr->mr, true, addr, &val, size,
+                        pmr->memory);
+}
+
+uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ProxyMemoryRegion *pmr = opaque;
+    uint64_t val;
+
+    send_bar_access_msg(pmr->dev, &pmr->mr, false, addr, &val, size,
+                        pmr->memory);
+
+     return val;
+}
+
+const MemoryRegionOps proxy_default_ops = {
+    .read = proxy_default_bar_read,
+    .write = proxy_default_bar_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index f97b103..5f57822 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -36,7 +36,19 @@
 #define PCI_PROXY_DEV_GET_CLASS(obj) \
             OBJECT_GET_CLASS(PCIProxyDevClass, (obj), TYPE_PCI_PROXY_DEV)
 
-typedef struct PCIProxyDev {
+typedef struct PCIProxyDev PCIProxyDev;
+
+typedef struct ProxyMemoryRegion {
+    PCIProxyDev *dev;
+    MemoryRegion mr;
+    bool memory;
+    bool present;
+    uint8_t type;
+} ProxyMemoryRegion;
+
+extern const MemoryRegionOps proxy_default_ops;
+
+struct PCIProxyDev {
     PCIDevice parent_dev;
 
     int n_mr_sections;
@@ -65,7 +77,8 @@ typedef struct PCIProxyDev {
     void (*proxy_ready) (PCIDevice *dev);
     void (*init_proxy) (PCIDevice *dev, char *command, bool need_spawn, Error **errp);
 
-} PCIProxyDev;
+    ProxyMemoryRegion region[PCI_NUM_REGIONS];
+};
 
 typedef struct PCIProxyDevClass {
     PCIDeviceClass parent_class;
@@ -77,5 +90,9 @@ typedef struct PCIProxyDevClass {
 
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);
 
+void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size);
+
+uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size);
 
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 7ef8207..89f04c5 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -52,6 +52,8 @@
  * CONF_READ        PCI config. space read
  * CONF_WRITE       PCI config. space write
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
+ * BAR_WRITE        Writes to PCI BAR region
+ * BAR_READ         Reads from PCI BAR region
  *
  * proc_cmd_t enum type to specify the command to be executed on the remote
  * device.
@@ -61,6 +63,8 @@ typedef enum {
     CONF_READ,
     CONF_WRITE,
     SYNC_SYSMEM,
+    BAR_WRITE,
+    BAR_READ,
     MAX,
 } mpqemu_cmd_t;
 
@@ -84,6 +88,13 @@ typedef struct {
 } sync_sysmem_msg_t;
 
 typedef struct {
+    hwaddr addr;
+    uint64_t val;
+    unsigned size;
+    bool memory;
+} bar_access_msg_t;
+
+typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -91,6 +102,7 @@ typedef struct {
     union {
         uint64_t u64;
         sync_sysmem_msg_t sync_sysmem;
+        bar_access_msg_t bar_access;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 6c2eb91..49b27d5 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -46,6 +46,7 @@
 #include "qemu/config-file.h"
 #include "sysemu/sysemu.h"
 #include "block/block.h"
+#include "exec/memattrs.h"
 
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
@@ -76,6 +77,66 @@ static void process_config_read(MPQemuMsg *msg)
     PUT_REMOTE_WAIT(wait);
 }
 
+/* TODO: confirm memtx attrs. */
+static void process_bar_write(MPQemuMsg *msg, Error **errp)
+{
+    bar_access_msg_t *bar_access = &msg->data1.bar_access;
+    AddressSpace *as =
+        bar_access->memory ? &address_space_memory : &address_space_io;
+    MemTxResult res;
+
+    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
+                           (uint8_t *)&bar_access->val, bar_access->size, true);
+
+    if (res != MEMTX_OK) {
+        error_setg(errp, "Could not perform address space write operation,"
+                   " inaccessible address: %lx.", bar_access->addr);
+    }
+}
+
+static void process_bar_read(MPQemuMsg *msg, Error **errp)
+{
+    bar_access_msg_t *bar_access = &msg->data1.bar_access;
+    AddressSpace *as;
+    int wait = msg->fds[0];
+    MemTxResult res;
+    uint64_t val = 0;
+
+    as = bar_access->memory ? &address_space_memory : &address_space_io;
+
+    assert(bar_access->size <= sizeof(uint64_t));
+
+    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
+                           (uint8_t *)&val, bar_access->size, false);
+
+    if (res != MEMTX_OK) {
+        error_setg(errp, "Could not perform address space read operation,"
+                   " inaccessible address: %lx.", bar_access->addr);
+        val = (uint64_t)-1;
+        goto fail;
+    }
+
+    switch (bar_access->size) {
+    case 4:
+        val = *((uint32_t *)&val);
+        break;
+    case 2:
+        val = *((uint16_t *)&val);
+        break;
+    case 1:
+        val = *((uint8_t *)&val);
+        break;
+    default:
+        error_setg(errp, "Invalid PCI BAR read size");
+        return;
+    }
+
+fail:
+    notify_proxy(wait, val);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static void process_msg(GIOCondition cond, MPQemuChannel *chan)
 {
     MPQemuMsg *msg = NULL;
@@ -102,6 +163,18 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     case CONF_READ:
         process_config_read(msg);
         break;
+    case BAR_WRITE:
+        process_bar_write(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
+    case BAR_READ:
+        process_bar_read(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1


