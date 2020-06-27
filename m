Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7602C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7259E20775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hAsU+TOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7259E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEQn-0000Gl-IZ
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELe-0008VR-Cm
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELc-0007BI-7S
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH31u6034898;
 Sat, 27 Jun 2020 17:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cpmn/SmI/LwjRmXxyhxkyqCczzoytGmIVE3OSnHrYRI=;
 b=hAsU+TOeBA4Z0o2jnglUkUA2PFjPARx++lKiUiV45BJna8CHniwYB4N6D0a1nLI7U7wV
 Y3ocFgkMrXxdH+cmR2tNnyUD3lji4OQP9vwL+h0IYhtW4aSMphu1+5h2eRbxpDATKnuJ
 VChgbCSC2iHo2PxOe8lAU9m9u8fFbbTgQPGd3Hm0zz+2r1GVpfYAKecTUN+7K9556ln6
 MzAHyW7YSg1MLDRIKqr1cr6VrR/dvCVZST6C/FqNOjobOLcVv9313h0tvKs+XEjBTBdb
 jnOeqbznqRzbsU+rLlICkc7UEldXRm8ouvVcLEfti22TryJopiEuwt3KR9gOL0mTAZat 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 31wwhr9ca1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH7dPX195436;
 Sat, 27 Jun 2020 17:10:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 31wu7s8yb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:27 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RHAPQu030702;
 Sat, 27 Jun 2020 17:10:26 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:25 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 19/21] multi-process: perform device reset in the remote
 process
Date: Sat, 27 Jun 2020 10:09:41 -0700
Message-Id: <609039447d2d5dc85f47a34c906e416b54341998.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 cotscore=-2147483648
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:03:10
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Perform device reset in the remote process when QEMU performs
device reset. This is required to reset the internal state
(like registers, etc...) of emulated devices

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/i386/remote-msg.c     | 16 ++++++++++++++++
 hw/pci/proxy.c           | 20 ++++++++++++++++++++
 include/io/mpqemu-link.h |  1 +
 3 files changed, 37 insertions(+)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 919bddc1d5..63d2be4701 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -11,6 +11,7 @@
 #include "exec/memattrs.h"
 #include "hw/i386/remote-memory.h"
 #include "hw/remote/iohub.h"
+#include "sysemu/reset.h"
 
 static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
                                     Error **errp);
@@ -23,6 +24,7 @@ static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
 static void process_get_pci_info_msg(QIOChannel *ioc, MPQemuMsg *msg,
                                      PCIDevice *pci_dev);
 static void process_proxy_ping_msg(QIOChannel *ioc);
+static void process_device_reset_msg(QIOChannel *ioc);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
@@ -80,6 +82,9 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     case PROXY_PING:
         process_proxy_ping_msg(ioc);
         break;
+    case DEVICE_RESET:
+        process_device_reset_msg(ioc);
+        break;
     default:
         error_setg(&local_err, "Unknown command (%d) received from proxy \
                    in remote process pid=%d", msg.cmd, getpid());
@@ -283,3 +288,14 @@ static void process_proxy_ping_msg(QIOChannel *ioc)
 
     mpqemu_msg_send(&ret, ioc);
 }
+
+static void process_device_reset_msg(QIOChannel *ioc)
+{
+    MPQemuMsg ret = { 0 };
+
+    qemu_devices_reset();
+
+    ret.cmd = RET_MSG;
+
+    mpqemu_msg_send(&ret, ioc);
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index e2e9a13287..9cba2bec65 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -26,6 +26,7 @@
 static void probe_pci_info(PCIDevice *dev);
 static void start_hb_timer(PCIProxyDev *dev);
 static void pci_proxy_dev_exit(PCIDevice *pdev);
+static void proxy_device_reset(DeviceState *dev);
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -198,6 +199,8 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     k->config_write = pci_proxy_write_config;
     k->exit = pci_proxy_dev_exit;
 
+    dc->reset = proxy_device_reset;
+
     device_class_set_props(dc, proxy_properties);
 }
 
@@ -414,3 +417,20 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
 
     stop_hb_timer(dev);
 }
+
+static void proxy_device_reset(DeviceState *dev)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    MPQemuMsg msg = { 0 };
+    Error *local_err = NULL;
+
+    msg.bytestream = 0;
+    msg.size = sizeof(msg.data1);
+    msg.cmd = DEVICE_RESET;
+
+    (void)mpqemu_msg_send_reply_co(&msg, pdev->com, &local_err);
+    if (local_err) {
+        error_report("Failed to send DEVICE_RESET to the remote process");
+    }
+
+}
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 676d7eb3ef..29dce60035 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -45,6 +45,7 @@ typedef enum {
     SET_IRQFD,
     GET_PCI_INFO,
     PROXY_PING,
+    DEVICE_RESET,
     MAX = INT_MAX,
 } MPQemuCmd;
 
-- 
2.25.GIT


