Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677C52084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQ7sq46u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677C52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVVQ-0007lV-Vu
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPG-00033v-8V
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPE-0003lc-WD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40876
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVPE-0003lS-SV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEkcUMJRBc9FGUOr6ZCqvX/emDXGhCMHZKWY7+i+bOY=;
 b=OQ7sq46udGpKHqWllSRmwqDGzld25RzPKkbS3wrFTyszLLjVrIpeJ93q+/J5Jn8XcIWymr
 bImYyV2OO3XWlIsxTu5Bky+SXwmNC91TdHKkhLL1oo94htEmbE3JX/Rz0jIC4SrPHGVG6M
 IkXrWtLrls2Fxw2CKmRQESNbkxWN4DM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-MFMRGtyiOjOwZD69AmduBw-1; Mon, 21 Oct 2019 06:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5905800D49;
 Mon, 21 Oct 2019 10:59:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39289614C1;
 Mon, 21 Oct 2019 10:59:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 07/30] virtiofsd: remove mountpoint dummy argument
Date: Mon, 21 Oct 2019 11:58:09 +0100
Message-Id: <20191021105832.36574-8-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MFMRGtyiOjOwZD69AmduBw-1
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

Classic FUSE file system daemons take a mountpoint argument but
virtiofsd exposes a vhost-user UNIX domain socket instead.  The
mountpoint argument is not used by virtiofsd but the user is still
required to pass a dummy argument on the command-line.

Remove the mountpoint argument to clean up the command-line.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.c  |  2 +-
 contrib/virtiofsd/fuse_lowlevel.h  |  4 +---
 contrib/virtiofsd/helper.c         | 21 +++------------------
 contrib/virtiofsd/passthrough_ll.c | 12 ++----------
 4 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index f83cc2855d..2f40510707 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -2315,7 +2315,7 @@ out1:
 =09return NULL;
 }
=20
-int fuse_session_mount(struct fuse_session *se, const char *mountpoint)
+int fuse_session_mount(struct fuse_session *se)
 {
 =09int fd;
=20
diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index 207346081e..b0566ea21d 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -1834,7 +1834,6 @@ struct fuse_cmdline_opts {
 =09int foreground;
 =09int debug;
 =09int nodefault_subtype;
-=09char *mountpoint;
 =09int show_version;
 =09int show_help;
 =09int clone_fd;
@@ -1897,12 +1896,11 @@ struct fuse_session *fuse_session_new(struct fuse_a=
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
diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
index 8b993f228b..f7b00db258 100644
--- a/contrib/virtiofsd/helper.c
+++ b/contrib/virtiofsd/helper.c
@@ -142,28 +142,13 @@ void fuse_cmdline_help(void)
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
 =09=09=09=09struct fuse_args *outargs)
 {
+=09(void) data;
 =09(void) outargs;
-=09struct fuse_cmdline_opts *opts =3D data;
=20
 =09switch (key) {
 =09case FUSE_OPT_KEY_NONOPT:
-=09=09if (!opts->mountpoint) {
-=09=09=09if (fuse_mnt_parse_fuse_fd(arg) !=3D -1) {
-=09=09=09=09return fuse_opt_add_opt(&opts->mountpoint, arg);
-=09=09=09}
-
-=09=09=09char mountpoint[PATH_MAX] =3D "";
-=09=09=09if (realpath(arg, mountpoint) =3D=3D NULL) {
-=09=09=09=09fuse_log(FUSE_LOG_ERR,
-=09=09=09=09=09"fuse: bad mount point `%s': %s\n",
-=09=09=09=09=09arg, strerror(errno));
-=09=09=09=09return -1;
-=09=09=09}
-=09=09=09return fuse_opt_add_opt(&opts->mountpoint, mountpoint);
-=09=09} else {
-=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
-=09=09=09return -1;
-=09=09}
+=09=09fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
+=09=09return -1;
=20
 =09default:
 =09=09/* Pass through unknown options */
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 4e3760294a..8f94dcbc92 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1218,7 +1218,7 @@ int main(int argc, char *argv[])
 =09if (fuse_parse_cmdline(&args, &opts) !=3D 0)
 =09=09return 1;
 =09if (opts.show_help) {
-=09=09printf("usage: %s [options] <mountpoint>\n\n", argv[0]);
+=09=09printf("usage: %s [options]\n\n", argv[0]);
 =09=09fuse_cmdline_help();
 =09=09fuse_lowlevel_help();
 =09=09ret =3D 0;
@@ -1230,13 +1230,6 @@ int main(int argc, char *argv[])
 =09=09goto err_out1;
 =09}
=20
-=09if(opts.mountpoint =3D=3D NULL) {
-=09=09printf("usage: %s [options] <mountpoint>\n", argv[0]);
-=09=09printf("       %s --help\n", argv[0]);
-=09=09ret =3D 1;
-=09=09goto err_out1;
-=09}
-
 =09if (fuse_opt_parse(&args, &lo, lo_opts, NULL)=3D=3D -1)
 =09=09return 1;
=20
@@ -1295,7 +1288,7 @@ int main(int argc, char *argv[])
 =09if (fuse_set_signal_handlers(se) !=3D 0)
 =09    goto err_out2;
=20
-=09if (fuse_session_mount(se, opts.mountpoint) !=3D 0)
+=09if (fuse_session_mount(se) !=3D 0)
 =09    goto err_out3;
=20
 =09fuse_daemonize(opts.foreground);
@@ -1312,7 +1305,6 @@ err_out3:
 err_out2:
 =09fuse_session_destroy(se);
 err_out1:
-=09free(opts.mountpoint);
 =09fuse_opt_free_args(&args);
=20
 =09if (lo.root.fd >=3D 0)
--=20
2.23.0


