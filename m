Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AA9C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DC720B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BmP2BWpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DC720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwEe-0007ZN-Th
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAJ-000593-9L
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAG-00018M-5X
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAF-000178-OJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8kX5149217;
 Mon, 17 Jun 2019 18:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=UyK3zkxmP+RF5OK1eFM3wHGEgIEkAjDWj4q/n2YLGOM=;
 b=BmP2BWpqvYpv9kgX/LBsH6bpk+f1//GPh953PRS2IWQ6nbWhmMUsS9lusjFvqYUL+5hB
 ujNJJ0HiYOIvUERjEt6koT9Jz8Q5l9TKYV1svXyadCWJOsNABfhE8XSg35NSrtTrPeI1
 PuslrLlXvLTOC1w+1xlLbvKnv2mLQKHeWovNEHsCUR6BPx1M6NeDH0EaPI9qpHPma9c9
 JA8XCYpIt0gL8jmAlLWf5o1AiCy9DifaB/3EHKZ0O+jkYTUbOyOa2ryEqtT10UsqngvX
 80O6gHeMuSLTqlAv52GUKcPp4UhR/4gRGSDy9kqk0ubvvnHLJeUU7k5Cbosvk4AtZGv7 Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t4r3tg2u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF9Tn117968;
 Mon, 17 Jun 2019 18:15:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t5cpdkejj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIFSTK027776;
 Mon, 17 Jun 2019 18:15:28 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:15:28 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:15:25 -0700
Message-Id: <20190617181525.29419-1-elena.ufimtseva@oracle.com>
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
Subject: [Qemu-devel] [RFC PATCH v2 07/35] multi-process: define proxy-link
 object
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

Defines proxy-link object which forms the communication link between
QEMU & emulation program.
Adds functions to configure members of proxy-link object instance.
Adds functions to send and receive messages over the communication
channel.
Adds GMainLoop to handle events received on the communication channel.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Changes in v2:
 - Use default context for main loop instead of a new context;
---
 include/glib-compat.h   |   4 +
 include/io/proxy-link.h | 136 ++++++++++++++++++++
 io/Makefile.objs        |   2 +
 io/proxy-link.c         | 275 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 417 insertions(+)
 create mode 100644 include/io/proxy-link.h
 create mode 100644 io/proxy-link.c

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 1291628e09..6189b9a41d 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -19,12 +19,16 @@
 /* Ask for warnings for anything that was marked deprecated in
  * the defined version, or before. It is a candidate for rewrite.
  */
+#ifndef GLIB_VERSION_MIN_REQUIRED
 #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
+#endif
 
 /* Ask for warnings if code tries to use function that did not
  * exist in the defined version. These risk breaking builds
  */
+#ifndef GLIB_VERSION_MAX_ALLOWED
 #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
