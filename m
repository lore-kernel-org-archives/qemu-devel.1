Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE13DC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2665D20679
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2665D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htEXs-0006Gv-0k
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36515)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1htETp-00050a-8r
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1htETo-0002Gc-7L
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1htELn-0005Y2-UF
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AEC117C52F;
 Thu,  1 Aug 2019 16:54:42 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99CCB5D9CD;
 Thu,  1 Aug 2019 16:54:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 17:54:09 +0100
Message-Id: <20190801165409.20121-5-stefanha@redhat.com>
In-Reply-To: <20190801165409.20121-1-stefanha@redhat.com>
References: <20190801165409.20121-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 01 Aug 2019 16:54:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] virtiofsd: add --thread-pool-size=NUM
 option
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an option to control the size of the thread pool.  Requests are now
processed in parallel by default.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/fuse_i.h        | 1 +
 contrib/virtiofsd/fuse_lowlevel.c | 8 ++++++--
 contrib/virtiofsd/fuse_virtio.c   | 4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index dcde9feb97..5c82cf2eac 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -74,6 +74,7 @@ struct fuse_session {
         int   vu_listen_fd;
         int   vu_socketfd;
         struct fv_VuDev *virtio_dev;
+        int thread_pool_size;
 };
=20
 struct fuse_chan {
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_l=
owlevel.c
index 483a1bc9be..b692791fbc 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -26,7 +26,7 @@
 #include <assert.h>
 #include <sys/file.h>
=20
-
+#define THREAD_POOL_SIZE 64
=20
 #define OFFSET_MAX 0x7fffffffffffffffLL
=20
@@ -2556,6 +2556,7 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
 	LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
         LL_OPTION("vhost_user_socket=3D%s", vu_socket_path, 0),
 	LL_OPTION("--fd=3D%d", vu_listen_fd, 0),
+	LL_OPTION("--thread-pool-size=3D%d", thread_pool_size, 0),
 	FUSE_OPT_END
 };
=20
@@ -2575,7 +2576,9 @@ void fuse_lowlevel_help(void)
 "    --socket-path=3DPATH         path for the vhost-user socket\n"
 "    -o vhost_user_socket=3DPATH  path for the vhost-user socket\n"
 "    --fd=3DFDNUM                 fd number of vhost-user socket\n"
-"    -o auto_unmount            auto unmount on process termination\n");
+"    -o auto_unmount            auto unmount on process termination\n"
+"    --thread-pool-size=3DNUM     thread pool size limit (default %d)\n"=
,
+	       THREAD_POOL_SIZE);
 }
=20
 void fuse_session_destroy(struct fuse_session *se)
@@ -2629,6 +2632,7 @@ struct fuse_session *fuse_session_new(struct fuse_a=
rgs *args,
 	}
 	se->fd =3D -1;
 	se->vu_listen_fd =3D -1;
+	se->thread_pool_size =3D THREAD_POOL_SIZE;
 	se->conn.max_write =3D UINT_MAX;
 	se->conn.max_readahead =3D UINT_MAX;
=20
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_vir=
tio.c
index 0c52911144..e13b3cc2e6 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -663,8 +663,8 @@ static void *fv_queue_thread(void *opaque)
         struct fuse_session *se =3D qi->virtio_dev->se;
         GThreadPool *pool;
=20
-        pool =3D g_thread_pool_new(fv_queue_worker, qi, 1 /* TODO max_th=
reads */,
-                        TRUE, NULL);
+        pool =3D g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_=
size,
+                                 TRUE, NULL);
         if (!pool) {
                 fuse_err("%s: g_thread_pool_new failed\n", __func__);
                 return NULL;
--=20
2.21.0


