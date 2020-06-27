Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E95C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643D5206E9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m2hpGBy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643D5206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEMm-00018U-Jx
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELJ-0007is-4B
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELF-00071C-K2
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH2ddK172581;
 Sat, 27 Jun 2020 17:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=f38bVO2T0ONvo//Y6Y+Hxg6hHWZdhZGpu1r3zOSMW8c=;
 b=m2hpGBy41ciROyvLI+U6z8KFeBG/dH0BdsNTnxJX+R0RCTpjdxRNQJjsiY+anuCyXyEC
 qVTvxvWvUMzqLyu9UGr7yN4d4Zi6KbwBg8g/bguv3R/xP5lWy6VAL4Ms0q8eqi771+YV
 41dPlJP7cj3fqzo5eHr6WR31KsHcPwOXTiPvRng1SA7UJZihZxVhQBUw6SOfB+1vsm7/
 0ZSEpWJ+vLgDQ5J5EaDgKWN9AWkmhuCEr0Z+Who0J6V4nqLH9qm5hL2UoyfGWPpxiFI2
 rERylLaV0KZbxKyxHXs/0+ZUHZ70REOfrIDqQ8t91f1zK7ksRGOTiSJ3uoql2GPFKLRP yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 31wxrms97w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8PEb102161;
 Sat, 27 Jun 2020 17:10:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 31wwx17sea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RH9xf9030585;
 Sat, 27 Jun 2020 17:09:59 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:09:59 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/21] multi-process: add co-routines to communicate with
 remote
Date: Sat, 27 Jun 2020 10:09:29 -0700
Message-Id: <d7013c71ba09fb73bc61a725088bebd91f0fda30.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=15
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=15 spamscore=0 classifier=spam adjust=0
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
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

process to avoid blocking the main loop during the message exchanges.
To be used by proxy device.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 include/io/mpqemu-link.h | 16 +++++++++
 io/mpqemu-link.c         | 78 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 1542e8ed07..52aa89656c 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -17,6 +17,7 @@
 #include "qom/object.h"
 #include "qemu/thread.h"
 #include "io/channel.h"
+#include "io/channel-socket.h"
 
 #define REMOTE_MAX_FDS 8
 
@@ -30,6 +31,7 @@
  */
 typedef enum {
     INIT = 0,
+    RET_MSG,
     MAX = INT_MAX,
 } MPQemuCmd;
 
@@ -67,6 +69,20 @@ typedef struct {
     uint8_t *data2;
 } MPQemuMsg;
 
+struct MPQemuRequest {
+    MPQemuMsg *msg;
+    QIOChannelSocket *sioc;
+    Coroutine *co;
+    bool finished;
+    int error;
+    long ret;
+};
+
+typedef struct MPQemuRequest MPQemuRequest;
+
+uint64_t mpqemu_msg_send_reply_co(MPQemuMsg *msg, QIOChannel *ioc,
+                                  Error **errp);
+
 void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc);
 int mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc);
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index bfc542b5fd..c430b4d6a2 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -16,6 +16,8 @@
 #include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "io/channel-socket.h"
 
 void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc)
 {
@@ -118,6 +120,82 @@ int mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc)
     return 0;
 }
 
+/* Use in proxy only as it clobbers fd handlers. */
+static void coroutine_fn mpqemu_msg_send_co(void *data)
+{
+    MPQemuRequest *req = (MPQemuRequest *)data;
+    MPQemuMsg msg_reply = {0};
+    long ret = -EINVAL;
+
+    if (!req->sioc) {
+        error_report("No channel available to send command %d",
+                     req->msg->cmd);
+        atomic_mb_set(&req->finished, true);
+        req->error = -EINVAL;
+        return;
+    }
+
+    req->co = qemu_coroutine_self();
+    mpqemu_msg_send(req->msg, QIO_CHANNEL(req->sioc));
+
+    yield_until_fd_readable(req->sioc->fd);
+
+    ret = mpqemu_msg_recv(&msg_reply, QIO_CHANNEL(req->sioc));
+    if (ret < 0) {
+        error_report("ERROR: failed to get a reply for command %d, \
+                     errno %s, ret is %ld",
+                     req->msg->cmd, strerror(errno), ret);
+        req->error = -errno;
+    } else {
+        if (!mpqemu_msg_valid(&msg_reply) || msg_reply.cmd != RET_MSG) {
+            error_report("ERROR: Invalid reply received for command %d",
+                         req->msg->cmd);
+            req->error = -EINVAL;
+        } else {
+            req->ret = msg_reply.data1.u64;
+        }
+    }
+    atomic_mb_set(&req->finished, true);
+}
+
+/*
+ * Create if needed and enter co-routine to send the message to the
+ * remote channel ioc and wait for the reply.
+ * Resturns the value from the reply message, sets the error on failure.
+ */
+
+uint64_t mpqemu_msg_send_reply_co(MPQemuMsg *msg, QIOChannel *ioc,
+                                  Error **errp)
+{
+    MPQemuRequest req = {0};
+    uint64_t ret = UINT64_MAX;
+
+    req.sioc = QIO_CHANNEL_SOCKET(ioc);
+    if (!req.sioc) {
+        return ret;
+    }
+
+    req.msg = msg;
+    req.ret = 0;
+    req.finished = false;
+
+    if (!req.co) {
+        req.co = qemu_coroutine_create(mpqemu_msg_send_co, &req);
+    }
+
+    qemu_coroutine_enter(req.co);
+    while (!req.finished) {
+        aio_poll(qemu_get_aio_context(), false);
+    }
+    if (req.error) {
+        error_setg(errp, "Error exchanging message with remote process, "\
+                        "socket %d, error %d", req.sioc->fd, req.error);
+    }
+    ret = req.ret;
+
+    return ret;
+}
+
 bool mpqemu_msg_valid(MPQemuMsg *msg)
 {
     if (msg->cmd >= MAX && msg->cmd < 0) {
-- 
2.25.GIT