+#endif
 
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
new file mode 100644
index 0000000000..fb266ca2a8
--- /dev/null
+++ b/include/io/proxy-link.h
@@ -0,0 +1,136 @@
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
+#ifndef PROXY_LINK_H
+#define PROXY_LINK_H
+
+#include <stddef.h>
+#include <stdint.h>
+#include <glib.h>
+#include <pthread.h>
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "qemu/thread.h"
+
+typedef struct ProxyLinkState ProxyLinkState;
+
+#define TYPE_PROXY_LINK "proxy-link"
+#define PROXY_LINK(obj) \
+    OBJECT_CHECK(ProxyLinkState, (obj), TYPE_PROXY_LINK)
+
+#define REMOTE_MAX_FDS 8
+
+#define PROC_HDR_SIZE offsetof(ProcMsg, data1.u64)
+
+/*
+ * proc_cmd_t enum type to specify the command to be executed on the remote
+ * device
+ *
+ * Following commands are supported:
+ * CONF_READ        PCI config. space read
+ * CONF_WRITE       PCI config. space write
+ *
+ */
+typedef enum {
+    INIT = 0,
+    CONF_READ,
+    CONF_WRITE,
+    MAX,
+} proc_cmd_t;
+
+/*
+ * ProcMsg Format of the message sent to the remote device from QEMU
+ *
+ * cmd         The remote command
+ * bytestream  Indicates if the data to be shared is structured (data1)
+ *             or unstructured (data2)
+ * size        Size of the data to be shared
+ * data1       Structured data
+ * fds         File descriptors to be shared with remote device
+ * data2       Unstructured data
+ *
+ */
+typedef struct {
+    proc_cmd_t cmd;
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
+} ProcMsg;
+
+struct conf_data_msg {
+    uint32_t addr;
+    uint32_t val;
+    int l;
+};
+
+typedef void (*proxy_link_callback)(GIOCondition cond);
+
+typedef struct ProxySrc {
+    GSource gsrc;
+    GPollFD gpfd;
+} ProxySrc;
+
+/*
+ * ProxyLinkState Instance info. of the communication
+ * link between QEMU and remote process
+ *
+ * ctx        GMainContext to be used for communication
+ * loop       Main loop that would be used to poll for incoming data
+ * src        Source fds to poll on, and which events to poll on
+ * sock       Unix socket used for the link
+ * lock       Lock to synchronize access to the link
+ *
+ */
+struct ProxyLinkState {
+    Object obj;
+
+    GMainContext *ctx;
+    GMainLoop *loop;
+    ProxySrc *src;
+
+    int sock;
+    QemuMutex lock;
+
+    proxy_link_callback callback;
+};
+
+ProxyLinkState *proxy_link_create(void);
+void proxy_link_finalize(ProxyLinkState *s);
+
+void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg);
+int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg);
+void proxy_link_set_sock(ProxyLinkState *s, int fd);
+void proxy_link_set_callback(ProxyLinkState *s, proxy_link_callback callback);
+void start_handler(ProxyLinkState *s);
+
+#endif
diff --git a/io/Makefile.objs b/io/Makefile.objs
index 9a20fce4ed..ff88b46c90 100644
--- a/io/Makefile.objs
+++ b/io/Makefile.objs
@@ -10,3 +10,5 @@ io-obj-y += channel-util.o
 io-obj-y += dns-resolver.o
 io-obj-y += net-listener.o
 io-obj-y += task.o
