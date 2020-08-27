Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD79C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F0A2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n5r8I7zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F0A2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMRw-0005Vf-RT
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOW-0000lc-I8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOT-0007CJ-TO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI55Ax096581;
 Thu, 27 Aug 2020 18:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eJ9dsHQwBvBUUVRFG3NgqCJwFSugBMwAFy5VvdhdyTQ=;
 b=n5r8I7zO56/xe/iiLHFwMaxYtzr8VUmJPVPqlZlhSdah252vYPALYTfQ4lfBEvfXmeil
 nKKn4KpAXgZKtD6r6gS8dSPMSBDpMWBij9qW6AIB/xrr8pq2n0LMhdN3/Sw/BQB2k9jC
 IOiXyb6Rfl21P3z4MULqZcqoPD1cg0JJ5LeelFpv0ZzBq6W8nrfioeirQuVnDdO5no+5
 Od4zJNF5hltVZv0Trs0xHON4jWophIIgZgU3h2mVTFkyj+YY11ngE3oJ4hsnrdmWb4b5
 J4qzm1Wg+jjVRzLOuJqBYNpsJ4IqlxAKvbhCsD4QOt+Y7eRjvT5btI5ra5IMtun8NCrd Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 336ht3g16u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:12:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI4kVW075185;
 Thu, 27 Aug 2020 18:12:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 333ru1sxy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:12:54 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RICrSU025318;
 Thu, 27 Aug 2020 18:12:53 GMT
Received: from flaka.hsd1.ca.comcast.net (/10.159.136.159)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:12:53 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v9 06/20] multi-process: define MPQemuMsg format and
 transmission functions
Date: Thu, 27 Aug 2020 11:12:17 -0700
Message-Id: <20200827181231.22778-7-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=1 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270136
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 13:54:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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

Also defined the helper functions to send and receive messages over the
QIOChannel

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS              |   2 +
 include/io/mpqemu-link.h |  60 ++++++++++++++
 io/meson.build           |   2 +
 io/mpqemu-link.c         | 173 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 237 insertions(+)
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
index 0000000000..c7de8648bc
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
+    INIT = 0,
+    MAX = INT_MAX,
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
+} MPQemuMsg;
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
index 0000000000..d9be2bdeab
--- /dev/null
+++ b/io/mpqemu-link.c
@@ -0,0 +1,173 @@
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
+void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
+{
+    bool iolock = qemu_mutex_iothread_locked();
+    Error *local_err = NULL;
+    struct iovec send[2];
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
+
+    if (iolock) {
+        qemu_mutex_unlock_iothread();
+    }
+
+    (void)qio_channel_writev_full_all(ioc, send, G_N_ELEMENTS(send), fds, nfds,
+                                      &local_err);
+
+    if (iolock) {
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
+static ssize_t mpqemu_read(QIOChannel *ioc, void *buf, size_t len, int **fds,
+                           size_t *nfds, Error **errp)
+{
+    struct iovec iov = { .iov_base = buf, .iov_len = len };
+    bool iolock = qemu_mutex_iothread_locked();
+    struct iovec *iovp = &iov;
+    Error *local_err = NULL;
+    unsigned int niov = 1;
+    size_t *l_nfds = nfds;
+    int **l_fds = fds;
+    ssize_t bytes = 0;
+    size_t size;
+
+    iov.iov_base = buf;
+    iov.iov_len = len;
+    size = iov.iov_len;
+
+    while (size > 0) {
+        bytes = qio_channel_readv_full(ioc, iovp, niov, l_fds, l_nfds,
+                                       &local_err);
+
+        if (bytes == QIO_CHANNEL_ERR_BLOCK) {
+            if (iolock) {
+                qemu_mutex_unlock_iothread();
+            }
+
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_IN);
+            } else {
+                qio_channel_wait(ioc, G_IO_IN);
+            }
+
+            if (iolock) {
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
+    if (len < 0) {
+        goto fail;
+    } else if (len != MPQEMU_MSG_HDR_SIZE) {
+        error_setg(&local_err, "Message header corrupted");
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
+    if (msg->cmd >= MAX && msg->cmd < 0) {
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


