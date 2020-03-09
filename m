Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B68C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFF52072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOWuJrhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFF52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFLL-0008KV-Lx
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1jBFHD-0001yB-UM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1jBFHB-0008D6-7S
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:47 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1jBFH9-0008CX-VA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:44 -0400
Received: by mail-pl1-x643.google.com with SMTP id g12so3790982plo.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mNIpc7WjLPe4VU98GoFlLhEQ0jaKhtLz1PlfU5uA9A4=;
 b=VOWuJrhUIXNzAQrlFgEWWBcx/YDyqqUH0Ip61Vs/EA4XKCeb1CIIcbL2vNy0OS0a/P
 txhn0gKzKe7ISf9lj1hMeagb0KPHyFZ8o+TTyogHus9lm5icBKkVBY9bMAvOgwmsEuqS
 VBfMRJOW4w1UMVyiPfJdjaAzCgMvE7fEySQm6kSaBJXz6RuWsRO2jT3jUAnazi4Ek2a4
 20CsDwQa7dsiQe5/ELbh4yqEzqzMpXTPUHyYw+qw8WxT6Ufz2Fesn5Fya8FRnt5u3N1D
 7PmuBYr4JbxAeEwUEyhb/+d/CrF5FGIT7+ItbcyYH1FiPuCLrwilEGdIIPIujgLvnWOs
 Gz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mNIpc7WjLPe4VU98GoFlLhEQ0jaKhtLz1PlfU5uA9A4=;
 b=qkpl/fOL4sokNuaP2nZs1j5/Ol6TVp7GKtyNa4U2DPV+Ja79Dc801HSw0TM9VtEadH
 hoWJq75fL/29NcLDv57ANbMB2WPeMM56Cb9rDhlstfdHR/wCLF9fcPvCAOsQnwld7QgK
 X81U0UaYmAaj21lWjOk8Q2U1cOCS4M303VKUXpFyF3PQ42vrECYsEQsDlydvpJ87ES/5
 iX/i5SEX9UwCjUYKrqqd7SHrIFq6wv0cpoSzH3rHU+vgLOnUlJecUdtrxXtNExYLlCZk
 6ihPcoYp9A5Dk8ArdlGNVeyAjQnve7H/pGtTX0j3b7eWoDcwNnJG8Oge4g9zv88yT1Tt
 JlVw==
X-Gm-Message-State: ANhLgQ2TowPMHbzrkftMvUwva06hBsyTEW26FzWKXAqClmSIYG8UYPU1
 IXeXlIvKX+ZT3w9xJ/+HmD6fnPdz5vVwxA==
X-Google-Smtp-Source: ADFU+vtmhpRGXRmSbTv38mSdJDR6bGY77QzadBwRaHjlOV6qjyHEXw7K5hbdARnkwCyezViAMVXCrQ==
X-Received: by 2002:a17:90a:1785:: with SMTP id
 q5mr17806447pja.35.1583748281730; 
 Mon, 09 Mar 2020 03:04:41 -0700 (PDT)
Received: from localhost.localdomain
 (tunnel571398-pt.tunnel.tserv14.sea1.ipv6.he.net. [2001:470:a:247::2])
 by smtp.googlemail.com with ESMTPSA id s21sm16077377pfd.99.2020.03.09.03.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 03:04:41 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/5] generic vhost user server
Date: Mon,  9 Mar 2020 18:03:39 +0800
Message-Id: <20200309100342.14921-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309100342.14921-1-coiby.xu@gmail.com>
References: <20200309100342.14921-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
 util/vhost-user-server.c | 360 +++++++++++++++++++++++++++++++++++++++
 util/vhost-user-server.h |  57 ++++++
 3 files changed, 420 insertions(+)
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

