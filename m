Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106D42177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X8ICOz0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106D42177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMSa-0006Cs-8d
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOs-0001Ug-DC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOp-0007GI-St
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI5pS8006327;
 Thu, 27 Aug 2020 18:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=yosw9lIeZh2bU6VAK0dhj8NKodY2ofoCmitoQc0cLSo=;
 b=X8ICOz0bQOif4L94IsxPdfa0+OHqfxENL8BAQJbeLemx4nrfb95O37Zodb67zinBuC1i
 s6LWjqMAB03DHLWJngXpfSohIkgA5cKUfzNFkNFar5BrpquDHjF+lUEhKNEUrimimC1F
 nzYZO6XnSMZatQ7rJI2O4VYHfaVX0wqMunLnLsF81RTYRRzGm9wsJK2WkG+252PTex/U
 tdVoM9jANQ34fgQfkCL1j2jv3arlnhqP35Ylb2WcN89To61pRODc50WXLoxQWxYo2tig
 mfgdoVcasloteO65F+s4lAbi/SfUuQyCcsHjWmf9rJLNLG22zKmg2mcrBowpd+BgVX6T 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 333dbs7y9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:13:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI4t4G072596;
 Thu, 27 Aug 2020 18:13:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 333r9nqyyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:13:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RIDFrx020974;
 Thu, 27 Aug 2020 18:13:15 GMT
Received: from flaka.hsd1.ca.comcast.net (/10.159.136.159)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:13:15 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v9 14/20] multi-process: PCI BAR read/write handling for proxy
 & remote endpoints
Date: Thu, 27 Aug 2020 11:12:25 -0700
Message-Id: <20200827181231.22778-15-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270136
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 14:13:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
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
 hw/i386/remote-msg.c     | 94 ++++++++++++++++++++++++++++++++++++++++
 hw/pci/proxy.c           | 64 ++++++++++++++++++++++++++-
 include/hw/pci/proxy.h   | 16 ++++++-
 include/io/mpqemu-link.h | 10 +++++
 io/mpqemu-link.c         |  6 +++
 5 files changed, 186 insertions(+), 4 deletions(-)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 322c1888a3..841c681d76 100644
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
@@ -62,6 +65,12 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
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
@@ -134,3 +143,88 @@ static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
                      getpid());
     }
 }
+
+static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp)
+{
+    BarAccessMsg *bar_access = &msg->data.bar_access;
+    AddressSpace *as =
+        bar_access->memory ? &address_space_memory : &address_space_io;
+    MPQemuMsg ret = { 0 };
+    MPQemuRequest req = { 0 };
+    MemTxResult res;
+    uint64_t val;
+    Error *local_err = NULL;
+
+    if (!is_power_of_2(bar_access->size) ||
+       (bar_access->size > sizeof(uint64_t))) {
+        ret.data.u64 = UINT64_MAX;
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
+        ret.data.u64 = -1;
+    }
+
+fail:
+    ret.cmd = RET_MSG;
+    ret.size = sizeof(ret.data.u64);
+
+    req.ioc = ioc;
+    req.msg = &ret;
+
+    mpqemu_msg_send_in_co(&req, ioc, (errp && *errp) ? NULL : &local_err);
+    if (local_err) {
+        error_setg(errp, "Error while sending message to proxy "
+                   "in remote process pid=%d", getpid());
+    }
+}
+
+static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp)
+{
+    BarAccessMsg *bar_access = &msg->data.bar_access;
+    MPQemuMsg ret = { 0 };
+    MPQemuRequest req = { 0 };
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
+    }
+
+fail:
+    ret.cmd = RET_MSG;
+    ret.data.u64 = le64_to_cpu(val);
+    ret.size = sizeof(ret.data.u64);
+
+    req.ioc = ioc;
+    req.msg = &ret;
+    mpqemu_msg_send_in_co(&req, ioc, (errp && *errp) ? NULL : &local_err);
+    if (local_err) {
+        error_setg(errp, "Error while sending message to proxy "
+                   "in remote process pid=%d", getpid());
+    }
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 23aab44d8e..d332c63bf3 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -61,7 +61,7 @@ static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
                           int l, unsigned int op)
 {
     MPQemuMsg msg = { 0 };
-    long ret = -EINVAL;
+    uint64_t ret = -EINVAL;
     Error *local_err = NULL;
 
     msg.cmd = op;
@@ -72,7 +72,7 @@ static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
 
     ret = mpqemu_msg_send_and_await_reply(&msg, pdev, &local_err);
     if (local_err) {
-        error_report("Failed to exchange PCI_CONFIG message with remote");
+        error_report_err(local_err);
     }
     if (op == PCI_CONFIG_READ) {
         *val = (uint32_t)ret;
@@ -132,3 +132,63 @@ static void pci_proxy_dev_register_types(void)
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
+    msg.size = sizeof(BarAccessMsg);
+    msg.data.bar_access.addr = mr->addr + addr;
+    msg.data.bar_access.size = size;
+    msg.data.bar_access.memory = memory;
+
+    if (write) {
+        msg.cmd = BAR_WRITE;
+        msg.data.bar_access.val = *val;
+    } else {
+        msg.cmd = BAR_READ;
+    }
+
+    ret = mpqemu_msg_send_and_await_reply(&msg, pdev, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
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
+        .max_access_size = 8,
+    },
+};
diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
index 4ae7becf34..e5e18f0b15 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -17,7 +17,17 @@
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
 
@@ -29,6 +39,8 @@ typedef struct PCIProxyDev {
      */
     QemuMutex io_mutex;
     QIOChannel *ioc;
-} PCIProxyDev;
+
+    ProxyMemoryRegion region[PCI_NUM_REGIONS];
+};
 
 #endif /* PROXY_H */
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index a0ffedcdb1..967ae24e3a 100644
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
  * MPQemuMsg:
  * @cmd: The remote command
@@ -70,6 +79,7 @@ typedef struct {
         uint64_t u64;
         ConfDataMsg conf_data;
         SyncSysmemMsg sync_sysmem;
+        BarAccessMsg bar_access;
     } data;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index af9f536660..9233df215e 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -328,6 +328,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case BAR_WRITE:
+    case BAR_READ:
+        if ((msg->size != sizeof(BarAccessMsg)) || (msg->num_fds != 0)) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.25.GIT


