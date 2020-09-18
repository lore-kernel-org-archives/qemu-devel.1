Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89622C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A21021481
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDH0J6t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A21021481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBW0-00052w-6g
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSl-00007q-Jr
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:47 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSj-0003HJ-38
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:47 -0400
Received: by mail-pj1-x1041.google.com with SMTP id u3so2616924pjr.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4zyRE+PLFJ59iQlzfMElbeubCVfyJK8cQ7dZ8TMcYeg=;
 b=NDH0J6t5Vap8ZIh1grxUMjP1zERnBqsyFjYO1u945NpEZAHHWTMfZ5iKWt4LJqgiWZ
 NuVDsnVJsOdeYSeYlPyRYdHcqtfr+mBYVo5iUquBkLC8fh9Klf/HzG043IJvs8gp3Vbk
 he3DGEfP9VKSjaboJdoIOKqN+mZtqmUh0CCQ2dRUTTCaIyVksuWiqIbtLxq/dBPnIQkc
 zu1rsI24l80EeRwpfpJxAyNEKuhnPTfKfZ1otBOUpyGQkvXlWram9dckG0RuDOefgXWk
 8fkhh+X/sSaxDjXax+LNc00DOSYEvZpOWoUMvvM6Yc3kWyKMzCLSiG+NDHgje4XNLNtG
 mFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4zyRE+PLFJ59iQlzfMElbeubCVfyJK8cQ7dZ8TMcYeg=;
 b=M/mtaK3z9KilfOXNRET5R0TYg6B6t6JyRGKHk+YTaksfY9agbtHFiIt+1PWqvHWW4+
 iEA3E01XzMghbomBBDCjzw6ViSScSRyXtiyDYKhK5k0GSm4L98+iAguHLICZB3XHlzcG
 L3LcO/HDBbEFX7SJTYQ2dO460rHhAgO8J6f8EkuiiTCBj0UpSG4X4A0qQ7iE+MGWrmig
 6uZj+kbmiWX3+uXGBZJmDzcI9iDmjMPHWBvKQ0NZRTXSAGIbp6cJ9NW3L20LZizsMioO
 cxy4R2qikhAY7PppCEAaAPTTZWh71RvPeg6qeP4DpiMznyxbL2g0TcP+413PP7u/2Pxf
 0S+A==
X-Gm-Message-State: AOAM532Msj7qeQ518fQbjeBLf1S0fn49uxLp+nBlqQS5Df21/LXVS2HS
 ldcVL/7+U36C2N9Aaqw+24kvkmpArsDAZg==
X-Google-Smtp-Source: ABdhPJyuihqgXL3RGSTdvkR8MGdgJ/qSQagkZLXAClMY7XVjjiZCWRdUK9WkwnoQdO/18qwgNiSk+A==
X-Received: by 2002:a17:902:7d8f:b029:d1:bafa:baf3 with SMTP id
 a15-20020a1709027d8fb02900d1bafabaf3mr28230072plm.17.1600416581304; 
 Fri, 18 Sep 2020 01:09:41 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id gd14sm2027707pjb.0.2020.09.18.01.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:09:40 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 3/7] util/vhost-user-server: generic vhost user server
Date: Fri, 18 Sep 2020 16:09:08 +0800
Message-Id: <20200918080912.321299-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <Coiby.Xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sharing QEMU devices via vhost-user protocol.

Only one vhost-user client can connect to the server one time.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 util/meson.build         |   1 +
 util/vhost-user-server.c | 428 +++++++++++++++++++++++++++++++++++++++
 util/vhost-user-server.h |  65 ++++++
 3 files changed, 494 insertions(+)
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

diff --git a/util/meson.build b/util/meson.build
index e6b207a99e..3921981ccf 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -66,6 +66,7 @@ if have_block
   util_ss.add(files('main-loop.c'))
   util_ss.add(files('nvdimm-utils.c'))
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
+  util_ss.add(when: 'CONFIG_LINUX', if_true: files('vhost-user-server.c'))
   util_ss.add(files('qemu-coroutine-sleep.c'))
   util_ss.add(files('qemu-co-shared-resource.c'))
   util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
