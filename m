Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05681FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF20F20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF20F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL814-0001eb-CP
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iL7D6-00059m-Q0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iL7D5-00039E-En
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iL7D5-00038p-6X
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7821A8553F
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 14:57:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-36.ams2.redhat.com
 [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6024100194E;
 Thu, 17 Oct 2019 14:57:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] crypto: add support for nettle's native XTS impl
Date: Thu, 17 Oct 2019 15:56:54 +0100
Message-Id: <20191017145654.11371-5-berrange@redhat.com>
In-Reply-To: <20191017145654.11371-1-berrange@redhat.com>
References: <20191017145654.11371-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 17 Oct 2019 14:57:02 +0000 (UTC)
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nettle 3.5.0 will add support for the XTS mode. Use this because long
term we wish to delete QEMU's XTS impl to avoid carrying private crypto
algorithm impls.

Unfortunately this degrades nettle performance from 612 MB/s to 568 MB/s
as nettle's XTS impl isn't so well optimized yet.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure              | 18 ++++++++++++++++++
 crypto/cipher-nettle.c | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/configure b/configure
index 98edb0ff44..6650c72348 100755
--- a/configure
+++ b/configure
@@ -471,6 +471,7 @@ gtk_gl=3D"no"
 tls_priority=3D"NORMAL"
 gnutls=3D""
 nettle=3D""
+nettle_xts=3D"no"
 gcrypt=3D""
 gcrypt_hmac=3D"no"
 gcrypt_xts=3D"no"
@@ -2862,6 +2863,19 @@ if test "$nettle" !=3D "no"; then
             pass=3D"yes"
         fi
     fi
+    if test "$pass" =3D "yes"
+    then
+        cat > $TMPC << EOF
+#include <nettle/xts.h>
+int main(void) {
+  return 0;
+}
+EOF
+        if compile_prog "$nettle_cflags" "$nettle_libs" ; then
+            nettle_xts=3Dyes
+            qemu_private_xts=3Dno
+        fi
+    fi
     if test "$pass" =3D "no" && test "$nettle" =3D "yes"; then
         feature_not_found "nettle" "Install nettle devel >=3D 2.7.1"
     else
@@ -6337,6 +6351,10 @@ then
    echo "  XTS             $gcrypt_xts"
 fi
 echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
+if test "$nettle" =3D "yes"
+then
+   echo "  XTS             $nettle_xts"
+fi
 echo "libtasn1          $tasn1"
 echo "PAM               $auth_pam"
 echo "iconv support     $iconv"
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index d7411bb8ff..08794a9b10 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -19,7 +19,9 @@
  */
=20
 #include "qemu/osdep.h"
+#ifdef CONFIG_QEMU_PRIVATE_XTS
 #include "crypto/xts.h"
+#endif
 #include "cipherpriv.h"
=20
 #include <nettle/nettle-types.h>
@@ -30,6 +32,9 @@
 #include <nettle/serpent.h>
 #include <nettle/twofish.h>
 #include <nettle/ctr.h>
+#ifndef CONFIG_QEMU_PRIVATE_XTS
+#include <nettle/xts.h>
+#endif
=20
 typedef void (*QCryptoCipherNettleFuncWrapper)(const void *ctx,
                                                size_t length,
@@ -626,9 +631,15 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
         break;
=20
     case QCRYPTO_CIPHER_MODE_XTS:
+#ifdef CONFIG_QEMU_PRIVATE_XTS
         xts_encrypt(ctx->ctx, ctx->ctx_tweak,
                     ctx->alg_encrypt_wrapper, ctx->alg_encrypt_wrapper,
                     ctx->iv, len, out, in);
+#else
+        xts_encrypt_message(ctx->ctx, ctx->ctx_tweak,
+                            ctx->alg_encrypt_native,
+                            ctx->iv, len, out, in);
+#endif
         break;
=20
     case QCRYPTO_CIPHER_MODE_CTR:
@@ -673,9 +684,16 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
         break;
=20
     case QCRYPTO_CIPHER_MODE_XTS:
+#ifdef CONFIG_QEMU_PRIVATE_XTS
         xts_decrypt(ctx->ctx, ctx->ctx_tweak,
                     ctx->alg_encrypt_wrapper, ctx->alg_decrypt_wrapper,
                     ctx->iv, len, out, in);
+#else
+        xts_decrypt_message(ctx->ctx, ctx->ctx_tweak,
+                            ctx->alg_encrypt_native,
+                            ctx->alg_decrypt_native,
+                            ctx->iv, len, out, in);
+#endif
         break;
     case QCRYPTO_CIPHER_MODE_CTR:
         ctr_crypt(ctx->ctx, ctx->alg_encrypt_native,
--=20
2.21.0


