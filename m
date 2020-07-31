Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2591C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EB122B42
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="puw0PCIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EB122B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZmJ-0004O6-07
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeU-00020h-A9
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:21:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeS-0005Pd-0f
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:21:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIBoU4055692;
 Fri, 31 Jul 2020 18:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=5L78Iy7PdvzE74L6wqxwIfW54qDEgeObBhE2Id4ITFY=;
 b=puw0PCIsMxYDmPDjY99DHa+e2pvAuqc+P2GOdPlBySkz3bMgzqm9EQbhoXAAfMo+Knl7
 txRK01F8lL+aU7Z598WE22QCumajTuIh4RyG/cVFOLLCP3TFhrBUwPmpdBXwFtDhNBKa
 BeWUumtF7GEUsaj2C6nDMcs8qYKDi7P3D1AOK/tCm+fVPLTBasf7v0R+FJs/J63bqMCB
 uBvXLSwk32q/34wuM1W6f62LeqLxWko1lhcFLJzBeDBRhbTYh0atbrAfnvW2K2zZHc/H
 cUGe/X0TM13KLrxJkRXdATtjmrQtLKYCpOQVaSif2t/9v7ph/OMegbtCRgRA7nUMgJ7V nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 32mf9g2tr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:20:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIIjqO080379;
 Fri, 31 Jul 2020 18:20:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 32mf70ve30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:57 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VIKt8L013585;
 Fri, 31 Jul 2020 18:20:56 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:55 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 13/20] multi-process: PCI BAR read/write handling for proxy
 & remote endpoints
Date: Fri, 31 Jul 2020 14:20:20 -0400
Message-Id: <3588624b278c97cb3c9d1eeda109ad36af39effc.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=1 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310136
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 14:20:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Proxy device object implements handler for PCI BAR writes and reads.
The handler uses BAR_WRITE/BAR_READ message to communicate to the
remote process with the BAR address and value to be written/read.
The remote process implements handler for BAR_WRITE/BAR_READ
message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/i386/remote-msg.c     | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/pci/proxy.c           | 61 +++++++++++++++++++++++++++++++++
 include/hw/pci/proxy.h   | 16 +++++++--
 include/io/mpqemu-link.h | 10 ++++++
 io/mpqemu-link.c         |  6 ++++
 5 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index c5b8651..7ccdd63 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -16,11 +16,14 @@
 #include "qapi/error.h"
 #include "sysemu/runstate.h"
 #include "hw/pci/pci.h"
+#include "exec/memattrs.h"
 
 static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
                                  MPQemuMsg *msg);
 static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
                                 MPQemuMsg *msg);
+static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
+static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
@@ -58,6 +61,12 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
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
         error_setg(&local_err,
                    "Unknown command (%d) received for device %s (pid=%d)",
@@ -127,3 +136,82 @@ static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
     }
 
 }
+
+static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp)
+{
+    BarAccessMsg *bar_access = &msg->data1.bar_access;
+    AddressSpace *as =
+        bar_access->memory ? &address_space_memory : &address_space_io;
+    MPQemuMsg ret = { 0 };
+    MemTxResult res;
+    uint64_t val;
+    Error *local_err = NULL;
+
+    if (!is_power_of_2(bar_access->size) ||
+       (bar_access->size > sizeof(uint64_t))) {
+        ret.data1.u64 = UINT64_MAX;
+        goto fail;
+    }
+
+    val = cpu_to_le64(bar_access->val);
+
+    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
+                           (void *)&val, bar_access->size, true);
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
+    mpqemu_msg_send(&ret, ioc, &local_err);
+    if (local_err) {
+        error_setg(errp, "Error while sending message to proxy "
+                   "in remote process pid=%d", getpid());
+    }
+}
+
+static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp)
+{
+    BarAccessMsg *bar_access = &msg->data1.bar_access;
+    MPQemuMsg ret = { 0 };
+    AddressSpace *as;
+    MemTxResult res;
+    uint64_t val = 0;
+    Error *local_err = NULL;
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
+fail:
+    ret.cmd = RET_MSG;
+    ret.data1.u64 = le64_to_cpu(val);
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, ioc, &local_err);
+    if (local_err) {
+        error_setg(errp, "Error while sending message to proxy "
+                   "in remote process pid=%d", getpid());
+    }
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 945cc35..179f0c7 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -133,3 +133,64 @@ static void pci_proxy_dev_register_types(void)
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
+    ret = mpqemu_msg_send_and_await_reply(&msg, pdev->ioc, &local_err);
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
index 0a66ddc..9d57483 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -17,10 +17,22 @@
 #define PCI_PROXY_DEV(obj) \
             OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
 
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
     QIOChannel *ioc;
-} PCIProxyDev;
+
+    ProxyMemoryRegion region[PCI_NUM_REGIONS];
+};
 
 #endif /* PROXY_H */
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 9bd754e..ee3b44f 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -36,6 +36,8 @@ typedef enum {
     RET_MSG,
     PCI_CONFIG_WRITE,
     PCI_CONFIG_READ,
+    BAR_WRITE,
+    BAR_READ,
     MAX = INT_MAX,
 } MPQemuCmd;
 
@@ -51,6 +53,13 @@ typedef struct {
     int l;
 } ConfDataMsg;
 
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
@@ -78,6 +87,7 @@ typedef struct {
     union {
         uint64_t u64;
         SyncSysmemMsg sync_sysmem;
+        BarAccessMsg bar_access;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 5d04b81..82b8465 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -269,6 +269,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case BAR_WRITE:
+    case BAR_READ:
+        if ((msg->size != sizeof(msg->data1)) || (msg->num_fds != 0)) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
1.8.3.1


