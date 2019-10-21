Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97743206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYOrD5HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97743206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVal-0006QO-5V
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPt-0003dm-PF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPs-0003wa-GM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60264
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVPs-0003wJ-Bq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+O+R9BdeYeGrQ6yVk8iXo17XYj/kKSf2L9XLSL8w5V0=;
 b=GYOrD5HXtmvKDUpyP/pJ7FuTEtHoyyG0HR5aCsA2JNFsReKw4zJ055hNq/SgA4nwYr4li7
 nTjRiF60NOqxvNMJrCQjWfSY6CGPNbHs7lI1Z0W+pvS+qoZdTLfmpHL1s04tHnmYM7QLRT
 s/l1RoZD54yVPcFjH7S56yAKfKBgJ14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-m72oMF15M4-ccN_0XYcE2A-1; Mon, 21 Oct 2019 06:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A3EA107AD33;
 Mon, 21 Oct 2019 10:59:55 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFB2764026;
 Mon, 21 Oct 2019 10:59:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 13/30] virtiofsd: Add options for virtio
Date: Mon, 21 Oct 2019 11:58:15 +0100
Message-Id: <20191021105832.36574-14-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: m72oMF15M4-ccN_0XYcE2A-1
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add options to specify parameters for virtio-fs paths, i.e.

   ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_i.h        |  1 +
 contrib/virtiofsd/fuse_lowlevel.c | 10 +++++++---
 contrib/virtiofsd/helper.c        | 18 +++++++++---------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index 6c3f432d0e..d65af06ff0 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -63,6 +63,7 @@ struct fuse_session {
 =09struct fuse_notify_req notify_list;
 =09size_t bufsize;
 =09int error;
+=09char *vu_socket_path;
 };
=20
 struct fuse_chan {
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 6fe7506ead..d47e4438f3 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -2064,6 +2064,8 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
 =09LL_OPTION("-d", debug, 1),
 =09LL_OPTION("--debug", debug, 1),
 =09LL_OPTION("allow_root", deny_others, 1),
+=09LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
+=09LL_OPTION("vhost_user_socket=3D%s", vu_socket_path, 0),
 =09FUSE_OPT_END
 };
=20
@@ -2078,9 +2080,11 @@ void fuse_lowlevel_help(void)
 =09/* These are not all options, but the ones that are
 =09   potentially of interest to an end-user */
 =09printf(
-"    -o allow_other         allow access by all users\n"
-"    -o allow_root          allow access by root\n"
-"    -o auto_unmount        auto unmount on process termination\n");
+"    -o allow_other             allow access by all users\n"
+"    -o allow_root              allow access by root\n"
+"    --socket-path=3DPATH         path for the vhost-user socket\n"
+"    -o vhost_user_socket=3DPATH  path for the vhost-user socket\n"
+"    -o auto_unmount            auto unmount on process termination\n");
 }
=20
 void fuse_session_destroy(struct fuse_session *se)
diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
index 958a42b6f4..f67533f053 100644
--- a/contrib/virtiofsd/helper.c
+++ b/contrib/virtiofsd/helper.c
@@ -126,15 +126,15 @@ static const struct fuse_opt conn_info_opt_spec[] =3D=
 {
=20
 void fuse_cmdline_help(void)
 {
-=09printf("    -h   --help            print help\n"
-=09       "    -V   --version         print version\n"
-=09       "    -d   -o debug          enable debug output (implies -f)\n"
-=09       "    -f                     foreground operation\n"
-=09       "    -s                     disable multi-threaded operation\n"
-=09       "    -o clone_fd            use separate fuse device fd for each=
 thread\n"
-=09       "                           (may improve performance)\n"
-=09       "    -o max_idle_threads    the maximum number of idle worker th=
reads\n"
-=09       "                           allowed (default: 10)\n");
+=09printf("    -h   --help                print help\n"
+=09       "    -V   --version             print version\n"
+=09       "    -d   -o debug              enable debug output (implies -f)=
\n"
+=09       "    -f                         foreground operation\n"
+=09       "    -s                         disable multi-threaded operation=
\n"
+=09       "    -o clone_fd                use separate fuse device fd for =
each thread\n"
+=09       "                               (may improve performance)\n"
+=09       "    -o max_idle_threads        the maximum number of idle worke=
r threads\n"
+=09       "                               allowed (default: 10)\n");
 }
=20
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
--=20
2.23.0


