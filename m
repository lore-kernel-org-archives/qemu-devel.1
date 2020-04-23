Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1932C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB172071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yxi7nRIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB172071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTX1-0002H5-Mq
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTII-0003S3-Ho
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIH-0002hK-Qs
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTIH-0002e0-6C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CV7O064315;
 Thu, 23 Apr 2020 04:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6MI7OMXkw4mkbhw+Rl2Uw8cIgWTp5a9k/egU8WM9EAU=;
 b=Yxi7nRIyxTLpxYYw/5rEnfATmOyp1qiQdeEBxV+RNDOSW2e+Mq2+baOKQYUPHdUuNGbg
 H4ZCiM5KRWYXAF95N3QuDPKWNZ6m4Dm0scEEYtEeGAR4PHZnL1jhXPUN1gXEPjl/ZjK3
 Cr9J+8ZN9JT2Y5mK+3qMV4iWW+XgAl1SFwoT/0OX/QoiMnq0MPCPX64DCuEOrv9cjiv8
 KF2HtgCBtZmlRlQrp38Edp3ZYEOgZ42NoCDF3SJissKyTQe1Jt6ZuRBe3fA72PFpZBP8
 fVGSuzoUpwv1vWS75uS9WDomNGjYPprGFFPK0ulcpOEg87NxLJcCg0t+CLqhou5i/b+P ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 30grpgtrwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:16:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CIho089325;
 Thu, 23 Apr 2020 04:14:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 30gb1ku7uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:49 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03N4Elbo020761;
 Thu, 23 Apr 2020 04:14:47 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:47 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 12/36] multi-process: add functions to synchronize
 proxy and remote endpoints
Date: Wed, 22 Apr 2020 21:13:47 -0700
Message-Id: <7542e59e646421515051902fcd05fbb69fa4d866.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
 include/io/mpqemu-link.h |  7 +++++
 io/mpqemu-link.c         | 61 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

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
index 48f53a8928..cc0a7aecd4 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include <poll.h>
 
 #include "qemu/module.h"
 #include "io/mpqemu-link.h"
@@ -204,6 +205,66 @@ int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan)
     return rc;
 }
 
+/*
+ * wait_for_remote() Synchronizes QEMU and the remote process. The maximum
+ *                   wait time is 1s, after which the wait times out.
+ *                   The function alse returns a 64 bit return value after
+ *                   the wait. The function uses eventfd() to do the wait
+ *                   and pass the return values. eventfd() can't return a
+ *                   value of '0'. Therefore, all return values are offset
+ *                   by '1' at the sending end, and corrected at the
+ *                   receiving end.
+ */
+
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
+        return UINT64_MAX;
+    case -1:
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Poll error wait_for_remote: %s\n",
+                      strerror(errno));
+        return UINT64_MAX;
+    default:
+        if (read(efd, &val, sizeof(val)) == -1) {
+            qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: %s\n",
+                          strerror(errno));
+            return UINT64_MAX;
+        }
+    }
+
+    /*
+     * The remote process could write a non-zero value
+     * to the eventfd to wake QEMU up. However, the drawback of using eventfd
+     * for this purpose is that a return value of zero wouldn't wake QEMU up.
+     * Therefore, we offset the return value by one at the remote process and
+     * correct it in the QEMU end.
+     */
+    val = (val == UINT64_MAX) ? val : (val - 1);
+
+    return val;
+}
+
+void notify_proxy(int efd, uint64_t val)
+{
+    val = (val == UINT64_MAX) ? val : (val + 1);
+    ssize_t len = -1;
+
+    len = write(efd, &val, sizeof(val));
+    if (len == -1 || len != sizeof(val)) {
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


