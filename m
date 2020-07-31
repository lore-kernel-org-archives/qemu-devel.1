Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2E821744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oO3jk8e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2E821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZqO-0001Cy-H7
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZgI-0004Oc-1W
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:22:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZgD-0005bd-NJ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:22:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIMFt4092729;
 Fri, 31 Jul 2020 18:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=1+MgqF0N0d8dXHSe7a/SxoPOyeQy5/CjjiuwlEa+YeA=;
 b=oO3jk8e4o8eYErd8anDQPwbAG2Fn528y/vn6pjRsHYUnsZqv4bU1sH/FkzbJjZGvF/G4
 71Q9kyZphRSZXeOYae796oRnhndeoA0aH/KqN+nu8L4bWspbh7wds0XOI0KKQTKuLLUt
 WogqwhmdXnCGUeP3d/aDlimbIL657/BjmLqcB07PQ3zSUdv1RlMmDQVwNRl0QYULgdOv
 OlyLpk9T43z5uVc9UgSuA5m32ewQT/N9RPaONywmwcwTgrrSMPOG4raN0kioQYuxCYND
 AXfckF4FNYjDi3s5EQI42EAMNnUsDRHNqweaUxaiEBACEGj7g6Pw3yUMTsOC4JcfC7eH tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 32mf702uj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:22:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIId2Y137682;
 Fri, 31 Jul 2020 18:20:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 32hu64r724-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:47 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VIKjnM020161;
 Fri, 31 Jul 2020 18:20:45 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:45 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 06/20] multi-process: define MPQemuMsg format and
 transmission functions
Date: Fri, 31 Jul 2020 14:20:13 -0400
Message-Id: <50f84ecac23889920aeed397adb9317b8ea5a54b.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=3
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Defines MPQemuMsg, which is the message that is sent to the remote
process. This message is sent over QIOChannel and is used to
command the remote process to perform various tasks.

Also defined the helper functions to send and receive messages over the
QIOChannel

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS              |   2 +
 include/io/mpqemu-link.h |  73 ++++++++++++++++++++
 io/Makefile.objs         |   2 +
 io/mpqemu-link.c         | 175 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 32e264e..41fe809 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3044,6 +3044,8 @@ F: hw/pci-host/remote.c
 F: include/hw/pci-host/remote.h
 F: hw/i386/remote.c
 F: include/hw/i386/remote.h
+F: io/mpqemu-link.c
+F: include/io/mpqemu-link.h
 
 Build and test automation
 -------------------------
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
new file mode 100644
index 0000000..ae7008e
--- /dev/null
+++ b/include/io/mpqemu-link.h
@@ -0,0 +1,73 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef MPQEMU_LINK_H
+#define MPQEMU_LINK_H
+
+#include "qom/object.h"
+#include "qemu/thread.h"
+#include "io/channel.h"
+
+#define REMOTE_MAX_FDS 8
+
+#define MPQEMU_MSG_HDR_SIZE offsetof(MPQemuMsg, data1.u64)
+
+/**
+ * MPQemuCmd:
+ *
+ * MPQemuCmd enum type to specify the command to be executed on the remote
+ * device.
+ */
+typedef enum {
+    INIT = 0,
+    MAX = INT_MAX,
+} MPQemuCmd;
+
+/**
+ * Maximum size of data2 field in the message to be transmitted.
+ */
+#define MPQEMU_MSG_DATA_MAX 256
+
+/**
+ * MPQemuMsg:
+ * @cmd: The remote command
+ * @bytestream: Indicates if the data to be shared is structured (data1)
+ *              or unstructured (data2)
+ * @size: Size of the data to be shared
+ * @data1: Structured data
+ * @fds: File descriptors to be shared with remote device
+ * @data2: Unstructured data
+ *
+ * MPQemuMsg Format of the message sent to the remote device from QEMU.
+ *
+ */
+typedef struct {
+    int cmd;
+    int bytestream;
+    size_t size;
+
+    union {
+        uint64_t u64;
+    } data1;
+
+    int fds[REMOTE_MAX_FDS];
+    int num_fds;
+
+    /* Max size of data2 is MPQEMU_MSG_DATA_MAX */
+    uint8_t *data2;
+} MPQemuMsg;
+
+void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
+void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
+
+bool mpqemu_msg_valid(MPQemuMsg *msg);
+void mpqemu_msg_cleanup(MPQemuMsg *msg);
+
+#endif
diff --git a/io/Makefile.objs b/io/Makefile.objs
index 9a20fce..5875ab0 100644
--- a/io/Makefile.objs
+++ b/io/Makefile.objs
@@ -10,3 +10,5 @@ io-obj-y += channel-util.o
 io-obj-y += dns-resolver.o
 io-obj-y += net-listener.o
 io-obj-y += task.o
