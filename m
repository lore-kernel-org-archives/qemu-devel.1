Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA138C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707DE206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDSOYgSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707DE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnJS-0001eZ-KD
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCu-0007qm-Eh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCs-0001R5-EM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so3518664wrm.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=La3wf0jgdLLaxy3qyiZ5nLFWQDulF/WBD+D4LgHv5vo=;
 b=gDSOYgSFewYCKCeiBthgQfO9lDdu251R/GVGuV69QTfKwahNlWXaTyMUnKiZcCLRwZ
 J3We7jodc6NQ7jHC86IJpHHURJc45O+bvnnqI/MehiicHpvvWUHzonrCKxc14M1htnM/
 ieM+uPWUdkfYbyHoEGQ0NqHWnjG2MmAr6amBossVDArsXaThqA69zcMqZjL29V/xRPkG
 kQHSWh0RGM5Ot/o7V6ISt5Uk//+IctUG0nsjkBfnJ8HUfN9mJvW0hGc0oHrppjAB3Gyr
 4qJxETzaACuIVtVWHItKkcHuifPd/KG7nyqc8SFS3PCAQDKiG1gnlCzGoa6FpimLafIb
 6DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=La3wf0jgdLLaxy3qyiZ5nLFWQDulF/WBD+D4LgHv5vo=;
 b=ebZ5YeV1lRoi66VlnEZ71ngjmuGPxV3rKcY7L9JYfagjjasow/bX/jANw85LfaVUmp
 sE4AkQnCzOSpGWOtknIC/GoreIXhU6b/SWwz8NrTBgxd680jX59T56v7voJ3GiPpKScB
 wCTrDrGmTTVFjm9uaDGk0bOyHTCdbH65I3GtOAM/fq8AWJBPLs5ehxGrTREQnzHvoIqf
 Rrh7hQNGmVWD0Hrlnp+mP+KGdHKg2Xjck6FzZmNYqCxzOcgrPrPj5CIVkG/W6cdlEZs7
 tvAL7sdDHJzOIJtzFNpZZIKJiR3xNyo5WyROYQpIue+oRYArXS2a0xx5Oej+Y8PgYwsY
 FtDQ==
X-Gm-Message-State: AOAM530WE1A75FXBMUm1cgdQqXnNXRA9HSp6TtkwAVJdrCF0wbPba5bu
 zRV+/3b0FfhrvSlK/75XYZDiYg==
X-Google-Smtp-Source: ABdhPJw+FnAq0jAiugV2Cg4Tl3jIA4VQwRsQf9Hp7qNWdz8GCxcD2vXGq4F6xrTrZ0uReMSF0qA0HQ==
X-Received: by 2002:adf:e292:: with SMTP id v18mr4351820wri.256.1601038329141; 
 Fri, 25 Sep 2020 05:52:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i83sm2877331wma.22.2020.09.25.05.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C74D1FF99;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 10/19] tools/vhost-user-rpmb: handle shutdown and
 SIGINT/SIGHUP cleanly
Date: Fri, 25 Sep 2020 13:51:38 +0100
Message-Id: <20200925125147.26943-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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

The libvhost-user library will just exit if it handles the
VHOST_USER_NONE message and we want to ensure we have tidied up after
ourselves. As we need to signal the shutdown of the main loop we need
to move the information into the VuRmb state structure.

We also want to do the same if we catch a SIGINT/SIGHUP termination
signal. While we are at it add some instrumentation so we can follow
the program flow.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 49 +++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 1be0d4b8a567..7b3b29ccfc5b 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -12,6 +12,7 @@
 #include <glib.h>
 #include <gio/gio.h>
 #include <gio/gunixsocketaddress.h>
+#include <glib-unix.h>
 #include <stdio.h>
 #include <string.h>
 #include <inttypes.h>
@@ -73,6 +74,7 @@ struct virtio_rpmb_frame {
 typedef struct VuRpmb {
     VugDev dev;
     struct virtio_rpmb_config virtio_config;
+    GMainLoop *loop;
 } VuRpmb;
 
 struct virtio_rpmb_ctrl_command {
@@ -158,10 +160,22 @@ vrpmb_queue_set_started(VuDev *dev, int qidx, bool started)
     }
 }
 
-static int
-vrpmb_process_msg(VuDev *dev, VhostUserMsg *msg, int *do_reply)
+/*
+ * vrpmb_process_msg: process messages of vhost-user interface
+ *
+ * Any that are not handled here are processed by the libvhost library
+ * itself.
+ */
+static int vrpmb_process_msg(VuDev *dev, VhostUserMsg *msg, int *do_reply)
 {
+    VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
+
+    g_info("%s: msg %d", __func__, msg->request);
+
     switch (msg->request) {
+    case VHOST_USER_NONE:
+        g_main_loop_quit(r->loop);
+        return 1;
     default:
         return 0;
     }
@@ -181,6 +195,9 @@ static const VuDevIface vuiface = {
 static void vrpmb_destroy(VuRpmb *r)
 {
     vug_deinit(&r->dev);
+    if (socket_path) {
+        unlink(socket_path);
+    }
 }
 
 /* Print vhost-user.json backend program capabilities */
@@ -191,11 +208,18 @@ static void print_capabilities(void)
     printf("}\n");
 }
 
+static gboolean hangup(gpointer user_data)
+{
+    GMainLoop *loop = (GMainLoop *) user_data;
+    g_info("%s: caught hangup/quit signal, quitting main loop", __func__);
+    g_main_loop_quit(loop);
+    return true;
+}
+
 int main (int argc, char *argv[])
 {
     GError *error = NULL;
     GOptionContext *context;
-    g_autoptr(GMainLoop) loop = NULL;
     g_autoptr(GSocket) socket = NULL;
     VuRpmb rpmb = {  };
 
@@ -262,15 +286,28 @@ int main (int argc, char *argv[])
         }
     }
 
+    /*
+     * Create the main loop first so all the various sources can be
+     * added. As well as catching signals we need to ensure vug_init
+     * can add it's GSource watches.
+     */
+
+    rpmb.loop = g_main_loop_new(NULL, FALSE);
+    /* catch exit signals */
+    g_unix_signal_add(SIGHUP, hangup, rpmb.loop);
+    g_unix_signal_add(SIGINT, hangup, rpmb.loop);
+
     if (!vug_init(&rpmb.dev, VHOST_USER_RPMB_MAX_QUEUES, g_socket_get_fd(socket),
                   vrpmb_panic, &vuiface)) {
         g_printerr("Failed to initialize libvhost-user-glib.\n");
         exit(EXIT_FAILURE);
     }
 
-    loop = g_main_loop_new(NULL, FALSE);
-    g_main_loop_run(loop);
-    g_main_loop_unref(loop);
 
+    g_message("entering main loop, awaiting messages");
+    g_main_loop_run(rpmb.loop);
+    g_message("finished main loop, cleaning up");
+
+    g_main_loop_unref(rpmb.loop);
     vrpmb_destroy(&rpmb);
 }
-- 
2.20.1


