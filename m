Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A836BC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FB82075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUwtVQ63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FB82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojyN-00031K-7N
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojPI-00057p-A6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojPG-0007e5-IJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojPG-0007du-Ek
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mjtemMUgB27JpLi8+N3bxzl1+0IVjBnBvvjPKdiAjc=;
 b=EUwtVQ633ugwwJ955WJAJBmY5lSYaP0R8d3RlgwlaHf1A8fJ0UUZklrRWapNGuGwN8HNtj
 hF6+kL32QY0mGWxrgHMfZe9haqbvCv5sboZPwPJIAiRfFEAjV2Ku0IHlxQObhJIeYkgGfF
 C/AOLh9ETjycm2AC+eVc1/hchNSQirQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-c2H7NctTPy-pMV7lO2k2kA-1; Tue, 07 Jan 2020 02:35:58 -0500
Received: by mail-qt1-f197.google.com with SMTP id e37so35931077qtk.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P6B2QZEV+S1MRINFAeh/u30RoNzW+dHtR0xLU33u1wE=;
 b=N2/GvsOjw13SkZ0uNikrrgFn3WDbumUXDJLMdSv9Lp71LQfhJWi78+dZZju6z7Zk44
 AvXzzJLsece+2JS5NfZvwUe35rItDbcFT4z5VxZK73FRhf1BTXBaeMGG92OoJ2zaDfgl
 knt0yNiOiunoVWNccFFW5lziyeH52c/xEcoKpYjgQI8InJlmhX+WEzD9qMCV+jQPhRSr
 B7I2xMfN6ovZBmKk+2diBDIiYghVmVtOfrbWgnAQWU7deGx2B1160M9qYY8hDi9h0ADz
 KqeD/nPnR+h6l9S5WCs2dU0bkrTcqxjlnGRTjVAxX9OH5h/wMO/n8O9xymptuVkTyWEm
 cfWw==
X-Gm-Message-State: APjAAAWsdrkIweHqnol5YN54UzgE1uf22B1iwuAKRKXT/5CgubX8jAxp
 ozI2G49/iOHfpLXSLAan4qIo+rskrgHxQQSEQkUXbUEhsqNVJdz4HAKOIAErxGRo0HPstPWVFxg
 8lf7Q2JH5Eady1F4=
X-Received: by 2002:a05:620a:1227:: with SMTP id
 v7mr12066157qkj.225.1578382557294; 
 Mon, 06 Jan 2020 23:35:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNlIg/pf9+BEIA0P3YXKNuszfONQF0anTzcPbUaKBPoZ7wosF1eE8513NvW4Msk7XIP5ggAQ==
X-Received: by 2002:a05:620a:1227:: with SMTP id
 v7mr12066138qkj.225.1578382556914; 
 Mon, 06 Jan 2020 23:35:56 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id u15sm21999829qku.67.2020.01.06.23.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:35:56 -0800 (PST)
Date: Tue, 7 Jan 2020 02:35:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/32] Implement backend program convention command for
 vhost-user-blk
Message-ID: <20200107073451.298261-10-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: c2H7NctTPy-pMV7lO2k2kA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Micky Yun Chan <chanmickyyun@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Micky Yun Chan <chanmickyyun@gmail.com>

This patch is to add standard commands defined in docs/interop/vhost-user.r=
st
For vhost-user-* program

Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
Message-Id: <20191209015331.5455-1-chanmickyyun@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.json            |  31 +++++++
 contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++----------
 docs/interop/vhost-user.rst             |  17 ++++
 3 files changed, 112 insertions(+), 44 deletions(-)

diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index da6aaf51c8..ce0ef74db5 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -54,6 +54,37 @@
   ]
 }
=20
+##
+# @VHostUserBackendBlockFeature:
+#
+# List of vhost user "block" features.
+#
+# @read-only: The --read-only command line option is supported.
+# @blk-file: The --blk-file command line option is supported.
+#
+# Since: 5.0
+##
+{
+  'enum': 'VHostUserBackendBlockFeature',
+  'data': [ 'read-only', 'blk-file' ]
+}
+
+##
+# @VHostUserBackendCapabilitiesBlock:
+#
+# Capabilities reported by vhost user "block" backends
+#
+# @features: list of supported features.
+#
+# Since: 5.0
+##
+{
+  'struct': 'VHostUserBackendCapabilitiesBlock',
+  'data': {
+    'features': [ 'VHostUserBackendBlockFeature' ]
+  }
+}
+
 ##
 # @VHostUserBackendInputFeature:
 #
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-b=
lk/vhost-user-blk.c
index ae61034656..6fd91c7e99 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -576,70 +576,90 @@ vub_new(char *blk_file)
     return vdev_blk;
 }
