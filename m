Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60058C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2545C2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VOld4uj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2545C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fua-0002R4-NZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZp-0007Kx-Fb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZn-0000JD-Uh
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZn-0000IZ-Mq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXqVD062439;
 Tue, 3 Sep 2019 20:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=hUkMbLInRYnGpWuGCRLtrqZcj9Se8FIP4xcY/vwdo2E=;
 b=VOld4uj2kL90H4rukUx6/D/Oy6HUSC1tXMo3w6hZCFZLKaXzE6irRXi30FWb5oscdoO6
 JyjnrN9o6iRsytf8NV3znGqU4GB7X5sVCh/BWiTmxJnCzYxv3+wO5FkAFIYm80RotxU1
 oAsoh5JSX3krxKoApDGilhZidYHllXpe4aUHqd693lOr7jgXhBqsi0pmn/TulW41XLuD
 geQe3VA/Pauh13xxoDf4IF/Dzzboqug3qvS1ZHMG2di0LlRvNMFRx2hFnbTwVoeG8ikJ
 cKtPIPi9gGG855zffpbCWC7iIofFCvfIA6JNpTfYKn7jMYmMaHmCz8j95iVFzfJVdR4r ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2usy66r2e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcLHf188207;
 Tue, 3 Sep 2019 20:38:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2usu51182h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:48 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Kcm1L012337;
 Tue, 3 Sep 2019 20:38:48 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:47 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:42 -0400
Message-Id: <c47dcdb7ddfe7b274ddc5305921f0b7d7f4aed05.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 16/45] multi-process: PCI BAR read/write
 handling for proxy & remote endpoints
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
 hw/proxy/qemu-proxy.c         | 50 +++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  5 +++
 include/io/proxy-link.h       | 12 +++++++
 remote/remote-main.c          | 73 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index e5fd4bb..44668bf 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -287,3 +287,53 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
 }
+
+static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
+                                bool write, hwaddr addr, uint64_t *val,
+                                unsigned size, bool memory)
+{
+    ProcMsg msg;
+    int wait;
+
+    memset(&msg, 0, sizeof(ProcMsg));
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
+    proxy_proc_send(proxy_link, &msg, proxy_link->com);
+
+    if (!write) {
+        *val = wait_for_remote(wait);
+        PUT_REMOTE_WAIT(wait);
+    }
+}
+
+void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                             uint64_t val, unsigned size, bool memory)
+{
+    send_bar_access_msg(dev->proxy_link, mr, true, addr, &val, size, memory);
+}
+
+uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                                unsigned size, bool memory)
+{
+    uint64_t val;
+
+    send_bar_access_msg(dev->proxy_link, mr, false, addr, &val, size, memory);
+
+    return val;
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 3b37b65..a951570 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -77,5 +77,10 @@ typedef struct PCIProxyDevClass {
 
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);
 
+void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                             uint64_t val, unsigned size, bool memory);
+
+uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                                unsigned size, bool memory);
 
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 0785394..2c290b2 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -56,6 +56,8 @@ typedef struct ProxyLinkState ProxyLinkState;
  * CONF_READ        PCI config. space read
  * CONF_WRITE       PCI config. space write
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
+ * BAR_WRITE        Writes to PCI BAR region
+ * BAR_READ         Reads from PCI BAR region
  *
  */
 typedef enum {
@@ -63,6 +65,8 @@ typedef enum {
     CONF_READ,
     CONF_WRITE,
     SYNC_SYSMEM,
+    BAR_WRITE,
+    BAR_READ,
     MAX,
 } proc_cmd_t;
 
@@ -85,6 +89,13 @@ typedef struct {
 } sync_sysmem_msg_t;
 
 typedef struct {
+    hwaddr addr;
+    uint64_t val;
+    unsigned size;
+    bool memory;
+} bar_access_msg_t;
+
+typedef struct {
     proc_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -93,6 +104,7 @@ typedef struct {
     union {
         uint64_t u64;
         sync_sysmem_msg_t sync_sysmem;
+        bar_access_msg_t bar_access;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 93b2d36..43fe50a 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -45,6 +45,7 @@
 #include "qemu/config-file.h"
 #include "sysemu/sysemu.h"
 #include "block/block.h"
+#include "exec/memattrs.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -75,6 +76,66 @@ static void process_config_read(ProcMsg *msg)
     PUT_REMOTE_WAIT(wait);
 }
 
+/* TODO: confirm memtx attrs. */
+static void process_bar_write(ProcMsg *msg, Error **errp)
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
+static void process_bar_read(ProcMsg *msg, Error **errp)
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
 static void process_msg(GIOCondition cond, ProcChannel *chan)
 {
     ProcMsg *msg = NULL;
@@ -101,6 +162,18 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
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


