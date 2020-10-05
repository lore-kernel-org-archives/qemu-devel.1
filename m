Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1941CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14E020756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w5vy8a+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14E020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVew-0003TK-Qz
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 14:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaB-0006eB-9P
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVa7-00083P-O3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095InpX1076382;
 Mon, 5 Oct 2020 18:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DSVWraebzFC9YxMzx/WYyHA7syPYZcR25yCGn/QGJRU=;
 b=w5vy8a+ljjohLwEjlAI8BU+5P368EqII58ga1/EiT0kQoTJNOSMrgvAh7dRwOxPdziAK
 PDciIacF1q9WSOEtnC7e/FL3jQgTHP7FpR1ttx5moLQ/qsBqDbJMa6GSO4YdreDdDd2O
 Ry3u3JivlEDdtSlROP63NdofePvirfZHOEBaNUFCY4Z/4Lfp+u9QP/0G9vrVMId2StwE
 XSC+TiILixA95aQtWVqFprjlOoMiIU/JIkwdwbUQwCluJIPv9SXoS6W3tMJT+xM7xelM
 JADZIOMQgAbyvOALEEFi1DHpHYazu3Rj6EAkvUmv+guFx93g1tHOAm2ysyi8gZPXF70r LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 33ym34c9rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:51:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095IomJD124190;
 Mon, 5 Oct 2020 18:51:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 33y36wumbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:21 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 095IpKJ7005260;
 Mon, 5 Oct 2020 18:51:20 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:20 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 06/19] multi-process: define MPQemuMsg format and
 transmission functions
Date: Mon,  5 Oct 2020 11:50:54 -0700
Message-Id: <45fd2f984d994d70b5d1780ac39ca2c03dcc10bf.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=1 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=1 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 14:51:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Defines MPQemuMsg, which is the message that is sent to the remote
process. This message is sent over QIOChannel and is used to
command the remote process to perform various tasks.
Define transmission functions used by proxy and by remote.
There are certain restrictions on where its safe to use these
functions:
  - From main loop in co-routine context. Will block the main loop if not in
    co-routine context;
  - From vCPU thread with no co-routine context and if the channel is not part
    of the main loop handling;
  - From IOThread within co-routine context, outside of co-routine context will
    block IOThread;

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS              |   2 +
 include/io/mpqemu-link.h |  60 ++++++++++
 io/meson.build           |   2 +
 io/mpqemu-link.c         | 230 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 38d19c83cd..1ca1f8ccff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3045,6 +3045,8 @@ F: hw/pci-host/remote.c
 F: include/hw/pci-host/remote.h
 F: hw/i386/remote.c
 F: include/hw/i386/remote.h
+F: io/mpqemu-link.c
+F: include/io/mpqemu-link.h
 
 Build and test automation
 -------------------------
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
new file mode 100644
index 0000000000..3505e062dd
--- /dev/null
+++ b/include/io/mpqemu-link.h
@@ -0,0 +1,60 @@
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
+#define MPQEMU_MSG_HDR_SIZE offsetof(MPQemuMsg, data.u64)
+
+/**
+ * MPQemuCmd:
+ *
+ * MPQemuCmd enum type to specify the command to be executed on the remote
+ * device.
+ */
+typedef enum {
+    MPQEMU_CMD_INIT,
+    MPQEMU_CMD_MAX,
+} MPQemuCmd;
+
+/**
+ * MPQemuMsg:
+ * @cmd: The remote command
+ * @size: Size of the data to be shared
+ * @data: Structured data
+ * @fds: File descriptors to be shared with remote device
+ *
+ * MPQemuMsg Format of the message sent to the remote device from QEMU.
+ *
+ */
+typedef struct {
+    int cmd;
+    size_t size;
+
+    union {
+        uint64_t u64;
+    } data;
+
+    int fds[REMOTE_MAX_FDS];
+    int num_fds;
+} QEMU_PACKED MPQemuMsg;
+
+void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
+void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
+
+bool mpqemu_msg_valid(MPQemuMsg *msg);
+
+#endif
diff --git a/io/meson.build b/io/meson.build
index 768c1b5ec3..3d40cd8867 100644
--- a/io/meson.build
+++ b/io/meson.build
@@ -15,6 +15,8 @@ io_ss.add(files(
   'task.c',
 ))
 