+
+io-obj-$(CONFIG_MPQEMU) += proxy-link.o
diff --git a/io/proxy-link.c b/io/proxy-link.c
new file mode 100644
index 0000000000..75e0bb5e27
--- /dev/null
+++ b/io/proxy-link.c
@@ -0,0 +1,275 @@
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
+#include <assert.h>
+#include <errno.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include "qemu/module.h"
+#include "io/proxy-link.h"
+#include "qemu/log.h"
+
+static void proxy_link_inst_init(Object *obj)
+{
+    ProxyLinkState *s = PROXY_LINK(obj);
+
+    qemu_mutex_init(&s->lock);
+
+    s->sock = STDIN_FILENO;
+    s->ctx = g_main_context_default();
+    s->loop = g_main_loop_new(s->ctx, FALSE);
+}
+
+static const TypeInfo proxy_link_info = {
+    .name = TYPE_PROXY_LINK,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(ProxyLinkState),
+    .instance_init = proxy_link_inst_init,
+};
+
+static void proxy_link_register_types(void)
+{
+    type_register_static(&proxy_link_info);
+}
+
+type_init(proxy_link_register_types)
+
+ProxyLinkState *proxy_link_create(void)
+{
+    return PROXY_LINK(object_new(TYPE_PROXY_LINK));
+}
+
+void proxy_link_finalize(ProxyLinkState *s)
+{
+    g_source_unref(&s->src->gsrc);
+    g_main_loop_unref(s->loop);
+    g_main_context_unref(s->ctx);
+    g_main_loop_quit(s->loop);
+
+    close(s->sock);
+
+    qemu_mutex_destroy(&s->lock);
+
+    object_unref(OBJECT(s));
+}
+
+void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg)
+{
+    int rc;
+    uint8_t *data;
+    char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))] = { };
+    struct msghdr hdr;
+    struct cmsghdr *chdr;
+
+    struct iovec iov = {
+        .iov_base = (char *) msg,
+        .iov_len = PROC_HDR_SIZE,
+    };
+
+    memset(&hdr, 0, sizeof(hdr));
+    memset(control, 0, sizeof(control));
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
+        hdr.msg_control = control;
+        hdr.msg_controllen = sizeof(control);
+
+        chdr = CMSG_FIRSTHDR(&hdr);
+        chdr->cmsg_len = CMSG_LEN(fdsize);
+        chdr->cmsg_level = SOL_SOCKET;
+        chdr->cmsg_type = SCM_RIGHTS;
+        memcpy(CMSG_DATA(chdr), msg->fds, fdsize);
+        hdr.msg_controllen = chdr->cmsg_len;
+    }
+
+    qemu_mutex_lock(&s->lock);
+
+    do {
+        rc = sendmsg(s->sock, &hdr, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - sendmsg rc is %d, errno is %d,"
+                      " sock %d\n", __func__, rc, errno, s->sock);
+        qemu_mutex_unlock(&s->lock);
+        return;
+    }
+
+    if (msg->bytestream) {
+        data = msg->data2;
+    } else {
+        data = (uint8_t *)msg + PROC_HDR_SIZE;
+    }
+
+    do {
+        rc = write(s->sock, data, msg->size);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    qemu_mutex_unlock(&s->lock);
+}
+
+
+int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg)
+{
+    int rc;
+    uint8_t *data;
+    char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))] = { };
+    struct msghdr hdr;
+    struct cmsghdr *chdr;
+    size_t fdsize;
+
+    struct iovec iov = {
+        .iov_base = (char *) msg,
+        .iov_len = PROC_HDR_SIZE,
+    };
+
+    memset(&hdr, 0, sizeof(hdr));
+    memset(control, 0, sizeof(control));
+
+    hdr.msg_iov = &iov;
+    hdr.msg_iovlen = 1;
+    hdr.msg_control = control;
+    hdr.msg_controllen = sizeof(control);
+
+    qemu_mutex_lock(&s->lock);
+
+    do {
+        rc = recvmsg(s->sock, &hdr, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, errno is %d,"
+                      " sock %d\n", __func__, rc, errno, s->sock);
+        qemu_mutex_unlock(&s->lock);
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
+            rc = read(s->sock, data, msg->size);
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    }
+
+    qemu_mutex_unlock(&s->lock);
+
+    return rc;
+}
+
+static gboolean proxy_link_handler_prepare(GSource *gsrc, gint *timeout)
+{
+    g_assert(timeout);
+
+    *timeout = -1;
+
+    return FALSE;
+}
+
+static gboolean proxy_link_handler_check(GSource *gsrc)
+{
+    ProxySrc *src = (ProxySrc *)gsrc;
+
+    return src->gpfd.events & src->gpfd.revents;
+}
+
+static gboolean proxy_link_handler_dispatch(GSource *gsrc, GSourceFunc func,
+                                            gpointer data)
+{
+    ProxySrc *src = (ProxySrc *)gsrc;
+    ProxyLinkState *s = (ProxyLinkState *)data;
+
+    s->callback(src->gpfd.revents);
+
+    if ((src->gpfd.revents & G_IO_HUP) || (src->gpfd.revents & G_IO_ERR)) {
+        return G_SOURCE_REMOVE;
+    }
+
+    return G_SOURCE_CONTINUE;
+}
+
+void proxy_link_set_sock(ProxyLinkState *s, int fd)
+{
+    s->sock = fd;
+}
+
+void proxy_link_set_callback(ProxyLinkState *s, proxy_link_callback callback)
+{
+    s->callback = callback;
+}
+
+void start_handler(ProxyLinkState *s)
+{
+    GSourceFuncs gsrc_funcs = (GSourceFuncs){
+        .prepare = proxy_link_handler_prepare,
+        .check = proxy_link_handler_check,
+        .dispatch = proxy_link_handler_dispatch,
+        .finalize = NULL,
+    };
+    ProxySrc *src = (ProxySrc *)g_source_new(&gsrc_funcs, sizeof(ProxySrc));
+    guint id;
+
+    g_source_set_callback(&src->gsrc, NULL, (gpointer)s, NULL);
+
+    src->gpfd.fd = s->sock;
+    src->gpfd.events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+    g_source_add_poll(&src->gsrc, &src->gpfd);
+    id = g_source_attach(&src->gsrc, s->ctx);
+    g_assert(id);
+    s->src = src;
+
+    g_main_loop_run(s->loop);
+}
-- 
2.17.1


