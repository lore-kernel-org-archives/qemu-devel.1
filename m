Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58B9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AB520650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlSjDlnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AB520650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcD5-0003EX-St
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIW-0004Qt-7c
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIS-0000E8-QT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIS-0000De-Mh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOoH2MrO5Iv8wxrq71Pp5eOaXEZCGGGikdZtRxnjKGo=;
 b=JlSjDlnmJo6ozLr4LKGlBJrd58KdLrcUO88M7XR5BWo1abY1GfCVGynUpInj/7FkR5662Z
 BfkAm+4JkvlUxx2vM12E1wo4XgeqrppapUHdNZuzYRc2bzbiKdgo0vsekDxYUVbnCJX1MY
 FBTmh7qhS4CfFMUdxSnvM9zl52QrdPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-Y23KV8TbP-SBDTLLFetfPQ-1; Thu, 24 Oct 2019 07:28:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44BA9100550E;
 Thu, 24 Oct 2019 11:28:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDE3552D5;
 Thu, 24 Oct 2019 11:28:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 20/25] virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
Date: Thu, 24 Oct 2019 12:27:13 +0100
Message-Id: <20191024112718.34657-21-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Y23KV8TbP-SBDTLLFetfPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 contrib/virtiofsd/fuse_common.h   | 5 ++++-
 contrib/virtiofsd/fuse_lowlevel.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/virtiofsd/fuse_common.h b/contrib/virtiofsd/fuse_commo=
n.h
index b5b6d270fe..63ef2390a1 100644
--- a/contrib/virtiofsd/fuse_common.h
+++ b/contrib/virtiofsd/fuse_common.h
@@ -83,8 +83,11 @@ struct fuse_file_info {
 =09    nothing when set by open()). */
 =09unsigned int cache_readdir : 1;
=20
+=09/* Indicates that suid/sgid bits should be removed upon write */
+=09unsigned int kill_priv : 1;
+
 =09/** Padding.  Reserved for future use*/
-=09unsigned int padding : 25;
+=09unsigned int padding : 24;
 =09unsigned int padding2 : 32;
=20
 =09/** File handle id.  May be filled in by filesystem in create,
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index d032e411e1..8f9a59a34c 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -1151,6 +1151,7 @@ static void do_write(fuse_req_t req, fuse_ino_t nodei=
d,
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
 =09fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
+=09fi.kill_priv =3D !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
=20
 =09if (!compat) {
 =09=09fi.lock_owner =3D arg->lock_owner;
@@ -1197,7 +1198,8 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t n=
odeid,
 =09}
=20
 =09fi.fh =3D arg->fh;
-=09fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
+=09fi.writepage =3D !!(arg->write_flags & FUSE_WRITE_CACHE);
+=09fi.kill_priv =3D !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
=20
 =09if (ibufv->count =3D=3D 1) {
 =09=09assert(!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD));
--=20
2.23.0


