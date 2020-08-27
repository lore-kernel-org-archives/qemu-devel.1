Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B6AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AE52087C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SbpoW62E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AE52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMZx-000119-GA
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMQU-0004Kj-O7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:15:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMQS-0007Tr-Ly
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:15:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RIE1n7026728;
 Thu, 27 Aug 2020 18:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=vtlz9TZYiG1jElOpp8FErUVrtr7azEzawPqqQsiEzg0=;
 b=SbpoW62E3zCLfrBY/+EkW8mu0WehbGxNkft6aWHxSX7gSMbzN6k4Buewk0MYnI6h9A7v
 PxVjRhDvLs7VlY94HGFE4BzhtmehumaYm1V94Q6gqPuyVmXLgrRodHYLoFlQCRsEP6PX
 fDcUHWfzO40Xj7oCJXvviAJ6Aiozy/1MoWv7ym1JHneToaXkTiNdSSlmStiWvQHkrkka
 D8wznzGS/vZa+GJbSwOxPXdQ5sHygcaMc4OK1vN4FRJY9vTbZ1cOovp3tyTBb7j4P62W
 iQ9uXvn75ZtzOU1CeSY17k/R1IKsAIVwjkmBB2mZsugNRocrqDzRft40PSUqrX3/ef6H 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 333dbs7yh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:14:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI5PIH187518;
 Thu, 27 Aug 2020 18:12:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 333r9njx1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:12:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07RICu6o021077;
 Thu, 27 Aug 2020 18:12:56 GMT
Received: from flaka.hsd1.ca.comcast.net (/10.159.136.159)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:12:55 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v9 07/20] multi-process: define transmission functions in
 remote
Date: Thu, 27 Aug 2020 11:12:18 -0700
Message-Id: <20200827181231.22778-8-elena.ufimtseva@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270137
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 14:13:10
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

remote process uses Qemu event loop and cannot block while
communicating with the remote proxy object.
This patch defines the co-routines to receive and send
messages to the proxy from remote process.

TODO: Avoid the aio_poll by entering the co-routines
from the higher level to avoid aio_poll.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 include/io/mpqemu-link.h |  12 +++++
 io/mpqemu-link.c         | 108 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index c7de8648bc..e02b5ce663 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -52,6 +52,18 @@ typedef struct {
     int num_fds;
 } MPQemuMsg;
 
+struct MPQemuRequest {
+    MPQemuMsg *msg;
+    QIOChannel *ioc;
+    bool finished;
+    int error;
+};
+
+typedef struct MPQemuRequest MPQemuRequest;
+
+void mpqemu_msg_send_in_co(MPQemuRequest *req, QIOChannel *ioc, Error **errp);
+void mpqemu_msg_recv_in_co(MPQemuRequest *req, QIOChannel *ioc, Error **errp);
+
 void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
 void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index d9be2bdeab..1dd776f81b 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -150,6 +150,114 @@ fail:
     }
 }
 
+static void coroutine_fn mpqemu_msg_send_co(void *data)
+{
+    MPQemuRequest *req = (MPQemuRequest *)data;
+    Error *local_err = NULL;
+
+    mpqemu_msg_send(req->msg, req->ioc, &local_err);
+    if (local_err) {
+        error_report("ERROR: failed to send command to remote %d, ",
+                     req->msg->cmd);
+        req->finished = true;
+        req->error = -EINVAL;
+        return;
+    }
+
+    req->finished = true;
+}
+
+void mpqemu_msg_send_in_co(MPQemuRequest *req, QIOChannel *ioc,
+                                  Error **errp)
+{
+    Coroutine *co;
+
+    if (!req->ioc) {
+        if (errp) {
+            error_setg(errp, "Channel is set to NULL");
+        } else {
+            error_report("Channel is set to NULL");
+        }
+        return;
+    }
+
+    req->error = 0;
+    req->finished = false;
+
+    co = qemu_coroutine_create(mpqemu_msg_send_co, req);
+    qemu_coroutine_enter(co);
+
+    while (!req->finished) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+
+    if (req->error) {
+        if (errp) {
+            error_setg(errp, "Error sending message to proxy, "
+                             "error %d", req->error);
+        } else {
+            error_report("Error sending message to proxy, "
+                         "error %d", req->error);
+        }
+    }
+
+    return;
+}
+
+static void coroutine_fn mpqemu_msg_recv_co(void *data)
+{
+    MPQemuRequest *req = (MPQemuRequest *)data;
+    Error *local_err = NULL;
+
+    mpqemu_msg_recv(req->msg, req->ioc, &local_err);
+    if (local_err) {
+        error_report("ERROR: failed to send command to remote %d, ",
+                     req->msg->cmd);
+        req->finished = true;
+        req->error = -EINVAL;
+        return;
+    }
+
+    req->finished = true;
+}
+
+void mpqemu_msg_recv_in_co(MPQemuRequest *req, QIOChannel *ioc,
+                               Error **errp)
+{
+    Coroutine *co;
+
+    if (!req->ioc) {
+        if (errp) {
+            error_setg(errp, "Channel is set to NULL");
+        } else {
+            error_report("Channel is set to NULL");
+        }
+        return;
+    }
+
+    req->error = 0;
+    req->finished = false;
+
+    co = qemu_coroutine_create(mpqemu_msg_recv_co, req);
+    qemu_coroutine_enter(co);
+
+    while (!req->finished) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+
+    if (req->error) {
+        if (errp) {
+            error_setg(errp, "Error sending message to proxy, "
+                             "error %d", req->error);
+        } else {
+            error_report("Error sending message to proxy, "
+                         "error %d", req->error);
+        }
+    }
+
+    return;
+}
+
 bool mpqemu_msg_valid(MPQemuMsg *msg)
 {
     if (msg->cmd >= MAX && msg->cmd < 0) {
-- 
2.25.GIT


