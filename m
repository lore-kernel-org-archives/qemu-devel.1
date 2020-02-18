Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343DEC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42AA2064C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZewBSgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42AA2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3v85-0004xx-3C
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 00:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j3v7C-0003MO-PO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j3v7A-0004UZ-L4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:08:10 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j3v7A-0004UH-Ct
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:08:08 -0500
Received: by mail-pl1-x641.google.com with SMTP id b22so7576303pls.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 21:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=somfXtqn1AIDOM38Cq280CYKrla4QNtFWNSuCjJxyLo=;
 b=SZewBSgR4506zM/tuykeZ/DQ/JcHaTcyLTfFn/z1fei36lmv9DXOhie/13vn16kcCf
 WRIJw4U8ytRfCP+2u8mmN9DyRnwIgjVWDsOiJRZ7BiTEif9TnIwG7GfjvAXkFbQofKEE
 IiNC8rSRbnXBo47EVQum4HLrIJmprlv0rdzamY2mslrSxuLCJX/x0eli0pV1tG9D6GwE
 bszGlqPXLtyDHoj1tcRRzhj/PNaNStMYeWQ/Ts+mfMh5i+hclo8O91K8oMdbo4msQ9b+
 eIYVKgWDfRVY+dfh8YEphZhypTnSJaQCSg4/WULjZl74mggYH97jnB/YKfhABup1YxqQ
 VRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=somfXtqn1AIDOM38Cq280CYKrla4QNtFWNSuCjJxyLo=;
 b=pfE6hJi/fvN4J/oEdU3tPogozQpxLqPey4yPlNYySHAMUSC7ommtyyZSZSoVinT8P4
 NLoWKxIXigmlZa9FpAk6x7yIcxcrZ9eBs5wllD5R7NYxlFUyshVb/i8oGRP8JL5dUZxp
 MNo3HVRoUwpLL7L0gdbXSpV74mwu0OdZOhPvApvss4A8O+fXwxLh7myk8GXAu6FeZRCo
 9XX7KWHXLI9CbrnB/ld6ShLUV09Vl79qqNfR17Y/5fytqEgbH7Xqk3gbrrLDgxwJxtIy
 bKR7Lq5ZvrrpIFcPYH4HrNMNT1tOecDdH2dqV/ZvzedfDELK77Ob/FXi0GUHlG2kQx5W
 q8HQ==
X-Gm-Message-State: APjAAAUHoKs/3JZwtVzrxrD2FnQYgCS+QgD3PceutFJWZBaUbSbnIN7H
 XmDRUhrkhlHnUVG2xjZjI53Xk7pYZ6k=
X-Google-Smtp-Source: APXvYqw+IpBc7/MgdIwpRrOwWst2EmhFCQ67PJzQLGSReOssT+U04Seq1Q/sINK94YvjIuqazwmDPg==
X-Received: by 2002:a17:902:348:: with SMTP id
 66mr19131160pld.137.1582002485390; 
 Mon, 17 Feb 2020 21:08:05 -0800 (PST)
Received: from localhost.localdomain ([2402:9e80:0:1000::1:c192])
 by smtp.googlemail.com with ESMTPSA id 3sm1181613pjg.27.2020.02.17.21.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 21:08:04 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] generic vhost user server
Date: Tue, 18 Feb 2020 13:07:08 +0800
Message-Id: <20200218050711.8133-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218050711.8133-1-coiby.xu@gmail.com>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sharing QEMU devices via vhost-user protocol

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 util/Makefile.objs       |   3 +
 util/vhost-user-server.c | 427 +++++++++++++++++++++++++++++++++++++++
 util/vhost-user-server.h |  56 +++++
 3 files changed, 486 insertions(+)
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

diff --git a/util/Makefile.objs b/util/Makefile.objs
index 11262aafaf..5e450e501c 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -36,6 +36,9 @@ util-obj-y += readline.o
 util-obj-y += rcu.o
 util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
+ifdef CONFIG_LINUX
+util-obj-y += vhost-user-server.o
+endif
 util-obj-y += qemu-coroutine-sleep.o
 util-obj-y += qemu-co-shared-resource.o
 util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
