Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADCFC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1873F2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cNuYhgM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1873F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwLk-000835-DE
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58755)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwB5-0005Yx-By
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwB1-0001pe-5E
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAz-0001j6-1K
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI9Ofj159576;
 Mon, 17 Jun 2019 18:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=wAbYWjTDPTNdGXz4juao/Kn/TenPE6WdVD5YQrfPQwc=;
 b=cNuYhgM88UND9sEqbVSNa/REfrBAiZsy4z77idHqVaPTfLNozuLzX9Q+m/YXJ28BX1fE
 CnfyjkrXJjqKF7aNsDv05HFx9zis9fr1NxKVw8QWg43Dp1R8zZvCMN2nQ3c5g5ERn5h3
 em7bH2ndV6DBp0ptCaz3Hl/7zvxG2x2QqBYeF4832WcYni2SxZZPvaJUVZF+9gFhHze9
 g8d3NFuxy/JhHL9O0ZV8nEZvMywkYqUu8YTK65Q6EbOgkHaYBwcVU4zXU6vn/HWzD/sc
 34HoJ+QUjsgQ7lDXqxLWUG4CmQBqyzJpHpQ4ftiduITep58JjzANmyhUEjJ+XKKfOt7y jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t4saq7yew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIEN2w175334;
 Mon, 17 Jun 2019 18:16:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgasa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIG5PR024976;
 Mon, 17 Jun 2019 18:16:05 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:05 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:02 -0700
Message-Id: <20190617181602.29817-1-elena.ufimtseva@oracle.com>
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
Subject: [Qemu-devel] [RFC PATCH v2 15/35] multi-process: PCI BAR read
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

Proxy device object implements the read handler for PCI BAR accesses.
The handler sends BAR_READ message to the remote process.
The remote process implements handler for BAR_READ message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 22 ++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  3 +++
 include/io/proxy-link.h       |  2 ++
 remote/remote-main.c          | 49 +++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 7f796a8e67..3ee3854f40 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -254,6 +254,7 @@ static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
                                 unsigned size, bool memory)
 {
     ProcMsg msg;
+    int wait;
 
     memset(&msg, 0, sizeof(ProcMsg));
 
@@ -266,9 +267,20 @@ static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
     if (write) {
         msg.cmd = BAR_WRITE;
         msg.data1.bar_access.val = *val;
+    } else {
+        wait = GET_REMOTE_WAIT;
+
+        msg.cmd = BAR_READ;
+        msg.num_fds = 1;
+        msg.fds[0] = wait;
     }
 
     proxy_proc_send(proxy_link, &msg);
+
+    if (!write) {
+        *val = wait_for_remote(wait);
+        PUT_REMOTE_WAIT(wait);
+    }
 }
 
 void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
@@ -276,3 +288,13 @@ void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
 {
     send_bar_access_msg(dev->proxy_link, mr, true, addr, &val, size, memory);
 }
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
index b717c8d767..a0db811de4 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -78,4 +78,7 @@ int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);
 void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
                              uint64_t val, unsigned size, bool memory);
 
+uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                                unsigned size, bool memory);
+
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 20bc217212..69074a3519 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -57,6 +57,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * CONF_WRITE       PCI config. space write
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  * BAR_WRITE        Writes to PCI BAR region
+ * BAR_READ         Reads from PCI BAR region
  *
  */
 typedef enum {
@@ -65,6 +66,7 @@ typedef enum {
     CONF_WRITE,
     SYNC_SYSMEM,
     BAR_WRITE,
+    BAR_READ,
     MAX,
 } proc_cmd_t;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 90e979289c..4372b71e89 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -93,6 +93,49 @@ static void process_bar_write(ProcMsg *msg, Error **errp)
     }
 }
 
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
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -125,6 +168,12 @@ static void process_msg(GIOCondition cond)
             goto finalize_loop;
         }
         break;
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
2.17.1


