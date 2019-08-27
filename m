Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620AF206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620AF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2YEC-0007Ay-FB
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2YBq-0004IH-Vn
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2YBp-0004lu-Pu
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:55:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i2YBp-0004le-KG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:55:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCE983D962
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 09:55:00 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 874455D70D;
 Tue, 27 Aug 2019 09:54:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 10:54:34 +0100
Message-Id: <20190827095437.18819-2-stefanha@redhat.com>
In-Reply-To: <20190827095437.18819-1-stefanha@redhat.com>
References: <20190827095437.18819-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 27 Aug 2019 09:55:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] virtiofsd: make -f (foreground) the default
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to vhost-user.rst "Backend program conventions", backend
programs should run in the foregound by default.  Follow the
conventions so libvirt and other management tools can control virtiofsd
in a standard way.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
index 4c71452080..8d8bca889b 100644
--- a/contrib/virtiofsd/helper.c
+++ b/contrib/virtiofsd/helper.c
@@ -42,6 +42,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
 	FUSE_OPT_KEY("-d",		FUSE_OPT_KEY_KEEP),
 	FUSE_OPT_KEY("debug",		FUSE_OPT_KEY_KEEP),
 	FUSE_HELPER_OPT("-f",		foreground),
+	FUSE_HELPER_OPT_VALUE("--daemonize", foreground, 0),
 	FUSE_HELPER_OPT("-s",		singlethread),
 	FUSE_HELPER_OPT("fsname=3D",	nodefault_subtype),
 	FUSE_OPT_KEY("fsname=3D",		FUSE_OPT_KEY_KEEP),
@@ -139,6 +140,7 @@ void fuse_cmdline_help(void)
 	       "    -d   -o debug              enable debug output (implies -f)=
\n"
 	       "    --syslog                   log to syslog (default stderr)\n=
"
 	       "    -f                         foreground operation\n"
+	       "    --daemonize                run in background\n"
 	       "    -s                         disable multi-threaded operation=
\n"
 	       "    -o clone_fd                use separate fuse device fd for =
each thread\n"
 	       "                               (may improve performance)\n"
@@ -171,6 +173,7 @@ int fuse_parse_cmdline(struct fuse_args *args,
 	memset(opts, 0, sizeof(struct fuse_cmdline_opts));
=20
 	opts->max_idle_threads =3D 10;
+	opts->foreground =3D 1;
=20
 	if (fuse_opt_parse(args, opts, fuse_helper_opts,
 			   fuse_helper_opt_proc) =3D=3D -1)
--=20
2.21.0


