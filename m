Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2763C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EA9206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VADl1ikV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EA9206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLON7-000541-Jo
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGa-0001Zl-PD
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGY-00029a-MQ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGW-00027P-Ri
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369dkIJ069626;
 Mon, 6 Apr 2020 09:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=959nCTrI56f4p3sVT1WQASzy2cespo3AN8EG4QncjXU=;
 b=VADl1ikVn74ixkeS9eIzbQihBhiD+jW7LfMAHaxYXktjMuQOcCNtrtK8d5ieSvUceLNS
 KZbrqOB5TKiqWoY0TzrRBKTBr/YtOi8Aye64fvvCPsVXeGZsa5RicOsDR2NfMElqXtkD
 EHhut2MdjkciFVCpoyLJbyIq1GngBTJwD4ZWpCvWrX4mBkkI1VNpzTlnfhnRcvZZW6ep
 L7nY9F1k78SCVh3x67ptHz/Pl1XTOSUd1qUclVdVrsHh3Y+t6qlt4Y3FBEtwYhoNftXS
 9ouchganuVpNGkI0RxrkIO2XvaMg+Ssc7IB/wEcSSbbS/T7rpml+fRo1biLiGyfjryPC BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 306j6m5tap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369bK3t056244;
 Mon, 6 Apr 2020 09:41:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 3073qcncdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:53 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369fqHY031805;
 Mon, 6 Apr 2020 09:41:52 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:52 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/36] multi-process: add functions to synchronize proxy
 and remote endpoints
Date: Mon,  6 Apr 2020 02:41:02 -0700
Message-Id: <013cbc654f4f22a60659e580e98bd45925614866.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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

From: Jagannathan Raman <jag.raman@oracle.com>

In some cases, for example MMIO read, QEMU has to wait for the remote to
complete a command before proceeding. An eventfd based mechanism is
added to synchronize QEMU & remote process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 include/io/mpqemu-link.h |  7 +++++++
 io/mpqemu-link.c         | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index af401e640c..ef95599bca 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -124,4 +124,11 @@ void mpqemu_link_set_callback(MPQemuLinkState *s,
 void mpqemu_start_coms(MPQemuLinkState *s, MPQemuChannel* chan);
 bool mpqemu_msg_valid(MPQemuMsg *msg);
 
+#define GET_REMOTE_WAIT eventfd(0, EFD_CLOEXEC)
+#define PUT_REMOTE_WAIT(wait) close(wait)
+#define PROXY_LINK_WAIT_DONE 1
+
+uint64_t wait_for_remote(int efd);
+void notify_proxy(int fd, uint64_t val);
+
 #endif
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index b7d3e53ae8..fa9b3a66b1 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include <poll.h>
 
 #include "qemu/module.h"
 #include "io/mpqemu-link.h"
@@ -204,6 +205,46 @@ int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan)
     return rc;
 }
 
+uint64_t wait_for_remote(int efd)
+{
+    struct pollfd pfd = { .fd = efd, .events = POLLIN };
+    uint64_t val;
+    int ret;
+
+    ret = poll(&pfd, 1, 1000);
+
+    switch (ret) {
+    case 0:
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: Timed out\n");
+        /* TODO: Kick-off error recovery */
+        return ULLONG_MAX;
+    case -1:
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Poll error wait_for_remote: %s\n",
+                      strerror(errno));
+        return ULLONG_MAX;
+    default:
+        if (read(efd, &val, sizeof(val)) == -1) {
+            qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: %s\n",
+                          strerror(errno));
+            return ULLONG_MAX;
+        }
+    }
+
+    val = (val == ULLONG_MAX) ? val : (val - 1);
+
+    return val;
+}
+
+void notify_proxy(int efd, uint64_t val)
+{
+    val = (val == ULLONG_MAX) ? val : (val + 1);
+
+    if (write(efd, &val, sizeof(val)) == -1) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Error notify_proxy: %s\n",
+                      strerror(errno));
+    }
+}
+
 static gboolean mpqemu_link_handler_prepare(GSource *gsrc, gint *timeout)
 {
     g_assert(timeout);
-- 
2.25.GIT


