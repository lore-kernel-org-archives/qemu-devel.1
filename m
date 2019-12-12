Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86BF214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrEaEfxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86BF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRqH-0003h3-26
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVP-0005Vg-7G
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVN-0001jI-3k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVM-0001ig-Vs
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7bD0dOx27r76nONEMW9u8B5bkrGN8LoLqIE2MOXJbk=;
 b=IrEaEfxwo07VL3x54d3UR1jb7gCLkh740tBMLDw3uspS6v7ThrtuxZeyRjetH4hRg9RieR
 BQvl1MP39xyTse/yM+fyxte1KsgCYXS1IRw5DQg/8ssX83GpPuivGXxa6T0sR7CTU7Il50
 3Jm+jkBbd8OL2N75PwoYTOc0CCJ/9g8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-_oyxQlW3NASP1MbLEE-R3Q-1; Thu, 12 Dec 2019 11:39:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68C8C800D41
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:54 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5851760BE1;
 Thu, 12 Dec 2019 16:39:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 028/104] virtiofsd: make -f (foreground) the default
Date: Thu, 12 Dec 2019 16:37:48 +0000
Message-Id: <20191212163904.159893-29-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _oyxQlW3NASP1MbLEE-R3Q-1
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

According to vhost-user.rst "Backend program conventions", backend
programs should run in the foregound by default.  Follow the
conventions so libvirt and other management tools can control virtiofsd
in a standard way.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 48e38a7963..d4fff4fa53 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -28,6 +28,11 @@
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
@@ -41,6 +46,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
     FUSE_OPT_KEY("-d", FUSE_OPT_KEY_KEEP),
     FUSE_OPT_KEY("debug", FUSE_OPT_KEY_KEEP),
     FUSE_HELPER_OPT("-f", foreground),
+    FUSE_HELPER_OPT_VALUE("--daemonize", foreground, 0),
     FUSE_HELPER_OPT("-s", singlethread),
     FUSE_HELPER_OPT("fsname=3D", nodefault_subtype),
     FUSE_OPT_KEY("fsname=3D", FUSE_OPT_KEY_KEEP),
@@ -132,6 +138,7 @@ void fuse_cmdline_help(void)
            "    -V   --version             print version\n"
            "    -d   -o debug              enable debug output (implies -f=
)\n"
            "    -f                         foreground operation\n"
+           "    --daemonize                run in background\n"
            "    -s                         disable multi-threaded operatio=
n\n"
            "    -o clone_fd                use separate fuse device fd for=
 "
            "each thread\n"
@@ -163,6 +170,7 @@ int fuse_parse_cmdline(struct fuse_args *args, struct f=
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
2.23.0


