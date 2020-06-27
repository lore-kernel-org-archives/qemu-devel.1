Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D12AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099D420760
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QEBAH77G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099D420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEX1-0001cw-Bi
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELl-0000Jz-BP
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELi-0007Bn-Vj
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH3ALN035235;
 Sat, 27 Jun 2020 17:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=XTYgyNRDCERo5huzGWcdWGWEwmbDb86jzsCSvpOa/8Y=;
 b=QEBAH77GvxjAkXNh+F66Q9bTi217gY3Bbs+XUcoPazwUlEgkLmhyZeOgrW9Zi4vVSMce
 T0bO10x8WJ+hUo8xRdp19iGSmetqV4a6Pru6l+lJtt0szVl/2TaT4x8VINgEt9RcJ3j0
 ttX8BkQEYxlvnwU/YxlxOeT0GtqJQ1Lc0HQPcGSxGBTTdUl8nD+P1ZybzaWx5ZT27Yl0
 wc+3ruFNvOVZkr8qkGYIXL6bDoYXdf5AmLLZlzQtX7pxh/7isP9UK+T196gNHxPzg1ow
 S3QpYcWmhmj7nbohbQHF/2M9kxpHN0hig1ArAxYjzBZleInxvJzb8Z3MGxowK1+4dYe+ Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 31wwhr9c9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8JiA081218;
 Sat, 27 Jun 2020 17:10:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 31wv59awqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RHAFk9030682;
 Sat, 27 Jun 2020 17:10:15 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:14 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/21] multi-process: PCI BAR read/write handling for proxy
 & remote endpoints
Date: Sat, 27 Jun 2020 10:09:36 -0700
Message-Id: <d979961dd356ed375b9bca34d99ed2e669072407.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 cotscore=-2147483648
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:03:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Jagannathan Raman <jag.raman@oracle.com>

Proxy device object implements handler for PCI BAR writes and reads.
The handler uses BAR_WRITE/BAR_READ message to communicate to the
remote process with the BAR address and value to be written/read.
The remote process implements handler for BAR_WRITE/BAR_READ
message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/i386/remote-msg.c     | 95 ++++++++++++++++++++++++++++++++++++++++
 hw/pci/proxy.c           | 61 ++++++++++++++++++++++++++
 include/hw/pci/proxy.h   | 16 ++++++-
 include/io/mpqemu-link.h | 10 +++++
 io/mpqemu-link.c         |  6 +++
 5 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index aa5780d521..ffb4143736 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -8,6 +8,7 @@
 #include "sysemu/runstate.h"
 #include "io/channel-util.h"
 #include "hw/pci/pci.h"
+#include "exec/memattrs.h"
 
 static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
                                     Error **errp);
@@ -15,6 +16,8 @@ static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
                                  MPQemuMsg *msg);
 static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
                                 MPQemuMsg *msg);
+static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
+static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
@@ -54,6 +57,12 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     case PCI_CONFIG_READ:
         process_config_read(ioc, pci_dev, &msg);
         break;
+    case BAR_WRITE:
+        process_bar_write(ioc, &msg, &local_err);
+        break;
+    case BAR_READ:
+        process_bar_read(ioc, &msg, &local_err);
+        break;
     default:
         error_setg(&local_err, "Unknown command (%d) received from proxy \
                    in remote process pid=%d", msg.cmd, getpid());
@@ -143,3 +152,89 @@ static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
 
     mpqemu_msg_send(&ret, ioc);
 }