new file mode 100644
index 0000000000..7b50a2b1fd
--- /dev/null
+++ b/util/vhost-user-server.c
@@ -0,0 +1,428 @@
+/*
+ * Sharing QEMU devices via vhost-user protocol
+ *
+ * Copyright (c) Coiby Xu <coiby.xu@gmail.com>.
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
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
+static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
+                      gpointer opaque);
+
+static void close_client(VuServer *server)
+{
+    /*
+     * Before closing the client
+     *
+     * 1. Let vu_client_trip stop processing new vhost-user msg
+     *
+     * 2. remove kick_handler
+     *
+     * 3. wait for the kick handler to be finished
+     *
+     * 4. wait for the current vhost-user msg to be finished processing
+     */
+
+    QIOChannelSocket *sioc = server->sioc;
+    /* When this is set vu_client_trip will stop new processing vhost-user message */
+    server->sioc = NULL;
+
+    VuFdWatch *vu_fd_watch, *next;
+    QTAILQ_FOREACH_SAFE(vu_fd_watch, &server->vu_fd_watches, next, next) {
+        aio_set_fd_handler(server->ioc->ctx, vu_fd_watch->fd, true, NULL,
+                           NULL, NULL, NULL);
+    }
+
+    while (!QTAILQ_EMPTY(&server->vu_fd_watches)) {
+        QTAILQ_FOREACH_SAFE(vu_fd_watch, &server->vu_fd_watches, next, next) {
+            if (!vu_fd_watch->processing) {
+                QTAILQ_REMOVE(&server->vu_fd_watches, vu_fd_watch, next);
+                g_free(vu_fd_watch);
+            }
+        }
+    }
+
+    while (server->processing_msg) {
+        if (server->ioc->read_coroutine) {
+            server->ioc->read_coroutine = NULL;
+            qio_channel_set_aio_fd_handler(server->ioc, server->ioc->ctx, NULL,
+                                           NULL, server->ioc);
+            server->processing_msg = false;
+        }
+    }
+
+    vu_deinit(&server->vu_dev);
+    object_unref(OBJECT(sioc));
+    object_unref(OBJECT(server->ioc));
+}
+
+static void panic_cb(VuDev *vu_dev, const char *buf)
+{
+    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
+
+    /* avoid while loop in close_client */
+    server->processing_msg = false;
+
+    if (buf) {
+        error_report("vu_panic: %s", buf);
+    }
+
+    if (server->sioc) {
+        close_client(server);
+    }
+
+    if (server->device_panic_notifier) {
+        server->device_panic_notifier(server);
+    }
+
+    /*
+     * Set the callback function for network listener so another
+     * vhost-user client can connect to this server
+     */
+    qio_net_listener_set_client_func(server->listener,
+                                     vu_accept,
+                                     server,
+                                     NULL);
+}
+
+static bool coroutine_fn
+vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    struct iovec iov = {
+        .iov_base = (char *)vmsg,
+        .iov_len = VHOST_USER_HDR_SIZE,
+    };
+    int rc, read_bytes = 0;
+    Error *local_err = NULL;
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
+    const size_t max_fds = G_N_ELEMENTS(vmsg->fds);
+    int *fds_t = NULL;
+    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
+    QIOChannel *ioc = server->ioc;
+
+    if (!ioc) {
+        error_report_err(local_err);
+        goto fail;
+    }
+
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
+        if (nfds_t > 0) {
+            if (nfds + nfds_t > max_fds) {
+                error_report("A maximum of %zu fds are allowed, "
+                             "however got %lu fds now",
+                             max_fds, nfds + nfds_t);
+                goto fail;
+            }
+            memcpy(vmsg->fds + nfds, fds_t,
+                   nfds_t *sizeof(vmsg->fds[0]));
+            nfds += nfds_t;
+            g_free(fds_t);
+        }
+        if (read_bytes == VHOST_USER_HDR_SIZE || rc == 0) {
+            break;
+        }
+        iov.iov_base = (char *)vmsg + read_bytes;
+        iov.iov_len = VHOST_USER_HDR_SIZE - read_bytes;
+    } while (true);
+
+    vmsg->fd_num = nfds;
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
+static void vu_client_start(VuServer *server);
+static coroutine_fn void vu_client_trip(void *opaque)
+{
+    VuServer *server = opaque;
+
+    while (!server->aio_context_changed && server->sioc) {
+        server->processing_msg = true;
+        vu_dispatch(&server->vu_dev);
+        server->processing_msg = false;
+    }
+
+    if (server->aio_context_changed && server->sioc) {
+        server->aio_context_changed = false;
+        vu_client_start(server);
+    }
+}
+
+static void vu_client_start(VuServer *server)
+{
+    server->co_trip = qemu_coroutine_create(vu_client_trip, server);
+    aio_co_enter(server->ctx, server->co_trip);
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
+    VuFdWatch *vu_fd_watch = opaque;
+    vu_fd_watch->processing = true;
+    vu_fd_watch->cb(vu_fd_watch->vu_dev, 0, vu_fd_watch->pvt);
+    vu_fd_watch->processing = false;
+}
+
+
+static VuFdWatch *find_vu_fd_watch(VuServer *server, int fd)
+{
+
+    VuFdWatch *vu_fd_watch, *next;
+    QTAILQ_FOREACH_SAFE(vu_fd_watch, &server->vu_fd_watches, next, next) {
+        if (vu_fd_watch->fd == fd) {
+            return vu_fd_watch;
+        }
+    }
+    return NULL;
+}
+
+static void
+set_watch(VuDev *vu_dev, int fd, int vu_evt,
+          vu_watch_cb cb, void *pvt)
+{
+
+    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
+    g_assert(vu_dev);
+    g_assert(fd >= 0);
+    g_assert(cb);
+
+    VuFdWatch *vu_fd_watch = find_vu_fd_watch(server, fd);
+
+    if (!vu_fd_watch) {
+        VuFdWatch *vu_fd_watch = g_new0(VuFdWatch, 1);
+
+        QTAILQ_INSERT_TAIL(&server->vu_fd_watches, vu_fd_watch, next);
+
+        vu_fd_watch->fd = fd;
+        vu_fd_watch->cb = cb;
+        qemu_set_nonblock(fd);
+        aio_set_fd_handler(server->ioc->ctx, fd, true, kick_handler,
+                           NULL, NULL, vu_fd_watch);
+        vu_fd_watch->vu_dev = vu_dev;
+        vu_fd_watch->pvt = pvt;
+    }
+}
+
+
+static void remove_watch(VuDev *vu_dev, int fd)
+{
+    VuServer *server;
+    g_assert(vu_dev);
+    g_assert(fd >= 0);
+
+    server = container_of(vu_dev, VuServer, vu_dev);
+
+    VuFdWatch *vu_fd_watch = find_vu_fd_watch(server, fd);
+
+    if (!vu_fd_watch) {
+        return;
+    }
+    aio_set_fd_handler(server->ioc->ctx, fd, true, NULL, NULL, NULL, NULL);
+
+    QTAILQ_REMOVE(&server->vu_fd_watches, vu_fd_watch, next);
+    g_free(vu_fd_watch);
+}
+
+
+static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
+                      gpointer opaque)
+{
+    VuServer *server = opaque;
+
+    if (server->sioc) {
+        warn_report("Only one vhost-user client is allowed to "
+                    "connect the server one time");
+        return;
+    }
+
+    if (!vu_init(&server->vu_dev, server->max_queues, sioc->fd, panic_cb,
+                 vu_message_read, set_watch, remove_watch, server->vu_iface)) {
+        error_report("Failed to initialize libvhost-user");
+        return;
+    }
+
+    /*
+     * Unset the callback function for network listener to make another
+     * vhost-user client keeping waiting until this client disconnects
+     */
+    qio_net_listener_set_client_func(server->listener,
+                                     NULL,
+                                     NULL,
+                                     NULL);
+    server->sioc = sioc;
+    /*
+     * Increase the object reference, so sioc will not freed by
+     * qio_net_listener_channel_func which will call object_unref(OBJECT(sioc))
+     */
+    object_ref(OBJECT(server->sioc));
+    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-user client");
+    server->ioc = QIO_CHANNEL(sioc);
+    object_ref(OBJECT(server->ioc));
+    qio_channel_attach_aio_context(server->ioc, server->ctx);
+    qio_channel_set_blocking(QIO_CHANNEL(server->sioc), false, NULL);
+    vu_client_start(server);
+}
+
+
+void vhost_user_server_stop(VuServer *server)
+{
+    if (server->sioc) {
+        close_client(server);
+    }
+
+    if (server->listener) {
+        qio_net_listener_disconnect(server->listener);
+        object_unref(OBJECT(server->listener));
+    }
+
+}
+
+void vhost_user_server_set_aio_context(VuServer *server, AioContext *ctx)
+{
+    VuFdWatch *vu_fd_watch, *next;
+    void *opaque = NULL;
+    IOHandler *io_read = NULL;
+    bool attach;
+
+    server->ctx = ctx ? ctx : qemu_get_aio_context();
+
+    if (!server->sioc) {
+        /* not yet serving any client*/
+        return;
+    }
+
+    if (ctx) {
+        qio_channel_attach_aio_context(server->ioc, ctx);
+        server->aio_context_changed = true;
+        io_read = kick_handler;
+        attach = true;
+    } else {
+        qio_channel_detach_aio_context(server->ioc);
+        /* server->ioc->ctx keeps the old AioConext */
+        ctx = server->ioc->ctx;
+        attach = false;
+    }
+
+    QTAILQ_FOREACH_SAFE(vu_fd_watch, &server->vu_fd_watches, next, next) {
+        if (vu_fd_watch->cb) {
+            opaque = attach ? vu_fd_watch : NULL;
+            aio_set_fd_handler(ctx, vu_fd_watch->fd, true,
+                               io_read, NULL, NULL,
+                               opaque);
+        }
+    }
+}
+
+
+bool vhost_user_server_start(VuServer *server,
+                             SocketAddress *socket_addr,
+                             AioContext *ctx,
+                             uint16_t max_queues,
+                             DevicePanicNotifierFn *device_panic_notifier,
+                             const VuDevIface *vu_iface,
+                             Error **errp)
+{
+    QIONetListener *listener = qio_net_listener_new();
+    if (qio_net_listener_open_sync(listener, socket_addr, 1,
+                                   errp) < 0) {
+        object_unref(OBJECT(listener));
+        return false;
+    }
+
+    /* zero out unspecified fileds */
+    *server = (VuServer) {
+        .listener              = listener,
+        .vu_iface              = vu_iface,
+        .max_queues            = max_queues,
+        .ctx                   = ctx,
+        .device_panic_notifier = device_panic_notifier,
+    };
+
+    qio_net_listener_set_name(server->listener, "vhost-user-backend-listener");
+
+    qio_net_listener_set_client_func(server->listener,
+                                     vu_accept,
+                                     server,
+                                     NULL);
+
+    QTAILQ_INIT(&server->vu_fd_watches);
+    return true;
+}
diff --git a/util/vhost-user-server.h b/util/vhost-user-server.h
new file mode 100644
index 0000000000..5232f96718
--- /dev/null
+++ b/util/vhost-user-server.h
@@ -0,0 +1,65 @@
+/*
+ * Sharing QEMU devices via vhost-user protocol
+ *
+ * Copyright (c) Coiby Xu <coiby.xu@gmail.com>.
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef VHOST_USER_SERVER_H
+#define VHOST_USER_SERVER_H
+
+#include "contrib/libvhost-user/libvhost-user.h"
+#include "io/channel-socket.h"
+#include "io/channel-file.h"
+#include "io/net-listener.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "standard-headers/linux/virtio_blk.h"
+
+typedef struct VuFdWatch {
+    VuDev *vu_dev;
+    int fd; /*kick fd*/
+    void *pvt;
+    vu_watch_cb cb;
+    bool processing;
+    QTAILQ_ENTRY(VuFdWatch) next;
+} VuFdWatch;
+
+typedef struct VuServer VuServer;
+typedef void DevicePanicNotifierFn(VuServer *server);
+
+struct VuServer {
+    QIONetListener *listener;
+    AioContext *ctx;
+    DevicePanicNotifierFn *device_panic_notifier;
+    int max_queues;
+    const VuDevIface *vu_iface;
+    VuDev vu_dev;
+    QIOChannel *ioc; /* The I/O channel with the client */
+    QIOChannelSocket *sioc; /* The underlying data channel with the client */
+    /* IOChannel for fd provided via VHOST_USER_SET_SLAVE_REQ_FD */
+    QIOChannel *ioc_slave;
+    QIOChannelSocket *sioc_slave;
+    Coroutine *co_trip; /* coroutine for processing VhostUserMsg */
+    QTAILQ_HEAD(, VuFdWatch) vu_fd_watches;
+    /* restart coroutine co_trip if AIOContext is changed */
+    bool aio_context_changed;
+    bool processing_msg;
+};
+
+bool vhost_user_server_start(VuServer *server,
+                             SocketAddress *unix_socket,
+                             AioContext *ctx,
+                             uint16_t max_queues,
+                             DevicePanicNotifierFn *device_panic_notifier,
+                             const VuDevIface *vu_iface,
+                             Error **errp);
+
+void vhost_user_server_stop(VuServer *server);
+
+void vhost_user_server_set_aio_context(VuServer *server, AioContext *ctx);
+
+#endif /* VHOST_USER_SERVER_H */
-- 
2.28.0


