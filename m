Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B444A21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoEGlIy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B444A21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhSI-0007lW-Gu
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdT-0004Tp-BC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdR-0006Hq-Ny
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdR-0006Hg-LN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pa5Tc/5wbQWlujFEIsGw4Jvrr1IG5Qh8MD2XG2sAtKs=;
 b=KoEGlIy75F5KbWhco+2Nzpyxk//iRuS6AfEZAsriGV3HKmcGHHw0baN0jOx4jRKj7YdaYb
 eb4RecXSTHlLki0tOcI+nuIx/8UuHeeJbD48/8Q3sUmo58SS8FdkLuqBuuBrIeIqvMKNDN
 yraQI1Z23ROh4tg8F25XW0Q3bq/5puI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-hXswx2bcOFKL-_ckM55Oug-1; Thu, 23 Jan 2020 11:47:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0BB18C18E6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:10 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A54828991;
 Thu, 23 Jan 2020 16:47:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 019/108] virtiofsd: Start wiring up vhost-user
Date: Thu, 23 Jan 2020 16:45:01 +0000
Message-Id: <20200123164630.91498-20-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hXswx2bcOFKL-_ckM55Oug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Listen on our unix socket for the connection from QEMU, when we get it
initialise vhost-user and dive into our own loop variant (currently
dummy).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_i.h         |  4 ++
 tools/virtiofsd/fuse_lowlevel.c  |  5 ++
 tools/virtiofsd/fuse_lowlevel.h  |  7 +++
 tools/virtiofsd/fuse_virtio.c    | 87 +++++++++++++++++++++++++++++++-
 tools/virtiofsd/fuse_virtio.h    |  2 +
 tools/virtiofsd/passthrough_ll.c |  7 +--
 6 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 82d6ac7115..ec04449069 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -13,6 +13,8 @@
 #include "fuse.h"
 #include "fuse_lowlevel.h"
=20
+struct fv_VuDev;
+
 struct fuse_req {
     struct fuse_session *se;
     uint64_t unique;
@@ -65,6 +67,8 @@ struct fuse_session {
     size_t bufsize;
     int error;
     char *vu_socket_path;
+    int   vu_socketfd;
+    struct fv_VuDev *virtio_dev;
 };
=20
 struct fuse_chan {
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 5df124e64b..af09fa2b94 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2242,6 +2242,11 @@ void fuse_session_unmount(struct fuse_session *se)
 {
 }
=20
+int fuse_lowlevel_is_virtio(struct fuse_session *se)
+{
+    return se->vu_socket_path !=3D NULL;
+}
+
 #ifdef linux
 int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
 {
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 2fa225d40b..f6b34700af 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1755,6 +1755,13 @@ void fuse_req_interrupt_func(fuse_req_t req, fuse_in=
terrupt_func_t func,
  */
 int fuse_req_interrupted(fuse_req_t req);
=20
+/**
+ * Check if the session is connected via virtio
+ *
+ * @param se session object
+ * @return 1 if the session is a virtio session
+ */
+int fuse_lowlevel_is_virtio(struct fuse_session *se);
=20
 /*
  * Inquiry functions
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index cbef6ffdda..2ae3c764dd 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -19,18 +19,78 @@
=20
 #include <stdint.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/un.h>
 #include <unistd.h>
=20
+#include "contrib/libvhost-user/libvhost-user.h"
+
+/*
+ * We pass the dev element into libvhost-user
+ * and then use it to get back to the outer
+ * container for other data.
+ */
+struct fv_VuDev {
+    VuDev dev;
+    struct fuse_session *se;
+};
+
 /* From spec */
 struct virtio_fs_config {
     char tag[36];
     uint32_t num_queues;
 };
=20
+/*
+ * Callback from libvhost-user if there's a new fd we're supposed to liste=
n
+ * to, typically a queue kick?
+ */
+static void fv_set_watch(VuDev *dev, int fd, int condition, vu_watch_cb cb=
,
+                         void *data)
+{
+    fuse_log(FUSE_LOG_WARNING, "%s: TODO! fd=3D%d\n", __func__, fd);
+}
+
+/*
+ * Callback from libvhost-user if we're no longer supposed to listen on an=
 fd
+ */
+static void fv_remove_watch(VuDev *dev, int fd)
+{
+    fuse_log(FUSE_LOG_WARNING, "%s: TODO! fd=3D%d\n", __func__, fd);
+}
+
+/* Callback from libvhost-user to panic */
+static void fv_panic(VuDev *dev, const char *err)
+{
+    fuse_log(FUSE_LOG_ERR, "%s: libvhost-user: %s\n", __func__, err);
+    /* TODO: Allow reconnects?? */
+    exit(EXIT_FAILURE);
+}
+
+static bool fv_queue_order(VuDev *dev, int qidx)
+{
+    return false;
+}
+
+static const VuDevIface fv_iface =3D {
+    /* TODO: Add other callbacks */
+    .queue_is_processed_in_order =3D fv_queue_order,
+};
+
+int virtio_loop(struct fuse_session *se)
+{
+    fuse_log(FUSE_LOG_INFO, "%s: Entry\n", __func__);
+
+    while (1) {
+        /* TODO: Add stuffing */
+    }
+
+    fuse_log(FUSE_LOG_INFO, "%s: Exit\n", __func__);
+}
+
 int virtio_session_mount(struct fuse_session *se)
 {
     struct sockaddr_un un;
@@ -75,5 +135,30 @@ int virtio_session_mount(struct fuse_session *se)
         return -1;
     }
=20
-    return -1;
+    fuse_log(FUSE_LOG_INFO, "%s: Waiting for vhost-user socket connection.=
..\n",
+             __func__);
+    int data_sock =3D accept(listen_sock, NULL, NULL);
+    if (data_sock =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "vhost socket accept: %m\n");
+        close(listen_sock);
+        return -1;
+    }
+    close(listen_sock);
+    fuse_log(FUSE_LOG_INFO, "%s: Received vhost-user socket connection\n",
+             __func__);
+
+    /* TODO: Some cleanup/deallocation! */
+    se->virtio_dev =3D calloc(sizeof(struct fv_VuDev), 1);
+    if (!se->virtio_dev) {
+        fuse_log(FUSE_LOG_ERR, "%s: virtio_dev calloc failed\n", __func__)=
;
+        close(data_sock);
+        return -1;
+    }
+
+    se->vu_socketfd =3D data_sock;
+    se->virtio_dev->se =3D se;
+    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, fv_set_wat=
ch,
+            fv_remove_watch, &fv_iface);
+
+    return 0;
 }
diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virtio.h
index 8f2edb69ca..23026d6e4c 100644
--- a/tools/virtiofsd/fuse_virtio.h
+++ b/tools/virtiofsd/fuse_virtio.h
@@ -20,4 +20,6 @@ struct fuse_session;
=20
 int virtio_session_mount(struct fuse_session *se);
=20
+int virtio_loop(struct fuse_session *se);
+
 #endif
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index fc9b264d56..037c5d7b26 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -36,6 +36,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "fuse_virtio.h"
 #include "fuse_lowlevel.h"
 #include <assert.h>
 #include <dirent.h>
@@ -1395,11 +1396,7 @@ int main(int argc, char *argv[])
     fuse_daemonize(opts.foreground);
=20
     /* Block until ctrl+c or fusermount -u */
-    if (opts.singlethread) {
-        ret =3D fuse_session_loop(se);
-    } else {
-        ret =3D fuse_session_loop_mt(se, opts.clone_fd);
-    }
+    ret =3D virtio_loop(se);
=20
     fuse_session_unmount(se);
 err_out3:
--=20
2.24.1


