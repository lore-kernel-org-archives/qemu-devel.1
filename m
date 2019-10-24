Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FCC20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AS3kPjkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FCC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZbg-0002N0-A9
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZAG-0001Si-5d
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZAE-0005BE-2q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZAD-0005Ag-QD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94Md7094848;
 Thu, 24 Oct 2019 09:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=F/E41FhsIR2e21OD7DpZqakoxt8Wz7+Qliiw0Bdlxt4=;
 b=AS3kPjkgooLHwUyNncGazR/qm0hKD+BlEiL/1IN5RKzdPOeusv4yXrnp+UvdoRgoFHUx
 G3ZBGPDO+2U8jA+AznlEByFQFSTrn2zWF0TgTb2UhM3ullmfg018hg47zE9d5jIGzsMP
 4v1DP/rK4axJzJ4BYicZduWNIOPvKUlIAewThWgiVbfIJgVRtAYOKkiyXAfiPmRzddiR
 VbGxwgD2YAqjB+Xe8L8BAbREfKrya9CsY+YdcMjE5WYWn1WLB3UX2+llp9cLCpvYwi66
 EH5WNURHtqEVlRGHgfOXWKzGdiexFMTBeEumR1Q5gF5ff8oU1z5x+x4oSW/rLfr6+b27 YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2vqu4r24ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:12:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97j18170537;
 Thu, 24 Oct 2019 09:10:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2vtsk4857y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9A4Jk008991;
 Thu, 24 Oct 2019 09:10:04 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:04 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 07/49] multi-process: define mpqemu-link object
Date: Thu, 24 Oct 2019 05:08:48 -0400
Message-Id: <b0bc2a517b0a41eb138ed4127aebe8a3952daec6.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
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

