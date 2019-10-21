Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5C1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74A9206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OERjwCxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74A9206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVY1-0002gs-G7
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQD-0003tU-4H
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQB-0004AP-HJ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVQB-0004A9-Cv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SThbSbNGiphCz20+AsQIO6yS/2HLszuoad5dZc4R9to=;
 b=OERjwCxPTdpRgt2ohJKxPlxHes/kT0If61yAw2ZGOlAy4wQTuUTFJ95+u/QVn1+fm1W/X0
 83mPOx9Wae+E0ujiyElUKL/VfHJYtycLC0QRxjdwE94w43AuWvoLnZBknfNJRgM7Yv3X4f
 MTTsC7Easl5ilNjPizV46zQ+DoHOl9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-AX4d9FgeO_m_wDUQ1kcC9g-1; Mon, 21 Oct 2019 07:00:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A450A1800DC7;
 Mon, 21 Oct 2019 11:00:14 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 664B760A9F;
 Mon, 21 Oct 2019 11:00:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 16/30] virtiofsd: Start wiring up vhost-user
Date: Mon, 21 Oct 2019 11:58:18 +0100
Message-Id: <20191021105832.36574-17-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: AX4d9FgeO_m_wDUQ1kcC9g-1
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Listen on our unix socket for the connection from QEMU, when we get it
initialise vhost-user and dive into our own loop variant (currently
dummy).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_i.h         |  4 ++
 contrib/virtiofsd/fuse_loop_mt.c   |  1 +
 contrib/virtiofsd/fuse_lowlevel.c  |  5 ++
 contrib/virtiofsd/fuse_lowlevel.h  |  7 +++
 contrib/virtiofsd/fuse_virtio.c    | 81 +++++++++++++++++++++++++++++-
 contrib/virtiofsd/fuse_virtio.h    |  2 +
 contrib/virtiofsd/passthrough_ll.c |  6 +--
 7 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index 27fa50274d..ea55f618a5 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -13,6 +13,8 @@
 #include "fuse.h"
 #include "fuse_lowlevel.h"
=20
+struct fv_VuDev;
+
 struct fuse_req {
 =09struct fuse_session *se;
 =09uint64_t unique;
@@ -65,6 +67,8 @@ struct fuse_session {
 =09size_t bufsize;
 =09int error;
 =09char *vu_socket_path;
+=09int   vu_socketfd;
+=09struct fv_VuDev *virtio_dev;
 };
=20
 struct fuse_chan {
diff --git a/contrib/virtiofsd/fuse_loop_mt.c b/contrib/virtiofsd/fuse_loop=
_mt.c
index e45b2337a0..2000a8902a 100644
--- a/contrib/virtiofsd/fuse_loop_mt.c
+++ b/contrib/virtiofsd/fuse_loop_mt.c
@@ -12,6 +12,7 @@
 #include "fuse_lowlevel.h"
 #include "fuse_misc.h"
 #include "fuse_kernel.h"
+#include "fuse_virtio.h"
=20
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 247667e3f4..328a9aa001 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -2193,6 +2193,11 @@ void fuse_session_unmount(struct fuse_session *se)
 {
 }
=20
+int fuse_lowlevel_is_virtio(struct fuse_session *se)
+{
+=09return se->vu_socket_path !=3D NULL;
+}
+
 #ifdef linux
 int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
 {
diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index 84379a4761..b06ab6915a 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -1756,6 +1756,13 @@ void fuse_req_interrupt_func(fuse_req_t req, fuse_in=
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
 /* ----------------------------------------------------------- *
  * Inquiry functions                                           *
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index da8451faa7..22f71d260f 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
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
@@ -71,5 +131,24 @@ int virtio_session_mount(struct fuse_session *se)
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
+    se->vu_socketfd =3D data_sock;
+
+    /* TODO: Some cleanup/deallocation! */
+    se->virtio_dev =3D calloc(sizeof(struct fv_VuDev), 1);
+    se->virtio_dev->se =3D se;
+    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, fv_set_wat=
ch,
+            fv_remove_watch, &fv_iface);
+
+    return 0;
 }
diff --git a/contrib/virtiofsd/fuse_virtio.h b/contrib/virtiofsd/fuse_virti=
o.h
index 6652e609e0..025a4d30ae 100644
--- a/contrib/virtiofsd/fuse_virtio.h
+++ b/contrib/virtiofsd/fuse_virtio.h
@@ -20,4 +20,6 @@ struct fuse_session;
=20
 int virtio_session_mount(struct fuse_session *se);
=20
+int virtio_loop(struct fuse_session *se);
+
 #endif
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 847814b793..c09fc4a65c 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -34,6 +34,7 @@
  * \include passthrough_ll.c
  */
=20
+#include "fuse_virtio.h"
 #include "fuse_lowlevel.h"
 #include <unistd.h>
 #include <stdlib.h>
@@ -1311,10 +1312,7 @@ int main(int argc, char *argv[])
 =09fuse_daemonize(opts.foreground);
=20
 =09/* Block until ctrl+c or fusermount -u */
-=09if (opts.singlethread)
-=09=09ret =3D fuse_session_loop(se);
-=09else
-=09=09ret =3D fuse_session_loop_mt(se, opts.clone_fd);
+=09ret =3D virtio_loop(se);
=20
 =09fuse_session_unmount(se);
 err_out3:
--=20
2.23.0


