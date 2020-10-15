Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54721C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7772F20760
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZiWDefOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7772F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7uI-0007TU-8y
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dU-00007x-Lp
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dS-0002R9-Cg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4NcF037594;
 Thu, 15 Oct 2020 18:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=xCnEGhrzBntX6Y7ThJQZehBK22YQuH+drv/c/OOn3xs=;
 b=ZiWDefOWK4S07gkf3dVAS+AF1Kn95EwKHi9EMvf/1fhJHfBO98p/jeYSokbQ9L2Mntpz
 md9Lo0JeB5eyJ6D67AlXVHHZVuphIbRo6g4yUzJH3xGRjlSFkFzlcI53+b8y12uPmhTV
 eyzGSYjlNTu0tp4CHDfdY/p4wL2zbCz9U9dYSJp1R7iT4Y6PPC0406iJPKO3UaY3AWux
 t2N1yT3SBUUwsvYIZWL+SK70R0YgPO1wHvDxTDY+brMq66knhC22cmoRKw2H/UYoVvXd
 59BhsIDyrsoLPgZkN28enGUT6mEJlU9gBAvUPfyxJJl9oaPHQKtpejJrzl6rYJvj9x71 JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 3434wkx759-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:05:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI5Nq2133344;
 Thu, 15 Oct 2020 18:05:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 343pv262et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09FI5k0B026365;
 Thu, 15 Oct 2020 18:05:46 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:46 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 17/19] multi-process: perform device reset in the remote
 process
Date: Thu, 15 Oct 2020 14:05:10 -0400
Message-Id: <48c43de968f54f6156bd39f20b552d5da34a5d47.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=3 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=3 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:05:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
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
index a318a9f..82f1b4f 100644
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
index ccffddb..e5b74bb 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -25,6 +25,7 @@
 #include "util/event_notifier-posix.c"
 
 static void probe_pci_info(PCIDevice *dev, Error **errp);
+static void proxy_device_reset(DeviceState *dev);
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -198,6 +199,8 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 
+    dc->reset = proxy_device_reset;
+
     device_class_set_props(dc, proxy_properties);
 }
 
@@ -355,3 +358,20 @@ static void probe_pci_info(PCIDevice *dev, Error **errp)
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
index 4cf81f5..7462968 100644
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
1.8.3.1