Defines mpqemu-link object which forms the communication link between
QEMU & emulation program.
Adds functions to configure members of mpqemu-link object instance.
Adds functions to send and receive messages over the communication
channel.
Adds GMainLoop to handle events received on the communication channel.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v1 -> v2:
   - Use default context for main loop instead of a new context

 v2 -> v3:
   - Enabled multi-channel support in the communication link

 v3 -> v4:
  - Change the name of proxy-link to mpqemu-link
  - Use separate locks for sending and receiving messages

 include/io/mpqemu-link.h | 150 +++++++++++++++++++++++
 io/Makefile.objs         |   2 +
 io/mpqemu-link.c         | 309 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 461 insertions(+)
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
new file mode 100644
index 0000000..345c67e
--- /dev/null
+++ b/include/io/mpqemu-link.h
@@ -0,0 +1,150 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef MPQEMU_LINK_H
+#define MPQEMU_LINK_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include <stddef.h>
+#include <stdint.h>
+#include <pthread.h>
+
+#include "qom/object.h"
+#include "qemu/thread.h"
+
+#define TYPE_MPQEMU_LINK "mpqemu-link"
+#define MPQEMU_LINK(obj) \
+    OBJECT_CHECK(MPQemuLinkState, (obj), TYPE_MPQEMU_LINK)
+
+#define REMOTE_MAX_FDS 8
+
+#define MPQEMU_MSG_HDR_SIZE offsetof(MPQemuMsg, data1.u64)
+
+/**
+ * mpqemu_cmd_t:
+ * CONF_READ        PCI config. space read
+ * CONF_WRITE       PCI config. space write
+ *
+ * proc_cmd_t enum type to specify the command to be executed on the remote
+ * device.
+ */
+typedef enum {
+    INIT = 0,
+    CONF_READ,
+    CONF_WRITE,
+    MAX,
+} mpqemu_cmd_t;
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
+    mpqemu_cmd_t cmd;
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
+    uint8_t *data2;
+} MPQemuMsg;
+
+struct conf_data_msg {
+    uint32_t addr;
+    uint32_t val;
+    int l;
+};
+
+/**
+ * MPQemuChannel:
+ * @gsrc: GSource object to be used by loop
+ * @gpfd: GPollFD object containing the socket & events to monitor
+ * @sock: Socket to send/receive communication, same as the one in gpfd
+ * @send_lock: Mutex to synchronize access to the send stream
+ * @recv_lock: Mutex to synchronize access to the recv stream
+ *
+ * Defines the channel that make up the communication link
+ * between QEMU and remote process
+ */
+
+typedef struct MPQemuChannel {
+    GSource gsrc;
+    GPollFD gpfd;
+    int sock;
+    QemuMutex send_lock;
+    QemuMutex recv_lock;
+} MPQemuChannel;
+
+typedef void (*mpqemu_link_callback)(GIOCondition cond, MPQemuChannel *chan);
+
+/*
+ * MPQemuLinkState Instance info. of the communication
+ * link between QEMU and remote process. The Link could
+ * be made up of multiple channels.
+ *
+ * ctx        GMainContext to be used for communication
+ * loop       Main loop that would be used to poll for incoming data
+ * com        Communication channel to transport control messages
+ *
+ */
+
+typedef struct MPQemuLinkState {
+    Object obj;
+
+    GMainContext *ctx;
+    GMainLoop *loop;
+
+    MPQemuChannel *com;
+
+    mpqemu_link_callback callback;
+} MPQemuLinkState;
+
+MPQemuLinkState *mpqemu_link_create(void);
+void mpqemu_link_finalize(MPQemuLinkState *s);
+
+void mpqemu_msg_send(MPQemuLinkState *s, MPQemuMsg *msg, MPQemuChannel *chan);
+int mpqemu_msg_recv(MPQemuLinkState *s, MPQemuMsg *msg, MPQemuChannel *chan);
+
+void mpqemu_init_channel(MPQemuLinkState *s, MPQemuChannel **chan, int fd);
+void mpqemu_destroy_channel(MPQemuChannel *chan);
+void mpqemu_link_set_callback(MPQemuLinkState *s, mpqemu_link_callback callback);
+void mpqemu_start_coms(MPQemuLinkState *s);
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
index 0000000..b39f4d0
--- /dev/null
+++ b/io/mpqemu-link.c
@@ -0,0 +1,309 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include <assert.h>
+#include <errno.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <limits.h>
+#include <poll.h>
+
+#include "qemu/module.h"
+#include "io/mpqemu-link.h"
+#include "qemu/log.h"
+
+GSourceFuncs gsrc_funcs;
+
+static void mpqemu_link_inst_init(Object *obj)
+{
+    MPQemuLinkState *s = MPQEMU_LINK(obj);
+
+    s->ctx = g_main_context_default();
+    s->loop = g_main_loop_new(s->ctx, FALSE);
+}
+
+static const TypeInfo mpqemu_link_info = {
+    .name = TYPE_MPQEMU_LINK,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(MPQemuLinkState),
+    .instance_init = mpqemu_link_inst_init,
+};
+
+static void mpqemu_link_register_types(void)
+{
+    type_register_static(&mpqemu_link_info);
+}
+
+type_init(mpqemu_link_register_types)
+
+MPQemuLinkState *mpqemu_link_create(void)
+{
+    return MPQEMU_LINK(object_new(TYPE_MPQEMU_LINK));
+}
+
+void mpqemu_link_finalize(MPQemuLinkState *s)
+{
+    g_main_loop_unref(s->loop);
+    g_main_context_unref(s->ctx);
+    g_main_loop_quit(s->loop);
+
+    mpqemu_destroy_channel(s->com);
+
+    object_unref(OBJECT(s));
+}
+
+void mpqemu_msg_send(MPQemuLinkState *s, MPQemuMsg *msg, MPQemuChannel *chan)
+{
+    int rc;
+    uint8_t *data;
+    union {
+        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
+        struct cmsghdr align;
+    } u;
+    struct msghdr hdr;
+    struct cmsghdr *chdr;
+    int sock = chan->sock;
+    QemuMutex *lock = &chan->send_lock;
+
+    struct iovec iov = {
+        .iov_base = (char *) msg,
+        .iov_len = MPQEMU_MSG_HDR_SIZE,
+    };
+
+    memset(&hdr, 0, sizeof(hdr));
+    memset(&u, 0, sizeof(u));
+
+    hdr.msg_iov = &iov;
+    hdr.msg_iovlen = 1;
+
+    if (msg->num_fds > REMOTE_MAX_FDS) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func__);
+        return;
+    }
+
+    if (msg->num_fds > 0) {
+        size_t fdsize = msg->num_fds * sizeof(int);
+
+        hdr.msg_control = &u;
+        hdr.msg_controllen = sizeof(u);
+
+        chdr = CMSG_FIRSTHDR(&hdr);
+        chdr->cmsg_len = CMSG_LEN(fdsize);
+        chdr->cmsg_level = SOL_SOCKET;
+        chdr->cmsg_type = SCM_RIGHTS;
+        memcpy(CMSG_DATA(chdr), msg->fds, fdsize);
+        hdr.msg_controllen = CMSG_SPACE(fdsize);
+    }
+
+    qemu_mutex_lock(lock);
+
+    do {
+        rc = sendmsg(sock, &hdr, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - sendmsg rc is %d, errno is %d,"
+                      " sock %d\n", __func__, rc, errno, sock);
+        qemu_mutex_unlock(lock);
+        return;
+    }
+
+    if (msg->bytestream) {
+        data = msg->data2;
+    } else {
+        data = (uint8_t *)msg + MPQEMU_MSG_HDR_SIZE;
+    }
+
+    do {
+        rc = write(sock, data, msg->size);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    qemu_mutex_unlock(lock);
+}
+
+
+int mpqemu_msg_recv(MPQemuLinkState *s, MPQemuMsg *msg, MPQemuChannel *chan)
+{
+    int rc;
+    uint8_t *data;
+    union {
+        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
+        struct cmsghdr align;
+    } u;
+    struct msghdr hdr;
+    struct cmsghdr *chdr;
+    size_t fdsize;
+    int sock = chan->sock;
+    QemuMutex *lock = &chan->recv_lock;
+
+    struct iovec iov = {
+        .iov_base = (char *) msg,
+        .iov_len = MPQEMU_MSG_HDR_SIZE,
+    };
+
+    memset(&hdr, 0, sizeof(hdr));
+    memset(&u, 0, sizeof(u));
+
+    hdr.msg_iov = &iov;
+    hdr.msg_iovlen = 1;
+    hdr.msg_control = &u;
+    hdr.msg_controllen = sizeof(u);
+
+    qemu_mutex_lock(lock);
+
+    do {
+        rc = recvmsg(sock, &hdr, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, errno is %d,"
+                      " sock %d\n", __func__, rc, errno, sock);
+        qemu_mutex_unlock(lock);
+        return rc;
+    }
+
+    msg->num_fds = 0;
+    for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
+         chdr = CMSG_NXTHDR(&hdr, chdr)) {
+        if ((chdr->cmsg_level == SOL_SOCKET) &&
+            (chdr->cmsg_type == SCM_RIGHTS)) {
+            fdsize = chdr->cmsg_len - CMSG_LEN(0);
+            msg->num_fds = fdsize / sizeof(int);
+            if (msg->num_fds > REMOTE_MAX_FDS) {
+                /*
+                 * TODO: Security issue detected. Sender never sends more
+                 * than REMOTE_MAX_FDS. This condition should be signaled to
+                 * the admin
+                 */
+                qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func__);
+                return -ERANGE;
+            }
+
+            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
+            break;
+        }
+    }
+
+    if (msg->size && msg->bytestream) {
+        msg->data2 = calloc(1, msg->size);
+        data = msg->data2;
+    } else {
+        data = (uint8_t *)&msg->data1;
+    }
+
+    if (msg->size) {
+        do {
+            rc = read(sock, data, msg->size);
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    }
+
+    qemu_mutex_unlock(lock);
+
+    return rc;
+}
+
+static gboolean mpqemu_link_handler_prepare(GSource *gsrc, gint *timeout)
+{
+    g_assert(timeout);
+
+    *timeout = -1;
+
+    return FALSE;
+}
+
+static gboolean mpqemu_link_handler_check(GSource *gsrc)
+{
+    MPQemuChannel *chan = (MPQemuChannel *)gsrc;
+
+    return chan->gpfd.events & chan->gpfd.revents;
+}
+
+static gboolean mpqemu_link_handler_dispatch(GSource *gsrc, GSourceFunc func,
+                                             gpointer data)
+{
+    MPQemuLinkState *s = (MPQemuLinkState *)data;
+    MPQemuChannel *chan = (MPQemuChannel *)gsrc;
+
+    s->callback(chan->gpfd.revents, chan);
+
+    if ((chan->gpfd.revents & G_IO_HUP) || (chan->gpfd.revents & G_IO_ERR)) {
+        return G_SOURCE_REMOVE;
+    }
+
+    return G_SOURCE_CONTINUE;
+}
+
+void mpqemu_link_set_callback(MPQemuLinkState *s, mpqemu_link_callback callback)
+{
+    s->callback = callback;
+}
+
+void mpqemu_init_channel(MPQemuLinkState *s, MPQemuChannel **chan, int fd)
+{
+    MPQemuChannel *src;
+
+    gsrc_funcs = (GSourceFuncs){
+        .prepare = mpqemu_link_handler_prepare,
+        .check = mpqemu_link_handler_check,
+        .dispatch = mpqemu_link_handler_dispatch,
+        .finalize = NULL,
+    };
+
+    src = (MPQemuChannel *)g_source_new(&gsrc_funcs, sizeof(MPQemuChannel));
+
+    src->sock = fd;
+    qemu_mutex_init(&src->send_lock);
+    qemu_mutex_init(&src->recv_lock);
+
+    g_source_set_callback(&src->gsrc, NULL, (gpointer)s, NULL);
+    src->gpfd.fd = fd;
+    src->gpfd.events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+    g_source_add_poll(&src->gsrc, &src->gpfd);
+
+    *chan = src;
+}
+
+void mpqemu_destroy_channel(MPQemuChannel *chan)
+{
+    g_source_unref(&chan->gsrc);
+    close(chan->sock);
+    qemu_mutex_destroy(&chan->send_lock);
+    qemu_mutex_destroy(&chan->recv_lock);
+}
+
+void mpqemu_start_coms(MPQemuLinkState *s)
+{
+
+    g_assert(g_source_attach(&s->com->gsrc, s->ctx));
+
+    g_main_loop_run(s->loop);
+}
-- 
1.8.3.1


