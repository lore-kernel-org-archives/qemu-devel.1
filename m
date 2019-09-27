Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A5C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91962146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91962146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDr5u-0002Nv-6X
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDqRl-0001bi-3H
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDqRj-0003G5-UD
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iDqRj-0003F2-Oh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:38:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B92E310C0931
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:59:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF78608C2;
 Fri, 27 Sep 2019 09:59:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] qcrypto-luks: don't overwrite cipher_mode in header
Date: Fri, 27 Sep 2019 10:59:17 +0100
Message-Id: <20190927095926.22230-3-berrange@redhat.com>
In-Reply-To: <20190927095926.22230-1-berrange@redhat.com>
References: <20190927095926.22230-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 27 Sep 2019 09:59:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

This way we can store the header we loaded, which
will be used in key management code

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index f12fa2d270..25f8a9f1c4 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -645,6 +645,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     QCryptoHashAlgorithm hash;
     QCryptoHashAlgorithm ivhash;
     g_autofree char *password =3D NULL;
+    g_autofree char *cipher_mode =3D NULL;
=20
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         if (!options->u.luks.key_secret) {
@@ -701,6 +702,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         goto fail;
     }
=20
+    cipher_mode =3D g_strdup(luks->header.cipher_mode);
+
     /*
      * The cipher_mode header contains a string that we have
      * to further parse, of the format
@@ -709,11 +712,11 @@ qcrypto_block_luks_open(QCryptoBlock *block,
      *
      * eg  cbc-essiv:sha256, cbc-plain64
      */
-    ivgen_name =3D strchr(luks->header.cipher_mode, '-');
+    ivgen_name =3D strchr(cipher_mode, '-');
     if (!ivgen_name) {
         ret =3D -EINVAL;
         error_setg(errp, "Unexpected cipher mode string format %s",
-                   luks->header.cipher_mode);
+                   cipher_mode);
         goto fail;
     }
     *ivgen_name =3D '\0';
@@ -735,7 +738,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         }
     }
=20
-    ciphermode =3D qcrypto_block_luks_cipher_mode_lookup(luks->header.ci=
pher_mode,
+    ciphermode =3D qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
                                                        &local_err);
     if (local_err) {
         ret =3D -ENOTSUP;
--=20
2.21.0


