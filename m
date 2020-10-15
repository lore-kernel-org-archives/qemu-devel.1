Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B49C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0F9206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mxQ+VL9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0F9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT82K-00066u-CY
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7fF-0002Wx-4L
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:07:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7fB-0002b3-PG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:07:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4OFY037616;
 Thu, 15 Oct 2020 18:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=8N6gznsNaczNN9RBmNYnNLa/Q2y3kSoNATcah5I3leI=;
 b=mxQ+VL9o5arNQxlIsvhXUXSlQcophhjO/YVF8c3NoeZrIX7vmGuRsDKiUehDS5Hmb0c+
 kMNZhDt4keSuQBaO90CRhFbbIGKWYsVLA0RV+m6RRcheTnW+ODUv/BLPF0I0yqCpLOmp
 O3SJlpQ8tHCqmbyNC4cwme/t8lqQCOTpVXsRyf4D2mM0pha+BTvASP+TKZehE4/t7kZ9
 CxoAaU1FYJpAErZJ6J/wy5YoeBYFw2FVAxqdTmFpWsBNH8+TF6kdPZfVn/gdqz3WUTJg
 Rd6a3zZxCqO0ah7n2CpY7dBMPoaf8fP6LD32Fv71JgpHNRquzV84QvEoqxnFoMY+NigT pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 3434wkx7cx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:07:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4eAX184506;
 Thu, 15 Oct 2020 18:05:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 343pw0qh6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FI5UrG002070;
 Thu, 15 Oct 2020 18:05:30 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:30 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 06/19] multi-process: define MPQemuMsg format and
 transmission functions
Date: Thu, 15 Oct 2020 14:04:59 -0400
Message-Id: <32b85be52b3901160de03aac396ed516d748204b.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=4 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=4 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:05:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 include/io/mpqemu-link.h |  60 ++++++++++++
 io/meson.build           |   2 +
 io/mpqemu-link.c         | 237 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 301 insertions(+)
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 12945ee..42b5da5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3104,6 +3104,8 @@ F: hw/pci-host/remote.c
 F: include/hw/pci-host/remote.h
 F: hw/i386/remote.c
 F: include/hw/i386/remote.h
+F: io/mpqemu-link.c
+F: include/io/mpqemu-link.h
 
 Build and test automation
 -------------------------
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
new file mode 100644
index 0000000..3505e06
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
index bcd8b1e..d25529c 100644
--- a/io/meson.build
+++ b/io/meson.build
@@ -13,3 +13,5 @@ io_ss.add(files(
   'net-listener.c',
   'task.c',
 ))
+
+io_ss.add(when: 'CONFIG_MPQEMU', if_true: files('mpqemu-link.c'))
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
new file mode 100644
index 0000000..d646aad
--- /dev/null
+++ b/io/mpqemu-link.c
@@ -0,0 +1,237 @@
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
+    while (local_err && nfds) {
+        close(fds[nfds - 1]);
+        nfds--;
+    }
+
+    g_free(fds);
+
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
1.8.3.1