diff --git a/util/Makefile.objs b/util/Makefile.objs
index 6b38b67cf1..d207b5f981 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -37,6 +37,9 @@ util-obj-y += readline.o
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
index 0000000000..7da96bc815
--- /dev/null
+++ b/util/vhost-user-server.c
@@ -0,0 +1,360 @@
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
+static void close_client(VuClientInfo *client)
+{
+    vu_deinit(&client->vu_dev);
+    client->sioc = NULL;
+    object_unref(OBJECT(client->ioc));
+    client->closed = true;
+
+}
+
+static void panic_cb(VuDev *vu_dev, const char *buf)
+{
+    VuClientInfo *client = container_of(vu_dev, VuClientInfo, vu_dev);
+    VuServer *server = client->server;
+
+    if (buf) {
+        error_report("vu_panic: %s", buf);
+    }
+
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
+     * Store fds/nfds returned from qio_channel_readv_full into
+     * temporary variables.
+     *
+     * VhostUserMsg is a packed structure, gcc will complain about passing
+     * pointer to a packed structure member if we pass &VhostUserMsg.fd_num
+     * and &VhostUserMsg.fds directly when calling qio_channel_readv_full,
+     * thus two temporary variables nfds and fds are used here.
+     */
+    size_t nfds = 0, nfds_t = 0;
+    int *fds = NULL, *fds_t = NULL;
+    VuClientInfo *client = container_of(vu_dev, VuClientInfo, vu_dev);
+    QIOChannel *ioc = client->ioc;
+
+    Error *local_err = NULL;
+    assert(qemu_in_coroutine());
+    do {
+        /*
+         * qio_channel_readv_full may have short reads, keeping calling it
+         * until getting VHOST_USER_HDR_SIZE or 0 bytes in total
+         */
+        rc = qio_channel_readv_full(ioc, &iov, 1, &fds_t, &nfds_t, &local_err);
+        if (rc < 0) {
+            if (rc == QIO_CHANNEL_ERR_BLOCK) {
+                qio_channel_yield(ioc, G_IO_IN);
+                continue;
+            } else {
+                error_report_err(local_err);
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
+    assert(nfds <= VHOST_MEMORY_MAX_NREGIONS);
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
+        rc = qio_channel_readv_all_eof(ioc, &iov_payload, 1, &local_err);
+        if (rc == -1) {
+            error_report_err(local_err);
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
+static void vu_client_start(VuClientInfo *client);
+static coroutine_fn void vu_client_trip(void *opaque)
+{
+    VuClientInfo *client = opaque;
+
+    while (!client->aio_context_changed && !client->closed) {
+        vu_dispatch(&client->vu_dev);
+    }
+
+    if (client->aio_context_changed) {
+        client->aio_context_changed = false;
+        vu_client_start(client);
+    }
+}
+
+static void vu_client_start(VuClientInfo *client)
+{
+    client->co_trip = qemu_coroutine_create(vu_client_trip, client);
+    aio_co_enter(client->ioc->ctx, client->co_trip);
+}
+
+/*
+ * a wrapper for vu_kick_cb
+ *
+ * since aio_dispatch can only pass one user data pointer to the
+ * callback function, pack VuDev and pvt into a struct. Then unpack it
+ * and pass them to vu_kick_cb
+ */
+static void kick_handler(void *opaque)
+{
+    KickInfo *kick_info = opaque;
+    kick_info->cb(kick_info->vu_dev, 0, (void *) kick_info->index);
+}
+
+
+static void
+set_watch(VuDev *vu_dev, int fd, int vu_evt,
+          vu_watch_cb cb, void *pvt)
+{
+
+    VuClientInfo *client;
+    client = container_of(vu_dev, VuClientInfo, vu_dev);
+    g_assert(vu_dev);
+    g_assert(fd >= 0);
+    long index = (intptr_t) pvt;
+    g_assert(cb);
+    KickInfo *kick_info = &client->kick_info[index];
+    if (!kick_info->cb) {
+        kick_info->fd = fd;
+        kick_info->cb = cb;
+        qemu_set_nonblock(fd);
+        aio_set_fd_handler(client->ioc->ctx, fd, false, kick_handler,
+                           NULL, NULL, kick_info);
+        kick_info->vu_dev = vu_dev;
+    }
+}
+
+
+static void remove_watch(VuDev *vu_dev, int fd)
+{
+    VuClientInfo *client;
+    int i;
+    int index = -1;
+    g_assert(vu_dev);
+    g_assert(fd >= 0);
+
+    client = container_of(vu_dev, VuClientInfo, vu_dev);
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
+    client->kick_info[i].cb = NULL;
+    aio_set_fd_handler(client->ioc->ctx, fd, false, NULL, NULL, NULL, NULL);
+}
+
+
+static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
+                      gpointer opaque)
+{
+    VuClientInfo *client;
+    VuServer *server = opaque;
+    client = g_new0(VuClientInfo, 1);
+    if (!vu_init(&client->vu_dev, server->max_queues, sioc->fd, panic_cb,
+                 vu_message_read, set_watch, remove_watch, server->vu_iface)) {
+        error_report("Failed to initialized libvhost-user");
+        g_free(client);
+        return;
+    }
+
+    client->server = server;
+    client->sioc = sioc;
+    client->kick_info = g_new0(KickInfo, server->max_queues);
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
+    VuClientInfo *client, *next;
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
+    VuClientInfo *client;
+    int i;
+    QTAILQ_FOREACH(client, &server->clients, next) {
+        qio_channel_detach_aio_context(client->ioc);
+        AioContext *ctx = client->ioc->ctx;
+        for (i = 0; i < client->vu_dev.max_queues; i++) {
+            if (client->kick_info[i].cb) {
+                aio_set_fd_handler(ctx, client->kick_info[i].fd, false, NULL,
+                                   NULL, NULL, NULL);
+            }
+        }
+    }
+}
+
+static void attach_context(VuServer *server, AioContext *ctx)
+{
+    VuClientInfo *client;
+    int i;
+    QTAILQ_FOREACH(client, &server->clients, next) {
+        qio_channel_attach_aio_context(client->ioc, ctx);
+        client->aio_context_changed = true;
+        if (client->co_trip) {
+            aio_co_schedule(ctx, client->co_trip);
+        }
+        for (i = 0; i < client->vu_dev.max_queues; i++) {
+            if (client->kick_info[i].cb) {
+                aio_set_fd_handler(ctx, client->kick_info[i].fd, false,
+                                   kick_handler, NULL, NULL,
+                                   &client->kick_info[i]);
+            }
+        }
+    }
+}
+
+void vhost_user_server_set_aio_context(AioContext *ctx, VuServer *server)
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
+    if (qio_net_listener_open_sync(server->listener, socket_addr, 1,
+                                   errp) < 0) {
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
index 0000000000..1a6b5e4ea9
--- /dev/null
+++ b/util/vhost-user-server.h
@@ -0,0 +1,57 @@
+#include "contrib/libvhost-user/libvhost-user.h"
+#include "io/channel-socket.h"
+#include "io/channel-file.h"
+#include "io/net-listener.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "standard-headers/linux/virtio_blk.h"
+
+typedef struct VuClientInfo VuClientInfo;
+
+typedef struct VuServer {
+    QIONetListener *listener;
+    AioContext *ctx;
+    QTAILQ_HEAD(, VuClientInfo) clients;
+    void (*device_panic_notifier)(struct VuClientInfo *client) ;
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
+typedef struct KickInfo {
+    VuDev *vu_dev;
+    int fd; /*kick fd*/
+    long index; /*queue index*/
+    vu_watch_cb cb;
+} KickInfo;
+
+struct VuClientInfo {
+    VuDev vu_dev;
+    VuServer *server;
+    QIOChannel *ioc; /* The current I/O channel */
+    QIOChannelSocket *sioc; /* The underlying data channel */
+    Coroutine *co_trip; /* coroutine for processing VhostUserMsg */
+    KickInfo *kick_info; /* an array with the length of the queue number */
+    QTAILQ_ENTRY(VuClientInfo) next;
+    /* restart coroutine co_trip if AIOContext is changed */
+    bool aio_context_changed;
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
+void vhost_user_server_set_aio_context(AioContext *ctx, VuServer *server);
--
2.25.1


