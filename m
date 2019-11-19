Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 02:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F258B22310
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 02:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOKBYVcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F258B22310
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtF0-0008NF-5R
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 21:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chanmickyyun@gmail.com>) id 1iWtEG-0007an-M8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chanmickyyun@gmail.com>) id 1iWtEF-0002od-Bx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:26:56 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chanmickyyun@gmail.com>)
 id 1iWtEF-0002oX-4D
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:26:55 -0500
Received: by mail-pl1-x641.google.com with SMTP id e3so10882462plt.7
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 18:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i2r/mOApj4LAQtxgh1li1SATnPX6DmW2po1B+XTx69E=;
 b=MOKBYVcTOvhT4CJoT3QNDu5O0c3DNgwu52SL3u8ddPSJ3/aEcz7lAP49veU+7SoFEX
 +lIxFJtKm2KYl83GtYFTt5rFGs0I1Zp17AQF28JF8l6Y8CAsjOoPefB+dQiD9BtsQfHf
 gkGZIHw/Ik6ljsW2uOWMw3eClmBxex+LZfxCdZOclSY5QpJe1CG1GNzqnzacGEVoJaQb
 MNcz8fjf2GuBtQmAcPmPzEGJe6Ufwf2RNmXqMcRYuScOfL6KmNjHkI1kiBAwR6Cu/ay6
 Ra/KZDCgij+rgeoPaIMeR9ZdzKKvwbsyzDix6QOI/0cZ7f7BBrLamKRkp0V2kNkouIpY
 mNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i2r/mOApj4LAQtxgh1li1SATnPX6DmW2po1B+XTx69E=;
 b=EUsbeLJ4kfD80Xh9jOrmW+7U6E8phkYOYwq6/5SMnqI6aYwLSjQsw2NTitlq+FG08T
 APauDPcLnmtd60MLY195/meH7hz0834oTnXv8V/1iAcP+dMIsChNkaY0YqI3LY/9nbAx
 zlGhF74EVfQ0lqw5Cfuv0HKiilaudJmEZpmbtJ8drMaYdMS1t/aCW7deyYopT77o4vdk
 4sj0MbJ4Eyuc0PZvv4Yq9Ik46f66tTQ/54iRo6OHO6SWYUne2CB7QKG/27Qpj1zxtwmO
 0XeRkY24sDXJKUvoF8onfjTHk3gojCGRFs8q6ySg2LIBqrdGZiPUrQBh/qf1+8wkME3w
 z7dQ==
X-Gm-Message-State: APjAAAWlX65wJMLBOtrz0jZ1VCH7sFeLgmsTCWJ3vyduhrCcALcyPpRC
 mIBFIDmfanHLxgeAlXISTJWtFKBvpy14S8jV
X-Google-Smtp-Source: APXvYqyx+oCOkkk5OEdo/K/Ru7eppXdZqzmG1rPLaY0wDnx+ISlOUXaRXM1hyvZAwvdUXdzuW4mmmw==
X-Received: by 2002:a17:90a:348c:: with SMTP id
 p12mr2910677pjb.105.1574130413428; 
 Mon, 18 Nov 2019 18:26:53 -0800 (PST)
Received: from localhost.localdomain.com ([209.132.188.80])
 by smtp.googlemail.com with ESMTPSA id i2sm21912113pgt.34.2019.11.18.18.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 18:26:52 -0800 (PST)
From: Micky Yun Chan <chanmickyyun@gmail.com>
X-Google-Original-From: Micky Yun Chan <michan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] Implement backend program convention command for
 vhost-user-blk
Date: Tue, 19 Nov 2019 10:26:40 +0800
Message-Id: <20191119022640.11021-1-michan@redhat.com>
X-Mailer: git-send-email 2.21.0
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
Cc: michan <michan@redhat.com>, Micky Yun Chan <chanmickyyun@gmail.com>,
 stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: michan <michan@redhat.com>

This patch is to add standard commands defined in docs/interop/vhost-user.rst
For vhost-user-* program

Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 109 ++++++++++++++----------
 1 file changed, 65 insertions(+), 44 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index ae61034656..a226148bdc 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -576,70 +576,91 @@ vub_new(char *blk_file)
     return vdev_blk;
 }
 
