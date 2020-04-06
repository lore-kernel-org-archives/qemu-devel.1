Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1AC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8C4206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="peV0U3Ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8C4206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOUR-0002Tr-R7
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGv-0002WW-C1
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGu-0002PZ-1o
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGt-0002Or-Pq
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369dotd089403;
 Mon, 6 Apr 2020 09:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=bx0c6Hybu8iBv8fzwLbjyVA2WnIXvJlvCCBNV6FRf0M=;
 b=peV0U3MabJE4ngS3qBpnou4FPYS0r7UcUz+S80iXgVhAEab9Swi4oG21U1DpzIoMl/+F
 ue85EMPV0fXJH6wfyx7eUpQtiIbF4akKOLRkHd2QniG83apnKXprCo3kuaRm2NetaTvs
 kXkFe5MyCPi7C78IGwygThlbvJzZELZvd/RYiQeppe3NaaMYA2aOlTDCvUlJD6CxJo65
 n6ZyKbQTCyCylXgiwVojwQJLOS/O5pQAKjeWOW5fopRToS4KOM+1rAnqIy92knuwbH73
 zqgsJeq+GucFl3sl0zRbIKxeCCTdEg73iIRaKBRhy/uELNJgKWrwI9agDD3KnAdGSTVn dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 306hnqwtxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cVKr006344;
 Mon, 6 Apr 2020 09:42:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 3073xvtuv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369g5uN006940;
 Mon, 6 Apr 2020 09:42:05 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:04 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 20/36] multi-process: Forward PCI config space acceses to
 the remote process
Date: Mon,  6 Apr 2020 02:41:10 -0700
Message-Id: <7a75d79057f2c412230ea1dbac4debe3a7d8eba8.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=1
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

The Proxy Object sends the PCI config space accesses as messages
to the remote process over the communication channel

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c    | 61 ++++++++++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |  8 ++++++
 io/mpqemu-link.c         |  6 ++++
 remote/remote-main.c     | 32 +++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 9b5e429a88..87cf39c672 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -14,6 +14,65 @@
 #include "hw/proxy/qemu-proxy.h"
 #include "hw/pci/pci.h"
 
+static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
+                          unsigned int op)
+{
+    MPQemuMsg msg;
+    struct conf_data_msg conf_data;
+    int wait;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+    conf_data.addr = addr;
+    conf_data.val = (op == PCI_CONFIG_WRITE) ? *val : 0;
+    conf_data.l = l;
+
+    msg.data2 = (uint8_t *)&conf_data;
+    if (!msg.data2) {
+        return -ENOMEM;
+    }
+
+    msg.size = sizeof(conf_data);
+    msg.cmd = op;
+    msg.bytestream = 1;
+
+    if (op == PCI_CONFIG_WRITE) {
+        msg.num_fds = 0;
+    } else {
+        /* TODO: Dont create fd each time for send. */
+        wait = GET_REMOTE_WAIT;
+        msg.num_fds = 1;
+        msg.fds[0] = wait;
+    }
+
+    mpqemu_msg_send(&msg, dev->mpqemu_link->dev);
+
+    if (op == PCI_CONFIG_READ) {
+        *val = (uint32_t)wait_for_remote(wait);
+        PUT_REMOTE_WAIT(wait);
+    }
+
+    return 0;
+}
+
+static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int len)
+{
+    uint32_t val;
+
+    (void)pci_default_read_config(d, addr, len);
+
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, len, PCI_CONFIG_READ);
+
+    return val;
+}
+
+static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
+                                   int l)
+{
+    pci_default_write_config(d, addr, val, l);
+
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, l, PCI_CONFIG_WRITE);
+}
+
 static void proxy_set_socket(Object *obj, const char *str, Error **errp)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(obj);
@@ -86,6 +145,8 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
+    k->config_read = pci_proxy_read_config;
+    k->config_write = pci_proxy_write_config;
 }
 
 static const TypeInfo pci_proxy_dev_type_info = {
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index ebae9afc45..7228a1915e 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -39,9 +39,17 @@ typedef enum {
     INIT = 0,
     SYNC_SYSMEM,
     CONNECT_DEV,
+    PCI_CONFIG_WRITE,
+    PCI_CONFIG_READ,
     MAX,
 } mpqemu_cmd_t;
 
+struct conf_data_msg {
+    uint32_t addr;
+    uint32_t val;
+    int l;
+};
+
 typedef struct {
     hwaddr gpas[REMOTE_MAX_FDS];
     uint64_t sizes[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index b395869a22..643c0588ce 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -361,6 +361,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case PCI_CONFIG_WRITE:
+    case PCI_CONFIG_READ:
+        if (msg->size != sizeof(struct conf_data_msg)) {
+            return false;
+        }
+        break;
     default:
         break;
     }
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 22319cb5ea..b5ed31f63b 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -41,6 +41,32 @@ static MPQemuLinkState *mpqemu_link;
 
 #define LINK_TO_DEV(link) ((PCIDevice *)link->opaque)
 
+static void process_config_write(PCIDevice *dev, MPQemuMsg *msg)
+{
+    struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+
+    qemu_mutex_lock_iothread();
+    pci_default_write_config(dev, conf->addr, conf->val, conf->l);
+    qemu_mutex_unlock_iothread();
+}
+
+static void process_config_read(PCIDevice *dev, MPQemuMsg *msg)
+{
+    struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+    uint32_t val;
+    int wait;
+
+    wait = msg->fds[0];
+
+    qemu_mutex_lock_iothread();
+    val = pci_default_read_config(dev, conf->addr, conf->l);
+    qemu_mutex_unlock_iothread();
+
+    notify_proxy(wait, val);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static gpointer dev_thread(gpointer data)
 {
     MPQemuLinkState *link = data;
@@ -99,6 +125,12 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
     case CONNECT_DEV:
         process_connect_dev_msg(msg);
         break;
+    case PCI_CONFIG_WRITE:
+        process_config_write(LINK_TO_DEV(link), msg);
+        break;
+    case PCI_CONFIG_READ:
+        process_config_read(LINK_TO_DEV(link), msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
2.25.GIT


