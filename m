Received: from eggs.gnu.org ([2001:4830:134:3::10]:60832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Ax-0008C7-P8
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Aq-0006UA-6I
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gB7Ao-0006RE-0M
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w9CNiv6W127456
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp2130.oracle.com with ESMTP id 2mxmfudn5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmjp1030998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:45 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmja2023378
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:45 GMT
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Fri, 12 Oct 2018 19:48:29 -0400
Message-Id: <cd5408610fe2c3db707e0164b50013c7a15e17bd.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [RFC PATCH v1 2/8] multi-process QEMU: define
 proxy-link object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: john.g.johnson@oracle.com, Kanth.Ghatraju@oracle.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com

- Define proxy-link object which forms the communication link between
  QEMU & emulation program.
- Add functions to configure members of proxy-link object instance.
- Add functions to send and receive messages over the communication
  channel.
- Add GMainLoop to handle events received on the communication channel.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 include/glib-compat.h   |   4 +
 include/io/proxy-link.h | 103 +++++++++++++++++++
 io/Makefile.objs        |   1 +
 io/proxy-link.c         | 263 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 include/io/proxy-link.h
 create mode 100644 io/proxy-link.c

diff --git a/include/glib-compat.h b/include/glib-compat.h
index fdf95a2..5e61d82 100644
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
index 0000000..6ce6c10
--- /dev/null
+++ b/include/io/proxy-link.h
@@ -0,0 +1,103 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright 2018, Oracle and/or its affiliates. All rights reserved.
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
+
+typedef struct ProxyLinkState ProxyLinkState;
+
+#define TYPE_PROXY_LINK "proxy-link"
+#define PROXY_LINK(obj) \
+    OBJECT_CHECK(ProxyLinkState, (obj), TYPE_PROXY_LINK)
+
+#define MAX_FDS 8
+
+#define PROC_HDR_SIZE offsetof(ProcMsg, data1.u64)
+
+typedef enum {
+    INIT = 0,
+    CONF_READ,
+    CONF_WRITE,
+    MAX,
+} proc_cmd_t;
+
+typedef struct {
+    proc_cmd_t cmd;
+    int bytestream;
+    size_t size;
+
+    union {
+        uint64_t u64;
+    } data1;
+
+    int fds[MAX_FDS];
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
+struct ProxyLinkState {
+    Object obj;
+
+    GMainContext *ctx;
+    GMainLoop *loop;
+    ProxySrc *src;
+
+    int sock;
+    pthread_mutex_t lock;
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
index 9a20fce..141e9ed 100644
--- a/io/Makefile.objs
+++ b/io/Makefile.objs
@@ -10,3 +10,4 @@ io-obj-y += channel-util.o
 io-obj-y += dns-resolver.o
 io-obj-y += net-listener.o
 io-obj-y += task.o
+io-obj-y += proxy-link.o
diff --git a/io/proxy-link.c b/io/proxy-link.c
new file mode 100644
index 0000000..f5f7887
--- /dev/null
+++ b/io/proxy-link.c
@@ -0,0 +1,263 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright 2018, Oracle and/or its affiliates. All rights reserved.
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
+
+static void proxy_link_inst_init(Object *obj)
+{
+    ProxyLinkState *s = PROXY_LINK(obj);
+
+    pthread_mutex_init(&s->lock, NULL);
+
+    s->sock = STDIN_FILENO;
+    s->ctx = g_main_context_new();
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
+    object_unref(OBJECT(s));
+}
+
+void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg)
+{
+    int rc;
+    uint8_t *data;
+    char control[CMSG_SPACE(MAX_FDS * sizeof(int))] = { };
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
+    assert(msg->num_fds <= MAX_FDS);
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
+    pthread_mutex_lock(&s->lock);
+
+    do {
+        rc = sendmsg(s->sock, &hdr, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        pthread_mutex_unlock(&s->lock);
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
+    pthread_mutex_unlock(&s->lock);
+}
+
+
+int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg)
+{
+    int rc;
+    uint8_t *data;
+    char control[CMSG_SPACE(MAX_FDS * sizeof(int))] = { };
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
+    pthread_mutex_lock(&s->lock);
+
+    do {
+        rc = recvmsg(s->sock, &hdr, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        pthread_mutex_unlock(&s->lock);
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
+    pthread_mutex_unlock(&s->lock);
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
+GSourceFuncs gsrc_funcs = (GSourceFuncs){
+    .prepare = proxy_link_handler_prepare,
+    .check = proxy_link_handler_check,
+    .dispatch = proxy_link_handler_dispatch,
+    .finalize = NULL,
+};
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
+    ProxySrc *src = (ProxySrc *)g_source_new(&gsrc_funcs, sizeof(ProxySrc));
+
+    g_source_set_callback(&src->gsrc, NULL, (gpointer)s, NULL);
+
+    src->gpfd.fd = s->sock;
+    src->gpfd.events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+    g_source_add_poll(&src->gsrc, &src->gpfd);
+    g_assert(g_source_attach(&src->gsrc, s->ctx));
+    s->src = src;
+
+    g_main_loop_run(s->loop);
+}
-- 
1.8.3.1
