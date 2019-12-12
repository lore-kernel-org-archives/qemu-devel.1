Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19667C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1BD2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8CkcsAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1BD2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSWo-0008TX-Dt
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXE-00084a-MZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXC-0005CC-9Z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22049
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRXC-0005B7-57
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VefKB9RlUXu02ons9azC9CYKcJBU6lNjMRM0fYViISw=;
 b=P8CkcsAs3h1YanvQbaISsdPUIImP3olwYpWen6jx1LRTNF67alFUow24iCnUMnIr274ScZ
 qcxhS9ew/M97Z4/4onBSBDC0bLyr0NxxEIKOmYYPnV3FRUmzigkUHo2SehYecd3sOshR72
 GOX5hLv9o3vdvuyTonPAjtZiDbmfGds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-4B_u7S6CO_KXW8nQr2liwg-1; Thu, 12 Dec 2019 11:41:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7610712A7E54
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:47 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C2F260BE1;
 Thu, 12 Dec 2019 16:41:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 103/104] virtiofsd: add --thread-pool-size=NUM option
Date: Thu, 12 Dec 2019 16:39:03 +0000
Message-Id: <20191212163904.159893-104-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4B_u7S6CO_KXW8nQr2liwg-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Add an option to control the size of the thread pool.  Requests are now
processed in parallel by default.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse_i.h        | 1 +
 tools/virtiofsd/fuse_lowlevel.c | 7 ++++++-
 tools/virtiofsd/fuse_virtio.c   | 5 +++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 8a4a05b319..4da6a242ba 100644
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
index 9f01c05e3e..09a7b23726 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -27,6 +27,7 @@
 #include <sys/file.h>
 #include <unistd.h>
=20
+#define THREAD_POOL_SIZE 64
=20
 #define OFFSET_MAX 0x7fffffffffffffffLL
=20
@@ -2523,6 +2524,7 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
     LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
     LL_OPTION("vhost_user_socket=3D%s", vu_socket_path, 0),
     LL_OPTION("--fd=3D%d", vu_listen_fd, 0),
+    LL_OPTION("--thread-pool-size=3D%d", thread_pool_size, 0),
     FUSE_OPT_END
 };
=20
@@ -2544,7 +2546,9 @@ void fuse_lowlevel_help(void)
         "    --socket-path=3DPATH         path for the vhost-user socket\n=
"
         "    -o vhost_user_socket=3DPATH  path for the vhost-user socket\n=
"
         "    --fd=3DFDNUM                 fd number of vhost-user socket\n=
"
-        "    -o auto_unmount            auto unmount on process terminatio=
n\n");
+        "    -o auto_unmount            auto unmount on process terminatio=
n\n"
+        "    --thread-pool-size=3DNUM     thread pool size limit (default =
%d)\n",
+        THREAD_POOL_SIZE);
 }
=20
 void fuse_session_destroy(struct fuse_session *se)
@@ -2598,6 +2602,7 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
     }
     se->fd =3D -1;
     se->vu_listen_fd =3D -1;
+    se->thread_pool_size =3D THREAD_POOL_SIZE;
     se->conn.max_write =3D UINT_MAX;
     se->conn.max_readahead =3D UINT_MAX;
=20
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index b696ac3135..7bc6ff2f19 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -570,10 +570,11 @@ static void *fv_queue_thread(void *opaque)
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
2.23.0


