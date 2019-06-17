Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4658CC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144662084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wf4rjmX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144662084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwHg-0003ym-BW
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAy-0005U3-6Q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAv-0001lX-3s
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAr-0001hA-Cy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8tMn159137;
 Mon, 17 Jun 2019 18:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=QAbbsNXjuZnlhha+vIc2Ur6Q0CBLGlGcdmYuVa78Qss=;
 b=Wf4rjmX5AKj+w6lOTfNDuSdHvrePslXKgfH8SXK+iUkpoFz95uz4cF7ogxD0HyZWH+lk
 Z1b/95qHaeCMHCBbqBpSsyLDe+icN8rgEYr2Si4jptczKzXAMHvlhFHrRxOFRS81VrIX
 l1Rinb732SKKDKR7LxHBiDGiuB6k601ZSO7hnMSPxZKQLr5zZHoX4gjFk5wWfPhC0QlW
 GxSLc7NmNDgcuvsy0ZYaxhuhDTXwpR1hAPU0ah8g7diMGQQUI7LfGtI4q5Vt7U7yRriI
 vt2f3rNVeDr4i0D0UmBD5fWSdbvT7ZlTlqMy0D5Gjdacic9CdS3BkKuf94pZhN1ejoBF ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t4saq7yep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF5Ce050134;
 Mon, 17 Jun 2019 18:16:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t5h5t9fhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIG2o7024949;
 Mon, 17 Jun 2019 18:16:02 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:02 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:15:59 -0700
Message-Id: <20190617181559.29770-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC PATCH v2 14/35] multi-process: PCI BAR write
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, berrange@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Proxy device object implements handler for PCI BAR writes. The handler
sends BAR_WRITE message to the remote process with the BAR address and
value to be written
The remote process implements handler for BAR_WRITE message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 28 ++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  2 ++
 include/io/proxy-link.h       | 10 ++++++++++
 remote/remote-main.c          | 24 ++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 6ae584b5ad..7f796a8e67 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -248,3 +248,31 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
 }
+
+static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
+                                bool write, hwaddr addr, uint64_t *val,
+                                unsigned size, bool memory)
+{
+    ProcMsg msg;
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
+    }
+
+    proxy_proc_send(proxy_link, &msg);
+}
+
+void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                             uint64_t val, unsigned size, bool memory)
+{
+    send_bar_access_msg(dev->proxy_link, mr, true, addr, &val, size, memory);
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 911da6a306..b717c8d767 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -75,5 +75,7 @@ typedef struct PCIProxyDevClass {
 
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);
 
+void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                             uint64_t val, unsigned size, bool memory);
 
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index e9efe531ad..20bc217212 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -56,6 +56,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * CONF_READ        PCI config. space read
  * CONF_WRITE       PCI config. space write
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
+ * BAR_WRITE        Writes to PCI BAR region
  *
  */
 typedef enum {
@@ -63,6 +64,7 @@ typedef enum {
     CONF_READ,
     CONF_WRITE,
     SYNC_SYSMEM,
+    BAR_WRITE,
     MAX,
 } proc_cmd_t;
 
@@ -84,6 +86,13 @@ typedef struct {
     ram_addr_t offsets[REMOTE_MAX_FDS];
 } sync_sysmem_msg_t;
 
+typedef struct {
+    hwaddr addr;
+    uint64_t val;
+    unsigned size;
+    bool memory;
+} bar_access_msg_t;
+
 typedef struct {
     proc_cmd_t cmd;
     int bytestream;
@@ -92,6 +101,7 @@ typedef struct {
     union {
         uint64_t u64;
         sync_sysmem_msg_t sync_sysmem;
+        bar_access_msg_t bar_access;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/remote/remote-main.c b/remote/remote-main.c
index bb0d5f5178..90e979289c 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -45,6 +45,7 @@
 #include "qemu/config-file.h"
 #include "sysemu/sysemu.h"
 #include "block/block.h"
+#include "exec/memattrs.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -75,6 +76,23 @@ static void process_config_read(ProcMsg *msg)
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
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -101,6 +119,12 @@ static void process_msg(GIOCondition cond)
     case CONF_READ:
         process_config_read(msg);
         break;
+    case BAR_WRITE:
+        process_bar_write(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
2.17.1


