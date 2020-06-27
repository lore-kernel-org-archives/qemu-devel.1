Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58246C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B24206E9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C+5dRQAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B24206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEN7-0001mZ-BV
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELH-0007hl-DF
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELF-00070u-6P
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH2VSK156352;
 Sat, 27 Jun 2020 17:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JI2v9YgoXly9rGI8dNFJBhH/IYVdyUio6ib9fKlwgxI=;
 b=C+5dRQACXkytUxWDaaJrForPx5q6y1EhJXh8YmvJ9/QPjvkSz0K1PfXad47OY3OCT2gn
 LaNNXW84B+v8XvWyAPyP0vcv0h8I4u3RmRFikHqicFSGN9Y92v8yb8JkQsGcmzuMgKsl
 EbXmC/nkNv6DYiND/yh379XmgITxT6QP7zYMxSY7Cf5qWTntf5Jhc8+5S+EQH2hCjAuH
 9aLUXXPTQsEiKSc+LlmVczPgnL6zdHf9H8va2u456mrpre3i/8bC3PlQ8WtPGR+2gNnT
 kc6q1/Nocv+o+FE+uxxKfoncok4r7Ownl5CLmcykavwjtDALbOvVjKbZ49slbZ+8N7AT mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 31wx2m9ax7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8Pci081756;
 Sat, 27 Jun 2020 17:10:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 31wv59awbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:09:59 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05RH9v5H002824;
 Sat, 27 Jun 2020 17:09:58 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:09:57 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/21] multi-process: define MPQemuMsg format and
 transmission functions
Date: Sat, 27 Jun 2020 10:09:28 -0700
Message-Id: <f3e8c0b53e9ee337f2551f7326562cba1fffb908.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=3 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 impostorscore=0 cotscore=-2147483648 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=3 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:10:09
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
 include/io/mpqemu-link.h |  75 +++++++++++++++++++
 io/Makefile.objs         |   2 +
 io/mpqemu-link.c         | 151 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 83aae5b441..50a5fc53d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2947,6 +2947,8 @@ F: hw/pci-host/remote.c
 F: include/hw/pci-host/remote.h
 F: hw/i386/remote.c
 F: include/hw/i386/remote.h
+F: io/mpqemu-link.c
+F: include/io/mpqemu-link.h
 
 Build and test automation
 -------------------------
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
new file mode 100644
index 0000000000..1542e8ed07
--- /dev/null
+++ b/include/io/mpqemu-link.h
@@ -0,0 +1,75 @@
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
+#include "qemu/osdep.h"
+#include "qemu-common.h"
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
+void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc);
+int mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc);
+
+bool mpqemu_msg_valid(MPQemuMsg *msg);
+
+#endif
diff --git a/io/Makefile.objs b/io/Makefile.objs
index 9a20fce4ed..5875ab0697 100644
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
index 0000000000..bfc542b5fd
--- /dev/null
+++ b/io/mpqemu-link.c
@@ -0,0 +1,151 @@
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
+void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc)
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
+        error_report_err(local_err);
+    }
+}
+
+static int mpqemu_readv(QIOChannel *ioc, struct iovec *iov, int **fds,
+                        size_t *nfds, Error **errp)
+{
+    size_t size, len;
+
+    size = iov->iov_len;
+
+    while (size > 0) {
+        len = qio_channel_readv_full(ioc, iov, 1, fds, nfds, errp);
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
+            return -EIO;
+        }
+
+        size -= len;
+    }
+
+    return iov->iov_len;
+}
+
+int mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc)
+{
+    Error *local_err = NULL;
+    int *fds = NULL;
+    struct iovec hdr, data;
+    size_t nfds = 0;
+
+    hdr.iov_base = g_malloc0(MPQEMU_MSG_HDR_SIZE);
+    hdr.iov_len = MPQEMU_MSG_HDR_SIZE;
+
+    if (mpqemu_readv(ioc, &hdr, &fds, &nfds, &local_err) < 0) {
+        return -EIO;
+    }
+
+    memcpy(msg, hdr.iov_base, hdr.iov_len);
+
+    free(hdr.iov_base);
+    if (msg->size > MPQEMU_MSG_DATA_MAX) {
+        error_report("The message size is more than MPQEMU_MSG_DATA_MAX %d",
+                     MPQEMU_MSG_DATA_MAX);
+        return -EINVAL;
+    }
+
+    data.iov_base = g_malloc0(msg->size);
+    data.iov_len = msg->size;
+
+    if (mpqemu_readv(ioc, &data, NULL, NULL, &local_err) < 0) {
+        return -EIO;
+    }
+
+    if (msg->bytestream) {
+        msg->data2 = calloc(1, msg->size);
+        memcpy(msg->data2, data.iov_base, msg->size);
+    } else {
+        memcpy((void *)&msg->data1, data.iov_base, msg->size);
+    }
+
+    free(data.iov_base);
+
+    if (nfds) {
+        msg->num_fds = nfds;
+        memcpy(msg->fds, fds, nfds * sizeof(int));
+    }
+
+    return 0;
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
-- 
2.25.GIT


