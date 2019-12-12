Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A88C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D6F214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr71Hf1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D6F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRlX-0006fn-Rh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV7-0005C9-4f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV5-0001J0-PA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRV5-0001HC-Kt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApPmWPRK4I1lG2CXxc3V5NYXJ4zQBISIKKv39MLqhpc=;
 b=Kr71Hf1BwXSWdNSQ9cUH0PMCwZ/lmhj5gcblS1sUgIwSSlg2YBDyr1F6IJi/9zzARoCZK5
 9cm2XY+34JJqGsC8OjcwrDahrfs18ZgjHk/Zf5k7BLsDam+FYnOr6Z7pNPpmyAqbUNgGGn
 qoPH6AmjXJZV3oGkmU/6ycaZUgaVGOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-PPetnx_kNkGd1PRof1zxxA-1; Thu, 12 Dec 2019 11:39:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 922921800D42
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:35 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6EE560BE1;
 Thu, 12 Dec 2019 16:39:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 014/104] virtiofsd: Add options for virtio
Date: Thu, 12 Dec 2019 16:37:34 +0000
Message-Id: <20191212163904.159893-15-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PPetnx_kNkGd1PRof1zxxA-1
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

Add options to specify parameters for virtio-fs paths, i.e.

   ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_i.h        |  1 +
 tools/virtiofsd/fuse_lowlevel.c | 17 ++++++++++++-----
 tools/virtiofsd/helper.c        | 22 +++++++++++-----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 0b5acc8765..f58be71e4b 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -63,6 +63,7 @@ struct fuse_session {
     struct fuse_notify_req notify_list;
     size_t bufsize;
     int error;
+    char *vu_socket_path;
 };
=20
 struct fuse_chan {
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 167701b453..da708161e1 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2118,8 +2118,12 @@ reply_err:
     }
=20
 static const struct fuse_opt fuse_ll_opts[] =3D {
-    LL_OPTION("debug", debug, 1), LL_OPTION("-d", debug, 1),
-    LL_OPTION("--debug", debug, 1), LL_OPTION("allow_root", deny_others, 1=
),
+    LL_OPTION("debug", debug, 1),
+    LL_OPTION("-d", debug, 1),
+    LL_OPTION("--debug", debug, 1),
+    LL_OPTION("allow_root", deny_others, 1),
+    LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
+    LL_OPTION("vhost_user_socket=3D%s", vu_socket_path, 0),
     FUSE_OPT_END
 };
=20
@@ -2135,9 +2139,12 @@ void fuse_lowlevel_help(void)
      * These are not all options, but the ones that are
      * potentially of interest to an end-user
      */
-    printf("    -o allow_other         allow access by all users\n"
-           "    -o allow_root          allow access by root\n"
-           "    -o auto_unmount        auto unmount on process termination=
\n");
+    printf(
+        "    -o allow_other             allow access by all users\n"
+        "    -o allow_root              allow access by root\n"
+        "    --socket-path=3DPATH         path for the vhost-user socket\n=
"
+        "    -o vhost_user_socket=3DPATH  path for the vhost-user socket\n=
"
+        "    -o auto_unmount            auto unmount on process terminatio=
n\n");
 }
=20
 void fuse_session_destroy(struct fuse_session *se)
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 8afccfc15e..48e38a7963 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -128,17 +128,17 @@ static const struct fuse_opt conn_info_opt_spec[] =3D=
 {
=20
 void fuse_cmdline_help(void)
 {
-    printf(
-        "    -h   --help            print help\n"
-        "    -V   --version         print version\n"
-        "    -d   -o debug          enable debug output (implies -f)\n"
-        "    -f                     foreground operation\n"
-        "    -s                     disable multi-threaded operation\n"
-        "    -o clone_fd            use separate fuse device fd for each "
-        "thread\n"
-        "                           (may improve performance)\n"
-        "    -o max_idle_threads    the maximum number of idle worker thre=
ads\n"
-        "                           allowed (default: 10)\n");
+    printf("    -h   --help                print help\n"
+           "    -V   --version             print version\n"
+           "    -d   -o debug              enable debug output (implies -f=
)\n"
+           "    -f                         foreground operation\n"
+           "    -s                         disable multi-threaded operatio=
n\n"
+           "    -o clone_fd                use separate fuse device fd for=
 "
+           "each thread\n"
+           "                               (may improve performance)\n"
+           "    -o max_idle_threads        the maximum number of idle work=
er "
+           "threads\n"
+           "                               allowed (default: 10)\n");
 }
=20
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
--=20
2.23.0