+
+static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp)
+{
+    BarAccessMsg *bar_access = &msg->data1.bar_access;
+    AddressSpace *as =
+        bar_access->memory ? &address_space_memory : &address_space_io;
+    MPQemuMsg ret = { 0 };
+    MemTxResult res;
+
+    if (!is_power_of_2(bar_access->size) ||
+       (bar_access->size > sizeof(uint64_t))) {
+        ret.data1.u64 = UINT64_MAX;
+        goto fail;
+    }
+
+    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
+                           (void *)&bar_access->val, bar_access->size,
+                           true);
+
+    if (res != MEMTX_OK) {
+        error_setg(errp, "Could not perform address space write operation,"
+                   " inaccessible address: %lx in pid %d.",
+                   bar_access->addr, getpid());
+        ret.data1.u64 = -1;
+    }
+
+fail:
+    ret.cmd = RET_MSG;
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, ioc);
+}
+
+static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp)
+{
+    BarAccessMsg *bar_access = &msg->data1.bar_access;
+    MPQemuMsg ret = { 0 };
+    AddressSpace *as;
+    MemTxResult res;
+    uint64_t val = 0;
+
+    as = bar_access->memory ? &address_space_memory : &address_space_io;
+
+    if (!is_power_of_2(bar_access->size) ||
+       (bar_access->size > sizeof(uint64_t))) {
+        val = UINT64_MAX;
+        goto fail;
+    }
+
+    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
+                           (void *)&val, bar_access->size, false);
+
+    if (res != MEMTX_OK) {
+        error_setg(errp, "Could not perform address space read operation,"
+                   " inaccessible address: %lx in pid %d.",
+                   bar_access->addr, getpid());
+        val = UINT64_MAX;
+        goto fail;
+    }
+
+    switch (bar_access->size) {
+    case 8:
+        /* Nothing to do as val is already 8 bytes long */
+        break;
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
+        error_setg(errp, "Invalid PCI BAR read size in pid %d",
+                   getpid());
+        val = (uint64_t)-1;
+    }
+
+fail:
+    ret.cmd = RET_MSG;
+    ret.data1.u64 = val;
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, ioc);
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 8934070a20..fff021a06a 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -150,3 +150,64 @@ static void pci_proxy_dev_register_types(void)
 }
 
 type_init(pci_proxy_dev_register_types)
+
+static void send_bar_access_msg(PCIProxyDev *pdev, MemoryRegion *mr,
+                                bool write, hwaddr addr, uint64_t *val,
+                                unsigned size, bool memory)
+{
+    MPQemuMsg msg = { 0 };
+    long ret = -EINVAL;
+    Error *local_err = NULL;
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
+        msg.cmd = BAR_READ;
+    }
+
+    ret = mpqemu_msg_send_reply_co(&msg, pdev->com, &local_err);
+    if (local_err) {
+        error_report("Failed to send BAR command to the remote process.");
+    }
+
+    if (!write) {
+        *val = ret;
+    }
+}
+
+static void proxy_bar_write(void *opaque, hwaddr addr, uint64_t val,
+                            unsigned size)
+{
+    ProxyMemoryRegion *pmr = opaque;
+
+    send_bar_access_msg(pmr->dev, &pmr->mr, true, addr, &val, size,
+                        pmr->memory);
+}
+
+static uint64_t proxy_bar_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ProxyMemoryRegion *pmr = opaque;
+    uint64_t val;
+
+    send_bar_access_msg(pmr->dev, &pmr->mr, false, addr, &val, size,
+                        pmr->memory);
+
+    return val;
+}
+
+const MemoryRegionOps proxy_mr_ops = {
+    .read = proxy_bar_read,
+    .write = proxy_bar_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
index 72dd7e0944..4f9f9c4e15 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -26,12 +26,24 @@
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
+struct PCIProxyDev {
     PCIDevice parent_dev;
     char *fd;
     QIOChannel *com;
     QIOChannel *dev;
-} PCIProxyDev;
+
+    ProxyMemoryRegion region[PCI_NUM_REGIONS];
+};
 
 typedef struct PCIProxyDevClass {
     PCIDeviceClass parent_class;
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index bbd6f3db44..0422213863 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -40,6 +40,8 @@ typedef enum {
     RET_MSG,
     PCI_CONFIG_WRITE,
     PCI_CONFIG_READ,
+    BAR_WRITE,
+    BAR_READ,
     MAX = INT_MAX,
 } MPQemuCmd;
 
@@ -55,6 +57,13 @@ struct conf_data_msg {
     int l;
 };
 
+typedef struct {
+    hwaddr addr;
+    uint64_t val;
+    unsigned size;
+    bool memory;
+} BarAccessMsg;
+
 /**
  * Maximum size of data2 field in the message to be transmitted.
  */
@@ -82,6 +91,7 @@ typedef struct {
     union {
         uint64_t u64;
         SyncSysmemMsg sync_sysmem;
+        BarAccessMsg bar_access;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 19887611d0..026e25dca4 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -256,6 +256,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case BAR_WRITE:
+    case BAR_READ:
+        if (msg->size != sizeof(msg->data1)) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.25.GIT


