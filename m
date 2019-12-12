Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C3C2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2E02173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rr4wyGC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2E02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRqb-00046x-8g
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVR-0005YO-1w
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVP-0001oA-TI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVP-0001mr-DV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0opAHaGSN+8ckxDx5WF3aWf8QfqLKlhIvqEClsm618=;
 b=Rr4wyGC35QFeqlN/iJdbWBVuLMRBXCcURhYN59443yyoCP4oeUebLn35vr1F59/4DEdezX
 9p+i+zvJyCzVPWVLt2rAq4pLR3XVxHa0/Z4Va84ESC/DI+nf+WxoR8PK9ytUCjfay0By9b
 KvwkqhdOxfbEPVedihpq4pD2XNanbwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-ejd34XK0NOCu7hXGcDXQmQ-1; Thu, 12 Dec 2019 11:39:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE9A801E7E
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:56 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D445460BE1;
 Thu, 12 Dec 2019 16:39:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 030/104] virtiofsd: add --print-capabilities option
Date: Thu, 12 Dec 2019 16:37:50 +0000
Message-Id: <20191212163904.159893-31-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ejd34XK0NOCu7hXGcDXQmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Add the --print-capabilities option as per vhost-user.rst "Backend
programs conventions".  Currently there are no advertised features.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/vhost-user.json     |  4 +++-
 tools/virtiofsd/fuse_lowlevel.h  |  1 +
 tools/virtiofsd/helper.c         |  2 ++
 tools/virtiofsd/passthrough_ll.c | 12 ++++++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

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
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 081bb1abb3..6c63cb740c 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1826,6 +1826,7 @@ struct fuse_cmdline_opts {
     int nodefault_subtype;
     int show_version;
     int show_help;
+    int print_capabilities;
     int clone_fd;
     unsigned int max_idle_threads;
 };
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index d4fff4fa53..4c9a3b2fc9 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -39,6 +39,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
     FUSE_HELPER_OPT("--help", show_help),
     FUSE_HELPER_OPT("-V", show_version),
     FUSE_HELPER_OPT("--version", show_version),
+    FUSE_HELPER_OPT("--print-capabilities", print_capabilities),
     FUSE_HELPER_OPT("-d", debug),
     FUSE_HELPER_OPT("debug", debug),
     FUSE_HELPER_OPT("-d", foreground),
@@ -136,6 +137,7 @@ void fuse_cmdline_help(void)
 {
     printf("    -h   --help                print help\n"
            "    -V   --version             print version\n"
+           "    --print-capabilities       print vhost-user.json\n"
            "    -d   -o debug              enable debug output (implies -f=
)\n"
            "    -f                         foreground operation\n"
            "    --daemonize                run in background\n"
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 23531d791d..68bacb6fc5 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1298,6 +1298,14 @@ static struct fuse_lowlevel_ops lo_oper =3D {
     .lseek =3D lo_lseek,
 };
=20
+/* Print vhost-user.json backend program capabilities */
+static void print_capabilities(void)
+{
+    printf("{\n");
+    printf("  \"type\": \"fs\"\n");
+    printf("}\n");
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -1328,6 +1336,10 @@ int main(int argc, char *argv[])
         fuse_lowlevel_version();
         ret =3D 0;
         goto err_out1;
+    } else if (opts.print_capabilities) {
+        print_capabilities();
+        ret =3D 0;
+        goto err_out1;
     }
=20
     if (fuse_opt_parse(&args, &lo, lo_opts, NULL) =3D=3D -1) {
--=20
2.23.0


