Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC62C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A4820644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A4820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYrP-0007EZ-CS
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYda-0000Ix-5D
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdY-0003vB-Tt
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:35:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18513)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdW-0003sl-HN; Fri, 16 Aug 2019 05:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6692308A958;
 Fri, 16 Aug 2019 09:35:05 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D2FD7DA4B;
 Fri, 16 Aug 2019 09:35:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:38 +0200
Message-Id: <20190816093439.14262-16-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
References: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 16 Aug 2019 09:35:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/16] qemu-img convert: Deprecate using -n and
 -o together
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_create options specified with -o have no effect when skipping image
creation with -n, so this doesn't make sense. Warn against the misuse
and deprecate the combination so we can make it a hard error later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c           | 5 +++++
 qemu-deprecated.texi | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 79983772de..d9321f6418 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2231,6 +2231,11 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }
=20
+    if (skip_create && options) {
+        warn_report("-o has no effect when skipping image creation");
+        warn_report("This will become an error in future QEMU versions."=
);
+    }
+
     s.src_num =3D argc - optind - 1;
     out_filename =3D s.src_num >=3D 1 ? argv[argc - 1] : NULL;
=20
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index fff07bb2a3..f7680c08e1 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -305,6 +305,13 @@ to just export the entire image and then mount only =
/dev/nbd0p1 than
 it is to reinvoke @command{qemu-nbd -c /dev/nbd0} limited to just a
 subset of the image.
=20
+@subsection qemu-img convert -n -o (since 4.2.0)
+
+All options specified in @option{-o} are image creation options, so
+they have no effect when used with @option{-n} to skip image creation.
+Silently ignored options can be confusing, so this combination of
+options will be made an error in future versions.
+
 @section Build system
=20
 @subsection Python 2 support (since 4.1.0)
--=20
2.20.1


