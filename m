Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0664C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 06:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF4C2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 06:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuO2u1Ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF4C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWxC1-0000nr-Ld
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 01:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chanmickyyun@gmail.com>) id 1iWxAf-0008OG-Bl
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 01:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chanmickyyun@gmail.com>) id 1iWxAe-0002fL-1q
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 01:39:29 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chanmickyyun@gmail.com>)
 id 1iWxAd-0002ct-Pj
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 01:39:27 -0500
Received: by mail-pg1-x542.google.com with SMTP id 15so10864274pgh.5
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 22:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+RJtGG6EMm+0AGgsAyLmBlQAelRZh9D77sVdnuuQ+xY=;
 b=JuO2u1IkffOqquWnjMIF44381DHRN6jMvP6NdHbdcfZCQdwGWXbQHyfzK9a1APmzav
 hhjfbPbuP68fSKasDAbEKNWR50QmLhB0asr3+6/9PelplmaEyt8Le5pTX42RvWAAJeIT
 LeUoW88vxb3DqTrLDVS+lhmjH+zONULyTe2Ih1UrgaOwf7YU/ZfO2BffC8EZveUBM1Yd
 SWvqliR6RycvUnU0izv1ElgvyuVmldSx9kVUW4WxIxt6tsBXhPlbchPZ0BGnMiauVMQS
 h0q4G/LBa0eFRKgQv3KGjjd90/pMMEFvOBzEiox50493fSs7s0i0eSN1/rNBnCsq57B8
 VMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+RJtGG6EMm+0AGgsAyLmBlQAelRZh9D77sVdnuuQ+xY=;
 b=fk02tYLD3s+FVlT2OYLH3yydzGVID7cu7/iS6wXRnD1GuqG74Ki1kNowMmVimMYmT3
 Pg6oIJSFmYiFX7QPzpj9zm2hmZrFZkbEgntK+AT/TCKqPH4JuR2dd4OsggkRxEPMj0B/
 CXF+JQA+9TL1aaSSkbnlC4gkZ/ajfMlW4xpYSXo5Zf0TWjtGQFQa4ySlF8ulTZDCo/y3
 6pZWHOi6WqLs/tyVhLobBda6+ismUEbhRPavWTRLZkXOIBSKZN3EkDW4XuZQ1CoXtfp8
 UoPWlIaZAEYj6N7MqNm0sI7hYIzwm2PDQvZ9KZIc0h1Y2ud+3Va2iWfsyH7O0PKd5mzE
 2stg==
X-Gm-Message-State: APjAAAV91AQ0zLN/X7A7+3eZRphGo6tFmfpgS4aQwaxfh8BMnPYUgWXE
 4hVUNsXTnTddAUYjtwmFCKckCUsfy/0pWnbD
X-Google-Smtp-Source: APXvYqzIuhjpewPh8fqhqP0dC4FLhMKbDlVajq7yuT9x9+psiUS0tcZgZjl01k+pPJ4EFgiVyLjEYA==
X-Received: by 2002:a63:8249:: with SMTP id w70mr3811553pgd.54.1574145566111; 
 Mon, 18 Nov 2019 22:39:26 -0800 (PST)
Received: from localhost.localdomain.com ([209.132.188.80])
 by smtp.googlemail.com with ESMTPSA id k17sm19223222pgb.64.2019.11.18.22.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 22:39:25 -0800 (PST)
From: Micky Yun Chan <chanmickyyun@gmail.com>
X-Google-Original-From: Micky Yun Chan <michan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5] Implement backend program convention command for
 vhost-user-blk
Date: Tue, 19 Nov 2019 14:39:11 +0800
Message-Id: <20191119063911.18888-1-michan@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
index ae61034656..96c43bb58d 100644
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
+            exit(EXIT_FAILURE);
         }
+    } else if (opt_fdnum < 0) {
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


