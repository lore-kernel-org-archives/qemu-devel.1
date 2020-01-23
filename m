Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C803C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5D421D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9YfwNV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5D421D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhrb-0003jj-OA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufeV-0005e3-6w
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufeT-0007QR-Kt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21886
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufeT-0007PQ-Hu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1EOq7CO60lirQD/aOliSVFjBdCyV+UdosKnZr6Gg7Q=;
 b=O9YfwNV9z15DXjQ6GVQXt+ZZJty9i+eK5MNd53anuE9BKceXGjuHxUWT1WUt6fL5py62Lm
 J9wDoR1wPirAtiKLQOJsVshhjtP5WD9Jitd4aYoQVktTsXiTnAmFiYu11oq6c2C0i+SwlP
 6c/FGiFj6yO6uxYRG+y9NN3ci077Hr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-lH15PQ6XOD6MMHSMJmornQ-1; Thu, 23 Jan 2020 11:48:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2182803A3A
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:14 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C96819C69;
 Thu, 23 Jan 2020 16:48:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 073/108] virtiofsd: passthrough_ll: clean up cache related
 options
Date: Thu, 23 Jan 2020 16:45:55 +0000
Message-Id: <20200123164630.91498-74-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lH15PQ6XOD6MMHSMJmornQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: Miklos Szeredi <mszeredi@redhat.com>

 - Rename "cache=3Dnever" to "cache=3Dnone" to match 9p's similar option.

 - Rename CACHE_NORMAL constant to CACHE_AUTO to match the "cache=3Dauto"
   option.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c         |  5 ++++-
 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 14f5d70c10..567202444a 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -145,6 +145,9 @@ void fuse_cmdline_help(void)
            "    --syslog                   log to syslog (default stderr)\=
n"
            "    -f                         foreground operation\n"
            "    --daemonize                run in background\n"
+           "    -o cache=3D<mode>            cache mode. could be one of \=
"auto, "
+           "always, none\"\n"
+           "                               default: auto\n"
            "    -o log_level=3D<level>       log level, default to \"info\=
"\n"
            "                               level could be one of \"debug, =
"
            "info, warn, err\"\n"
@@ -156,7 +159,7 @@ void fuse_cmdline_help(void)
            "    -o readdirplus|no_readdirplus\n"
            "                               enable/disable readirplus\n"
            "                               default: readdirplus except wit=
h "
-           "cache=3Dnever\n"
+           "cache=3Dnone\n"
           );
 }
=20
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 9e7191eb75..b40f2874a7 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -101,8 +101,8 @@ struct lo_cred {
 };
=20
 enum {
-    CACHE_NEVER,
-    CACHE_NORMAL,
+    CACHE_NONE,
+    CACHE_AUTO,
     CACHE_ALWAYS,
 };
=20
@@ -138,8 +138,8 @@ static const struct fuse_opt lo_opts[] =3D {
     { "no_xattr", offsetof(struct lo_data, xattr), 0 },
     { "timeout=3D%lf", offsetof(struct lo_data, timeout), 0 },
     { "timeout=3D", offsetof(struct lo_data, timeout_set), 1 },
-    { "cache=3Dnever", offsetof(struct lo_data, cache), CACHE_NEVER },
-    { "cache=3Dauto", offsetof(struct lo_data, cache), CACHE_NORMAL },
+    { "cache=3Dnone", offsetof(struct lo_data, cache), CACHE_NONE },
+    { "cache=3Dauto", offsetof(struct lo_data, cache), CACHE_AUTO },
     { "cache=3Dalways", offsetof(struct lo_data, cache), CACHE_ALWAYS },
     { "norace", offsetof(struct lo_data, norace), 1 },
     { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
@@ -482,7 +482,7 @@ static void lo_init(void *userdata, struct fuse_conn_in=
fo *conn)
         fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
         conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
     }
-    if ((lo->cache =3D=3D CACHE_NEVER && !lo->readdirplus_set) ||
+    if ((lo->cache =3D=3D CACHE_NONE && !lo->readdirplus_set) ||
         lo->readdirplus_clear) {
         fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
         conn->want &=3D ~FUSE_CAP_READDIRPLUS;
@@ -1493,7 +1493,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         fi->fh =3D fh;
         err =3D lo_do_lookup(req, parent, name, &e);
     }
-    if (lo->cache =3D=3D CACHE_NEVER) {
+    if (lo->cache =3D=3D CACHE_NONE) {
         fi->direct_io =3D 1;
     } else if (lo->cache =3D=3D CACHE_ALWAYS) {
         fi->keep_cache =3D 1;
@@ -1578,7 +1578,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, s=
truct fuse_file_info *fi)
     }
=20
     fi->fh =3D fh;
-    if (lo->cache =3D=3D CACHE_NEVER) {
+    if (lo->cache =3D=3D CACHE_NONE) {
         fi->direct_io =3D 1;
     } else if (lo->cache =3D=3D CACHE_ALWAYS) {
         fi->keep_cache =3D 1;
@@ -2395,7 +2395,7 @@ int main(int argc, char *argv[])
     lo.root.next =3D lo.root.prev =3D &lo.root;
     lo.root.fd =3D -1;
     lo.root.fuse_ino =3D FUSE_ROOT_ID;
-    lo.cache =3D CACHE_NORMAL;
+    lo.cache =3D CACHE_AUTO;
=20
     /*
      * Set up the ino map like this:
@@ -2470,11 +2470,11 @@ int main(int argc, char *argv[])
     }
     if (!lo.timeout_set) {
         switch (lo.cache) {
-        case CACHE_NEVER:
+        case CACHE_NONE:
             lo.timeout =3D 0.0;
             break;
=20
-        case CACHE_NORMAL:
+        case CACHE_AUTO:
             lo.timeout =3D 1.0;
             break;
=20
--=20
2.24.1


