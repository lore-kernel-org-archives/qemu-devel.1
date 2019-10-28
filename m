Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E7CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F42208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKtmZadt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F42208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7a6-0006qy-MP
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iP7HN-0004ec-IZ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iP7HL-00019W-KX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:50:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iP7HL-00019B-GX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572277799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Njq2xoulQgk96sQoBAc/2Clpi/XrfAdJezkanbUlKGo=;
 b=MKtmZadthcM5ytkVMWUNHUl4qeIFyBIbpE/KS8AWKa7qnSXgrFpoHb/Dl8iDYWZwaPNJpv
 Rpa9g/BYtW0LTqQigZwOrHQbaxllaHDEL5A+UhDzBVhXMrm6WQJwRtyK4YwH4diGaUofH4
 JyAJoNuE/vuu2+m3Cz4mkLuvNsB8Bdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-vmfVhUNqMlmqPjdSQabQsg-1; Mon, 28 Oct 2019 11:49:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99928476
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 15:49:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-24.ams2.redhat.com
 [10.36.112.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25AAB5D9C5;
 Mon, 28 Oct 2019 15:49:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] crypto: add support for gcrypt's native XTS impl
Date: Mon, 28 Oct 2019 16:49:13 +0100
Message-Id: <20191028154914.84821-4-berrange@redhat.com>
In-Reply-To: <20191028154914.84821-1-berrange@redhat.com>
References: <20191028154914.84821-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vmfVhUNqMlmqPjdSQabQsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Libgcrypt 1.8.0 added support for the XTS mode. Use this because long
term we wish to delete QEMU's XTS impl to avoid carrying private crypto
algorithm impls.

As an added benefit, using this improves performance from 531 MB/sec to
670 MB/sec, since we are avoiding several layers of function call
indirection.

This is even more noticable with the gcrypt builds in Fedora or RHEL-8
which have a non-upstream patch for FIPS mode which does mutex locking.
This is catastrophic for encryption performance with small block sizes,
meaning this patch improves encryption from 240 MB/sec to 670 MB/sec.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure              | 22 ++++++++++
 crypto/Makefile.objs   |  2 +-
 crypto/cipher-gcrypt.c | 97 ++++++++++++++++++++++++++++--------------
 tests/Makefile.include |  2 +-
 4 files changed, 88 insertions(+), 35 deletions(-)

diff --git a/configure b/configure
index 145fcabbb3..d1e9e457ce 100755
--- a/configure
+++ b/configure
@@ -474,6 +474,8 @@ gnutls=3D""
 nettle=3D""
 gcrypt=3D""
 gcrypt_hmac=3D"no"
+gcrypt_xts=3D"no"
+qemu_private_xts=3D"yes"
 auth_pam=3D""
 vte=3D""
 virglrenderer=3D""
@@ -2911,6 +2913,18 @@ EOF
         if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
             gcrypt_hmac=3Dyes
         fi
+        cat > $TMPC << EOF
+#include <gcrypt.h>
+int main(void) {
+  gcry_cipher_hd_t handle;
+  gcry_cipher_open(&handle, GCRY_CIPHER_AES, GCRY_CIPHER_MODE_XTS, 0);
+  return 0;
+}
+EOF
+        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
+            gcrypt_xts=3Dyes
+            qemu_private_xts=3Dno
+        fi
     elif test "$gcrypt" =3D "yes"; then
         feature_not_found "gcrypt" "Install gcrypt devel >=3D 1.5.0"
     else
@@ -6326,6 +6340,11 @@ echo "VTE support       $vte $(echo_version $vte $vt=
eversion)"
 echo "TLS priority      $tls_priority"
 echo "GNUTLS support    $gnutls"
 echo "libgcrypt         $gcrypt"
+if test "$gcrypt" =3D "yes"
+then
+   echo "  hmac            $gcrypt_hmac"
+   echo "  XTS             $gcrypt_xts"
+fi
 echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
 echo "libtasn1          $tasn1"
 echo "PAM               $auth_pam"
@@ -6804,6 +6823,9 @@ if test "$nettle" =3D "yes" ; then
   echo "CONFIG_NETTLE=3Dy" >> $config_host_mak
   echo "CONFIG_NETTLE_VERSION_MAJOR=3D${nettle_version%%.*}" >> $config_ho=
st_mak
 fi
