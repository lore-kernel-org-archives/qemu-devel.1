Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC06C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC7A205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQj/kzTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC7A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifScs-0006j2-66
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWP-0006wH-6u
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWN-0003cs-Ti
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59224
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWN-0003cA-PT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ayerbleBD9tfsCsZk1unXAwoVVFm3+vkuDEy+CyqFSM=;
 b=QQj/kzTZ/TNexJwWI0eXQ0aBK52hIrCcJdMgdQkoptEUV8PXiUfKR9G0HxMvy5RhlRoLNw
 CVTIo0c6h6wlgfjOyI07lsSW+QQyGbzHnjsFlg6FRypfXMTQI9xruzqNZuRqsng7t71f39
 a8Cl7iJ+DFCsqI02Zhini/Bq9jHwPYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-s4uPsL5dPbOBBbvupLk8Ag-1; Thu, 12 Dec 2019 11:40:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D7C5800D54
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:57 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3485D60BE1;
 Thu, 12 Dec 2019 16:40:56 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 073/104] virtiofsd: passthrough_ll: clean up cache related
 options
Date: Thu, 12 Dec 2019 16:38:33 +0000
Message-Id: <20191212163904.159893-74-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: s4uPsL5dPbOBBbvupLk8Ag-1
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

From: Miklos Szeredi <mszeredi@redhat.com>

 - Rename "cache=3Dnever" to "cache=3Dnone" to match 9p's similar option.

 - Rename CACHE_NORMAL constant to CACHE_AUTO to match the "cache=3Dauto"
   option.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 1b84d4f313..cd26db74cf 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -102,8 +102,8 @@ struct lo_cred {
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
@@ -139,8 +139,8 @@ static const struct fuse_opt lo_opts[] =3D {
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
@@ -483,7 +483,7 @@ static void lo_init(void *userdata, struct fuse_conn_in=
fo *conn)
         fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
         conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
     }
-    if ((lo->cache =3D=3D CACHE_NEVER && !lo->readdirplus_set) ||
+    if ((lo->cache =3D=3D CACHE_NONE && !lo->readdirplus_set) ||
         lo->readdirplus_clear) {
         fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
         conn->want &=3D ~FUSE_CAP_READDIRPLUS;
@@ -1525,7 +1525,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         fi->fh =3D fh;
         err =3D lo_do_lookup(req, parent, name, &e);
     }
-    if (lo->cache =3D=3D CACHE_NEVER) {
+    if (lo->cache =3D=3D CACHE_NONE) {
         fi->direct_io =3D 1;
     } else if (lo->cache =3D=3D CACHE_ALWAYS) {
         fi->keep_cache =3D 1;
@@ -1610,7 +1610,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, s=
truct fuse_file_info *fi)
     }
=20
     fi->fh =3D fh;
-    if (lo->cache =3D=3D CACHE_NEVER) {
+    if (lo->cache =3D=3D CACHE_NONE) {
         fi->direct_io =3D 1;
     } else if (lo->cache =3D=3D CACHE_ALWAYS) {
         fi->keep_cache =3D 1;
@@ -2427,7 +2427,7 @@ int main(int argc, char *argv[])
     lo.root.next =3D lo.root.prev =3D &lo.root;
     lo.root.fd =3D -1;
     lo.root.fuse_ino =3D FUSE_ROOT_ID;
-    lo.cache =3D CACHE_NORMAL;
+    lo.cache =3D CACHE_AUTO;
=20
     /*
      * Set up the ino map like this:
@@ -2503,11 +2503,11 @@ int main(int argc, char *argv[])
     lo.root.is_symlink =3D false;
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
2.23.0


