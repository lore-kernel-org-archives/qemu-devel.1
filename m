Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B79C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EFB214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/KBkio+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EFB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwUT-0008NI-Dr
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRwG4-0000bb-Qs
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRwFx-0008AS-Uk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602503082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIs8GSYndujj/IUhzFBYJYVlEAHzu8gUjnP34Xj8hpI=;
 b=i/KBkio+AUhJ1ClyXn6ygmtqJZPRjPfdcet12xlmFNAeRfWrXcvvyv5vNXirOxtwzzrA3L
 vBYF6M65OSQo/7TId3FxZqz7JOoBrizz+g1/bJKYHYZhE4xuVdRF/d7WbLQnhjnnlI+sZu
 PMm3CSCzJRtwylx5qrflh4RKIE8Eldk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-uEvCkDEIPB6Pv8stL71KtA-1; Mon, 12 Oct 2020 07:44:40 -0400
X-MC-Unique: uEvCkDEIPB6Pv8stL71KtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D4285C706;
 Mon, 12 Oct 2020 11:44:39 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-244.ams2.redhat.com
 [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3D6119C78;
 Mon, 12 Oct 2020 11:44:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, zhengchuan@huawei.com,
 stefanha@redhat.com, peterx@redhat.com
Subject: [PULL 2/6] tools/virtiofsd: add support for --socket-group
Date: Mon, 12 Oct 2020 12:44:21 +0100
Message-Id: <20201012114425.104765-3-dgilbert@redhat.com>
In-Reply-To: <20201012114425.104765-1-dgilbert@redhat.com>
References: <20201012114425.104765-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

If you like running QEMU as a normal user (very common for TCG runs)
but you have to run virtiofsd as a root user you run into connection
problems. Adding support for an optional --socket-group allows the
users to keep using the command line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Message-Id: <20200925125147.26943-2-alex.bennee@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  dgilbert: Split long line
---
 docs/tools/virtiofsd.rst        |  4 ++++
 tools/virtiofsd/fuse_i.h        |  1 +
 tools/virtiofsd/fuse_lowlevel.c |  6 ++++++
 tools/virtiofsd/fuse_virtio.c   | 21 +++++++++++++++++++--
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index ae02938a95..7ecee49834 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -87,6 +87,10 @@ Options
 
   Listen on vhost-user UNIX domain socket at PATH.
 
+.. option:: --socket-group=GROUP
+
+  Set the vhost-user UNIX domain socket gid to GROUP.
+
 .. option:: --fd=FDNUM
 
   Accept connections from vhost-user UNIX domain socket file descriptor FDNUM.
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 1240828208..492e002181 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -68,6 +68,7 @@ struct fuse_session {
     size_t bufsize;
     int error;
     char *vu_socket_path;
+    char *vu_socket_group;
     int   vu_listen_fd;
     int   vu_socketfd;
     struct fv_VuDev *virtio_dev;
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 2dd36ec03b..4d1ba2925d 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2523,6 +2523,7 @@ static const struct fuse_opt fuse_ll_opts[] = {
     LL_OPTION("--debug", debug, 1),
     LL_OPTION("allow_root", deny_others, 1),
     LL_OPTION("--socket-path=%s", vu_socket_path, 0),
+    LL_OPTION("--socket-group=%s", vu_socket_group, 0),
     LL_OPTION("--fd=%d", vu_listen_fd, 0),
     LL_OPTION("--thread-pool-size=%d", thread_pool_size, 0),
     FUSE_OPT_END
@@ -2630,6 +2631,11 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
                  "fuse: --socket-path and --fd cannot be given together\n");
         goto out4;
     }
+    if (se->vu_socket_group && !se->vu_socket_path) {
+        fuse_log(FUSE_LOG_ERR,
+                 "fuse: --socket-group can only be used with --socket-path\n");
+        goto out4;
+    }
 
     se->bufsize = FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_HEADER_SIZE;
 
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index d5c8e98253..89f537f79b 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -31,6 +31,8 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/un.h>
+#include <sys/types.h>
+#include <grp.h>
 #include <unistd.h>
 
 #include "contrib/libvhost-user/libvhost-user.h"
@@ -924,15 +926,30 @@ static int fv_create_listen_socket(struct fuse_session *se)
 
     /*
      * Unfortunately bind doesn't let you set the mask on the socket,
-     * so set umask to 077 and restore it later.
+     * so set umask appropriately and restore it later.
      */
-    old_umask = umask(0077);
+    if (se->vu_socket_group) {
+        old_umask = umask(S_IROTH | S_IWOTH | S_IXOTH);
+    } else {
+        old_umask = umask(S_IRGRP | S_IWGRP | S_IXGRP |
+                          S_IROTH | S_IWOTH | S_IXOTH);
+    }
     if (bind(listen_sock, (struct sockaddr *)&un, addr_len) == -1) {
         fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
         close(listen_sock);
         umask(old_umask);
         return -1;
     }
+    if (se->vu_socket_group) {
+        struct group *g = getgrnam(se->vu_socket_group);
+        if (g) {
+            if (!chown(se->vu_socket_path, -1, g->gr_gid)) {
+                fuse_log(FUSE_LOG_WARNING,
+                         "vhost socket failed to set group to %s (%d)\n",
+                         se->vu_socket_group, g->gr_gid);
+            }
+        }
+    }
     umask(old_umask);
 
     if (listen(listen_sock, 1) == -1) {
-- 
2.28.0


