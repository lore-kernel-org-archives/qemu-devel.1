Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A8EC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C985122314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNt5GZv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C985122314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittfQ-0004Dg-Sb
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itseU-0000R0-RS
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itseQ-0003Pa-Ty
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:29:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itseP-0003Ob-OR
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BEITB3bC61EKPhQglhxyG2sivRdxF5miD9Yo5/TUfcE=;
 b=dNt5GZv5a/A85Ggm7Qw7O/QlM7PGQncYEQOPfJGMw331Iyb28kVcL2nUTbA4BiMCGlN61P
 yhWAMqvw2p/4fJp6feAsawPveKa1hYlOHvoyK6VuWghDQUwAPi5rTjT6gOpPwwLR0xwt8N
 rMj3Ls0HoEGW/lfkLaXN0T0JetX2u4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-IDfm_bujMAeS9HDuEzbaeQ-1; Tue, 21 Jan 2020 07:28:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B936107ACC7;
 Tue, 21 Jan 2020 12:28:53 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 085F060BE0;
 Tue, 21 Jan 2020 12:28:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 053/109] virtiofsd: cap-ng helpers
Date: Tue, 21 Jan 2020 12:23:37 +0000
Message-Id: <20200121122433.50803-54-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IDfm_bujMAeS9HDuEzbaeQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

libcap-ng reads /proc during capng_get_caps_process, and virtiofsd's
sandboxing doesn't have /proc mounted; thus we have to do the
caps read before we sandbox it and save/restore the state.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 Makefile                         |  2 +-
 tools/virtiofsd/passthrough_ll.c | 72 ++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 967d59c98a..18f52d6270 100644
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
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 8748e64f33..bf939d06ae 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -38,6 +38,7 @@
 #include "fuse_virtio.h"
 #include "fuse_lowlevel.h"
 #include <assert.h>
+#include <cap-ng.h>
 #include <dirent.h>
 #include <errno.h>
 #include <inttypes.h>
@@ -138,6 +139,13 @@ static const struct fuse_opt lo_opts[] =3D {
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
@@ -161,6 +169,37 @@ static struct lo_data *lo_data(fuse_req_t req)
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
@@ -2022,6 +2061,35 @@ static void setup_namespaces(struct lo_data *lo, str=
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
@@ -2215,12 +2283,16 @@ int main(int argc, char *argv[])
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


