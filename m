Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D93FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B3421569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSd60dLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B3421569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittLS-00058l-Mn
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itseP-0000ON-PV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itseL-0003NB-Fg
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:28:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itseI-0003Lp-KF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceG1AGTgDgSsbOIJaA0a59PUzBQJdtUVTxb2yTj4tkA=;
 b=DSd60dLGMPMyc44NgolVrq0TqH1iESoeCQyroJDCwhrCv2wTeFJP5tQoU7HR0NxNQtZmvy
 +i6LqFfaWyy1KX9L7CGoyMyKWorMtIWfuvj7jal9a77Dh3ItjYrQ3S9nlMCEVDWivZ9Gtp
 TLdCep/WHhyo/pZGWOyfwCOp741FIk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-iiRWpAYZOc-E8Q7P1J8PlA-1; Tue, 21 Jan 2020 07:28:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B431B107ACC7;
 Tue, 21 Jan 2020 12:28:47 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFE1860BE0;
 Tue, 21 Jan 2020 12:28:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 052/109] virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
Date: Tue, 21 Jan 2020 12:23:36 +0000
Message-Id: <20200121122433.50803-53-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iiRWpAYZOc-E8Q7P1J8PlA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vivek Goyal <vgoyal@redhat.com>

Caller can set FUSE_WRITE_KILL_PRIV in write_flags. Parse it and pass it
to the filesystem.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
---
 tools/virtiofsd/fuse_common.h   | 6 +++++-
 tools/virtiofsd/fuse_lowlevel.c | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index deac132081..4b2c215fd9 100644
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
index f3e7f46008..63df56da6e 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -1143,6 +1143,7 @@ static void do_write(fuse_req_t req, fuse_ino_t nodei=
d,
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
     fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
+    fi.kill_priv =3D !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
=20
     fi.lock_owner =3D arg->lock_owner;
     fi.flags =3D arg->flags;
@@ -1178,7 +1179,8 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t n=
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
2.24.1


