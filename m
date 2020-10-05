Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2FFC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AAF20853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DBZmGkHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AAF20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVi5-00075W-2b
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 14:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVcD-00005U-Px
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:53:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVcA-0008Eu-1w
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:53:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095InrtC076457;
 Mon, 5 Oct 2020 18:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Zob/CAQNpsA6Cc4lW9xePRMMGl4iruYiIHIocoF1NGA=;
 b=DBZmGkHFNVZFCVDO/orQV7C7p5YHryC+APo/Bb4UZHp0XSPyN+PqGPvLRZmNW1s/fAMQ
 mV2ACJYRyTcEq6kIlYXjJqw4hwSwjSb8i6Wc+z4YC+eZVOoZ6QNCDiM29pZZg4IaAmUk
 vDbCy/ksV7o17mfPP3RZYyKtGgUjWkaXQwNih+NniJU7M+DXvKq85tntT5rO31oe9xcK
 OIW63QGC0u/kV6FZxXkAd3yPBmxBYp82J+3oysgw2o5pwB92IpCG6JMU97AvrDU0cwFC
 FJog+ydGBT8MQY4fcOwh53C+/RnWmrhYHPpr+Z083lqNUUbgN7w9GqsvNurdDDGw8oxs KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 33ym34ca5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:53:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095Ip6Y6026125;
 Mon, 5 Oct 2020 18:51:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 33yyje8pcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:30 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 095IpTAo014474;
 Mon, 5 Oct 2020 18:51:29 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:28 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 11/19] multi-process: add proxy communication functions
Date: Mon,  5 Oct 2020 11:50:59 -0700
Message-Id: <3839485584bff489f33041f2c51f51c01617b907.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=1 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 14:51:29
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

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/io/mpqemu-link.h |  4 ++++
 io/mpqemu-link.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index e33181ad80..4bea5daeb4 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -15,6 +15,8 @@
 #include "qemu/thread.h"
 #include "io/channel.h"
 #include "exec/hwaddr.h"
+#include "io/channel-socket.h"
+#include "hw/pci/proxy.h"
 
 #define REMOTE_MAX_FDS 8
 
@@ -65,6 +67,8 @@ typedef struct {
     int num_fds;
 } QEMU_PACKED MPQemuMsg;
 
+uint64_t mpqemu_msg_send_and_await_reply(MPQemuMsg *msg, PCIProxyDev *pdev,
+                                         Error **errp);
 void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
 void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 8d966820a0..618061753b 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -17,6 +17,7 @@
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "io/channel.h"
 
 /*
  * Send message over the ioc QIOChannel.
@@ -207,6 +208,43 @@ fail:
     }
 }
 
+/*
+ * Called from VCPU thread in non-coroutine context.
+ */
+uint64_t mpqemu_msg_send_and_await_reply(MPQemuMsg *msg, PCIProxyDev *pdev,
+                                         Error **errp)
+{
+    MPQemuMsg msg_reply = {0};
+    uint64_t ret = UINT64_MAX;
+    Error *local_err = NULL;
+
+    qemu_mutex_lock(&pdev->io_mutex);
+    mpqemu_msg_send(msg, pdev->ioc, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto exit_send;
+    }
+
+    mpqemu_msg_recv(&msg_reply, pdev->ioc, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto exit_send;
+    }
+
+    if (!mpqemu_msg_valid(&msg_reply) || msg_reply.cmd != RET_MSG) {
+        error_setg(errp, "ERROR: Invalid reply received for command %d",
+                         msg->cmd);
+        goto exit_send;
+    } else {
+        ret = msg_reply.data.u64;
+    }
+
+ exit_send:
+    qemu_mutex_unlock(&pdev->io_mutex);
+
+    return ret;
+}
+
 bool mpqemu_msg_valid(MPQemuMsg *msg)
 {
     if (msg->cmd >= MPQEMU_CMD_MAX && msg->cmd < 0) {
-- 
2.25.GIT


