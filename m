Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E3C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97C02176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IdeKf6Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97C02176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kur-0003i8-Ng
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km2-0005zG-GR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km0-0002uK-At
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km0-0002sE-1j
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrgVA164183;
 Mon, 24 Feb 2020 20:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=nE7Z5dONy9c4i9FPkTxs3CicaKlqTAunrxR/XPUCevM=;
 b=IdeKf6Bwct3KLHv6zWFWQ/hKnBG5Cf8qwQrSDk2La4fAbBGAjrD4mMs8/ijHnR7mY5DU
 b3kI3QiHGz1YsEfhHBOGJ/cVL4j2ymeImEJW4HJjyJGeW06WiN1Q15iDzVIzKx61JKdl
 QBtgPAgSZw39Eo5oh/I3HhHimfJHVicZJ5X8EVBXdc6Cj4drRQybAdrQCFWbirD+zxh5
 nd6HV7B7ZgQyiiehrGmCbLpinwQyQMRVJ9Ifk8NdzEcTkCELOiR0KpL8EUoYl1BbnBW/
 V6MiIgZAei+OMYDgAFhF4hgLl1WODH3cAoU9yJZrYUzxei6GBJ+g1LYFrz+mtYkgUMBN jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p932-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqjfd017311;
 Mon, 24 Feb 2020 20:56:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2ybduv6cn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:08 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKu7CP007766;
 Mon, 24 Feb 2020 20:56:07 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:07 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/50] multi-process: define mpqemu-link object
Date: Mon, 24 Feb 2020 15:54:58 -0500
Message-Id: <20ec6f6666cc8adb211642156f5230e478143b81.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 01OKrgVA164183
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
 v4 -> v5:
  - Cleaned up included header files

 include/io/mpqemu-link.h | 138 ++++++++++++++++++++++
 io/Makefile.objs         |   2 +
 io/mpqemu-link.c         | 294 +++++++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 434 insertions(+)
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c

diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
new file mode 100644
index 0000000..2f2dd83
--- /dev/null
+++ b/include/io/mpqemu-link.h
@@ -0,0 +1,138 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
+/*
+ * TODO: Dont use mpqemu link object since it is
+ * not needed to be created via -object.
+ */
+
+/**
+ * mpqemu_cmd_t:
+ * PCI_CONFIG_READ        PCI configuration space read
+ * PCI_CONFIG_WRITE       PCI configuration space write
+ *
+ * proc_cmd_t enum type to specify the command to be executed on the rem=
ote
+ * device.
+ */
+typedef enum {
+    INIT =3D 0,
+    PCI_CONFIG_READ,
+    PCI_CONFIG_WRITE,
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
+typedef void (*mpqemu_link_callback)(GIOCondition cond, MPQemuChannel *c=
han);
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
+void mpqemu_msg_send(MPQemuMsg *msg, MPQemuChannel *chan);
+int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan);
+
+void mpqemu_init_channel(MPQemuLinkState *s, MPQemuChannel **chan, int f=
d);
+void mpqemu_destroy_channel(MPQemuChannel *chan);
+void mpqemu_link_set_callback(MPQemuLinkState *s,
+                              mpqemu_link_callback callback);
+void mpqemu_start_coms(MPQemuLinkState *s);
+
+#endif
diff --git a/io/Makefile.objs b/io/Makefile.objs
index 9a20fce..5875ab0 100644
--- a/io/Makefile.objs
+++ b/io/Makefile.objs
@@ -10,3 +10,5 @@ io-obj-y +=3D channel-util.o
 io-obj-y +=3D dns-resolver.o
 io-obj-y +=3D net-listener.o
 io-obj-y +=3D task.o
