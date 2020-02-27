Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC53C4BA35
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9ECE20838
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUdGxyyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9ECE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j78Pd-0006Nq-0u
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 20:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j78OA-0004c4-NJ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j78O9-0002ZP-7S
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58060
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j78O9-0002X8-40
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582768496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoJGR4ZI+9m4O0mPGBL05+mvr80zAshpXsWSv07d0Ow=;
 b=cUdGxyyPZkpI3dK1fwLqI4DoQ3IJsIJ5M7oa2nQ2S4Ubotwsvg2mDsoecvsZu4TII3/ZvD
 39ZHgAryMFZTgq5hhAp12bna2qwJQn8+skWA5SKk8CQJX7QMdwRt0+PnLwIGZwBTuAymWj
 5Qk+eg+K23v2pFHu8KQVOKa2oQE0f38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-XIXfOmM1PjKlFp3HwhhTqA-1; Wed, 26 Feb 2020 20:54:52 -0500
X-MC-Unique: XIXfOmM1PjKlFp3HwhhTqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F09C5800D53;
 Thu, 27 Feb 2020 01:54:51 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CB6C5C28E;
 Thu, 27 Feb 2020 01:54:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] nbd-client: Support leading / in NBD URI
Date: Wed, 26 Feb 2020 19:54:46 -0600
Message-Id: <20200227015448.960538-3-eblake@redhat.com>
In-Reply-To: <20200227015448.960538-1-eblake@redhat.com>
References: <20200227015448.960538-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NBD URI specification [1] states that only one leading slash at
the beginning of the URI path component is stripped, not all such
slashes.  This becomes important to a patch I just proposed to nbdkit
[2], which would allow the exportname to select a file embedded within
an ext2 image: ext2fs demands an absolute pathname beginning with '/',
and because qemu was inadvertantly stripping it, my nbdkit patch had
to work around the behavior.

[1] https://github.com/NetworkBlockDevice/nbd/blob/master/doc/uri.md
[2] https://www.redhat.com/archives/libguestfs/2020-February/msg00109.html

Note that the qemu bug only affects handling of URIs such as
nbd://host:port//abs/path (where '/abs/path' should be the export
name); it is still possible to use --image-opts and pass the desired
export name with a leading slash directly through JSON even without
this patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200212023101.1162686-1-eblake@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
---
 block/nbd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 6d3b22f844ea..f69e61e68ad6 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1528,8 +1528,10 @@ static int nbd_parse_uri(const char *filename, QDict=
 *options)
         goto out;
     }

-    p =3D uri->path ? uri->path : "/";
-    p +=3D strspn(p, "/");
+    p =3D uri->path ? uri->path : "";
+    if (p[0] =3D=3D '/') {
+        p++;
+    }
     if (p[0]) {
         qdict_put_str(options, "export", p);
     }
--=20
2.24.1


