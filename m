Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58308C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE622168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GLLcD3fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE622168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fg2-0004Qw-S0
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZn-0007IQ-Oc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZm-0000Hr-Im
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZm-0000Fu-B3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXsxh062445;
 Tue, 3 Sep 2019 20:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=5K/RtrZChD37454LN52XWbHOA/tbKWaTIL7EHZSXi34=;
 b=GLLcD3fpuYmrHz94K4Fg7U6bzlHsfn0XWvy3dxmdNsJnW//lVptWbnAkrR40Y8iNtAJB
 VmwMzECbsYLeMmzouCPtqpUQkWRxpT8dHS2LQzaSHuZDOTdrkqO9Pn83/Rg/ZpWy2dqT
 1CBphyibGakDJC1LAwWxojUbPYe21zFBrE35fApzGloP8KcKsnLr520HoqTKYZcSOToF
 uCQM2J5dtm1pUB4fbhTb/jgojrZYJ/F600ThTK3IK6Qnb0KPUblKcmdPlsrrvDPImOET
 UiFlrQTDp9cQVvf+Jt419EBy0qBj1ZYtHRaXu/xYf7MofTNyAdmtTgq0+5w5Re+uOGNs mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2usy66r2e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Kc9ed025344;
 Tue, 3 Sep 2019 20:38:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2us5pha074-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:48 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Kck5C017469;
 Tue, 3 Sep 2019 20:38:46 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:46 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:41 -0400
Message-Id: <a7e4930166f395ba424e174386eb8742dee86a49.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 15/45] multi-process: add support of
 device id to communication channel
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 New patch in v3

 include/io/proxy-link.h |  3 +++
 io/proxy-link.c         | 37 ++++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 159c787..0785394 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -88,6 +88,7 @@ typedef struct {
     proc_cmd_t cmd;
     int bytestream;
     size_t size;
+    size_t size_id;
 
     union {
         uint64_t u64;
@@ -98,6 +99,8 @@ typedef struct {
     int num_fds;
 
     uint8_t *data2;
+    uint8_t *id;
+
 } ProcMsg;
 
 struct conf_data_msg {
diff --git a/io/proxy-link.c b/io/proxy-link.c
index 381a38e..6f60117 100644
--- a/io/proxy-link.c
+++ b/io/proxy-link.c
@@ -81,7 +81,7 @@ void proxy_link_finalize(ProxyLinkState *s)
 void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
 {
     int rc;
-    uint8_t *data;
+    uint8_t *data, *buf = NULL;
     union {
         char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
         struct cmsghdr align;
@@ -140,10 +140,19 @@ void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
         data = (uint8_t *)msg + PROC_HDR_SIZE;
     }
 
+    if (msg->size_id > 0) {
+        buf = calloc(1, msg->size + msg->size_id);
+        assert(buf);
+        memcpy(buf, data, msg->size);
+        memcpy(buf + msg->size, msg->id, msg->size_id);
+        data = buf;
+    }
     do {
-        rc = write(sock, data, msg->size);
+        rc = write(sock, data, msg->size + msg->size_id);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
 
+    free(buf);
+
     qemu_mutex_unlock(lock);
 }
 
@@ -151,7 +160,7 @@ void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
 int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
 {
     int rc;
-    uint8_t *data;
+    uint8_t *data, *buf = NULL;
     union {
         char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
         struct cmsghdr align;
@@ -207,10 +216,28 @@ int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
         data = (uint8_t *)&msg->data1;
     }
 
-    if (msg->size) {
+     if (msg->size) {
+        if (msg->size_id > 0) {
+            buf = calloc(1, msg->size + msg->size_id);
+            data = buf;
+        }
         do {
-            rc = read(sock, data, msg->size);
+            rc = read(sock, data, msg->size + msg->size_id);
         } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+        if (rc < 0) {
+            fprintf(stderr, "Read sock is an error!\n");
+            return rc;
+        }
+    }
+    if (msg->size && msg->bytestream) {
+        memcpy(msg->data2, data, msg->size);
+    } else {
+        memcpy((uint8_t *)&msg->data1, data, msg->size);
+    }
+
+    if (msg->size_id > 0) {
+        msg->id = calloc(1, msg->size_id);
+        memcpy(msg->id, data + msg->size, msg->size_id);
     }
 
     qemu_mutex_unlock(lock);
-- 
1.8.3.1


