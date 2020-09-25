Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C9C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FC0206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgxvFKsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FC0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnJe-000234-1r
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCp-0007n1-Dm
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCn-0001QP-5R
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id l15so1824725wmh.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LyX39wHBNrDOQa2NkxK5rhi5dv936oaE8zOOQGpdbek=;
 b=EgxvFKsFa+w2EoU101dM4fi2UQcaWDko5usfIsYh+Gc83uVqHoFtK69ClctkN3gJDl
 rnVMeIXp8+xCE9RCo5iMzUsThofAlgs6Rm9Q4ByzenZSAwdnf0iiBfR90jfEFPUKGz1A
 zy7cRrTszJzI7fubdVrfIDJmUhrazn4o5HtSnXZ5WKt9ufBN2qmVqJyyG9pViB0mvjrY
 BV+Z1lYEv3LPAUQETl1XoUldUkzn4GJg+e/c7xB6aiAxUG82aFz1br4s78c7DkP58F7z
 S2yNPcz7PRWckp92SDxumaDnOH2qcn8hZ/VTpSXRHcYOHd5x3wtv4PB0+Dman0MfvH4L
 9jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LyX39wHBNrDOQa2NkxK5rhi5dv936oaE8zOOQGpdbek=;
 b=btx8e5M+VLJMm9aKqTV2YFSiFSCt645qFT8qF3G/xTR/vS79eCGpw+OAvh834uJ4yt
 f98aNZej8L6bmA6oXslvBg34BORVV0Xsntyv9n8UPh409ZlD4N4ndNXw9EL6RSYi2/6i
 h/kvgqgkRogvwpFZqeZfHBJ4HsNd4ri6/rvrkWUfYMSm9X4NQ/eyEcEODEHptXgTd73o
 BAQ6hejeMrSqj8K3XbtCrbxDT9tJhHZDu6qZKgR2T0eRfnnMyy8i0GX8rd6kAJtK/iQW
 sLVkn9XoNRW0CGqsrRCoXKHnGlxltZkfQrHEVqaiRCWf9/ptiHR21nYs23UV61nIZsnE
 GUxg==
X-Gm-Message-State: AOAM531FN7Ww2B0KeGZ9wv0OZkfKV6O45akNUlLUbd093pSJIQuUWhBr
 wU+6yKXaGRtXqZfbuLp45A61fQ==
X-Google-Smtp-Source: ABdhPJxi/v3h2iuMHrsZ3StbC1XR0MKxMeNhamxbZ/I2fhP0xWFopPy82Rox73hf+EqwzTsOzijxdw==
X-Received: by 2002:a1c:800f:: with SMTP id b15mr2850434wmd.114.1601038323513; 
 Fri, 25 Sep 2020 05:52:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p3sm2631021wmm.40.2020.09.25.05.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 012C21FF96;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 08/19] tools/vhost-user-rpmb: connect to fd and
 instantiate basic run loop
Date: Fri, 25 Sep 2020 13:51:36 +0100
Message-Id: <20200925125147.26943-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Again doesn't do much on it's own but will create a socket and wait on
messages coming in from the vhost-user message socket.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c      | 211 +++++++++++++++++++++++++++++-
 tools/vhost-user-rpmb/meson.build |   2 +-
 2 files changed, 210 insertions(+), 3 deletions(-)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 6b1989125bd6..269c86cbb633 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -7,10 +7,23 @@
  */
 
 #include <glib.h>
+#include <gio/gio.h>
+#include <gio/gunixsocketaddress.h>
 #include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include "contrib/libvhost-user/libvhost-user-glib.h"
+#include "contrib/libvhost-user/libvhost-user.h"
+
+#ifndef container_of
+#define container_of(ptr, type, member) ({                      \
+        const typeof(((type *) 0)->member) *__mptr = (ptr);     \
+        (type *) ((char *) __mptr - offsetof(type, member));})
+#endif
 
 static gchar *socket_path;
