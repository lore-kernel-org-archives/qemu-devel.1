Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09213CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52D020684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOOqmsOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52D020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVq7-0008Jm-FD
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQm-00049E-FS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQh-0004Kg-7C
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVQf-0004Ji-8P
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odTervbFDCIvOq5Harp/KNndlPNyJwrH2yrMIn2Mut0=;
 b=QOOqmsOKSNlHP86Su0J7HcVoLMiuUMVKKUnUj0XJx8hNqBQYFmIWRrQMpx3TYq98P8v1e+
 g1EcHd2ZGZzPjAGy7bm5W5jgsCfk+8BGo6LfApekh4h2Cox6nMS12jrYG84uTzcVOr8lc8
 lBNm2f50lXEJeBUAdJlLFEQO3Z+q2MU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-fFZLHi8cOyivb3ew2MZRwQ-1; Mon, 21 Oct 2019 07:00:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 194BB80183E;
 Mon, 21 Oct 2019 11:00:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5376060D;
 Mon, 21 Oct 2019 11:00:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 26/30] virtiofsd: add --fd=FDNUM fd passing option
Date: Mon, 21 Oct 2019 11:58:28 +0100
Message-Id: <20191021105832.36574-27-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fFZLHi8cOyivb3ew2MZRwQ-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Although --socket-path=3DPATH is useful for manual invocations, management
tools typically create the UNIX domain socket themselves and pass it to
the vhost-user device backend.  This way QEMU can be launched
immediately with a valid socket.  No waiting for the vhost-user device
backend is required when fd passing is used.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_i.h        |  1 +
 contrib/virtiofsd/fuse_lowlevel.c | 13 ++++++++---
 contrib/virtiofsd/fuse_virtio.c   | 39 +++++++++++++++++++++++--------
 3 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index 5b6ef09df5..4b718f1aec 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -68,6 +68,7 @@ struct fuse_session {
 =09size_t bufsize;
 =09int error;
 =09char *vu_socket_path;
+=09int   vu_listen_fd;
 =09int   vu_socketfd;
 =09struct fv_VuDev *virtio_dev;
 };
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index b1f44ca17e..da2f151927 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -2077,6 +2077,7 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
 =09LL_OPTION("allow_root", deny_others, 1),
 =09LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
 =09LL_OPTION("vhost_user_socket=3D%s", vu_socket_path, 0),
+=09LL_OPTION("--fd=3D%d", vu_listen_fd, 0),
 =09FUSE_OPT_END
 };
=20
@@ -2095,6 +2096,7 @@ void fuse_lowlevel_help(void)
 "    -o allow_root              allow access by root\n"
 "    --socket-path=3DPATH         path for the vhost-user socket\n"
 "    -o vhost_user_socket=3DPATH  path for the vhost-user socket\n"
+"    --fd=3DFDNUM                 fd number of vhost-user socket\n"
 "    -o auto_unmount            auto unmount on process termination\n");
 }
=20
@@ -2134,6 +2136,7 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
 =09=09goto out1;
 =09}
 =09se->fd =3D -1;
+=09se->vu_listen_fd =3D -1;
 =09se->conn.max_write =3D UINT_MAX;
 =09se->conn.max_readahead =3D UINT_MAX;
=20
@@ -2163,8 +2166,12 @@ struct fuse_session *fuse_session_new(struct fuse_ar=
gs *args,
 =09=09goto out4;
 =09}
=20
-=09if (!se->vu_socket_path) {
-=09=09fprintf(stderr, "fuse: missing -o vhost_user_socket option\n");
+=09if (!se->vu_socket_path && se->vu_listen_fd < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "fuse: missing --socket-path or --fd option\n=
");
+=09=09goto out4;
+=09}
+=09if (se->vu_socket_path && se->vu_listen_fd >=3D 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "fuse: --socket-path and --fd cannot be given=
 together\n");
 =09=09goto out4;
 =09}
=20
@@ -2205,7 +2212,7 @@ void fuse_session_unmount(struct fuse_session *se)
=20
 int fuse_lowlevel_is_virtio(struct fuse_session *se)
 {
-=09return se->vu_socket_path !=3D NULL;
+=09return !!se->virtio_dev;
 }
=20
 #ifdef linux
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index f52d815596..cc393c3cac 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -635,21 +635,20 @@ int virtio_loop(struct fuse_session *se)
     return 0;
 }
=20
-int virtio_session_mount(struct fuse_session *se)
+static int fv_create_listen_socket(struct fuse_session *se)
 {
     struct sockaddr_un un;
=20
+    /* Nothing to do if fd is already initialized */
+    if (se->vu_listen_fd >=3D 0) {
+        return 0;
+    }
+
     if (strlen(se->vu_socket_path) >=3D sizeof(un.sun_path)) {
         fuse_log(FUSE_LOG_ERR, "Socket path too long\n");
         return -1;
     }
=20
-    /*
-     * Poison the fuse FD so we spot if we accidentally use it;
-     * DO NOT check for this value, check for fuse_lowlevel_is_virtio()
-     */
-    se->fd =3D 0xdaff0d11;
-
     /*
      * Create the Unix socket to communicate with qemu
      * based on QEMU's vhost-user-bridge
@@ -675,15 +674,35 @@ int virtio_session_mount(struct fuse_session *se)
         return -1;
     }
=20
+    se->vu_listen_fd =3D listen_sock;
+    return 0;
+}
+
+int virtio_session_mount(struct fuse_session *se)
+{
+    int ret;
+
+    ret =3D fv_create_listen_socket(se);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * Poison the fuse FD so we spot if we accidentally use it;
+     * DO NOT check for this value, check fuse_lowlevel_is_virtio()
+     */
+    se->fd =3D 0xdaff0d11;
+
     fuse_log(FUSE_LOG_INFO, "%s: Waiting for vhost-user socket connection.=
..\n",
              __func__);
-    int data_sock =3D accept(listen_sock, NULL, NULL);
+    int data_sock =3D accept(se->vu_listen_fd, NULL, NULL);
     if (data_sock =3D=3D -1) {
         fuse_log(FUSE_LOG_ERR, "vhost socket accept: %m\n");
-        close(listen_sock);
+        close(se->vu_listen_fd);
         return -1;
     }
-    close(listen_sock);
+    close(se->vu_listen_fd);
+    se->vu_listen_fd =3D -1;
     fuse_log(FUSE_LOG_INFO, "%s: Received vhost-user socket connection\n",
              __func__);
     se->vu_socketfd =3D data_sock;
--=20
2.23.0