+if test "$qemu_private_xts" =3D "yes" ; then
+  echo "CONFIG_QEMU_PRIVATE_XTS=3Dy" >> $config_host_mak
+fi
 if test "$tasn1" =3D "yes" ; then
   echo "CONFIG_TASN1=3Dy" >> $config_host_mak
 fi
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 7fe2fa9da2..cdb01f9de9 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -31,7 +31,7 @@ crypto-obj-y +=3D ivgen-essiv.o
 crypto-obj-y +=3D ivgen-plain.o
 crypto-obj-y +=3D ivgen-plain64.o
 crypto-obj-y +=3D afsplit.o
-crypto-obj-y +=3D xts.o
+crypto-obj-$(CONFIG_QEMU_PRIVATE_XTS) +=3D xts.o
 crypto-obj-y +=3D block.o
 crypto-obj-y +=3D block-qcow.o
 crypto-obj-y +=3D block-luks.o
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 5cece9b244..2864099527 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -19,7 +19,9 @@
  */
=20
 #include "qemu/osdep.h"
+#ifdef CONFIG_QEMU_PRIVATE_XTS
 #include "crypto/xts.h"
+#endif
 #include "cipherpriv.h"
=20
 #include <gcrypt.h>
@@ -59,10 +61,12 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg=
,
 typedef struct QCryptoCipherGcrypt QCryptoCipherGcrypt;
 struct QCryptoCipherGcrypt {
     gcry_cipher_hd_t handle;
-    gcry_cipher_hd_t tweakhandle;
     size_t blocksize;
+#ifdef CONFIG_QEMU_PRIVATE_XTS
+    gcry_cipher_hd_t tweakhandle;
     /* Initialization vector or Counter */
     uint8_t *iv;
+#endif
 };
=20
 static void
@@ -74,10 +78,12 @@ qcrypto_gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx=
,
     }
=20
     gcry_cipher_close(ctx->handle);
+#ifdef CONFIG_QEMU_PRIVATE_XTS
     if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
         gcry_cipher_close(ctx->tweakhandle);
     }
     g_free(ctx->iv);
+#endif
     g_free(ctx);
 }
=20
@@ -94,8 +100,14 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCry=
ptoCipherAlgorithm alg,
=20
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
+        gcrymode =3D GCRY_CIPHER_MODE_ECB;
+        break;
     case QCRYPTO_CIPHER_MODE_XTS:
+#ifdef CONFIG_QEMU_PRIVATE_XTS
         gcrymode =3D GCRY_CIPHER_MODE_ECB;
+#else
+        gcrymode =3D GCRY_CIPHER_MODE_XTS;
+#endif
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
         gcrymode =3D GCRY_CIPHER_MODE_CBC;
@@ -172,6 +184,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCry=
ptoCipherAlgorithm alg,
                    gcry_strerror(err));
         goto error;
     }
+#ifdef CONFIG_QEMU_PRIVATE_XTS
     if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
         err =3D gcry_cipher_open(&ctx->tweakhandle, gcryalg, gcrymode, 0);
         if (err !=3D 0) {
@@ -180,6 +193,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCry=
ptoCipherAlgorithm alg,
             goto error;
         }
     }
