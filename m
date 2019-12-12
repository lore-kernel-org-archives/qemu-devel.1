Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4FAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985B7214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0615imt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985B7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRmr-0000AZ-92
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV9-0005Ct-JH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV7-0001L4-7G
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49595
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRV6-0001JF-VG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXKKZHsYCw2RMG6OQgnRzNhEmU6giBdSnJxc3Xi9O0E=;
 b=R0615imtCxrx6DXrXsSS5Uk+K1yXRdjymF9NcHmlvIjcFa14vcL2yZu2bTW6YfViIXn2Ip
 4xlljJ2o/Q+VU6JP4UPHb0WxbRqc11U6d3tLI5XphuM8z/eOPLmnnW7/upWPsaUBDuTQVs
 e+etIIwyaXmeRUTFiZrEv/56AFFiXZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-eixFjUkEOaKxyAXeV56JFA-1; Thu, 12 Dec 2019 11:39:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8676107ACC7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:37 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07C4760BE1;
 Thu, 12 Dec 2019 16:39:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 016/104] virtiofsd: Open vhost connection instead of mounting
Date: Thu, 12 Dec 2019 16:37:36 +0000
Message-Id: <20191212163904.159893-17-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: eixFjUkEOaKxyAXeV56JFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When run with vhost-user options we conect to the QEMU instead
via a socket.  Start this off by creating the socket.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_i.h        |  7 ++-
 tools/virtiofsd/fuse_lowlevel.c | 55 +++-------------------
 tools/virtiofsd/fuse_virtio.c   | 83 +++++++++++++++++++++++++++++++++
 tools/virtiofsd/fuse_virtio.h   | 23 +++++++++
 4 files changed, 118 insertions(+), 50 deletions(-)
 create mode 100644 tools/virtiofsd/fuse_virtio.c
 create mode 100644 tools/virtiofsd/fuse_virtio.h

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index f58be71e4b..df078f2360 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -6,9 +6,10 @@
  * See the file COPYING.LIB
  */
=20
-#define FUSE_USE_VERSION 31
-
+#ifndef FUSE_I_H
+#define FUSE_I_H
=20
+#define FUSE_USE_VERSION 31
 #include "fuse.h"
 #include "fuse_lowlevel.h"
