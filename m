Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E66C31E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6D52084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KpsstjzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6D52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwHh-000414-Hb
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAd-0005Mj-M6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAb-0001U6-Jp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAZ-0001IL-F7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8r4P149269;
 Mon, 17 Jun 2019 18:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=KEujIo1vEx2wWhB0PXsc+4rd8jpemrHqR8jjUc1zmd0=;
 b=KpsstjzSXfsbojkpYLmBgcsK1TNUyYNbU56v9mrjEdcsivdyO8NPxC2bVLZ5HZ3b3WW+
 W9pBCunQO2qMsvYMZhQdyDok95O/Z2iaDzaZ8z0pZThFHXfI4AyhUAYP9mjTBEVnWUqY
 9QwY9XxftDSooDDfYo7Q4q/MV748j/9k1VBYE8mtEv6CaVXWVhom9JusmtZpQijB1eJ/
 hR/0jCAPEovoTUvhwazvH8AGzqM5qO0PzgFEeb9nrCrdsotwrhNDod4SKUZYWiwbq5xx
 YnT7gR1nO/umYl0/wOjZ9UM0uodvlAeilfMxsXhW9RIhRNfyVK7dxe5ZgASzo3WFyv7f sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t4r3tg2uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF9Y9117981;
 Mon, 17 Jun 2019 18:15:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2t5cpdkend-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:40 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIFdhx024697;
 Mon, 17 Jun 2019 18:15:39 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:15:38 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:15:29 -0700
Message-Id: <20190617181529.29468-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC PATCH v2 08/35] multi-process: add functions to
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, berrange@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com
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
 Changes in v2:
 - Added timeout to communication channel.
---
 include/io/proxy-link.h |  9 +++++++++
 io/proxy-link.c         | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index fb266ca2a8..2f1584e87d 100644
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
@@ -124,11 +126,18 @@ struct ProxyLinkState {
     proxy_link_callback callback;
 };
 
+#define GET_REMOTE_WAIT eventfd(0, 0)
+#define PUT_REMOTE_WAIT(wait) close(wait)
+#define PROXY_LINK_WAIT_DONE 1
+
 ProxyLinkState *proxy_link_create(void);
 void proxy_link_finalize(ProxyLinkState *s);
 
 void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg);
 int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg);
+uint64_t wait_for_remote(int efd);
+void notify_proxy(int fd, uint64_t val);
+
 void proxy_link_set_sock(ProxyLinkState *s, int fd);
 void proxy_link_set_callback(ProxyLinkState *s, proxy_link_callback callback);
 void start_handler(ProxyLinkState *s);
diff --git a/io/proxy-link.c b/io/proxy-link.c
index 75e0bb5e27..9bda646f39 100644
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
@@ -210,6 +212,46 @@ int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg)
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
2.17.1


