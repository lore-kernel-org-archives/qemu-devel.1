Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E50C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365C92087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dezramlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365C92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMXU-0004M1-Dw
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOm-0001EA-8P
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOk-0007FP-6i
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI5YCW074703;
 Thu, 27 Aug 2020 18:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=/3WRQagG/Ahb18wqrweqnb5MhkmRO8i1HqN53aAY4p0=;
 b=dezramlOZ0HW5hQ0Zvdl9xn12+/gWemHp1l4OswY4COWAQE8apq9jYfZUhLFgVortP3e
 0eLb03Fx/icJdoomytOx311eGpWi145c0iSxJip5+62l4TpCn/tFFujXokfFfVSRRdZ/
 MRoE9hAHcpyAzTbE76p3xDNBKBG0Yi0IF8eJiBDB6AUq1V8/Zw9eH8/F6Z5Yfvb0BcsE
 4ZMtkTiKTUzZZeWMvTmPc0fW0NZ81J1Xbi4TLDkkW7bnIxi6xyGstUITgFcP1+hez+22
 V/wabkLE4jCJtoyEty7dIKTxuBqWPXwPIzr1nEkppEf7R9oEMEY69Y1y++0p6ziezljM AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 333w6u6hjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:13:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI5PnU187506;
 Thu, 27 Aug 2020 18:13:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 333r9njx9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:13:11 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RID9ik020905;
 Thu, 27 Aug 2020 18:13:10 GMT
Received: from flaka.hsd1.ca.comcast.net (/10.159.136.159)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:13:09 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v9 12/20] multi-process: add proxy communication functions
Date: Thu, 27 Aug 2020 11:12:23 -0700
Message-Id: <20200827181231.22778-13-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=1 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270136
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 14:08:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
---
 include/io/mpqemu-link.h |  4 ++++
 io/mpqemu-link.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index b348c658d1..62425b8f3b 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -15,6 +15,8 @@
 #include "qemu/thread.h"
 #include "io/channel.h"
 #include "exec/hwaddr.h"
+#include "io/channel-socket.h"
+#include "hw/pci/proxy.h"
 
 #define REMOTE_MAX_FDS 8
 
@@ -77,6 +79,8 @@ typedef struct MPQemuRequest MPQemuRequest;
 void mpqemu_msg_send_in_co(MPQemuRequest *req, QIOChannel *ioc, Error **errp);
 void mpqemu_msg_recv_in_co(MPQemuRequest *req, QIOChannel *ioc, Error **errp);
 
+uint64_t mpqemu_msg_send_and_await_reply(MPQemuMsg *msg, PCIProxyDev *pdev,
+                                         Error **errp);
 void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
 void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 0d1eaaca7f..f5f22267d1 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -17,6 +17,7 @@
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "io/channel.h"
 
 void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
 {
@@ -150,6 +151,43 @@ fail:
     }
 }
 
+uint64_t mpqemu_msg_send_and_await_reply(MPQemuMsg *msg, PCIProxyDev *pdev,
+                                         Error **errp)
+{
+    MPQemuMsg msg_reply = {0};
+    uint64_t ret = UINT64_MAX;
+    Error *local_err = NULL;
+
+    qemu_mutex_unlock_iothread();
+    qemu_mutex_lock(&pdev->io_mutex);
+
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
+    qemu_mutex_lock_iothread();
+
+    return ret;
+}
+
 static void coroutine_fn mpqemu_msg_send_co(void *data)
 {
     MPQemuRequest *req = (MPQemuRequest *)data;
-- 
2.25.GIT


