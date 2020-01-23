Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C72C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D1021D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7ewzVIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D1021D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhla-0005uM-SK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuff6-0006JL-7g
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuff5-0000JR-0W
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53269
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuff4-0000Im-Td
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YrSgQYkhcU4kRkGHIjoT5DICb+mHjWZQdwrkOwGUhaA=;
 b=h7ewzVIkONfAKCa8cgbbuZ8aVX2QzLvFVCZXXmGECEreUbOruYLBPR9+Q8ryZL6evjq/3g
 xQDbmNvDNokNpUICBhiR2iKTBDz1UflNOqpbj/eZQRkPFT4JeFD8Wg8dkqHtGTg8JU9qqJ
 MxDszBqTkPV+i1AFyUkT7a28vdYO60w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-sYoalHJHMOagqzTsJ2y7WA-1; Thu, 23 Jan 2020 11:48:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26A791005510
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:52 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 727C228993;
 Thu, 23 Jan 2020 16:48:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 104/108] virtiofsd: add --thread-pool-size=NUM option
Date: Thu, 23 Jan 2020 16:46:26 +0000
Message-Id: <20200123164630.91498-105-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sYoalHJHMOagqzTsJ2y7WA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Add an option to control the size of the thread pool.  Requests are now
processed in parallel by default.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_i.h        | 1 +
 tools/virtiofsd/fuse_lowlevel.c | 7 ++++++-
 tools/virtiofsd/fuse_virtio.c   | 5 +++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 1447d86866..4e47e5880d 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -72,6 +72,7 @@ struct fuse_session {
     int   vu_listen_fd;
     int   vu_socketfd;
     struct fv_VuDev *virtio_dev;
+    int thread_pool_size;
 };
=20
 struct fuse_chan {
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 79a4031266..de2e2e0c65 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -28,6 +28,7 @@
 #include <sys/file.h>
 #include <unistd.h>
=20
+#define THREAD_POOL_SIZE 64
=20
 #define OFFSET_MAX 0x7fffffffffffffffLL
=20
@@ -2519,6 +2520,7 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
     LL_OPTION("allow_root", deny_others, 1),
     LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
     LL_OPTION("--fd=3D%d", vu_listen_fd, 0),
+    LL_OPTION("--thread-pool-size=3D%d", thread_pool_size, 0),
     FUSE_OPT_END
 };
=20
@@ -2537,7 +2539,9 @@ void fuse_lowlevel_help(void)
     printf(
         "    -o allow_root              allow access by root\n"
         "    --socket-path=3DPATH         path for the vhost-user socket\n=
"
-        "    --fd=3DFDNUM                 fd number of vhost-user socket\n=
");
+        "    --fd=3DFDNUM                 fd number of vhost-user socket\n=
"
+        "    --thread-pool-size=3DNUM     thread pool size limit (default =
%d)\n",
+        THREAD_POOL_SIZE);
 }
=20
 void fuse_session_destroy(struct fuse_session *se)
@@ -2591,6 +2595,7 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
     }
     se->fd =3D -1;
     se->vu_listen_fd =3D -1;
+    se->thread_pool_size =3D THREAD_POOL_SIZE;
     se->conn.max_write =3D UINT_MAX;
     se->conn.max_readahead =3D UINT_MAX;
=20
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 0dcf2ef57a..9f6582343c 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -572,10 +572,11 @@ static void *fv_queue_thread(void *opaque)
     struct fv_QueueInfo *qi =3D opaque;
     struct VuDev *dev =3D &qi->virtio_dev->dev;
     struct VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
+    struct fuse_session *se =3D qi->virtio_dev->se;
     GThreadPool *pool;
=20
-    pool =3D g_thread_pool_new(fv_queue_worker, qi, 1 /* TODO max_threads =
*/,
-                             TRUE, NULL);
+    pool =3D g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size, =
TRUE,
+                             NULL);
     if (!pool) {
         fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func__)=
;
         return NULL;
--=20
2.24.1


