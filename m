Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A773FC2D0EF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 09:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CFC2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 09:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3UXdxQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CFC2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP1Ax-0007TQ-J2
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 05:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jP1AD-0006YF-BA
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 05:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jP1AC-0006ak-5J
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 05:50:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32626
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jP1AC-0006aF-14
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 05:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587030627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47/3Th7brauSxUnjemVf9ft1hw3PvAXKdoVZcIE9hWs=;
 b=K3UXdxQ77BgAK+3fAQyZm9EMQiZ41pLkxCXeqYtphmtkKrcceUF+kp2ucTyezAqqCNpoYr
 ec+4HdQftDyheHHwwBerZcdRZy5HtK8jeG98me9w0VJ0prUyJ5MlKiBorw3KZa61tQwkpg
 Sip5p2peL1wcUSqtrvMfox2v6vnIWR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-iKSAeQloPCesU7uTAj1zEg-1; Thu, 16 Apr 2020 05:50:25 -0400
X-MC-Unique: iKSAeQloPCesU7uTAj1zEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF429801E57;
 Thu, 16 Apr 2020 09:50:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 720906EF91;
 Thu, 16 Apr 2020 09:50:23 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] block/crypto: better error message when creating too
 large files
Date: Thu, 16 Apr 2020 12:50:19 +0300
Message-Id: <20200416095019.4406-2-mlevitsk@redhat.com>
In-Reply-To: <20200416095019.4406-1-mlevitsk@redhat.com>
References: <20200416095019.4406-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently if you attampt to create too large file with luks you
get the following error message:

Formatting 'test.luks', fmt=3Dluks size=3D17592186044416 key-secret=3Dsec0
qemu-img: test.luks: Could not resize file: File too large

While for raw format the error message is
qemu-img: test.img: The image size is too large for file format 'raw'


The reason for this is that qemu-img checks for errno of the failure,
and presents the later error when it is -EFBIG

However crypto generic code 'swallows' the errno and replaces it
with -EIO.

As an attempt to make it better, we can make luks driver,
detect -EFBIG and in this case present a better error message,
which is what this patch does

The new error message is:

qemu-img: error creating test.luks: The requested file size is too large

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534898
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index d577f89659..1b604beb30 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -104,18 +104,35 @@ static ssize_t block_crypto_init_func(QCryptoBlock *b=
lock,
                                       Error **errp)
 {
     struct BlockCryptoCreateData *data =3D opaque;
+    Error *local_error =3D NULL;
+    int ret;
=20
     if (data->size > INT64_MAX || headerlen > INT64_MAX - data->size) {
-        error_setg(errp, "The requested file size is too large");
-        return -EFBIG;
+        ret =3D -EFBIG;
+        goto error;
     }
=20
     /* User provided size should reflect amount of space made
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
-    return blk_truncate(data->blk, data->size + headerlen, false,
+    ret =3D blk_truncate(data->blk, data->size + headerlen, false,
                         data->prealloc, errp);
+
+    if (ret >=3D 0) {
+        return ret;
+    }
+
+error:
+    if (ret =3D=3D -EFBIG) {
+        /* Replace the error message with a better one */
+        error_free(local_error);
+        error_setg(errp, "The requested file size is too large");
+    } else {
+        error_propagate(errp, local_error);
+    }
+
+    return ret;
 }
=20
=20
--=20
2.17.2


