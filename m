Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E98C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE8A2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mdhCaUhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE8A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTOW-0006WJ-73
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGe-0000g8-T9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGc-0007ae-3M
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTGb-0007XD-7o
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CowD051979;
 Thu, 23 Apr 2020 04:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Nq8JJNPE/ddRppPxNqBkZ3aE/HE+FQO01xV+SojZhQo=;
 b=mdhCaUhpmcwY/xTaNcLEhLkosIAVEQNvHvZ1fVA0fkfoWHtOzzRgsEMBzcImW6uF4gxw
 F56ieGLlpnccHv2A9RLAKUUf/IrQT5ioEAoVYKb4u6ueQEfIfERSHkjt3tUtcJpORjwH
 QAnrwFX7NhViyEyBG5+AJwywhzcIeHQjwGiN4BWW6O1z4UqP4clVq8BrYifpDLxFadtJ
 Kd+1xhkAa5RUl72UjPNIE1r7HNO0GkJARj4mJD+ca8nhDmTt+RAuAQ32RUukmoIHSMpw
 A7w1nYeDeHU3s0ZCbu0QUo1pHGALG1J+h0+gpdFL9b36KLItKCODgS6eXSPLI2eKdlwM hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 30jhyc5430-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CZZ2156923;
 Thu, 23 Apr 2020 04:15:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 30gbbjtxxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:02 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4F1gX017766;
 Thu, 23 Apr 2020 04:15:01 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:15:01 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 20/36] multi-process: Forward PCI config space
 acceses to the remote process
Date: Wed, 22 Apr 2020 21:13:55 -0700
Message-Id: <901295bf44c731d232bb60579ffb48dce5b05cc4.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=1 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=1 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
index f780b65181..ef4a07b81a 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -381,6 +381,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
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
index f541baae6a..834574e172 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -53,6 +53,32 @@ gchar *print_pid_exec(gchar *str)
 
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
@@ -115,6 +141,12 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
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
         error_setg(&err, "Unknown command in %s", print_pid_exec(pid_exec));
         goto finalize_loop;
-- 
2.25.GIT