+static int opt_fdnum = -1;
+static char *opt_socket_path;
+static char *opt_blk_file;
+static gboolean opt_print_caps;
+static gboolean opt_read_only;
+
+
+static GOptionEntry entries[] = {
+    { "print-capabilities", 'c', 0, G_OPTION_ARG_NONE, &opt_print_caps,
+      "Print capabilities", NULL },
+    { "fd", 'f', 0, G_OPTION_ARG_INT, &opt_fdnum,
+      "Use inherited fd socket", "FDNUM" },
+    { "socket-path", 's', 0, G_OPTION_ARG_FILENAME, &opt_socket_path,
+      "Use UNIX socket path", "PATH" },
+    {"blk-file", 'b', 0, G_OPTION_ARG_FILENAME, &opt_blk_file,
+     "block device or file path", "PATH"},
+    { "read-only", 'r', 0, G_OPTION_ARG_NONE, &opt_read_only,
+      "Enable read-only", NULL }
+};
+
 int main(int argc, char **argv)
 {
-    int opt;
-    char *unix_socket = NULL;
-    char *blk_file = NULL;
-    bool enable_ro = false;
     int lsock = -1, csock = -1;
     VubDev *vdev_blk = NULL;
+    GError *error = NULL;
+    GOptionContext *context;
 
-    while ((opt = getopt(argc, argv, "b:rs:h")) != -1) {
-        switch (opt) {
-        case 'b':
-            blk_file = g_strdup(optarg);
-            break;
-        case 's':
-            unix_socket = g_strdup(optarg);
-            break;
-        case 'r':
-            enable_ro = true;
-            break;
-        case 'h':
-        default:
-            printf("Usage: %s [ -b block device or file, -s UNIX domain socket"
-                   " | -r Enable read-only ] | [ -h ]\n", argv[0]);
-            return 0;
+    context = g_option_context_new(NULL);
+    g_option_context_add_main_entries(context, entries, NULL);
+    if (!g_option_context_parse(context, &argc, &argv, &error)) {
+        g_printerr("Option parsing failed: %s\n", error->message);
+        exit(EXIT_FAILURE);
+    }
+    if (opt_print_caps) {
+        g_print("{\n");
+        g_print("  \"type\": \"blk\",\n");
+        g_print("  \"features\": [\n");
+        g_print("    \"read-only\",\n");
+        g_print("    \"blk-file\"\n");
+        g_print("  ]\n");
+        g_print("}\n");
+        exit(EXIT_SUCCESS);
+    }
+
+    if (!opt_blk_file) {
+        g_print("%s\n", g_option_context_get_help(context, true, NULL));
+        exit(EXIT_FAILURE);
+    }
+
+    if (opt_socket_path) {
+        lsock = unix_sock_new(opt_socket_path);
+        if (lsock < 0) {
+           exit(EXIT_FAILURE);
         }
+    } else if(opt_fdnum < 0){
+        g_print("%s\n", g_option_context_get_help(context, true, NULL));
+        exit(EXIT_FAILURE);
+    } else {
+        lsock = opt_fdnum;
     }
 
-    if (!unix_socket || !blk_file) {
-        printf("Usage: %s [ -b block device or file, -s UNIX domain socket"
-               " | -r Enable read-only ] | [ -h ]\n", argv[0]);
-        return -1;
-    }
-
-    lsock = unix_sock_new(unix_socket);
-    if (lsock < 0) {
-        goto err;
-    }
-
-    csock = accept(lsock, (void *)0, (void *)0);
+    csock = accept(lsock, NULL, NULL);
     if (csock < 0) {
-        fprintf(stderr, "Accept error %s\n", strerror(errno));
-        goto err;
+        g_printerr("Accept error %s\n", strerror(errno));
+        exit(EXIT_FAILURE);
     }
 
-    vdev_blk = vub_new(blk_file);
+    vdev_blk = vub_new(opt_blk_file);
     if (!vdev_blk) {
-        goto err;
+        exit(EXIT_FAILURE);
     }
-    if (enable_ro) {
+    if (opt_read_only) {
         vdev_blk->enable_ro = true;
     }
 
     if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
                   vub_panic_cb, &vub_iface)) {
-        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
-        goto err;
+        g_printerr("Failed to initialize libvhost-user-glib\n");
+        exit(EXIT_FAILURE);
     }
 
     g_main_loop_run(vdev_blk->loop);
-
+    g_main_loop_unref(vdev_blk->loop);
+    g_option_context_free(context);
     vug_deinit(&vdev_blk->parent);
-
-err:
     vub_free(vdev_blk);
     if (csock >= 0) {
         close(csock);
@@ -647,8 +668,8 @@ err:
     if (lsock >= 0) {
         close(lsock);
     }
-    g_free(unix_socket);
-    g_free(blk_file);
+    g_free(opt_socket_path);
+    g_free(opt_blk_file);
 
     return 0;
 }
-- 
2.21.0