+io_ss.add(when: 'CONFIG_MPQEMU', if_true: files('mpqemu-link.c'))
+
 io_ss = io_ss.apply(config_host, strict: false)
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
new file mode 100644
index 0000000000..42df2af229
--- /dev/null
+++ b/io/mpqemu-link.c
@@ -0,0 +1,230 @@
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
+#include "qemu/main-loop.h"
+
+/*
+ * Send message over the ioc QIOChannel.
+ * This function is safe to call from:
+ * - From main loop in co-routine context. Will block the main loop if not in
+ *   co-routine context;
+ * - From vCPU thread with no co-routine context and if the channel is not part
+ *   of the main loop handling;
+ * - From IOThread within co-routine context, outside of co-routine context
+ *   will block IOThread;
+ */
+void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
+{
+    bool iolock = qemu_mutex_iothread_locked();
+    bool iothread = qemu_get_current_aio_context() == qemu_get_aio_context() ?
+                    false : true;
+    Error *local_err = NULL;
+    struct iovec send[2] =  {0};
+    int *fds = NULL;
+    size_t nfds = 0;
+
+    send[0].iov_base = msg;
+    send[0].iov_len = MPQEMU_MSG_HDR_SIZE;
+
+    send[1].iov_base = (void *)&msg->data;
+    send[1].iov_len = msg->size;
+
+    if (msg->num_fds) {
+        nfds = msg->num_fds;
+        fds = msg->fds;
+    }
+    /*
+     * Dont use in IOThread out of co-routine context as
+     * it will block IOThread.
+     */
+    if (iothread) {
+        assert(qemu_in_coroutine());
+    }
+    /*
+     * Skip unlocking/locking iothread when in IOThread running
+     * in co-routine context. Co-routine context is asserted above
+     * for IOThread case.
+     * Also skip this while in a co-routine in the main context.
+     */
+    if (iolock && !iothread && !qemu_in_coroutine()) {
+        qemu_mutex_unlock_iothread();
+    }
+
+    (void)qio_channel_writev_full_all(ioc, send, G_N_ELEMENTS(send), fds, nfds,
+                                      &local_err);
+
+    if (iolock && !iothread && !qemu_in_coroutine()) {
+        /* See above comment why skip locking here. */
+        qemu_mutex_lock_iothread();
+    }
+
+    if (errp) {
+        error_propagate(errp, local_err);
+    } else if (local_err) {
+        error_report_err(local_err);
+    }
+
+    return;
+}
+
+/*
+ * Read message from the ioc QIOChannel.
+ * This function is safe to call from:
+ * - From main loop in co-routine context. Will block the main loop if not in
+ *   co-routine context;
+ * - From vCPU thread with no co-routine context and if the channel is not part
+ *   of the main loop handling;
+ * - From IOThread within co-routine context, outside of co-routine context
+ *   will block IOThread;
+ */
+static ssize_t mpqemu_read(QIOChannel *ioc, void *buf, size_t len, int **fds,
+                           size_t *nfds, Error **errp)
+{
+    struct iovec iov = { .iov_base = buf, .iov_len = len };
+    bool iolock = qemu_mutex_iothread_locked();
+    bool iothread = qemu_get_current_aio_context() == qemu_get_aio_context()
+                        ? false : true;
+    struct iovec *iovp = &iov;
+    Error *local_err = NULL;
+    unsigned int niov = 1;
+    size_t *l_nfds = nfds;
+    int **l_fds = fds;
+    ssize_t bytes = 0;
+    size_t size;
+
+    size = iov.iov_len;
+
+    /*
+     * Dont use in IOThread out of co-routine context as
+     * it will block IOThread.
+     */
+    if (iothread) {
+        assert(qemu_in_coroutine());
+    }
+
+    while (size > 0) {
+        bytes = qio_channel_readv_full(ioc, iovp, niov, l_fds, l_nfds,
+                                       &local_err);
+        if (bytes == QIO_CHANNEL_ERR_BLOCK) {
+            /*
+             * Skip unlocking/locking iothread when in IOThread running
+             * in co-routine context. Co-routine context is asserted above
+             * for IOThread case.
+             * Also skip this while in a co-routine in the main context.
+             */
+            if (iolock && !iothread && !qemu_in_coroutine()) {
+                qemu_mutex_unlock_iothread();
+            }
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_IN);
+            } else {
+                qio_channel_wait(ioc, G_IO_IN);
+            }
+            /* See above comment why skip locking here. */
+            if (iolock && !iothread && !qemu_in_coroutine()) {
+                qemu_mutex_lock_iothread();
+            }
+            continue;
+        }
+
+        if (bytes <= 0) {
+            error_propagate(errp, local_err);
+            return -EIO;
+        }
+
+        l_fds = NULL;
+        l_nfds = NULL;
+
+        size -= bytes;
+
+        (void)iov_discard_front(&iovp, &niov, bytes);
+    }
+
+    return len - size;
+}
+
+void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
+{
+    Error *local_err = NULL;
+    int *fds = NULL;
+    size_t nfds = 0;
+    ssize_t len;
+
+    len = mpqemu_read(ioc, (void *)msg, MPQEMU_MSG_HDR_SIZE, &fds, &nfds,
+                      &local_err);
+    if (!local_err) {
+        if (len == -EIO) {
+            error_setg(&local_err, "Connection closed.");
+            goto fail;
+        }
+        if (len < 0) {
+            error_setg(&local_err, "Message length is less than 0");
+            goto fail;
+        }
+        if (len != MPQEMU_MSG_HDR_SIZE) {
+            error_setg(&local_err, "Message header corrupted");
+            goto fail;
+        }
+    } else {
+        goto fail;
+    }
+
+    if (msg->size > sizeof(msg->data)) {
+        error_setg(&local_err, "Invalid size for message");
+        goto fail;
+    }
+
+    if (mpqemu_read(ioc, (void *)&msg->data, msg->size, NULL, NULL,
+                    &local_err) < 0) {
+        goto fail;
+    }
+
+    msg->num_fds = nfds;
+    if (nfds) {
+        memcpy(msg->fds, fds, nfds * sizeof(int));
+    }
+
+fail:
+    if (errp) {
+        error_propagate(errp, local_err);
+    } else if (local_err) {
+        error_report_err(local_err);
+    }
+}
+
+bool mpqemu_msg_valid(MPQemuMsg *msg)
+{
+    if (msg->cmd >= MPQEMU_CMD_MAX && msg->cmd < 0) {
+        return false;
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