new file mode 100644
index 0000000000..70ff6d6701
--- /dev/null
+++ b/util/vhost-user-server.c
@@ -0,0 +1,427 @@
+/*
+ * Sharing QEMU devices via vhost-user protocol
+ *
+ * Author: Coiby Xu <coiby.xu@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include <sys/eventfd.h>
+#include "qemu/main-loop.h"
+#include "vhost-user-server.h"
+
+static void vmsg_close_fds(VhostUserMsg *vmsg)
+{
+    int i;
+    for (i = 0; i < vmsg->fd_num; i++) {
+        close(vmsg->fds[i]);
+    }
+}
+
+static void vmsg_unblock_fds(VhostUserMsg *vmsg)
+{
+    int i;
+    for (i = 0; i < vmsg->fd_num; i++) {
+        qemu_set_nonblock(vmsg->fds[i]);
+    }
+}
+
+
+static void close_client(VuClient *client)
+{
+    vu_deinit(&client->parent);
+    client->sioc = NULL;
+    object_unref(OBJECT(client->ioc));
+    client->closed = true;
+
+}
+
+static void panic_cb(VuDev *vu_dev, const char *buf)
+{
+    if (buf) {
+        error_report("vu_panic: %s", buf);
+    }
+
+    VuClient *client = container_of(vu_dev, VuClient, parent);
+    VuServer *server = client->server;
+    if (!client->closed) {
+        close_client(client);
+        QTAILQ_REMOVE(&server->clients, client, next);
+    }
+
+    if (server->device_panic_notifier) {
+        server->device_panic_notifier(client);
+    }
+}
+
+
+
+static bool coroutine_fn
+vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    struct iovec iov = {
+        .iov_base = (char *)vmsg,
+        .iov_len = VHOST_USER_HDR_SIZE,
+    };
+    int rc, read_bytes = 0;
+    /*
+     * VhostUserMsg is a packed structure, gcc will complain about passing
+     * pointer to a packed structure member if we pass &VhostUserMsg.fd_num
+     * and &VhostUserMsg.fds directly when calling qio_channel_readv_full,
+     * thus two temporary variables nfds and fds are used here.
+     */
+    size_t nfds = 0, nfds_t = 0;
+    int *fds = NULL, *fds_t = NULL;
+    VuClient *client = container_of(vu_dev, VuClient, parent);
+    QIOChannel *ioc = client->ioc;
+
+    Error *erp;
+    assert(qemu_in_coroutine());
+    do {
+        /*
+         * qio_channel_readv_full may have short reads, keeping calling it
+         * until getting VHOST_USER_HDR_SIZE or 0 bytes in total
+         */
+        rc = qio_channel_readv_full(ioc, &iov, 1, &fds_t, &nfds_t, &erp);
+        if (rc < 0) {
+            if (rc == QIO_CHANNEL_ERR_BLOCK) {
+                qio_channel_yield(ioc, G_IO_IN);
+                continue;
+            } else {
+                error_report("Error while recvmsg: %s", strerror(errno));
+                return false;
+            }
+        }
+        read_bytes += rc;
+        fds = g_renew(int, fds_t, nfds + nfds_t);
+        memcpy(fds + nfds, fds_t, nfds_t);
+        nfds += nfds_t;
+        if (read_bytes == VHOST_USER_HDR_SIZE || rc == 0) {
+            break;
+        }
+    } while (true);
+
+    vmsg->fd_num = nfds;
+    memcpy(vmsg->fds, fds, nfds * sizeof(int));
+    g_free(fds);
+    /* qio_channel_readv_full will make socket fds blocking, unblock them */
+    vmsg_unblock_fds(vmsg);
+    if (vmsg->size > sizeof(vmsg->payload)) {
+        error_report("Error: too big message request: %d, "
+                     "size: vmsg->size: %u, "
+                     "while sizeof(vmsg->payload) = %zu",
+                     vmsg->request, vmsg->size, sizeof(vmsg->payload));
+        goto fail;
+    }
+
+    struct iovec iov_payload = {
+        .iov_base = (char *)&vmsg->payload,
+        .iov_len = vmsg->size,
+    };
+    if (vmsg->size) {
+        rc = qio_channel_readv_all_eof(ioc, &iov_payload, 1, &erp);
+        if (rc == -1) {
+            error_report("Error while reading: %s", strerror(errno));
+            goto fail;
+        }
+    }
+
+    return true;
+
+fail:
+    vmsg_close_fds(vmsg);
+
+    return false;
+}
+
+
+static coroutine_fn void vu_client_next_trip(VuClient *client);
+
+static coroutine_fn void vu_client_trip(void *opaque)
+{
+    VuClient *client = opaque;
+
+    vu_dispatch(&client->parent);
+    client->co_trip = NULL;
+    if (!client->closed) {
+        vu_client_next_trip(client);
+    }
+}
+
+static coroutine_fn void vu_client_next_trip(VuClient *client)
+{
+    if (!client->co_trip) {
+        client->co_trip = qemu_coroutine_create(vu_client_trip, client);
+        aio_co_schedule(client->ioc->ctx, client->co_trip);
+    }
+}
+
+static void vu_client_start(VuClient *client)
+{
+    client->co_trip = qemu_coroutine_create(vu_client_trip, client);
+    aio_co_enter(client->ioc->ctx, client->co_trip);
+}
+
+static void coroutine_fn vu_kick_cb_next(VuClient *client,
+                                          kick_info *data);
+
+static void coroutine_fn vu_kick_cb(void *opaque)
+{
+    kick_info *data = (kick_info *) opaque;
+    int index = data->index;
+    VuDev *dev = data->vu_dev;
+    VuClient *client;
+    client = container_of(dev, VuClient, parent);
+    VuVirtq *vq = &dev->vq[index];
+    int sock = vq->kick_fd;
+    if (sock == -1) {
+        return;
+    }
+    assert(sock == data->fd);
+    eventfd_t kick_data;
+    ssize_t rc;
+    /*
+     * When eventfd is closed, the revent is POLLNVAL (=G_IO_NVAL) and
+     * reading eventfd will return errno=EBADF (Bad file number).
+     * Calling qio_channel_yield(ioc, G_IO_IN) will set reading handler
+     * for QIOChannel, but aio_dispatch_handlers will only dispatch
+     * G_IO_IN | G_IO_HUP | G_IO_ERR revents while ignoring
+     * G_IO_NVAL (POLLNVAL) revents.
+     *
+     * Thus when eventfd is closed by vhost-user client, QEMU will ignore
+     * G_IO_NVAL and keeping polling by repeatedly calling qemu_poll_ns which
+     * will lead to 100% CPU usage.
+     *
+     * To aovid this issue, make sure set_watch and remove_watch use the same
+     * AIOContext for QIOChannel. Thus remove_watch will eventually succefully
+     * remove eventfd from the set of file descriptors polled for
+     * corresponding GSource.
+     */
+    rc = read(sock, &kick_data, sizeof(eventfd_t));
+    if (rc != sizeof(eventfd_t)) {
+        if (errno == EAGAIN) {
+            qio_channel_yield(data->ioc, G_IO_IN);
+        } else if (errno != EINTR) {
+            data->co = NULL;
+            return;
+        }
+    } else {
+        vq->handler(dev, index);
+    }
+    data->co = NULL;
+    vu_kick_cb_next(client, data);
+
+}
+
+static void coroutine_fn vu_kick_cb_next(VuClient *client,
+                                          kick_info *cb_data)
+{
+    if (!cb_data->co) {
+        cb_data->co = qemu_coroutine_create(vu_kick_cb, cb_data);
+        aio_co_schedule(client->ioc->ctx, cb_data->co);
+    }
+}
+static const CoIface co_iface = {
+    .read_msg = vu_message_read,
+    .kick_callback = vu_kick_cb,
+};
+
+
+static void
+set_watch(VuDev *vu_dev, int fd, int vu_evt,
+          vu_watch_cb_packed_data cb, void *pvt)
+{
+    /*
+     * since aio_dispatch can only pass one user data pointer to the
+     * callback function, pack VuDev, pvt into a struct
+     */
+
+    VuClient *client;
+
+    client = container_of(vu_dev, VuClient, parent);
+    g_assert(vu_dev);
+    g_assert(fd >= 0);
+    long index = (intptr_t) pvt;
+    g_assert(cb);
+    kick_info *kick_info = &client->kick_info[index];
+    if (!kick_info->co) {
+        kick_info->fd = fd;
+        QIOChannelFile *fioc = qio_channel_file_new_fd(fd);
+        QIOChannel *ioc = QIO_CHANNEL(fioc);
+        ioc->ctx = client->ioc->ctx;
+        qio_channel_set_blocking(QIO_CHANNEL(ioc), false, NULL);
+        kick_info->fioc = fioc;
+        kick_info->ioc = ioc;
+        kick_info->vu_dev = vu_dev;
+        kick_info->co = qemu_coroutine_create(cb, kick_info);
+        aio_co_enter(client->ioc->ctx, kick_info->co);
+    }
+}
+
+
+static void remove_watch(VuDev *vu_dev, int fd)
+{
+    VuClient *client;
+    int i;
+    int index = -1;
+    g_assert(vu_dev);
+    g_assert(fd >= 0);
+
+    client = container_of(vu_dev, VuClient, parent);
+    for (i = 0; i < vu_dev->max_queues; i++) {
+        if (client->kick_info[i].fd == fd) {
+            index = i;
+            break;
+        }
+    }
+
+    if (index == -1) {
+        return;
+    }
+
+    kick_info *kick_info = &client->kick_info[index];
+    if (kick_info->ioc) {
+        aio_set_fd_handler(client->ioc->ctx, fd, false, NULL,
+                           NULL, NULL, NULL);
+        kick_info->ioc = NULL;
+        g_free(kick_info->fioc);
+        kick_info->co = NULL;
+        kick_info->fioc = NULL;
+    }
+}
+
+
+static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
+                      gpointer opaque)
+{
+    VuClient *client;
+    VuServer *server = opaque;
+    client = g_new0(VuClient, 1);
+
+    if (!vu_init_packed_data(&client->parent, server->max_queues,
+                             sioc->fd, panic_cb,
+                             set_watch, remove_watch,
+                             server->vu_iface, &co_iface)) {
+        error_report("Failed to initialized libvhost-user");
+        g_free(client);
+        return;
+    }
+
+    client->server = server;
+    client->sioc = sioc;
+    client->kick_info = g_new0(struct kick_info, server->max_queues);
+    /*
+     * increase the object reference, so cioc will not freed by
+     * qio_net_listener_channel_func which will call object_unref(OBJECT(sioc))
+     */
+    object_ref(OBJECT(client->sioc));
+    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-user client");
+    client->ioc = QIO_CHANNEL(sioc);
+    object_ref(OBJECT(client->ioc));
+    object_ref(OBJECT(sioc));
+    qio_channel_attach_aio_context(client->ioc, server->ctx);
+    qio_channel_set_blocking(QIO_CHANNEL(client->sioc), false, NULL);
+    client->closed = false;
+    QTAILQ_INSERT_TAIL(&server->clients, client, next);
+    vu_client_start(client);
+}
+
+
+void vhost_user_server_stop(VuServer *server)
+{
+    if (!server) {
+        return;
+    }
+
+    VuClient *client, *next;
+    QTAILQ_FOREACH_SAFE(client, &server->clients, next, next) {
+        if (!client->closed) {
+            close_client(client);
+            QTAILQ_REMOVE(&server->clients, client, next);
+        }
+    }
+
+    if (server->listener) {
+        qio_net_listener_disconnect(server->listener);
+        object_unref(OBJECT(server->listener));
+    }
+}
+
+static void detach_context(VuServer *server)
+{
+    VuClient *client;
+    int i;
+    QTAILQ_FOREACH(client, &server->clients, next) {
+        qio_channel_detach_aio_context(client->ioc);
+        for (i = 0; i < client->parent.max_queues; i++) {
+            if (client->kick_info[i].ioc) {
+                qio_channel_detach_aio_context(client->kick_info[i].ioc);
+            }
+        }
+    }
+}
+
+static void attach_context(VuServer *server, AioContext *ctx)
+{
+    VuClient *client;
+    int i;
+    QTAILQ_FOREACH(client, &server->clients, next) {
+        qio_channel_attach_aio_context(client->ioc, ctx);
+        if (client->co_trip) {
+            aio_co_schedule(ctx, client->co_trip);
+        }
+        for (i = 0; i < client->parent.max_queues; i++) {
+            if (client->kick_info[i].co) {
+                qio_channel_attach_aio_context(client->kick_info[i].ioc, ctx);
+                aio_co_schedule(ctx, client->kick_info[i].co);
+            }
+        }
+    }
+}
+void change_vu_context(AioContext *ctx, VuServer *server)
+{
+    AioContext *acquire_ctx = ctx ? ctx : server->ctx;
+    aio_context_acquire(acquire_ctx);
+    server->ctx = ctx ? ctx : qemu_get_aio_context();
+    if (ctx) {
+        attach_context(server, ctx);
+    } else {
+        detach_context(server);
+    }
+    aio_context_release(acquire_ctx);
+}
+
+
+VuServer *vhost_user_server_start(uint16_t max_queues,
+                                  SocketAddress *socket_addr,
+                                  AioContext *ctx,
+                                  void *server_ptr,
+                                  void *device_panic_notifier,
+                                  const VuDevIface *vu_iface,
+                                  Error **errp)
+{
+    VuServer *server = g_new0(VuServer, 1);
+    server->ptr_in_device = server_ptr;
+    server->listener = qio_net_listener_new();
+    if (qio_net_listener_open_sync(server->listener, socket_addr, 1, errp) < 0) {
+        goto error;
+    }
+
+    qio_net_listener_set_name(server->listener, "vhost-user-backend-listener");
+
+    server->vu_iface = vu_iface;
+    server->max_queues = max_queues;
+    server->ctx = ctx;
+    server->device_panic_notifier = device_panic_notifier;
+    qio_net_listener_set_client_func(server->listener,
+                                     vu_accept,
+                                     server,
+                                     NULL);
+
+    QTAILQ_INIT(&server->clients);
+    return server;
+error:
+    g_free(server);
+    return NULL;
+}
diff --git a/util/vhost-user-server.h b/util/vhost-user-server.h
new file mode 100644
index 0000000000..ff6d3145cd
--- /dev/null
+++ b/util/vhost-user-server.h
@@ -0,0 +1,56 @@
+#include "io/channel-socket.h"
+#include "io/channel-file.h"
+#include "io/net-listener.h"
+#include "contrib/libvhost-user/libvhost-user.h"
+#include "standard-headers/linux/virtio_blk.h"
+#include "qemu/error-report.h"
+
+typedef struct VuClient VuClient;
+
+typedef struct VuServer {
+    QIONetListener *listener;
+    AioContext *ctx;
+    QTAILQ_HEAD(, VuClient) clients;
+    void (*device_panic_notifier)(struct VuClient *client) ;
+    int max_queues;
+    const VuDevIface *vu_iface;
+    /*
+     * @ptr_in_device: VuServer pointer memory location in vhost-user device
+     * struct, so later container_of can be used to get device destruct
+     */
+    void *ptr_in_device;
+    bool close;
+} VuServer;
+
+typedef struct kick_info {
+    VuDev *vu_dev;
+    int fd; /*kick fd*/
+    long index; /*queue index*/
+    QIOChannel *ioc; /*I/O channel for kick fd*/
+    QIOChannelFile *fioc; /*underlying data channel for kick fd*/
+    Coroutine *co;
+} kick_info;
+
+struct VuClient {
+    VuDev parent;
+    VuServer *server;
+    QIOChannel *ioc; /* The current I/O channel */
+    QIOChannelSocket *sioc; /* The underlying data channel */
+    Coroutine *co_trip;
+    struct kick_info *kick_info;
+    QTAILQ_ENTRY(VuClient) next;
+    bool closed;
+};
+
+
+VuServer *vhost_user_server_start(uint16_t max_queues,
+                                  SocketAddress *unix_socket,
+                                  AioContext *ctx,
+                                  void *server_ptr,
+                                  void *device_panic_notifier,
+                                  const VuDevIface *vu_iface,
+                                  Error **errp);
+
+void vhost_user_server_stop(VuServer *server);
+
+void change_vu_context(AioContext *ctx, VuServer *server);
-- 
2.25.0


