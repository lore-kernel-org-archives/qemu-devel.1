Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828BBC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6CA22240
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lw5SvX41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6CA22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7hU-0004oF-QS
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dO-0008Kr-Cg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dL-0002LQ-1F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI3rmY104142;
 Thu, 15 Oct 2020 18:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=JgXq+3vipbibpaJbMd5WCbZxMYDqe61vsLgYUThkPdk=;
 b=lw5SvX41z8dT/Fq4P6qvk/42sGka0ccmyPcTTvupVgHSXs/sMK8l5kUGwqIyBO1cvq5f
 P+RSaBY74sF9Msxemgk/qcbO0P2zPjQoFB22g+4CzOZVieg3EN99oRObS2JD2rCUUW7D
 sl5YCDQ8DcgWIbg/whdlTNmhOn4i9XEB7G0cjl7zgxCbi9QmC9eEtYswwup3Y3ALE5ol
 AmcPTiIizOa88rpH1mJ5SgHJ5woyWJdRz9H7ExbHBe0HJBotkQpfggM+0pJzHCnJjSLR
 xZEVNI94Wk1wQ3LR8en/yJLWtaqXClDBnYZOxtsfgFRHJhgSqiX6OpvoxrenF3TWcGz0 Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 343vaemhms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:05:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4epD184521;
 Thu, 15 Oct 2020 18:05:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 343pw0qhbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:39 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FI5bYx002142;
 Thu, 15 Oct 2020 18:05:38 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:37 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 11/19] multi-process: add proxy communication functions
Date: Thu, 15 Oct 2020 14:05:04 -0400
Message-Id: <b2be9c456d863225cd6ae8dbde8f0ff6e5247dcd.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=1 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:05:35
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

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/io/mpqemu-link.h |  4 ++++
 io/mpqemu-link.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index e33181a..4bea5da 100644
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
index b30e27c..1339cc7 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -17,6 +17,7 @@
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "io/channel.h"
 
 /*
  * Send message over the ioc QIOChannel.
@@ -214,6 +215,43 @@ fail:
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
1.8.3.1


