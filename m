Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4027FC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6E22071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KauCM6PM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6E22071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTZ0-0004gV-1B
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIH-0003PV-2P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIF-0002dr-Uv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTIF-0002ZF-Dw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DMnV064457;
 Thu, 23 Apr 2020 04:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AW+8nck3N8h4MV3vqVps0Op8AEkMfrVcfHPd3UUNOXU=;
 b=KauCM6PMthKrXKC16huWogjIre8JV92wtrAjR1yy7Qr31xj83a21fXwtfqvK4r+CZeH7
 b5tkrt0wybfNmbECSGycEdn6qWfS8ANl/PlT8zwd4xmvo2SKDBmX3c6hkrAh3oUKFGlL
 aCVgcPd4HsJf7cPRNsTFGXhMQVdi5TlIXNwFTxzvaDn5kYiTpdMalfbyALmbGR3aIZuc
 D1YW8JEXDe9Jq0t3KChCeC/bAgGjg0T2OamiqJ7s/yYphVjrgWcTQeGcFoMbFzH5Gsyj
 HnRdXuIJFWU2VZ5KzcFyuBHq/gI6/IvD5dK39U7VbfkFZHGNXRakZ4Rzh7tkHAEd9vP3 Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 30grpgtrwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:16:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CJCL089372;
 Thu, 23 Apr 2020 04:14:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 30gb1ku7u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:47 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4EjB8020204;
 Thu, 23 Apr 2020 04:14:45 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:41 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 11/36] multi-process: define mpqemu-link object
Date: Wed, 22 Apr 2020 21:13:46 -0700
Message-Id: <8ffca5a79b71ebe0f183707db34f59562faee71f.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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

From: Jagannathan Raman <jag.raman@oracle.com>

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
 MAINTAINERS              |   2 +
 include/io/mpqemu-link.h | 127 ++++++++++++++++
 io/Makefile.objs         |   2 +
 io/mpqemu-link.c         | 312 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 443 insertions(+)
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 965f34d4f9..93ad693da4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2857,6 +2857,8 @@ M: John G Johnson <john.g.johnson@oracle.com>
 S: Maintained
 F: remote/Makefile.objs
 F: remote/remote-main.c
+F: include/io/mpqemu-link.h
+F: io/mpqemu-link.c
 
 Build and test automation
 -------------------------
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
new file mode 100644
index 0000000000..af401e640c
--- /dev/null
+++ b/include/io/mpqemu-link.h
@@ -0,0 +1,127 @@
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
+ *
+ * proc_cmd_t enum type to specify the command to be executed on the remote
+ * device.
+ */
+typedef enum {
+    INIT = 0,
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
+typedef struct MPQemuLinkState MPQemuLinkState;
+
+typedef void (*mpqemu_link_callback)(GIOCondition cond, MPQemuLinkState *link,
+                                     MPQemuChannel *chan);
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
+struct MPQemuLinkState {
+    Object obj;
+
+    GMainContext *ctx;
+    GMainLoop *loop;
+
+    MPQemuChannel *com;
+
+    mpqemu_link_callback callback;
+};
+
+MPQemuLinkState *mpqemu_link_create(void);
+void mpqemu_link_finalize(MPQemuLinkState *s);
+
+void mpqemu_msg_send(MPQemuMsg *msg, MPQemuChannel *chan);
+int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan);
+
+void mpqemu_init_channel(MPQemuLinkState *s, MPQemuChannel **chan, int fd);
+void mpqemu_destroy_channel(MPQemuChannel *chan);
+void mpqemu_link_set_callback(MPQemuLinkState *s,
+                              mpqemu_link_callback callback);
+void mpqemu_start_coms(MPQemuLinkState *s, MPQemuChannel* chan);
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
index 0000000000..48f53a8928
--- /dev/null
+++ b/io/mpqemu-link.c
@@ -0,0 +1,312 @@
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
+#include "qemu/log.h"
+#include "qemu/lockable.h"
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
+    MPQemuLinkState *link = MPQEMU_LINK(object_new(TYPE_MPQEMU_LINK));
+
+    link->com = NULL;
+
+    return link;
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
+void mpqemu_msg_send(MPQemuMsg *msg, MPQemuChannel *chan)
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
+    WITH_QEMU_LOCK_GUARD(lock) {
+        do {
+            rc = sendmsg(sock, &hdr, 0);
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+        if (rc < 0) {
+            qemu_log_mask(LOG_REMOTE_DEBUG, "%s - sendmsg rc is %d, "
+                          "errno is %d, sock %d\n", __func__, rc, errno, sock);
+            return;
+        }
+
+        if (msg->bytestream) {
+            data = msg->data2;
+        } else {
+            data = (uint8_t *)msg + MPQEMU_MSG_HDR_SIZE;
+        }
+
+        do {
+            rc = write(sock, data, msg->size);
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    }
+}
+
+
+int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan)
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
+    WITH_QEMU_LOCK_GUARD(lock) {
+        do {
+            rc = recvmsg(sock, &hdr, 0);
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+        if (rc < 0) {
+            qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, "
+                          "errno is %d, sock %d\n", __func__, rc, errno, sock);
+            return rc;
+        }
+
+        msg->num_fds = 0;
+        for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
+             chdr = CMSG_NXTHDR(&hdr, chdr)) {
+            if ((chdr->cmsg_level == SOL_SOCKET) &&
+                (chdr->cmsg_type == SCM_RIGHTS)) {
+                fdsize = chdr->cmsg_len - CMSG_LEN(0);
+                msg->num_fds = fdsize / sizeof(int);
+                if (msg->num_fds > REMOTE_MAX_FDS) {
+                    qemu_log_mask(LOG_REMOTE_DEBUG,
+                                  "%s: Max FDs exceeded\n", __func__);
+                    return -ERANGE;
+                }
+
+                memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
+                break;
+            }
+        }
+
+        if (msg->bytestream) {
+            if (!msg->size) {
+                qemu_mutex_unlock(lock);
+                return -EINVAL;
+            }
+
+            msg->data2 = calloc(1, msg->size);
+            data = msg->data2;
+        } else {
+            data = (uint8_t *)&msg->data1;
+        }
+
+        if (msg->size) {
+            do {
+                rc = read(sock, data, msg->size);
+            } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+        }
+    }
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
+    s->callback(chan->gpfd.revents, s, chan);
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
+void mpqemu_start_coms(MPQemuLinkState *s, MPQemuChannel* chan)
+{
+    g_assert(g_source_attach(&chan->gsrc, s->ctx));
+
+    g_main_loop_run(s->loop);
+}
+
+bool mpqemu_msg_valid(MPQemuMsg *msg)
+{
+    if (msg->cmd >= MAX) {
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


