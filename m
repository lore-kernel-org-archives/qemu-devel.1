Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132E2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA1922B42
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ijBD3K1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA1922B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Zkh-0002BG-3R
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeL-0001hY-OA
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:20:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeJ-0005LZ-Hz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:20:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIBmft069809;
 Fri, 31 Jul 2020 18:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=1l67bn+gCumzFGqkgymzvlntK4IEFqBqvaSg3HO6MtE=;
 b=ijBD3K1jNpms2CG0XjRlzRrdvgu8I9A4mDzpDQRNwkDrLQerCR+EM1pR0VU8U/zySSUi
 Vb7tZbkLP6ZeoW5LsJJLfiELJbnK6hbLkRH1bA1qGBeIruwzrBltuByJfqGuJWypE5Wu
 rzmc8XgwiAu5w10CAytqwP4iZiU+RFDHPaDdnR06PikJhmVzOhObjFEuWoIJoXEmyCaE
 Q0vOrsW0zsgAFWZt/gjRFddGSIawtsITITYMMkbV5zlxz4RZ3cwlGOkefs1je0s4Oesp
 YelPIgVJx/z16YzyD4CVo21BCsnWHgFkiphpQrqvtRXvm668BuczXqlw6re6mxGR3cKz jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 32mf702u7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:20:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIIi8c080286;
 Fri, 31 Jul 2020 18:20:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 32mf70vdwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:48 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VIKldb013260;
 Fri, 31 Jul 2020 18:20:47 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:46 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 07/20] multi-process: add co-routines to communicate with
 remote
Date: Fri, 31 Jul 2020 14:20:14 -0400
Message-Id: <b57493752ed0ec04f44df915413e325acf641882.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310136
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 14:20:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

process to avoid blocking the main loop during the message exchanges.
To be used by proxy device.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 include/io/mpqemu-link.h | 15 +++++++++
 io/mpqemu-link.c         | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index ae7008e..8591ad2 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -14,6 +14,7 @@
 #include "qom/object.h"
 #include "qemu/thread.h"
 #include "io/channel.h"
+#include "io/channel-socket.h"
 
 #define REMOTE_MAX_FDS 8
 
@@ -27,6 +28,7 @@
  */
 typedef enum {
     INIT = 0,
+    RET_MSG,
     MAX = INT_MAX,
 } MPQemuCmd;
 
@@ -64,6 +66,19 @@ typedef struct {
     uint8_t *data2;
 } MPQemuMsg;
 
+struct MPQemuRequest {
+    MPQemuMsg *msg;
+    QIOChannel *ioc;
+    Coroutine *co;
+    bool finished;
+    int error;
+    long ret;
+};
+
+typedef struct MPQemuRequest MPQemuRequest;
+
+uint64_t mpqemu_msg_send_and_await_reply(MPQemuMsg *msg, QIOChannel *ioc,
+                                  Error **errp);
 void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
 void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index dcefa42..d4dd0fe 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -16,6 +16,8 @@
 #include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "io/channel-socket.h"
 
 void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
 {
@@ -132,6 +134,86 @@ void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
     }
 }
 
+/* Use in proxy only as it clobbers fd handlers. */
+static void coroutine_fn mpqemu_msg_send_co(void *data)
+{
+    MPQemuRequest *req = (MPQemuRequest *)data;
+    MPQemuMsg msg_reply = {0};
+    Error *local_err = NULL;
+
+    if (!req->ioc) {
+        error_report("No channel available to send command %d",
+                     req->msg->cmd);
+        req->finished = true;
+        req->error = -EINVAL;
+        return;
+    }
+
+    req->co = qemu_coroutine_self();
+    mpqemu_msg_send(req->msg, req->ioc, &local_err);
+    if (local_err) {
+        error_report("ERROR: failed to send command to remote %d, ",
+                     req->msg->cmd);
+        req->finished = true;
+        req->error = -EINVAL;
+        return;
+    }
+
+    mpqemu_msg_recv(&msg_reply, req->ioc, &local_err);
+    if (local_err) {
+        error_report("ERROR: failed to get a reply for command %d, "
+                     "errno %s",
+                     req->msg->cmd, strerror(errno));
+        req->error = -EIO;
+    } else {
+        if (!mpqemu_msg_valid(&msg_reply) || msg_reply.cmd != RET_MSG) {
+            error_report("ERROR: Invalid reply received for command %d",
+                         req->msg->cmd);
+            req->error = -EINVAL;
+        } else {
+            req->ret = msg_reply.data1.u64;
+        }
+    }
+    req->finished = true;
+}
+
+/*
+ * Create if needed and enter co-routine to send the message to the
+ * remote channel ioc and wait for the reply.
+ * Returns the value from the reply message, sets the error on failure.
+ */
+
+uint64_t mpqemu_msg_send_and_await_reply(MPQemuMsg *msg, QIOChannel *ioc,
+                                  Error **errp)
+{
+    MPQemuRequest req = {0};
+    uint64_t ret = UINT64_MAX;
+
+    req.ioc = ioc;
+    if (!req.ioc) {
+        error_setg(errp, "Channel is set to NULL");
+        return ret;
+    }
+
+    req.msg = msg;
+    req.ret = 0;
+    req.finished = false;
+
+    req.co = qemu_coroutine_create(mpqemu_msg_send_co, &req);
+    qemu_coroutine_enter(req.co);
+
+    while (!req.finished) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+    if (req.error) {
+        error_setg(errp, "Error exchanging message with remote process, "
+                        "error %d", req.error);
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
1.8.3.1


