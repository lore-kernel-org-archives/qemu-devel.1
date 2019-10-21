Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA33CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869E42089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/GYr4Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869E42089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVwf-0007Rr-ER
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQs-0004Hf-In
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQr-0004Ou-BT
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:01:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVQr-0004Ok-7P
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+6bZV7IvqXoSCJpAd/UtY19X4BsIQsCY8xWjkMBj7A=;
 b=J/GYr4UcCdCykR+waqxTIpUhiPlFynNFMZIS9Odyb9H6uIjy0HNJJugv3tn08hXCEbbfOe
 JOp/BAEuXLafwrmJfqdRljTo6eLktlZhNhpu6KOGDOrbrfNfUTcyXRKobsYU8nPWEEoQ1J
 7OfltBxmlCyEIbVcBYIKJ/l1GLM0X5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ovpuvJ8zMoyZDy3fsGR5Nw-1; Mon, 21 Oct 2019 07:00:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB44F107AD31;
 Mon, 21 Oct 2019 11:00:54 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 074A760A9F;
 Mon, 21 Oct 2019 11:00:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 29/30] virtiofsd: add --print-capabilities option
Date: Mon, 21 Oct 2019 11:58:31 +0100
Message-Id: <20191021105832.36574-30-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ovpuvJ8zMoyZDy3fsGR5Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Add the --print-capabilities option as per vhost-user.rst "Backend
programs conventions".  Currently there are no advertised features.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.h  |  1 +
 contrib/virtiofsd/helper.c         |  2 ++
 contrib/virtiofsd/passthrough_ll.c | 12 ++++++++++++
 docs/interop/vhost-user.json       |  4 +++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index b06ab6915a..ab964a6fb3 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -1796,6 +1796,7 @@ struct fuse_cmdline_opts {
 =09int nodefault_subtype;
 =09int show_version;
 =09int show_help;
+=09int print_capabilities;
 =09int clone_fd;
 =09unsigned int max_idle_threads;
 };
diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
index ab20810c28..08e00c0d13 100644
--- a/contrib/virtiofsd/helper.c
+++ b/contrib/virtiofsd/helper.c
@@ -35,6 +35,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
 =09FUSE_HELPER_OPT("--help",=09show_help),
 =09FUSE_HELPER_OPT("-V",=09=09show_version),
 =09FUSE_HELPER_OPT("--version",=09show_version),
+=09FUSE_HELPER_OPT("--print-capabilities", print_capabilities),
 =09FUSE_HELPER_OPT("-d",=09=09debug),
 =09FUSE_HELPER_OPT("debug",=09debug),
 =09FUSE_HELPER_OPT("-d",=09=09foreground),
@@ -132,6 +133,7 @@ void fuse_cmdline_help(void)
 {
 =09printf("    -h   --help                print help\n"
 =09       "    -V   --version             print version\n"
+=09       "    --print-capabilities       print vhost-user.json\n"
 =09       "    -d   -o debug              enable debug output (implies -f)=
\n"
 =09       "    -f                         foreground operation\n"
 =09       "    --daemonize                run in background\n"
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index c09fc4a65c..2a1a880224 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1216,6 +1216,14 @@ static struct fuse_lowlevel_ops lo_oper =3D {
 #endif
 };
=20
+/* Print vhost-user.json backend program capabilities */
+static void print_capabilities(void)
+{
+=09printf("{\n");
+=09printf("  \"type\": \"fs\"\n");
+=09printf("}\n");
+}
+
 int main(int argc, char *argv[])
 {
 =09struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -1246,6 +1254,10 @@ int main(int argc, char *argv[])
 =09=09fuse_lowlevel_version();
 =09=09ret =3D 0;
 =09=09goto err_out1;
+=09} else if (opts.print_capabilities) {
+=09=09print_capabilities();
+=09=09ret =3D 0;
+=09=09goto err_out1;
 =09}
=20
 =09if (fuse_opt_parse(&args, &lo, lo_opts, NULL)=3D=3D -1)
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index da6aaf51c8..d4ea1f7ac5 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -31,6 +31,7 @@
 # @rproc-serial: virtio remoteproc serial link
 # @scsi: virtio scsi
 # @vsock: virtio vsock transport
+# @fs: virtio fs (since 4.2)
 #
 # Since: 4.0
 ##
@@ -50,7 +51,8 @@
       'rpmsg',
       'rproc-serial',
       'scsi',
-      'vsock'
+      'vsock',
+      'fs'
   ]
 }
=20
--=20
2.23.0


