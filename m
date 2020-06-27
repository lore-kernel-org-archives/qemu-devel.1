Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D319A20775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQfhh2HY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319A20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEP5-0005Kz-4O
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELO-0007sD-J8
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELM-00072c-8U
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH2Drf172511;
 Sat, 27 Jun 2020 17:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=DdiHkcF1a1OvCm4mH1Raimaz9o81BvEMG0ge/LUn5w4=;
 b=OQfhh2HYWLcbXAOASs+dasu7NqaY7a7CYfYCQGopJSQip0AB7GYf6RtuTUf9AzHNHdPn
 08jg3+N1z4mNMC57SZgzw6+1sszaqqJL15LOQBbmpJ5no6N8zyz960E5utCCUvWKIb3q
 +d1hbJKg1JlJ6qRw3XGyUUNBAyNUzjqpmkQMQEVwYV+uFdR5fAz4Chldfu7vXckxeGX7
 LMgCjGbcYjH8L51fJakuRJcuSV6z2Qkpk9vMhG2lFR8sfRFKKCV6FWpj8MbMpFqWZSgK
 3yi2Sd6ZJNXaJIKBC92BqTSzMo6fMmN5uqHDuO97L0iAw9ONYwkoq0Utl+1HrnVlbVRJ YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 31wxrms98a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8F09080786;
 Sat, 27 Jun 2020 17:10:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 31wv59awma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:11 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05RHA9r0002924;
 Sat, 27 Jun 2020 17:10:09 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:09 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/21] multi-process: Connect Proxy Object with device in
 the remote process
Date: Sat, 27 Jun 2020 10:09:34 -0700
Message-Id: <20f42fce1b701586a23c9abdb3b53d080845e94a.1593273671.git.elena.ufimtseva@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270123
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:10:10
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

Send a message to the remote process to connect PCI device with the
corresponding Proxy object in QEMU

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/i386/remote-msg.c     | 39 +++++++++++++++++++++++++++++++++++++++
 hw/pci/proxy.c           | 28 ++++++++++++++++++++++++++++
 include/hw/pci/proxy.h   |  1 +
 include/io/mpqemu-link.h |  1 +
 io/mpqemu-link.c         |  8 ++++++++
 5 files changed, 77 insertions(+)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 58e24ab2ad..68f50866bb 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -6,6 +6,11 @@
 #include "io/mpqemu-link.h"
 #include "qapi/error.h"
 #include "sysemu/runstate.h"
+#include "io/channel-util.h"
+#include "hw/pci/pci.h"
+
+static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
+                                    Error **errp);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
@@ -34,6 +39,9 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     }
 
     switch (msg.cmd) {
+    case CONNECT_DEV:
+        process_connect_dev_msg(&msg, ioc, &local_err);
+        break;
     default:
         error_setg(&local_err, "Unknown command (%d) received from proxy \
                    in remote process pid=%d", msg.cmd, getpid());
@@ -50,3 +58,34 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
 
     return TRUE;
 }
+
+static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
+                                    Error **errp)
+{
+    char *devid = (char *)msg->data2;
+    QIOChannel *dioc = NULL;
+    DeviceState *dev = NULL;
+    MPQemuMsg ret = { 0 };
+    int rc = 0;
+
+    g_assert(devid && (devid[msg->size - 1] == '\0'));
+
+    dev = qdev_find_recursive(sysbus_get_default(), devid);
+    if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        rc = 0xff;
+        goto exit;
+    }
+
+    dioc = qio_channel_new_fd(msg->fds[0], errp);
+
+    qio_channel_add_watch(dioc, G_IO_IN | G_IO_HUP, mpqemu_process_msg,
+                          (void *)dev, NULL);
+
+exit:
+    ret.cmd = RET_MSG;
+    ret.bytestream = 0;
+    ret.data1.u64 = rc;
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, com);
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 6d62399c52..16649ed0ec 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -15,10 +15,38 @@
 #include "io/channel-util.h"
 #include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
+#include "io/mpqemu-link.h"
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
+    DeviceState *dev = DEVICE(pdev);
+    MPQemuMsg msg = { 0 };
+    int fds[2];
+    Error *local_err = NULL;
+
     pdev->com = qio_channel_new_fd(fd, errp);
+
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds)) {
+        error_setg(errp, "Failed to create proxy channel with fd %d", fd);
+        return;
+    }
+
+    msg.cmd = CONNECT_DEV;
+    msg.bytestream = 1;
+    msg.data2 = (uint8_t *)dev->id;
+    msg.size = strlen(dev->id) + 1;
+    msg.num_fds = 1;
+    msg.fds[0] = fds[1];
+
+    (void)mpqemu_msg_send_reply_co(&msg, pdev->com, &local_err);
+    if (local_err) {
+        error_setg(errp, "Failed to send DEV_CONNECT to the remote process");
+        close(fds[0]);
+    } else {
+        pdev->dev = qio_channel_new_fd(fds[0], errp);
+    }
+
+    close(fds[1]);
 }
 
 static Property proxy_properties[] = {
diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
index c1c7142fa2..72dd7e0944 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -30,6 +30,7 @@ typedef struct PCIProxyDev {
     PCIDevice parent_dev;
     char *fd;
     QIOChannel *com;
+    QIOChannel *dev;
 } PCIProxyDev;
 
 typedef struct PCIProxyDevClass {
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index c6d2b6bf8b..d620806c17 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -36,6 +36,7 @@
 typedef enum {
     INIT = 0,
     SYNC_SYSMEM,
+    CONNECT_DEV,
     RET_MSG,
     MAX = INT_MAX,
 } MPQemuCmd;
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 5887c8c6c0..54df3b254e 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -234,6 +234,14 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case CONNECT_DEV:
+        if ((msg->num_fds != 1) ||
+            (msg->fds[0] == -1) ||
+            (msg->fds[0] == -1) ||
+            !msg->bytestream) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.25.GIT


