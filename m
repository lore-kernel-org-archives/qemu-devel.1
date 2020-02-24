Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D76C38BE6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4D721556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ucysf1QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4D721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KpF-0003Gh-6v
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km4-00063i-Rp
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km3-0002ys-C6
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km3-0002xE-34
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqUse017543;
 Mon, 24 Feb 2020 20:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=qVGAGC6C18wJ+u7koWS8q2G+1agjZ5LGHLUEggWIpvg=;
 b=Ucysf1QPfWCGisyEL/FZGhAGVkKDpXcLEWm5jk3AU+Mq/83yu0OV0AHbWg2JK4igkFCD
 LyHV+15ln4vqkRQcC0PiA2aOu88xg1Ao7RoDAWI7VuVh+4/6cHHm5rtqOE7g5YxJ6VFY
 zvFVxYQQIM4oC7ecvJmZWaV/2aUrX1oE7i4EBscZydZfmpxyEXkgfzjT5awykB3zk1Hl
 lGSk34fWWdTpib5BO7qqtRpyv/j5mjgIJFM2+1uPqCqxbA9JyMBOt+BO/2ksoVAmxcXw
 yZXwqcZULi0INMW/WFuAwkTlUK6PYDA0ZJ2e7mAwfp+2x41W2+4Gqom7hTmC5bVDueIP Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yavxrhydm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqhVI017288;
 Mon, 24 Feb 2020 20:56:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ybduv6cq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKu84e029598;
 Mon, 24 Feb 2020 20:56:09 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:08 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/50] multi-process: add functions to synchronize proxy
 and remote endpoints
Date: Mon, 24 Feb 2020 15:54:59 -0500
Message-Id: <3d013f0091ac6babb55f30cadf6ed806c322b7ce.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

In some cases, for example MMIO read, QEMU has to wait for the remote to
complete a command before proceeding. An eventfd based mechanism is
added to synchronize QEMU & remote process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 include/io/mpqemu-link.h |  7 +++++++
 io/mpqemu-link.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 2f2dd83..ae04fca 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -135,4 +135,11 @@ void mpqemu_link_set_callback(MPQemuLinkState *s,
                               mpqemu_link_callback callback);
 void mpqemu_start_coms(MPQemuLinkState *s);
 
+#define GET_REMOTE_WAIT eventfd(0, EFD_CLOEXEC)
+#define PUT_REMOTE_WAIT(wait) close(wait)
+#define PROXY_LINK_WAIT_DONE 1
+
+uint64_t wait_for_remote(int efd);
+void notify_proxy(int fd, uint64_t val);
+
 #endif
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index bac120b..73b7032 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include <poll.h>
 
 #include "qemu/module.h"
 #include "io/mpqemu-link.h"
@@ -216,6 +217,46 @@ int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan)
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
1.8.3.1