-static gint socket_fd;
+static gint socket_fd = -1;
 static gboolean print_cap;
 
 static GOptionEntry options[] =
@@ -21,6 +34,147 @@ static GOptionEntry options[] =
     { NULL }
 };
 
+enum {
+    VHOST_USER_RPMB_MAX_QUEUES = 1,
+};
+
+/* These structures are defined in the specification */
+
+struct virtio_rpmb_config {
+    uint8_t capacity;
+    uint8_t max_wr_cnt;
+    uint8_t max_rd_cnt;
+};
+
+struct virtio_rpmb_frame {
+    uint8_t stuff[196];
+    uint8_t key_mac[32];
+    uint8_t data[256];
+    uint8_t nonce[16];
+    /* remaining fields are big-endian */
+    uint32_t write_counter;
+    uint16_t address;
+    uint16_t block_count;
+    uint16_t result;
+    uint16_t req_resp;
+};
+
+/*
+ * Structure to track internal state of RPMB Device
+ */
+
+typedef struct VuRpmb {
+    VugDev dev;
+    struct virtio_rpmb_config virtio_config;
+} VuRpmb;
+
+struct virtio_rpmb_ctrl_command {
+    VuVirtqElement elem;
+    VuVirtq *vq;
+    struct virtio_rpmb_frame frame;
+    uint32_t error;
+    bool finished;
+};
+
+static void vrpmb_panic(VuDev *dev, const char *msg)
+{
+    g_critical("%s\n", msg);
+    exit(EXIT_FAILURE);
+}
+
+static uint64_t vrpmb_get_features(VuDev *dev)
+{
+    return 0;
+}
+
+static void vrpmb_set_features(VuDev *dev, uint64_t features)
+{
+    if (features) {
+        g_autoptr(GString) s = g_string_new("Requested un-handled feature");
+        g_string_append_printf(s, " 0x%" PRIx64 "", features);
+        g_info("%s: %s", __func__, s->str);
+    }
+}
+
+/*
+ * The configuration of the device is static and set when we start the
+ * daemon.
+ */
+static int
+vrpmb_get_config(VuDev *dev, uint8_t *config, uint32_t len)
+{
+    VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
+    g_return_val_if_fail(len <= sizeof(struct virtio_rpmb_config), -1);
+    memcpy(config, &r->virtio_config, len);
+    return 0;
+}
+
+static int
+vrpmb_set_config(VuDev *dev, const uint8_t *data,
+                 uint32_t offset, uint32_t size,
+                 uint32_t flags)
+{
+    /* ignore */
+    return 0;
+}
+
+static void
+vrpmb_handle_ctrl(VuDev *dev, int qidx)
+{
+    VuVirtq *vq = vu_get_queue(dev, qidx);
+    struct virtio_rpmb_ctrl_command *cmd = NULL;
+
+    for (;;) {
+        cmd = vu_queue_pop(dev, vq, sizeof(struct virtio_rpmb_ctrl_command));
+        if (!cmd) {
+            break;
+        }
+
+        g_debug("un-handled cmd: %p", cmd);
+    }
+}
+
+static void
+vrpmb_queue_set_started(VuDev *dev, int qidx, bool started)
+{
+    VuVirtq *vq = vu_get_queue(dev, qidx);
+
+    g_debug("queue started %d:%d\n", qidx, started);
+
+    switch (qidx) {
+    case 0:
+        vu_set_queue_handler(dev, vq, started ? vrpmb_handle_ctrl : NULL);
+        break;
+    default:
+        break;
+    }
+}
+
+static int
+vrpmb_process_msg(VuDev *dev, VhostUserMsg *msg, int *do_reply)
+{
+    switch (msg->request) {
+    default:
+        return 0;
+    }
+
+    return 0;
+}
+
+static const VuDevIface vuiface = {
+    .set_features = vrpmb_set_features,
+    .get_features = vrpmb_get_features,
+    .queue_set_started = vrpmb_queue_set_started,
+    .process_msg = vrpmb_process_msg,
+    .get_config = vrpmb_get_config,
+    .set_config = vrpmb_set_config,
+};
+
+static void vrpmb_destroy(VuRpmb *r)
+{
+    vug_deinit(&r->dev);
+}
+
 /* Print vhost-user.json backend program capabilities */
 static void print_capabilities(void)
 {
@@ -33,8 +187,11 @@ int main (int argc, char *argv[])
 {
     GError *error = NULL;
     GOptionContext *context;
+    g_autoptr(GMainLoop) loop = NULL;
+    g_autoptr(GSocket) socket = NULL;
+    VuRpmb rpmb = {  };
 
-    context = g_option_context_new ("vhost-user-rpmb - vhost-user emulation of RPBM device");
+    context = g_option_context_new ("vhost-user emulation of RPBM device");
     g_option_context_add_main_entries (context, options, "vhost-user-rpmb");
     if (!g_option_context_parse (context, &argc, &argv, &error))
     {
@@ -47,4 +204,54 @@ int main (int argc, char *argv[])
         exit(0);
     }
 
+    if (!socket_path && socket_fd < 0) {
+        g_printerr("Please specify either --fd or --socket-path\n");
+        exit(EXIT_FAILURE);
+    }
+
+    /*
+     * Now create a vhost-user socket that we will receive messages
+     * on. Once we have our handler set up we can enter the glib main
+     * loop.
+     */
+    if (socket_path) {
+        g_autoptr(GSocketAddress) addr = g_unix_socket_address_new(socket_path);
+        g_autoptr(GSocket) bind_socket = g_socket_new(G_SOCKET_FAMILY_UNIX, G_SOCKET_TYPE_STREAM,
+                                                      G_SOCKET_PROTOCOL_DEFAULT, &error);
+
+        if (!g_socket_bind(bind_socket, addr, false, &error)) {
+            g_printerr("Failed to bind to socket at %s (%s).\n",
+                       socket_path, error->message);
+            exit(EXIT_FAILURE);
+        }
+        if (!g_socket_listen(bind_socket, &error)) {
+            g_printerr("Failed to listen on socket %s (%s).\n",
+                       socket_path, error->message);
+        }
+        g_message("awaiting connection to %s", socket_path);
+        socket = g_socket_accept(bind_socket, NULL, &error);
+        if (!socket) {
+            g_printerr("Failed to accept on socket %s (%s).\n",
+                       socket_path, error->message);
+        }
+    } else {
+        socket = g_socket_new_from_fd(socket_fd, &error);
+        if (!socket) {
+            g_printerr("Failed to connect to FD %d (%s).\n",
+                       socket_fd, error->message);
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    if (!vug_init(&rpmb.dev, VHOST_USER_RPMB_MAX_QUEUES, g_socket_get_fd(socket),
+                  vrpmb_panic, &vuiface)) {
+        g_printerr("Failed to initialize libvhost-user-glib.\n");
+        exit(EXIT_FAILURE);
+    }
+
+    loop = g_main_loop_new(NULL, FALSE);
+    g_main_loop_run(loop);
+    g_main_loop_unref(loop);
+
+    vrpmb_destroy(&rpmb);
 }
diff --git a/tools/vhost-user-rpmb/meson.build b/tools/vhost-user-rpmb/meson.build
index e0df1b69a3fb..cf80bedd99ac 100644
--- a/tools/vhost-user-rpmb/meson.build
+++ b/tools/vhost-user-rpmb/meson.build
@@ -1,6 +1,6 @@
 executable('vhost-user-rpmb', files(
   'main.c'),
-  dependencies: [glib],
+  dependencies: [qemuutil, glib, gio],
   link_with: [libvhost_user],
   install: true,
   install_dir: get_option('libexecdir'))
-- 
2.20.1


