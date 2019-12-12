Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D37C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F52214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENAYq11J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F52214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRh9-0001bP-Lz
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV9-0005Cu-Jc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV7-0001MG-W8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRV7-0001LB-RJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQ3C994ze++zCJj3x5FxiloQohq+1fOlpcbkQsfjgGY=;
 b=ENAYq11Jh1P0WCvRZY96MAL7VGK/O2Y53G1ookYS7P1//0iHZif0veXdY1bFXBGd9oQSIn
 lcQRb7kqx41UCvpOjWkZHPN0lseiRRUZLyTu+9Bw8+sgqGBrHeZkzeh5FFXxaURI1/apru
 DTcmbtqmQdjqWKLeRUFqESGVXWaYYXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-0ankMk91MCyjB-HuEa04Nw-1; Thu, 12 Dec 2019 11:39:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0598C477
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:39 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BFC060BE1;
 Thu, 12 Dec 2019 16:39:38 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 017/104] virtiofsd: Start wiring up vhost-user
Date: Thu, 12 Dec 2019 16:37:37 +0000
Message-Id: <20191212163904.159893-18-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0ankMk91MCyjB-HuEa04Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
---
 tools/virtiofsd/fuse_i.h         |  4 ++
 tools/virtiofsd/fuse_loop_mt.c   |  1 +
 tools/virtiofsd/fuse_lowlevel.c  |  5 ++
 tools/virtiofsd/fuse_lowlevel.h  |  7 +++
 tools/virtiofsd/fuse_virtio.c    | 87 +++++++++++++++++++++++++++++++-
 tools/virtiofsd/fuse_virtio.h    |  2 +
 tools/virtiofsd/passthrough_ll.c |  7 +--
 7 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index df078f2360..76cc968a6e 100644
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
diff --git a/tools/virtiofsd/fuse_loop_mt.c b/tools/virtiofsd/fuse_loop_mt.=
c
index 00138b2ab3..5dfaff35fd 100644
--- a/tools/virtiofsd/fuse_loop_mt.c
+++ b/tools/virtiofsd/fuse_loop_mt.c
@@ -12,6 +12,7 @@
 #include "fuse_lowlevel.h"
 #include "fuse_misc.h"
 #include "standard-headers/linux/fuse.h"
+#include "fuse_virtio.h"
=20
 #include <assert.h>
 #include <errno.h>
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index f553102eba..2bdd1d9d80 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2263,6 +2263,11 @@ void fuse_session_unmount(struct fuse_session *se)
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
index 79929e5541..081bb1abb3 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1786,6 +1786,13 @@ void fuse_req_interrupt_func(fuse_req_t req, fuse_in=
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
index 3a77bb8657..69ad522323 100644
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
@@ -79,5 +139,30 @@ int virtio_session_mount(struct fuse_session *se)
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
index be808e7bb9..23531d791d 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -35,6 +35,7 @@
  * \include passthrough_ll.c
  */
=20
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
2.23.0


