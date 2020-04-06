Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B74C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F52206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4oMxuUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F52206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOOk-0000JI-FE
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGm-00026E-80
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGk-0002Iw-Lw
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGk-0002H4-DN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369dnfo069764;
 Mon, 6 Apr 2020 09:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=4mO2dJF75SlZTMUcGzJgBWOZymNp9EgvlBVCh8v7ZU8=;
 b=m4oMxuUxSrbuaiVpyRW4oI7eWq3K3JPPnje5Mw/p8lM/oD3qzORqK9d1akk5WaK7t5dM
 4aBkYKN6gzMSAGZidXDv/KtudfdlRApW3hx1aSMnrNAJNQ2u/7h5lj9Lylukk8fcB2W0
 CVNMRjympEplXFT+ZsyTDNXh6BAvxToqXWbhBKUeYxIR/crdjeOG7NKl+2lJ2R9J1R8b
 W8bgkqSAeXENdtLdYeTP/yZNMVuhXi081zDX7mYQae1WAN4UNwVFrfK/CJ/KcJM1bgun
 tCdmiw6mQbktkbJpuDZVrZRHEl9ITuY/+BUiUK0GxMhN/eTNSJbbMYCqBkRh4DWZ4L7r iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 306j6m5tbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369fNjo066109;
 Mon, 6 Apr 2020 09:42:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 307419xh6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369g6Em031919;
 Mon, 6 Apr 2020 09:42:06 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:06 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 21/36] multi-process: PCI BAR read/write handling for proxy
 & remote endpoints
Date: Mon,  6 Apr 2020 02:41:11 -0700
Message-Id: <848b7213d9c1de43f5f5c8518a4f5bcd46faec7e.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
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
 hw/proxy/qemu-proxy.c         | 64 ++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h | 20 +++++++++-
 include/io/mpqemu-link.h      | 12 ++++++
 io/mpqemu-link.c              |  6 +++
 remote/remote-main.c          | 73 +++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 87cf39c672..7fd0a312a5 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -169,3 +169,67 @@ static void pci_proxy_dev_register_types(void)
 
 type_init(pci_proxy_dev_register_types)
 
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
+    mpqemu_msg_send(&msg, mpqemu_link->dev);
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
index d7eaf26f29..9e4127eccb 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -26,14 +26,25 @@
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
 
     MPQemuLinkState *mpqemu_link;
 
     int socket;
 
-} PCIProxyDev;
+    ProxyMemoryRegion region[PCI_NUM_REGIONS];
+};
 
 typedef struct PCIProxyDevClass {
     PCIDeviceClass parent_class;
@@ -43,4 +54,9 @@ typedef struct PCIProxyDevClass {
     char *command;
 } PCIProxyDevClass;
 
+void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size);
+
+uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size);
+
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 7228a1915e..41cf092f9e 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -31,6 +31,8 @@
 /**
  * mpqemu_cmd_t:
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
+ * BAR_WRITE        Writes to PCI BAR region
+ * BAR_READ         Reads from PCI BAR region
  *
  * proc_cmd_t enum type to specify the command to be executed on the remote
  * device.
@@ -41,6 +43,8 @@ typedef enum {
     CONNECT_DEV,
     PCI_CONFIG_WRITE,
     PCI_CONFIG_READ,
+    BAR_WRITE,
+    BAR_READ,
     MAX,
 } mpqemu_cmd_t;
 
@@ -56,6 +60,13 @@ typedef struct {
     ram_addr_t offsets[REMOTE_MAX_FDS];
 } sync_sysmem_msg_t;
 
+typedef struct {
+    hwaddr addr;
+    uint64_t val;
+    unsigned size;
+    bool memory;
+} bar_access_msg_t;
+
 /**
  * MPQemuMsg:
  * @cmd: The remote command
@@ -78,6 +89,7 @@ typedef struct {
     union {
         uint64_t u64;
         sync_sysmem_msg_t sync_sysmem;
+        bar_access_msg_t bar_access;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 643c0588ce..2b67ef6410 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -367,6 +367,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
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
diff --git a/remote/remote-main.c b/remote/remote-main.c
index b5ed31f63b..4f512aa5a8 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "block/block.h"
 #include "exec/ramlist.h"
+#include "exec/memattrs.h"
 
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan);
@@ -102,6 +103,66 @@ exit:
     notify_proxy(wait, ret);
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
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan)
 {
@@ -131,6 +192,18 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
     case PCI_CONFIG_READ:
         process_config_read(LINK_TO_DEV(link), msg);
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
2.25.GIT