=20
@@ -120,3 +121,5 @@ void fuse_session_process_buf_int(struct fuse_session *=
se,
=20
 /* room needed in buffer to accommodate header */
 #define FUSE_BUFFER_HEADER_SIZE 0x1000
+
+#endif
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index da708161e1..f553102eba 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -13,6 +13,7 @@
 #include "standard-headers/linux/fuse.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
+#include "fuse_virtio.h"
=20
 #include <assert.h>
 #include <errno.h>
@@ -2223,6 +2224,11 @@ struct fuse_session *fuse_session_new(struct fuse_ar=
gs *args,
         goto out4;
     }
=20
+    if (!se->vu_socket_path) {
+        fprintf(stderr, "fuse: missing -o vhost_user_socket option\n");
+        goto out4;
+    }
+
     se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_HEADE=
R_SIZE;
=20
     list_init_req(&se->list);
@@ -2245,54 +2251,7 @@ out1:
=20
 int fuse_session_mount(struct fuse_session *se)
 {
-    int fd;
-
-    /*
-     * Make sure file descriptors 0, 1 and 2 are open, otherwise chaos
-     * would ensue.
-     */
-    do {
-        fd =3D open("/dev/null", O_RDWR);
-        if (fd > 2) {
-            close(fd);
-        }
-    } while (fd >=3D 0 && fd <=3D 2);
-
-    /*
-     * To allow FUSE daemons to run without privileges, the caller may ope=
n
-     * /dev/fuse before launching the file system and pass on the file
-     * descriptor by specifying /dev/fd/N as the mount point. Note that th=
e
-     * parent process takes care of performing the mount in this case.
-     */
-    fd =3D fuse_mnt_parse_fuse_fd(mountpoint);
-    if (fd !=3D -1) {
-        if (fcntl(fd, F_GETFD) =3D=3D -1) {
-            fuse_log(FUSE_LOG_ERR, "fuse: Invalid file descriptor /dev/fd/=
%u\n",
-                     fd);
-            return -1;
-        }
-        se->fd =3D fd;
-        return 0;
-    }
-
-    /* Open channel */
-    fd =3D fuse_kern_mount(mountpoint, se->mo);
-    if (fd =3D=3D -1) {
-        return -1;
-    }
-    se->fd =3D fd;
-
-    /* Save mountpoint */
-    se->mountpoint =3D strdup(mountpoint);
-    if (se->mountpoint =3D=3D NULL) {
-        goto error_out;
-    }
-
-    return 0;
-
-error_out:
-    fuse_kern_unmount(mountpoint, fd);
-    return -1;
+    return virtio_session_mount(se);
 }
=20
 int fuse_session_fd(struct fuse_session *se)
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
new file mode 100644
index 0000000000..3a77bb8657
--- /dev/null
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -0,0 +1,83 @@
+/*
+ * virtio-fs glue for FUSE
+ * Copyright (C) 2018 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *   Dave Gilbert  <dgilbert@redhat.com>
+ *
+ * Implements the glue between libfuse and libvhost-user
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB
+ */
+
+#include "fuse_i.h"
+#include "standard-headers/linux/fuse.h"
+#include "fuse_misc.h"
+#include "fuse_opt.h"
+#include "fuse_virtio.h"
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+/* From spec */
+struct virtio_fs_config {
+    char tag[36];
+    uint32_t num_queues;
+};
+
+int virtio_session_mount(struct fuse_session *se)
+{
+    struct sockaddr_un un;
+    mode_t old_umask;
+
+    if (strlen(se->vu_socket_path) >=3D sizeof(un.sun_path)) {
+        fuse_log(FUSE_LOG_ERR, "Socket path too long\n");
+        return -1;
+    }
+
+    /*
+     * Poison the fuse FD so we spot if we accidentally use it;
+     * DO NOT check for this value, check for fuse_lowlevel_is_virtio()
+     */
+    se->fd =3D 0xdaff0d11;
+
+    /*
+     * Create the Unix socket to communicate with qemu
+     * based on QEMU's vhost-user-bridge
+     */
+    unlink(se->vu_socket_path);
+    strcpy(un.sun_path, se->vu_socket_path);
+    size_t addr_len =3D sizeof(un);
+
+    int listen_sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
+    if (listen_sock =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "vhost socket creation: %m\n");
+        return -1;
+    }
+    un.sun_family =3D AF_UNIX;
+
+    /*
+     * Unfortunately bind doesn't let you set the mask on the socket,
+     * so set umask to 077 and restore it later.
+     */
+    old_umask =3D umask(0077);
+    if (bind(listen_sock, (struct sockaddr *)&un, addr_len) =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
+        umask(old_umask);
+        return -1;
+    }
+    umask(old_umask);
+
+    if (listen(listen_sock, 1) =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "vhost socket listen: %m\n");
+        return -1;
+    }
+
+    return -1;
+}
diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virtio.h
new file mode 100644
index 0000000000..8f2edb69ca
--- /dev/null
+++ b/tools/virtiofsd/fuse_virtio.h
@@ -0,0 +1,23 @@
+/*
+ * virtio-fs glue for FUSE
+ * Copyright (C) 2018 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *   Dave Gilbert  <dgilbert@redhat.com>
+ *
+ * Implements the glue between libfuse and libvhost-user
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ *  See the file COPYING.LIB
+ */
+
+#ifndef FUSE_VIRTIO_H
+#define FUSE_VIRTIO_H
+
+#include "fuse_i.h"
+
+struct fuse_session;
+
+int virtio_session_mount(struct fuse_session *se);
+
+#endif
--=20
2.23.0


