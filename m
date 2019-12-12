Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95321C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0EF21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZA43Uel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0EF21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRX2-000786-3A
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUw-0004ym-SK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUv-000119-8A
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35694
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRUv-000107-0y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBOHgPASCbgt85soFQULU7rrC7TcGSGFFIaNrwOh2VI=;
 b=SZA43UelLGLFdO3oeeDocqHrqYCxU13c4jkJ/rwvwl9EtwcH3aRKwS6VSETsySHtaq52Yl
 nbzdXhEIrTsm+669kTYOzvmSOxRRbZ9MLE7wNMlcERio8zH4TbKnydLy24wf05YeCk8nMR
 ykj5sTogqB7jVS8Wxcuh9UJlwOKEBJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-61Dz0DVxOiG5uMs2oL3DyA-1; Thu, 12 Dec 2019 11:39:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ED44800EB5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:26 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9483460BE1;
 Thu, 12 Dec 2019 16:39:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 008/104] virtiofsd: remove mountpoint dummy argument
Date: Thu, 12 Dec 2019 16:37:28 +0000
Message-Id: <20191212163904.159893-9-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 61Dz0DVxOiG5uMs2oL3DyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Classic FUSE file system daemons take a mountpoint argument but
virtiofsd exposes a vhost-user UNIX domain socket instead.  The
mountpoint argument is not used by virtiofsd but the user is still
required to pass a dummy argument on the command-line.

Remove the mountpoint argument to clean up the command-line.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c  |  2 +-
 tools/virtiofsd/fuse_lowlevel.h  |  4 +---
 tools/virtiofsd/helper.c         | 20 +++-----------------
 tools/virtiofsd/passthrough_ll.c | 12 ++----------
 4 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 42feee5c1c..20037eef67 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2479,7 +2479,7 @@ out1:
     return NULL;
 }
=20
-int fuse_session_mount(struct fuse_session *se, const char *mountpoint)
+int fuse_session_mount(struct fuse_session *se)
 {
     int fd;
=20
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 85cc027382..17899e012a 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1864,7 +1864,6 @@ struct fuse_cmdline_opts {
     int foreground;
     int debug;
     int nodefault_subtype;
-    char *mountpoint;
     int show_version;
     int show_help;
     int clone_fd;
@@ -1926,12 +1925,11 @@ struct fuse_session *fuse_session_new(struct fuse_a=
rgs *args,
 /**
  * Mount a FUSE file system.
  *
- * @param mountpoint the mount point path
  * @param se session object
  *
  * @return 0 on success, -1 on failure.
  **/
-int fuse_session_mount(struct fuse_session *se, const char *mountpoint);
+int fuse_session_mount(struct fuse_session *se);
=20
 /**
  * Enter a single threaded, blocking event loop.
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index e077943558..d8c42401a7 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -146,27 +146,13 @@ void fuse_cmdline_help(void)
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
                                 struct fuse_args *outargs)
 {
+    (void)data;
     (void)outargs;
-    struct fuse_cmdline_opts *opts =3D data;
=20
     switch (key) {
     case FUSE_OPT_KEY_NONOPT:
-        if (!opts->mountpoint) {
-            if (fuse_mnt_parse_fuse_fd(arg) !=3D -1) {
-                return fuse_opt_add_opt(&opts->mountpoint, arg);
-            }
-
-            char mountpoint[PATH_MAX] =3D "";
-            if (realpath(arg, mountpoint) =3D=3D NULL) {
-                fuse_log(FUSE_LOG_ERR, "fuse: bad mount point `%s': %s\n",=
 arg,
-                         strerror(errno));
-                return -1;
-            }
-            return fuse_opt_add_opt(&opts->mountpoint, mountpoint);
-        } else {
-            fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
-            return -1;
-        }
+        fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
+        return -1;
=20
     default:
         /* Pass through unknown options */
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index cd399d5c4b..a79ec2c70d 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1297,7 +1297,7 @@ int main(int argc, char *argv[])
         return 1;
     }
     if (opts.show_help) {
-        printf("usage: %s [options] <mountpoint>\n\n", argv[0]);
+        printf("usage: %s [options]\n\n", argv[0]);
         fuse_cmdline_help();
         fuse_lowlevel_help();
         ret =3D 0;
@@ -1309,13 +1309,6 @@ int main(int argc, char *argv[])
         goto err_out1;
     }
=20
-    if (opts.mountpoint =3D=3D NULL) {
-        printf("usage: %s [options] <mountpoint>\n", argv[0]);
-        printf("       %s --help\n", argv[0]);
-        ret =3D 1;
-        goto err_out1;
-    }
-
     if (fuse_opt_parse(&args, &lo, lo_opts, NULL) =3D=3D -1) {
         return 1;
     }
@@ -1375,7 +1368,7 @@ int main(int argc, char *argv[])
         goto err_out2;
     }
=20
-    if (fuse_session_mount(se, opts.mountpoint) !=3D 0) {
+    if (fuse_session_mount(se) !=3D 0) {
         goto err_out3;
     }
=20
@@ -1394,7 +1387,6 @@ err_out3:
 err_out2:
     fuse_session_destroy(se);
 err_out1:
-    free(opts.mountpoint);
     fuse_opt_free_args(&args);
=20
     if (lo.root.fd >=3D 0) {
--=20
2.23.0