=20
+static int opt_fdnum =3D -1;
+static char *opt_socket_path;
+static char *opt_blk_file;
+static gboolean opt_print_caps;
+static gboolean opt_read_only;
+
+static GOptionEntry entries[] =3D {
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
-    char *unix_socket =3D NULL;
-    char *blk_file =3D NULL;
-    bool enable_ro =3D false;
     int lsock =3D -1, csock =3D -1;
     VubDev *vdev_blk =3D NULL;
+    GError *error =3D NULL;
+    GOptionContext *context;
=20
-    while ((opt =3D getopt(argc, argv, "b:rs:h")) !=3D -1) {
-        switch (opt) {
-        case 'b':
-            blk_file =3D g_strdup(optarg);
-            break;
-        case 's':
-            unix_socket =3D g_strdup(optarg);
-            break;
-        case 'r':
-            enable_ro =3D true;
-            break;
-        case 'h':
-        default:
-            printf("Usage: %s [ -b block device or file, -s UNIX domain so=
cket"
-                   " | -r Enable read-only ] | [ -h ]\n", argv[0]);
-            return 0;
+    context =3D g_option_context_new(NULL);
+    g_option_context_add_main_entries(context, entries, NULL);
+    if (!g_option_context_parse(context, &argc, &argv, &error)) {
+        g_printerr("Option parsing failed: %s\n", error->message);
+        exit(EXIT_FAILURE);
+    }
+    if (opt_print_caps) {
+        g_print("{\n");
+        g_print("  \"type\": \"block\",\n");
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
+        lsock =3D unix_sock_new(opt_socket_path);
+        if (lsock < 0) {
+            exit(EXIT_FAILURE);
         }
+    } else if (opt_fdnum < 0) {
+        g_print("%s\n", g_option_context_get_help(context, true, NULL));
+        exit(EXIT_FAILURE);
+    } else {
+        lsock =3D opt_fdnum;
     }
=20
-    if (!unix_socket || !blk_file) {
-        printf("Usage: %s [ -b block device or file, -s UNIX domain socket=
"
-               " | -r Enable read-only ] | [ -h ]\n", argv[0]);
-        return -1;
-    }
-
-    lsock =3D unix_sock_new(unix_socket);
-    if (lsock < 0) {
-        goto err;
-    }
-
-    csock =3D accept(lsock, (void *)0, (void *)0);
+    csock =3D accept(lsock, NULL, NULL);
     if (csock < 0) {
-        fprintf(stderr, "Accept error %s\n", strerror(errno));
-        goto err;
+        g_printerr("Accept error %s\n", strerror(errno));
+        exit(EXIT_FAILURE);
     }
=20
-    vdev_blk =3D vub_new(blk_file);
+    vdev_blk =3D vub_new(opt_blk_file);
     if (!vdev_blk) {
-        goto err;
+        exit(EXIT_FAILURE);
     }
-    if (enable_ro) {
+    if (opt_read_only) {
         vdev_blk->enable_ro =3D true;
     }
=20
     if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
                   vub_panic_cb, &vub_iface)) {
-        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
-        goto err;
+        g_printerr("Failed to initialize libvhost-user-glib\n");
+        exit(EXIT_FAILURE);
     }
=20
     g_main_loop_run(vdev_blk->loop);
-
+    g_main_loop_unref(vdev_blk->loop);
+    g_option_context_free(context);
     vug_deinit(&vdev_blk->parent);
-
-err:
     vub_free(vdev_blk);
     if (csock >=3D 0) {
         close(csock);
@@ -647,8 +667,8 @@ err:
     if (lsock >=3D 0) {
         close(lsock);
     }
-    g_free(unix_socket);
-    g_free(blk_file);
+    g_free(opt_socket_path);
+    g_free(opt_blk_file);
=20
     return 0;
 }
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 7827b710aa..015ac08177 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1376,3 +1376,20 @@ Command line options:
   Enable virgl rendering support.
=20
   (optional)
+
+vhost-user-blk
+--------------
+
+Command line options:
+
+--blk-file=3DPATH
+
+  Specify block device or file path.
+
+  (optional)
+
+--read-only
+
+  Enable read-only.
+
+  (optional)
--=20
MST


