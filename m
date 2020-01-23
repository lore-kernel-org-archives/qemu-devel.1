Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C09C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA6720684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQFqkmg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA6720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucyr-000731-K7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9Q-0002rl-C1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9O-0005Pu-1a
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9N-0005PV-U0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKmIx2goe/8AH+0OLBD9B3fz9bJTXcfzHsQVtaOAxTc=;
 b=cQFqkmg8QSwxFaPlg2zZ2ZLOas8gVaxkFBdjSPQTcYtlLT7p/tto/ehC39e9/4ybAEtVHC
 voxiBskgY3CxuO2yzhasF1ai6vx2J81AsiJWIYXTOXBXU+oCgQjS3zZNtdm5Qlbr3NWm2o
 R3kU64z3cblmdNpvdeLqKGva2gG5N5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-mGywQ974MgiSlXwYaM80lw-1; Thu, 23 Jan 2020 06:59:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E848010DD
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:50 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41B201CB;
 Thu, 23 Jan 2020 11:59:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 054/111] virtiofsd: cap-ng helpers
Date: Thu, 23 Jan 2020 11:57:44 +0000
Message-Id: <20200123115841.138849-55-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mGywQ974MgiSlXwYaM80lw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

libcap-ng reads /proc during capng_get_caps_process, and virtiofsd's
sandboxing doesn't have /proc mounted; thus we have to do the
caps read before we sandbox it and save/restore the state.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 Makefile                         |  4 +-
 tools/virtiofsd/passthrough_ll.c | 72 ++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ad400f36b2..6b4b075a92 100644
--- a/Makefile
+++ b/Makefile
@@ -327,7 +327,7 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
 vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
=20
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP),yy)
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
 HELPERS-y +=3D virtiofsd$(EXESUF)
 vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
 endif
@@ -675,7 +675,7 @@ rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADD=
S)
 =09$(call LINK, $^)
=20
 # relies on Linux-specific syscalls
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP),yy)
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
 virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
 =09$(call LINK, $^)
 endif
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index bd8925bd83..97e7c75667 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -39,6 +39,7 @@
 #include "fuse_virtio.h"
 #include "fuse_lowlevel.h"
 #include <assert.h>
+#include <cap-ng.h>
 #include <dirent.h>
 #include <errno.h>
 #include <inttypes.h>
@@ -139,6 +140,13 @@ static const struct fuse_opt lo_opts[] =3D {
=20
 static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n);
=20
+static struct {
+    pthread_mutex_t mutex;
+    void *saved;
+} cap;
+/* That we loaded cap-ng in the current thread from the saved */
+static __thread bool cap_loaded =3D 0;
+
 static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st);
=20
 static int is_dot_or_dotdot(const char *name)
@@ -162,6 +170,37 @@ static struct lo_data *lo_data(fuse_req_t req)
     return (struct lo_data *)fuse_req_userdata(req);
 }
=20
+/*
+ * Load capng's state from our saved state if the current thread
+ * hadn't previously been loaded.
+ * returns 0 on success
+ */
+static int load_capng(void)
+{
+    if (!cap_loaded) {
+        pthread_mutex_lock(&cap.mutex);
+        capng_restore_state(&cap.saved);
+        /*
+         * restore_state free's the saved copy
+         * so make another.
+         */
+        cap.saved =3D capng_save_state();
+        if (!cap.saved) {
+            fuse_log(FUSE_LOG_ERR, "capng_save_state (thread)\n");
+            return -EINVAL;
+        }
+        pthread_mutex_unlock(&cap.mutex);
+
+        /*
+         * We want to use the loaded state for our pid,
+         * not the original
+         */
+        capng_setpid(syscall(SYS_gettid));
+        cap_loaded =3D true;
+    }
+    return 0;
+}
+
 static void lo_map_init(struct lo_map *map)
 {
     map->elems =3D NULL;
@@ -2023,6 +2062,35 @@ static void setup_namespaces(struct lo_data *lo, str=
uct fuse_session *se)
     }
 }
=20
+/*
+ * Capture the capability state, we'll need to restore this for individual
+ * threads later; see load_capng.
+ */
+static void setup_capng(void)
+{
+    /* Note this accesses /proc so has to happen before the sandbox */
+    if (capng_get_caps_process()) {
+        fuse_log(FUSE_LOG_ERR, "capng_get_caps_process\n");
+        exit(1);
+    }
+    pthread_mutex_init(&cap.mutex, NULL);
+    pthread_mutex_lock(&cap.mutex);
+    cap.saved =3D capng_save_state();
+    if (!cap.saved) {
+        fuse_log(FUSE_LOG_ERR, "capng_save_state\n");
+        exit(1);
+    }
+    pthread_mutex_unlock(&cap.mutex);
+}
+
+static void cleanup_capng(void)
+{
+    free(cap.saved);
+    cap.saved =3D NULL;
+    pthread_mutex_destroy(&cap.mutex);
+}
+
+
 /*
  * Make the source directory our root so symlinks cannot escape and no oth=
er
  * files are accessible.  Assumes unshare(CLONE_NEWNS) was already called.
@@ -2216,12 +2284,16 @@ int main(int argc, char *argv[])
=20
     fuse_daemonize(opts.foreground);
=20
+    /* Must be before sandbox since it wants /proc */
+    setup_capng();
+
     setup_sandbox(&lo, se);
=20
     /* Block until ctrl+c or fusermount -u */
     ret =3D virtio_loop(se);
=20
     fuse_session_unmount(se);
+    cleanup_capng();
 err_out3:
     fuse_remove_signal_handlers(se);
 err_out2:
--=20
2.24.1


