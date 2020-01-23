Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A35C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD972077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEP3W/SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD972077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhxt-0003w1-Nn
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdM-0004Ku-Jn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdL-0006Dy-DN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdL-0006Du-B7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAhRXhYwXAns+MA2t3Em27S0qDI1ffvTD6Z2k4ho6zM=;
 b=CEP3W/SWiYhrCG6n3jIn4RGmR9HeXFbbakny0tjYbrtAkxJQ3KP43On0EoS2+AVjQz45qH
 OfHNXyCHsJb6F2Xo+rS5ppmzKHJ0djkLasE9ucGnCvM61rE4eviVUwY+BVTABMKzZk0AyL
 /qAsdFMfvARPS1JnSj6rCXkmSmXhurI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-WdIdixdHNEucYOdTiOhjuw-1; Thu, 23 Jan 2020 11:47:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6BD4800D4E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:03 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 110ED28994;
 Thu, 23 Jan 2020 16:47:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 014/108] vitriofsd/passthrough_ll: fix fallocate() ifdefs
Date: Thu, 23 Jan 2020 16:44:56 +0000
Message-Id: <20200123164630.91498-15-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WdIdixdHNEucYOdTiOhjuw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

1) Use correct CONFIG_FALLOCATE macro to check if fallocate() is supported.=
(i.e configure
   script sets CONFIG_FALLOCATE intead of HAVE_FALLOCATE if fallocate() is =
supported)
2) Replace HAVE_POSIX_FALLOCATE with CONFIG_POSIX_FALLOCATE.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Merged from two of Xiao Yang's patches
---
 tools/virtiofsd/passthrough_ll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 322a889cdf..6c4da18075 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -975,13 +975,13 @@ static void lo_fallocate(fuse_req_t req, fuse_ino_t i=
no, int mode, off_t offset,
     int err =3D EOPNOTSUPP;
     (void)ino;
=20
-#ifdef HAVE_FALLOCATE
+#ifdef CONFIG_FALLOCATE
     err =3D fallocate(fi->fh, mode, offset, length);
     if (err < 0) {
         err =3D errno;
     }
=20
-#elif defined(HAVE_POSIX_FALLOCATE)
+#elif defined(CONFIG_POSIX_FALLOCATE)
     if (mode) {
         fuse_reply_err(req, EOPNOTSUPP);
         return;
--=20
2.24.1


