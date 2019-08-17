Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE50C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 08:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B142077C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 08:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B142077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyuVJ-0002S4-Te
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 04:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyuUA-0001BW-An
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 04:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyuU9-0006rU-AF
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 04:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hyuU7-0006pt-1E; Sat, 17 Aug 2019 04:54:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DC70189DACA;
 Sat, 17 Aug 2019 08:54:50 +0000 (UTC)
Received: from thuth.com (ovpn-116-52.ams2.redhat.com [10.36.116.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B163A4FAB;
 Sat, 17 Aug 2019 08:54:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sat, 17 Aug 2019 10:54:41 +0200
Message-Id: <20190817085443.11471-2-thuth@redhat.com>
In-Reply-To: <20190817085443.11471-1-thuth@redhat.com>
References: <20190817085443.11471-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Sat, 17 Aug 2019 08:54:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/3] block: fix NetBSD qemu-iotests failure
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Opening a block device on NetBSD has an additional step compared to other=
 OSes,
corresponding to raw_normalize_devicepath.  The error message in that fun=
ction
is slightly different from that in raw_open_common and this was causing s=
purious
failures in qemu-iotests.  However, in general it is not important to kno=
w what
exact step was failing, for example in the qemu-iotests case the error me=
ssage
contains the fairly unequivocal "No such file or directory" text from str=
error.
We can thus fix the failures by standardizing on a single error message f=
or
both raw_open_common and raw_normalize_devicepath; in fact, we can even
use error_setg_file_open to make sure the error message is the same as in
the rest of QEMU.

Message-Id: <20190725095920.28419-1-pbonzini@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/file-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index b8b4dad553..e41e91e075 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -217,7 +217,7 @@ static int raw_normalize_devicepath(const char **file=
name, Error **errp)
     fname =3D *filename;
     dp =3D strrchr(fname, '/');
     if (lstat(fname, &sb) < 0) {
-        error_setg_errno(errp, errno, "%s: stat failed", fname);
+        error_setg_file_open(errp, errno, fname);
         return -errno;
     }
=20
@@ -561,7 +561,7 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
     ret =3D fd < 0 ? -errno : 0;
=20
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not open '%s'", filename);
+        error_setg_file_open(errp, -ret, filename);
         if (ret =3D=3D -EROFS) {
             ret =3D -EACCES;
         }
--=20
2.18.1