+#endif
=20
     if (alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB) {
         /* We're using standard DES cipher from gcrypt, so we need
@@ -191,6 +205,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCry=
ptoCipherAlgorithm alg,
         g_free(rfbkey);
         ctx->blocksize =3D 8;
     } else {
+#ifdef CONFIG_QEMU_PRIVATE_XTS
         if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
             nkey /=3D 2;
             err =3D gcry_cipher_setkey(ctx->handle, key, nkey);
@@ -201,8 +216,11 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCr=
yptoCipherAlgorithm alg,
             }
             err =3D gcry_cipher_setkey(ctx->tweakhandle, key + nkey, nkey)=
;
         } else {
+#endif
             err =3D gcry_cipher_setkey(ctx->handle, key, nkey);
+#ifdef CONFIG_QEMU_PRIVATE_XTS
         }
+#endif
         if (err !=3D 0) {
             error_setg(errp, "Cannot set key: %s",
                        gcry_strerror(err));
@@ -228,6 +246,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCry=
ptoCipherAlgorithm alg,
         }
     }
=20
+#ifdef CONFIG_QEMU_PRIVATE_XTS
     if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
         if (ctx->blocksize !=3D XTS_BLOCK_SIZE) {
             error_setg(errp,
@@ -237,6 +256,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCry=
ptoCipherAlgorithm alg,
         }
         ctx->iv =3D g_new0(uint8_t, ctx->blocksize);
     }
+#endif
=20
     return ctx;
=20
@@ -253,6 +273,7 @@ qcrypto_gcrypt_cipher_ctx_free(QCryptoCipher *cipher)
 }
=20
=20
+#ifdef CONFIG_QEMU_PRIVATE_XTS
 static void qcrypto_gcrypt_xts_encrypt(const void *ctx,
                                        size_t length,
                                        uint8_t *dst,
@@ -272,6 +293,7 @@ static void qcrypto_gcrypt_xts_decrypt(const void *ctx,
     err =3D gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src, l=
ength);
     g_assert(err =3D=3D 0);
 }
+#endif
=20
 static int
 qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
@@ -289,20 +311,23 @@ qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
         return -1;
     }
=20
+#ifdef CONFIG_QEMU_PRIVATE_XTS
     if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
         xts_encrypt(ctx->handle, ctx->tweakhandle,
                     qcrypto_gcrypt_xts_encrypt,
                     qcrypto_gcrypt_xts_decrypt,
                     ctx->iv, len, out, in);
-    } else {
-        err =3D gcry_cipher_encrypt(ctx->handle,
-                                  out, len,
-                                  in, len);
-        if (err !=3D 0) {
-            error_setg(errp, "Cannot encrypt data: %s",
-                       gcry_strerror(err));
-            return -1;
-        }
+        return 0;
+    }
+#endif
+
+    err =3D gcry_cipher_encrypt(ctx->handle,
+                              out, len,
+                              in, len);
+    if (err !=3D 0) {
+        error_setg(errp, "Cannot encrypt data: %s",
+                   gcry_strerror(err));
+        return -1;
     }
=20
     return 0;
@@ -325,20 +350,23 @@ qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
         return -1;
     }
=20
+#ifdef CONFIG_QEMU_PRIVATE_XTS
     if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
         xts_decrypt(ctx->handle, ctx->tweakhandle,
                     qcrypto_gcrypt_xts_encrypt,
                     qcrypto_gcrypt_xts_decrypt,
                     ctx->iv, len, out, in);
-    } else {
-        err =3D gcry_cipher_decrypt(ctx->handle,
-                                  out, len,
-                                  in, len);
-        if (err !=3D 0) {
-            error_setg(errp, "Cannot decrypt data: %s",
-                       gcry_strerror(err));
-            return -1;
-        }
+        return 0;
+    }
+#endif
+
+    err =3D gcry_cipher_decrypt(ctx->handle,
+                              out, len,
+                              in, len);
+    if (err !=3D 0) {
+        error_setg(errp, "Cannot decrypt data: %s",
+                   gcry_strerror(err));
+        return -1;
     }
=20
     return 0;
@@ -358,24 +386,27 @@ qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
         return -1;
     }
=20
+#ifdef CONFIG_QEMU_PRIVATE_XTS
     if (ctx->iv) {
         memcpy(ctx->iv, iv, niv);
-    } else {
-        if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {
-            err =3D gcry_cipher_setctr(ctx->handle, iv, niv);
-            if (err !=3D 0) {
-                error_setg(errp, "Cannot set Counter: %s",
+        return 0;
+    }
+#endif
+
+    if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {
+        err =3D gcry_cipher_setctr(ctx->handle, iv, niv);
+        if (err !=3D 0) {
+            error_setg(errp, "Cannot set Counter: %s",
                        gcry_strerror(err));
-                return -1;
-            }
-        } else {
-            gcry_cipher_reset(ctx->handle);
-            err =3D gcry_cipher_setiv(ctx->handle, iv, niv);
-            if (err !=3D 0) {
-                error_setg(errp, "Cannot set IV: %s",
+            return -1;
+        }
+    } else {
+        gcry_cipher_reset(ctx->handle);
+        err =3D gcry_cipher_setiv(ctx->handle, iv, niv);
+        if (err !=3D 0) {
+            error_setg(errp, "Cannot set IV: %s",
                        gcry_strerror(err));
-                return -1;
-            }
+            return -1;
         }
     }
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 09e5b410dc..4efdd0cd6e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -140,7 +140,7 @@ check-unit-y +=3D tests/test-base64$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GC=
RYPT))) +=3D tests/test-crypto-pbkdf$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-ivgen$(EXESUF)
 check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-afsplit$(EXESUF)
-check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-xts$(EXESUF)
+check-unit-$(if $(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) +=3D tests/tes=
t-crypto-xts$(EXESUF)
 check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-block$(EXESUF)
 check-unit-y +=3D tests/test-logging$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) +=3D tests/t=
est-replication$(EXESUF)
--=20
2.23.0