+
+io-obj-$(CONFIG_MPQEMU) +=3D mpqemu-link.o
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
new file mode 100644
index 0000000..bac120b
--- /dev/null
+++ b/io/mpqemu-link.c
@@ -0,0 +1,294 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
+
+GSourceFuncs gsrc_funcs;
+
+/*
+ * TODO: make all communications asynchronous and run in the main
+ * loop or existing IOThread.
+ */
+
+static void mpqemu_link_inst_init(Object *obj)
+{
+    MPQemuLinkState *s =3D MPQEMU_LINK(obj);
+
+    s->ctx =3D g_main_context_default();
+    s->loop =3D g_main_loop_new(s->ctx, FALSE);
+}
+
+static const TypeInfo mpqemu_link_info =3D {
+    .name =3D TYPE_MPQEMU_LINK,
+    .parent =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(MPQemuLinkState),
+    .instance_init =3D mpqemu_link_inst_init,
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
+    int sock =3D chan->sock;
+    QemuMutex *lock =3D &chan->send_lock;
+
+    struct iovec iov =3D {
+        .iov_base =3D (char *) msg,
+        .iov_len =3D MPQEMU_MSG_HDR_SIZE,
+    };
+
+    memset(&hdr, 0, sizeof(hdr));
+    memset(&u, 0, sizeof(u));
+
+    hdr.msg_iov =3D &iov;
+    hdr.msg_iovlen =3D 1;
+
+    if (msg->num_fds > REMOTE_MAX_FDS) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func=
__);
+        return;
+    }
+
+    if (msg->num_fds > 0) {
+        size_t fdsize =3D msg->num_fds * sizeof(int);
+
+        hdr.msg_control =3D &u;
+        hdr.msg_controllen =3D sizeof(u);
+
+        chdr =3D CMSG_FIRSTHDR(&hdr);
+        chdr->cmsg_len =3D CMSG_LEN(fdsize);
+        chdr->cmsg_level =3D SOL_SOCKET;
+        chdr->cmsg_type =3D SCM_RIGHTS;
+        memcpy(CMSG_DATA(chdr), msg->fds, fdsize);
+        hdr.msg_controllen =3D CMSG_SPACE(fdsize);
+    }
+
+    qemu_mutex_lock(lock);
+
+    do {
+        rc =3D sendmsg(sock, &hdr, 0);
+    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
+    if (rc < 0) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - sendmsg rc is %d, errno is=
 %d,"
+                      " sock %d\n", __func__, rc, errno, sock);
+        qemu_mutex_unlock(lock);
+        return;
+    }
+
+    if (msg->bytestream) {
+        data =3D msg->data2;
+    } else {
+        data =3D (uint8_t *)msg + MPQEMU_MSG_HDR_SIZE;
+    }
+
+    do {
+        rc =3D write(sock, data, msg->size);
+    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
+    qemu_mutex_unlock(lock);
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
+    int sock =3D chan->sock;
+    QemuMutex *lock =3D &chan->recv_lock;
+
+    struct iovec iov =3D {
+        .iov_base =3D (char *) msg,
+        .iov_len =3D MPQEMU_MSG_HDR_SIZE,
+    };
+
+    memset(&hdr, 0, sizeof(hdr));
+    memset(&u, 0, sizeof(u));
+
+    hdr.msg_iov =3D &iov;
+    hdr.msg_iovlen =3D 1;
+    hdr.msg_control =3D &u;
+    hdr.msg_controllen =3D sizeof(u);
+
+    qemu_mutex_lock(lock);
+
+    do {
+        rc =3D recvmsg(sock, &hdr, 0);
+    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
+    if (rc < 0) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, errno is=
 %d,"
+                      " sock %d\n", __func__, rc, errno, sock);
+        qemu_mutex_unlock(lock);
+        return rc;
+    }
+
+    msg->num_fds =3D 0;
+    for (chdr =3D CMSG_FIRSTHDR(&hdr); chdr !=3D NULL;
+         chdr =3D CMSG_NXTHDR(&hdr, chdr)) {
+        if ((chdr->cmsg_level =3D=3D SOL_SOCKET) &&
+            (chdr->cmsg_type =3D=3D SCM_RIGHTS)) {
+            fdsize =3D chdr->cmsg_len - CMSG_LEN(0);
+            msg->num_fds =3D fdsize / sizeof(int);
+            if (msg->num_fds > REMOTE_MAX_FDS) {
+                /*
+                 * TODO: Security issue detected. Sender never sends mor=
e
+                 * than REMOTE_MAX_FDS. This condition should be signale=
d to
+                 * the admin
+                 */
+                qemu_log_mask(LOG_REMOTE_DEBUG,
+                              "%s: Max FDs exceeded\n", __func__);
+                return -ERANGE;
+            }
+
+            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
+            break;
+        }
+    }
+
+    if (msg->bytestream) {
+        if (!msg->size) {
+            qemu_mutex_unlock(lock);
+            return -EINVAL;
+        }
+
+        msg->data2 =3D calloc(1, msg->size);
+        data =3D msg->data2;
+    } else {
+        data =3D (uint8_t *)&msg->data1;
+    }
+
+    if (msg->size) {
+        do {
+            rc =3D read(sock, data, msg->size);
+        } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+    }
+
+    qemu_mutex_unlock(lock);
+
+    return rc;
+}
+
+static gboolean mpqemu_link_handler_prepare(GSource *gsrc, gint *timeout=
)
+{
+    g_assert(timeout);
+
+    *timeout =3D -1;
+
+    return FALSE;
+}
+
+static gboolean mpqemu_link_handler_check(GSource *gsrc)
+{
+    MPQemuChannel *chan =3D (MPQemuChannel *)gsrc;
+
+    return chan->gpfd.events & chan->gpfd.revents;
+}
+
+static gboolean mpqemu_link_handler_dispatch(GSource *gsrc, GSourceFunc =
func,
+                                             gpointer data)
+{
+    MPQemuLinkState *s =3D (MPQemuLinkState *)data;
+    MPQemuChannel *chan =3D (MPQemuChannel *)gsrc;
+
+    s->callback(chan->gpfd.revents, chan);
+
+    if ((chan->gpfd.revents & G_IO_HUP) || (chan->gpfd.revents & G_IO_ER=
R)) {
+        return G_SOURCE_REMOVE;
+    }
+
+    return G_SOURCE_CONTINUE;
+}
+
+void mpqemu_link_set_callback(MPQemuLinkState *s, mpqemu_link_callback c=
allback)
+{
+    s->callback =3D callback;
+}
+
+void mpqemu_init_channel(MPQemuLinkState *s, MPQemuChannel **chan, int f=
d)
+{
+    MPQemuChannel *src;
+
+    gsrc_funcs =3D (GSourceFuncs){
+        .prepare =3D mpqemu_link_handler_prepare,
+        .check =3D mpqemu_link_handler_check,
+        .dispatch =3D mpqemu_link_handler_dispatch,
+        .finalize =3D NULL,
+    };
+
+    src =3D (MPQemuChannel *)g_source_new(&gsrc_funcs, sizeof(MPQemuChan=
nel));
+
+    src->sock =3D fd;
+    qemu_mutex_init(&src->send_lock);
+    qemu_mutex_init(&src->recv_lock);
+
+    g_source_set_callback(&src->gsrc, NULL, (gpointer)s, NULL);
+    src->gpfd.fd =3D fd;
+    src->gpfd.events =3D G_IO_IN | G_IO_HUP | G_IO_ERR;
+    g_source_add_poll(&src->gsrc, &src->gpfd);
+
+    *chan =3D src;
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
--=20
1.8.3.1


