Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917E3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1A22084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXSbirZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1A22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVV1-0007Tt-O5
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQ2-0003fy-8S
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQ0-00042T-4s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVQ0-00041n-0Y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rmkutg1eWb8oKSfxmZGXg7G1V8iVJQJXx0SHheWDu4I=;
 b=OXSbirZwrC6TXt/6vuksl9e5ICbusf3oDnOEOV6XNAPnGXBU2cTc6ne03H2x8QbNPwzSHB
 9SSU6wune2tR26inlQ4yhpcUhbUf8BLegDhkfnZxTnNi94+zDkBjrkRXjQkyy279fWc+6g
 Zig1TLfzuWWijeHQH+YIeQD+M9url5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-XdaLSnIIPmCRGGsi9q3UYA-1; Mon, 21 Oct 2019 07:00:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2153B80183E;
 Mon, 21 Oct 2019 11:00:02 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BADE860619;
 Mon, 21 Oct 2019 10:59:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 15/30] virtiofsd: Open vhost connection instead of mounting
Date: Mon, 21 Oct 2019 11:58:17 +0100
Message-Id: <20191021105832.36574-16-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XdaLSnIIPmCRGGsi9q3UYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When run with vhost-user options we conect to the QEMU instead
via a socket.  Start this off by creating the socket.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_i.h        |  7 ++-
 contrib/virtiofsd/fuse_lowlevel.c | 53 +++-------------------
 contrib/virtiofsd/fuse_virtio.c   | 75 +++++++++++++++++++++++++++++++
 contrib/virtiofsd/fuse_virtio.h   | 23 ++++++++++
 4 files changed, 110 insertions(+), 48 deletions(-)
 create mode 100644 contrib/virtiofsd/fuse_virtio.c
 create mode 100644 contrib/virtiofsd/fuse_virtio.h

diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index d65af06ff0..27fa50274d 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -6,9 +6,10 @@
   See the file COPYING.LIB
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
@@ -119,3 +120,5 @@ void fuse_session_process_buf_int(struct fuse_session *=
se,
=20
 /* room needed in buffer to accommodate header */
 #define FUSE_BUFFER_HEADER_SIZE 0x1000
+
+#endif
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index d47e4438f3..247667e3f4 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -13,6 +13,7 @@
 #include "fuse_kernel.h"
 #include "fuse_opt.h"
 #include "fuse_misc.h"
+#include "fuse_virtio.h"
=20
 #include <stdio.h>
 #include <stdlib.h>
@@ -2152,6 +2153,11 @@ struct fuse_session *fuse_session_new(struct fuse_ar=
gs *args,
 =09=09goto out4;
 =09}
=20
+=09if (!se->vu_socket_path) {
+=09=09fprintf(stderr, "fuse: missing -o vhost_user_socket option\n");
+=09=09goto out4;
+=09}
+
 =09se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() +
 =09=09FUSE_BUFFER_HEADER_SIZE;
=20
@@ -2175,52 +2181,7 @@ out1:
=20
 int fuse_session_mount(struct fuse_session *se)
 {
-=09int fd;
-
-=09/*
-=09 * Make sure file descriptors 0, 1 and 2 are open, otherwise chaos
-=09 * would ensue.
-=09 */
-=09do {
-=09=09fd =3D open("/dev/null", O_RDWR);
-=09=09if (fd > 2)
-=09=09=09close(fd);
-=09} while (fd >=3D 0 && fd <=3D 2);
-
-=09/*
-=09 * To allow FUSE daemons to run without privileges, the caller may open
-=09 * /dev/fuse before launching the file system and pass on the file
-=09 * descriptor by specifying /dev/fd/N as the mount point. Note that the
-=09 * parent process takes care of performing the mount in this case.
-=09 */
-=09fd =3D fuse_mnt_parse_fuse_fd(mountpoint);
-=09if (fd !=3D -1) {
-=09=09if (fcntl(fd, F_GETFD) =3D=3D -1) {
-=09=09=09fuse_log(FUSE_LOG_ERR,
-=09=09=09=09"fuse: Invalid file descriptor /dev/fd/%u\n",
-=09=09=09=09fd);
-=09=09=09return -1;
-=09=09}
-=09=09se->fd =3D fd;
-=09=09return 0;
-=09}
-
-=09/* Open channel */
-=09fd =3D fuse_kern_mount(mountpoint, se->mo);
-=09if (fd =3D=3D -1)
-=09=09return -1;
-=09se->fd =3D fd;
-
-=09/* Save mountpoint */
-=09se->mountpoint =3D strdup(mountpoint);
-=09if (se->mountpoint =3D=3D NULL)
-=09=09goto error_out;
-
-=09return 0;
-
-error_out:
-=09fuse_kern_unmount(mountpoint, fd);
-=09return -1;
+=09return virtio_session_mount(se);
 }
=20
 int fuse_session_fd(struct fuse_session *se)
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
new file mode 100644
index 0000000000..da8451faa7
--- /dev/null
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -0,0 +1,75 @@
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
+#include "fuse_kernel.h"
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
+    size_t addr_len =3D sizeof(un.sun_family) + strlen(se->vu_socket_path)=
;
+
+    int listen_sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
+    if (listen_sock =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "vhost socket creation: %m\n");
+        return -1;
+    }
+    un.sun_family =3D AF_UNIX;
+
+    if (bind(listen_sock, (struct sockaddr *)&un, addr_len) =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
+        return -1;
+    }
+
+    if (listen(listen_sock, 1) =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "vhost socket listen: %m\n");
+        return -1;
+    }
+
+    return -1;
+}
diff --git a/contrib/virtiofsd/fuse_virtio.h b/contrib/virtiofsd/fuse_virti=
o.h
new file mode 100644
index 0000000000..6652e609e0
--- /dev/null
+++ b/contrib/virtiofsd/fuse_virtio.h
@@ -0,0 +1,23 @@
+/*
+  virtio-fs glue for FUSE
+  Copyright (C) 2018 Red Hat, Inc. and/or its affiliates
+
+  Authors:
+    Dave Gilbert  <dgilbert@redhat.com>
+
+  Implements the glue between libfuse and libvhost-user
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file COPYING.LIB
+*/
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


