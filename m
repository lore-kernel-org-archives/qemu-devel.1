Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC5C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E67E20A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIjR7RWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E67E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSnt-0001zN-DI
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42188 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQSkf-0006g9-RI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:30:06 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQSkd-00076e-3K
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:30:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQSkc-00073J-K2
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587375000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgqUnD+ml8yvE6jseWPXVGnW2zlVJAIY0McbGhWLCeI=;
 b=SIjR7RWKeXuUXBOCJVjYsZ9WWfAmn+95cHmvRfFf0A9iFMBnAHlX+Xlqklvh8rSU0mxwTd
 nMbJXDJ7AeMjL75MG9r4WTh9dz4Fe57hqP87IPYI1EkmMekDUfkauC2muYTARealteI8+W
 SvoXEFdj95zwKM+nMQ8XSSKtPJm+uiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-xTffz-X5MLqL-LGEI7c8Mw-1; Mon, 20 Apr 2020 05:29:59 -0400
X-MC-Unique: xTffz-X5MLqL-LGEI7c8Mw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CD70107ACC9;
 Mon, 20 Apr 2020 09:29:58 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B49B65D9CD;
 Mon, 20 Apr 2020 09:29:56 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] block/crypto: better error message when creating too
 large files
Date: Mon, 20 Apr 2020 12:29:51 +0300
Message-Id: <20200420092951.24578-2-mlevitsk@redhat.com>
In-Reply-To: <20200420092951.24578-1-mlevitsk@redhat.com>
References: <20200420092951.24578-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


The reason for this is that qemu-img checks for errono of the failure,
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
 block/crypto.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index d577f89659..f9f5dc11a7 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -104,18 +104,35 @@ static ssize_t block_crypto_init_func(QCryptoBlock *b=
lock,
                                       Error **errp)
 {
     struct BlockCryptoCreateData *data =3D opaque;
+    Error *local_err =3D NULL;
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
-                        data->prealloc, errp);
+    ret =3D blk_truncate(data->blk, data->size + headerlen, false,
+                        data->prealloc, &local_err);
+
+    if (ret >=3D 0) {
+        return ret;
+    }
+
+error:
+    if (ret =3D=3D -EFBIG) {
+        /* Replace the error message with a better one */
+        error_free(local_err);
+        error_setg(errp, "The requested file size is too large");
+    } else {
+        error_propagate(errp, local_err);
+    }
+
+    return ret;
 }
=20
=20
--=20
2.17.2


