Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC84C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C9820870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNRuy3WK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C9820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Z70-0003zZ-Ne
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 13:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Z6M-0003ZP-Rd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Z6L-0006Hv-7y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:50:38 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Z6L-0006HB-01
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:50:37 -0500
Received: by mail-wr1-x441.google.com with SMTP id z15so3800165wrl.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lbKy+WaGgNwoCKwhW+MO0+B04VmoOihd0HIydDrhh5s=;
 b=uNRuy3WK7riPi0VDGuiWjTOoBc2SSemQKwBIoHIYV3iHbZdw7gNC8Qb0awbi8MGhYr
 2Y2GaJlpX0B1XSscflvqUlEA4LJDvz2r+Ribo1n/cbKwOriOIros/w1aa5KnK63r/93O
 0KjbSvPdzzLjGADvZ+LZznBei3DwIohnuPV9kVSRQpc4JYiTqd1a7OMEP4efvkKxERCf
 cumGEGlNOi7v+Y+JI80YWJoASH0dUzqxWZ6LKrzEC8Xk6MN1wQ5krv8FKhbgkVH49Ulb
 isuHySTVhW3wbIL9+DkHDhwLADnYkaQmpOiu8jFEU3+BNo2Q4n9zlvJtzGrqVszJmTg2
 f5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lbKy+WaGgNwoCKwhW+MO0+B04VmoOihd0HIydDrhh5s=;
 b=SNvargs6SIdmhizCNGtV6F+l0Lp5Hspo2BUjbeRWqvvs8HSa9PAeYDlgBT0pZiTZ53
 gPprF1MqgzAqQDAy7/EkxO7FZCSbTrg9wJ3ZL38CIfzLykBEkKBk91I3One57+qXvFKD
 4juPgLCgCaToF7L5ri8hNMzjVivNoG8KoH145E237a9alBxLKUc9fA1k80Ngppv3fkz2
 aTTQMrLaA9XObBndcuWbG4aFXH4iGCLXVqGnYI7UFLGNiBFRcF72r0KQQqBcFagcbr76
 A13nZaQ3YyrQTRylX+GVbUvwePbckTiQ2rWhsWRfso3RBpI4Imiu0PzQCItcTaf7L/Or
 /RcA==
X-Gm-Message-State: ANhLgQ2jr++Pl/ZsvzwI1/QsI2x7364a76+OjnYjW5kpewuNUn7fcgYU
 r/xPpmO27uL6Hb2Cs97wL1oskQ==
X-Google-Smtp-Source: ADFU+vtW3Rou1PLiloOshkaQFlnlMSWW1qAce/u2ANIYQ0/LLTn1vh3pvK6zNuiK7MhgMIzBM+FaTw==
X-Received: by 2002:adf:d843:: with SMTP id k3mr5071306wrl.427.1583347835357; 
 Wed, 04 Mar 2020 10:50:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r3sm3081567wmg.19.2020.03.04.10.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 10:50:34 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7FF4B1FF87;
 Wed,  4 Mar 2020 18:50:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] tools/virtiofsd: add support for --socket-group
Date: Wed,  4 Mar 2020 18:50:25 +0000
Message-Id: <20200304185025.19853-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you like running QEMU as a normal user (very common for TCG runs)
but you have to run virtiofsd as a root user you run into connection
problems. Adding support for an optional --socket-group allows the
users to keep using the command line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/tools/virtiofsd.rst        |  4 ++++
 tools/virtiofsd/fuse_i.h        |  1 +
 tools/virtiofsd/fuse_lowlevel.c |  6 ++++++
 tools/virtiofsd/fuse_virtio.c   | 20 ++++++++++++++++++--
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 378594c422a..6d2342f74d4 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -85,6 +85,10 @@ Options
 
   Listen on vhost-user UNIX domain socket at PATH.
 
+.. option:: --socket-group=GROUP
+
+  Also make vhost-user UNIX domain socket accessible to GROUP.
+
 .. option:: --fd=FDNUM
 
   Accept connections from vhost-user UNIX domain socket file descriptor FDNUM.
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 1240828208a..492e002181e 100644
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
index 2dd36ec03b6..4d1ba2925d1 100644
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
index 3b6d16a0417..13d69525646 100644
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
@@ -924,15 +926,29 @@ static int fv_create_listen_socket(struct fuse_session *se)
 
     /*
      * Unfortunately bind doesn't let you set the mask on the socket,
-     * so set umask to 077 and restore it later.
+     * so set umask to appropriately and restore it later.
      */
-    old_umask = umask(0077);
+    if (se->vu_socket_group) {
+        old_umask = umask(S_IROTH | S_IWOTH | S_IXOTH);
+    } else {
+        old_umask = umask(S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IWOTH | S_IXOTH);
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
2.20.1