+
+io-obj-$(CONFIG_MPQEMU) += mpqemu-link.o
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
new file mode 100644
index 0000000..dcefa42
--- /dev/null
+++ b/io/mpqemu-link.c
@@ -0,0 +1,175 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "qemu/module.h"
+#include "io/mpqemu-link.h"
+#include "qapi/error.h"
+#include "qemu/iov.h"
+#include "qemu/error-report.h"
+
+void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
+{
+    Error *local_err = NULL;
+    struct iovec send[2];
+    int *fds = NULL;
+    size_t nfds = 0;
+
+    send[0].iov_base = msg;
+    send[0].iov_len = MPQEMU_MSG_HDR_SIZE;
+
+    send[1].iov_base = msg->bytestream ? msg->data2 : (void *)&msg->data1;
+    send[1].iov_len = msg->size;
+
+    if (msg->num_fds) {
+        nfds = msg->num_fds;
+        fds = msg->fds;
+    }
+
+    (void)qio_channel_writev_full_all(ioc, send, G_N_ELEMENTS(send), fds, nfds,
+                                      &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+
+    return;
+}
+
+static int mpqemu_readv(QIOChannel *ioc, struct iovec *iov, int **fds,
+                        size_t *nfds, Error **errp)
+{
+    struct iovec *l_iov = iov;
+    size_t *l_nfds = nfds;
+    unsigned int niov = 1;
+    int **l_fds = fds;
+    size_t size, len;
+    Error *local_err = NULL;
+
+    size = iov->iov_len;
+
+    while (size > 0) {
+        len = qio_channel_readv_full(ioc, l_iov, niov, l_fds, l_nfds,
+                                     &local_err);
+
+        if (len == QIO_CHANNEL_ERR_BLOCK) {
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_IN);
+            } else {
+                qio_channel_wait(ioc, G_IO_IN);
+            }
+            continue;
+        }
+
+        if (len <= 0) {
+            error_propagate(errp, local_err);
+            return -EIO;
+        }
+
+        l_fds = NULL;
+        l_nfds = NULL;
+
+        size -= len;
+
+        (void)iov_discard_front(&l_iov, &niov, len);
+    }
+
+    return iov->iov_len;
+}
+
+void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
+{
+    Error *local_err = NULL;
+    int *fds = NULL;
+    struct iovec hdr, data;
+    size_t nfds = 0;
+
+    hdr.iov_base = msg;
+    hdr.iov_len = MPQEMU_MSG_HDR_SIZE;
+
+    if (mpqemu_readv(ioc, &hdr, &fds, &nfds, &local_err) < 0) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (msg->size > MPQEMU_MSG_DATA_MAX) {
+        error_setg(errp, "The message size is more than MPQEMU_MSG_DATA_MAX %d",
+                     MPQEMU_MSG_DATA_MAX);
+        return;
+    }
+
+    data.iov_base = g_malloc0(msg->size);
+    data.iov_len = msg->size;
+
+    if (mpqemu_readv(ioc, &data, NULL, NULL, &local_err) < 0) {
+        error_propagate(errp, local_err);
+        g_free(data.iov_base);
+        return;
+    }
+
+    if (msg->bytestream) {
+        msg->data2 = data.iov_base;
+        data.iov_base = NULL;
+    } else if (msg->size > sizeof(msg->data1)) {
+        error_setg(errp, "Invalid size for message");
+        g_free(data.iov_base);
+    } else {
+        memcpy((void *)&msg->data1, data.iov_base, msg->size);
+        g_free(data.iov_base);
+    }
+
+    msg->num_fds = nfds;
+    if (nfds) {
+        memcpy(msg->fds, fds, nfds * sizeof(int));
+    }
+}
+
+bool mpqemu_msg_valid(MPQemuMsg *msg)
+{
+    if (msg->cmd >= MAX && msg->cmd < 0) {
+        return false;
+    }
+
+    if (msg->bytestream) {
+        if (!msg->data2) {
+            return false;
+        }
+        if (msg->data1.u64 != 0) {
+            return false;
+        }
+    } else {
+        if (msg->data2) {
+            return false;
+        }
+    }
+
+    /* Verify FDs. */
+    if (msg->num_fds >= REMOTE_MAX_FDS) {
+        return false;
+    }
+
+    if (msg->num_fds > 0) {
+        for (int i = 0; i < msg->num_fds; i++) {
+            if (fcntl(msg->fds[i], F_GETFL) == -1) {
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
+void mpqemu_msg_cleanup(MPQemuMsg *msg)
+{
+    if (msg->data2) {
+        free(msg->data2);
+    }
+}
-- 
1.8.3.1


