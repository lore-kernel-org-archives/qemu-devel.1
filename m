Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B333207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="icwY7vQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B333207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fbu-0000iZ-I3
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZd-00074K-Fl
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZc-0008Uv-3f
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZb-0008Tt-R0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXeLt066086;
 Tue, 3 Sep 2019 20:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=RFnGd7mRDZoMBPLbemZy4/IawuAulvCvwnuP/3KMQdA=;
 b=icwY7vQ20US2aAVnfQgaKIHVSAqY7SiXAlI8AIEQVOjtxTYUPXSij7mCaTbjNJwlqgZm
 o9J3ViqnGn5cNwoRj5UE5CeZjvjO70a3zG/GPKvi0Hl0JVG20H2WL+5oz6AT92Tu2Tl9
 oIH3iI+xRh5O0RXA+3hie/zLm9b9BdMI7p6QgV08NdxEzSTTqrZncvWgJNrL5k8qZfA3
 7FhXTgk7TUbAG6crSzSpJtKHnNk9C8J/5aLeQ6rCUO4PS8RhLs/xMaUmIgG6Wd1KMgkI
 9wtvsV1NWG7YzoMvLIp/RjztjcrMS/5U27tmqyA9Rf/RNXra2VUnY0wPQvBQr7SxwOV7 zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2usy4u82y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcLOj188202;
 Tue, 3 Sep 2019 20:38:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2usu5117w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KcZT0012236;
 Tue, 3 Sep 2019 20:38:35 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:35 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:34 -0400
Message-Id: <0f0117061fabf398c5d16811ef8787c0ba7d4b0e.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC v3 PATCH 08/45] multi-process: add functions to
 synchronize proxy and remote endpoints
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

In some cases, for example MMIO read, QEMU has to wait for the remote to
complete a command before proceeding. An eventfd based mechanism is
added to synchronize QEMU & remote process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v1 -> v2:
   - Added timeout to synchronization functions

 include/io/proxy-link.h |  8 ++++++++
 io/proxy-link.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index ee78cdd..b76c574 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -28,7 +28,9 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <glib.h>
+#include <unistd.h>
 #include <pthread.h>
+#include <sys/eventfd.h>
 
 #include "qemu/osdep.h"
 #include "qom/object.h"
@@ -133,11 +135,17 @@ struct ProxyLinkState {
     proxy_link_callback callback;
 };
 
+#define GET_REMOTE_WAIT eventfd(0, 0)
+#define PUT_REMOTE_WAIT(wait) close(wait)
+#define PROXY_LINK_WAIT_DONE 1
+
 ProxyLinkState *proxy_link_create(void);
 void proxy_link_finalize(ProxyLinkState *s);
 
 void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan);
 int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan);
+uint64_t wait_for_remote(int efd);
+void notify_proxy(int fd, uint64_t val);
 
 void proxy_link_init_channel(ProxyLinkState *s, ProcChannel **chan, int fd);
 void proxy_link_destroy_channel(ProcChannel *chan);
diff --git a/io/proxy-link.c b/io/proxy-link.c
index 5eb9718..381a38e 100644
--- a/io/proxy-link.c
+++ b/io/proxy-link.c
@@ -31,6 +31,8 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+#include <limits.h>
+#include <poll.h>
 
 #include "qemu/module.h"
 #include "io/proxy-link.h"
@@ -216,6 +218,46 @@ int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
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
 static gboolean proxy_link_handler_prepare(GSource *gsrc, gint *timeout)
 {
     g_assert(timeout);
-- 
1.8.3.1


