Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63271C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D5320FC3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xDJqp3P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D5320FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVlW-0001wl-EZ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVcP-0000Er-Kn
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:53:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVcN-0008FV-J1
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:53:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095InLLw184425;
 Mon, 5 Oct 2020 18:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=e/7JWEBlF6H0N6DheP+WdOmqN7+fCY+mSCzFs/7zbt8=;
 b=xDJqp3P5yNjiOqucKUpY8vIJsAgs+nMEXXNgaK+3Vutq3dEXJKPgmBMxINeWotEe1nz8
 RMk5bcTRciGS+NXPjT/b96DBh55yjRTRilF7ImThMNdPnS0IussqXhNZ2b5/4b6xOWoh
 Gt+s/iam2PwwbzfW7lWvbE2srPLj6DzdjfXfycp8GChty93WgKOMabxhP32d4D1Stcwx
 Hquj+F1e2ySpNN8bIEIA4TWR+zGcJWmMbOFsiza+hYvBNfIRbm6cO4OGzHulOqpMHXyr
 jGghaJAlndP0s+/Iq6swAhsCut75Gy6VsgxUpoKEnb3otNop0S+Xnt4LOj2XLKIeuLlC sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 33xhxmq5gs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:53:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095Ip6Ab026139;
 Mon, 5 Oct 2020 18:51:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 33yyje8pnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:40 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 095Ipd9A032260;
 Mon, 5 Oct 2020 18:51:39 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:38 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 17/19] multi-process: perform device reset in the remote
 process
Date: Mon,  5 Oct 2020 11:51:05 -0700
Message-Id: <dc5360232cf4fbb9191338d037ff6ddd452d9af2.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=3 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:40:53
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Perform device reset in the remote process when QEMU performs
device reset. This is required to reset the internal state
(like registers, etc...) of emulated devices

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/i386/remote-msg.c     | 23 ++++++++++++++++++++++-
 hw/pci/proxy.c           | 20 ++++++++++++++++++++
 include/io/mpqemu-link.h |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index a318a9ff91..82f1b4f2a0 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -19,6 +19,7 @@
 #include "exec/memattrs.h"
 #include "hw/i386/remote-memory.h"
 #include "hw/i386/remote-iohub.h"
+#include "sysemu/reset.h"
 
 static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
                                  MPQemuMsg *msg);
@@ -26,6 +27,8 @@ static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
                                 MPQemuMsg *msg);
 static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
 static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
+static void process_device_reset_msg(QIOChannel *ioc, PCIDevice *dev,
+                                     Error **errp);
 
 void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
 {
@@ -72,7 +75,9 @@ void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
         case SET_IRQFD:
             process_set_irqfd_msg(pci_dev, &msg);
             break;
-
+        case DEVICE_RESET:
+            process_device_reset_msg(com->ioc, pci_dev, &local_err);
+            break;
         default:
             error_setg(&local_err,
                        "Unknown command (%d) received for device %s (pid=%d)",
@@ -218,3 +223,19 @@ fail:
                    "in remote process pid=%d", getpid());
     }
 }
+
+static void process_device_reset_msg(QIOChannel *ioc, PCIDevice *dev,
+                                     Error **errp)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    DeviceState *s = DEVICE(dev);
+    MPQemuMsg ret = { 0 };
+
+    if (dc->reset) {
+        dc->reset(s);
+    }
+
+    ret.cmd = RET_MSG;
+
+    mpqemu_msg_send(&ret, ioc, errp);
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 1e4b18e5b2..90d588b43c 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -25,6 +25,7 @@
 #include "util/event_notifier-posix.c"
 
 static void probe_pci_info(PCIDevice *dev, Error **errp);
+static void proxy_device_reset(DeviceState *dev);
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -194,6 +195,8 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 
+    dc->reset = proxy_device_reset;
+
     device_class_set_props(dc, proxy_properties);
 }
 
@@ -351,3 +354,20 @@ static void probe_pci_info(PCIDevice *dev, Error **errp)
         }
     }
 }
+
+static void proxy_device_reset(DeviceState *dev)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    MPQemuMsg msg = { 0 };
+    Error *local_err = NULL;
+
+    msg.cmd = DEVICE_RESET;
+    msg.size = 0;
+
+    (void)mpqemu_msg_send_and_await_reply(&msg, pdev, &local_err);
+    if (local_err) {
+        error_report("Failed to send DEVICE_RESET to the remote process");
+        error_free(local_err);
+    }
+
+}
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 4cf81f5237..746296885a 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -39,6 +39,7 @@ typedef enum {
     BAR_WRITE,
     BAR_READ,
     SET_IRQFD,
+    DEVICE_RESET,
     MPQEMU_CMD_MAX,
 } MPQemuCmd;
 
-- 
2.25.GIT


