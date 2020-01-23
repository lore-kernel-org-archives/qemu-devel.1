Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA402467B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF6tYFUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA402467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucJ8-0004W9-Ql
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub93-0002MI-4a
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub92-00059m-1K
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub91-00059S-Th
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GecZLFNgbt9puS1dpkZtIJjkHeSDvk6GvBLw3x562/s=;
 b=HF6tYFUfh3LizoQmtQAqwcr4lfNyrfW17jBa23vV4SBaFjG6ZZm38L4yM6ZGW8o0hsEZkO
 HsJQoiwsJgwOUjkHJ6aEg6cAcS5zp8gM4MDj8KOtupKoHFoVJ1EXr6gIzImdvOQQQMSVpx
 WtmykmSjZbCv1o7zaZihbw7y1nwZNO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-_AUDsSPnMd-aQzH6fS2oGQ-1; Thu, 23 Jan 2020 06:59:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A96E10120A8
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:24 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F6641CB;
 Thu, 23 Jan 2020 11:59:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 030/111] virtiofsd: make -f (foreground) the default
Date: Thu, 23 Jan 2020 11:57:20 +0000
Message-Id: <20200123115841.138849-31-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _AUDsSPnMd-aQzH6fS2oGQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: Stefan Hajnoczi <stefanha@redhat.com>

According to vhost-user.rst "Backend program conventions", backend
programs should run in the foregound by default.  Follow the
conventions so libvirt and other management tools can control virtiofsd
in a standard way.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 676032e71f..a3645fc807 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -29,6 +29,11 @@
     {                                               \
         t, offsetof(struct fuse_cmdline_opts, p), 1 \
     }
+#define FUSE_HELPER_OPT_VALUE(t, p, v)              \
+    {                                               \
+        t, offsetof(struct fuse_cmdline_opts, p), v \
+    }
+
=20
 static const struct fuse_opt fuse_helper_opts[] =3D {
     FUSE_HELPER_OPT("-h", show_help),
@@ -42,6 +47,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
     FUSE_OPT_KEY("-d", FUSE_OPT_KEY_KEEP),
     FUSE_OPT_KEY("debug", FUSE_OPT_KEY_KEEP),
     FUSE_HELPER_OPT("-f", foreground),
+    FUSE_HELPER_OPT_VALUE("--daemonize", foreground, 0),
     FUSE_HELPER_OPT("fsname=3D", nodefault_subtype),
     FUSE_OPT_KEY("fsname=3D", FUSE_OPT_KEY_KEEP),
     FUSE_HELPER_OPT("subtype=3D", nodefault_subtype),
@@ -131,6 +137,7 @@ void fuse_cmdline_help(void)
            "    -V   --version             print version\n"
            "    -d   -o debug              enable debug output (implies -f=
)\n"
            "    -f                         foreground operation\n"
+           "    --daemonize                run in background\n"
            "    -o max_idle_threads        the maximum number of idle work=
er "
            "threads\n"
            "                               allowed (default: 10)\n");
@@ -158,6 +165,7 @@ int fuse_parse_cmdline(struct fuse_args *args, struct f=
use_cmdline_opts *opts)
     memset(opts, 0, sizeof(struct fuse_cmdline_opts));
=20
     opts->max_idle_threads =3D 10;
+    opts->foreground =3D 1;
=20
     if (fuse_opt_parse(args, opts, fuse_helper_opts, fuse_helper_opt_proc)=
 =3D=3D
         -1) {
--=20
2.24.1


