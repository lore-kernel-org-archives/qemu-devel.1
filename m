Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781BCC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488162173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Be2Od8ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488162173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSDq-0008JA-OX
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVx-0006EA-5p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVv-0002fl-TZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVv-0002dz-Od
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zCWgU5wSX+ZOtO7tkdYlO+R9PnuS8eLt1pa4uOBgOU=;
 b=Be2Od8okQA2oE1z63unbBQJl0mgtsqhlhaNVgcpV6s5JZ3JYuZq1Gf5sXF5SQPxqYphGDK
 RDwTzyEZ0BMJk1PWtw+59fpfltqlzbdyF5/Mqc28ZrsCa0b/S+rBfWhKff3SyZu7amx3M+
 ki7u5kvbA+BJpOShPbz4gX9KaF4L5u4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-npSOdD8tPM2Kj4owtoDXUA-1; Thu, 12 Dec 2019 11:40:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A402107ACC7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6157160BF3;
 Thu, 12 Dec 2019 16:40:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 051/104] virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
Date: Thu, 12 Dec 2019 16:38:11 +0000
Message-Id: <20191212163904.159893-52-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: npSOdD8tPM2Kj4owtoDXUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vivek Goyal <vgoyal@redhat.com>

Caller can set FUSE_WRITE_KILL_PRIV in write_flags. Parse it and pass it
to the filesystem.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/fuse_common.h   | 6 +++++-
 tools/virtiofsd/fuse_lowlevel.c | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index 147c043bd9..1e8191b7a6 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -93,8 +93,12 @@ struct fuse_file_info {
      */
     unsigned int cache_readdir:1;
=20
+    /* Indicates that suid/sgid bits should be removed upon write */
+    unsigned int kill_priv:1;
+
+
     /** Padding.  Reserved for future use*/
-    unsigned int padding:25;
+    unsigned int padding:24;
     unsigned int padding2:32;
=20
     /*
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index bd5ca2f157..c8a3b1597a 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -1144,6 +1144,7 @@ static void do_write(fuse_req_t req, fuse_ino_t nodei=
d,
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
     fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
+    fi.kill_priv =3D !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
=20
     fi.lock_owner =3D arg->lock_owner;
     fi.flags =3D arg->flags;
@@ -1179,7 +1180,8 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t n=
odeid,
     fi.lock_owner =3D arg->lock_owner;
     fi.flags =3D arg->flags;
     fi.fh =3D arg->fh;
-    fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
+    fi.writepage =3D !!(arg->write_flags & FUSE_WRITE_CACHE);
+    fi.kill_priv =3D !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
=20
     if (ibufv->count =3D=3D 1) {
         assert(!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD));
--=20
2.23.0


