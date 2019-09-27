Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E95C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24522086A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24522086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqJr-0001he-6s
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDpvU-0005nm-Jb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDpvS-0004Tc-90
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iDpvR-0004St-MU
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5174F3090FD6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:59:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19F47608C2;
 Fri, 27 Sep 2019 09:59:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] qcrypto-luks: extract check and parse header
Date: Fri, 27 Sep 2019 10:59:23 +0100
Message-Id: <20190927095926.22230-9-berrange@redhat.com>
In-Reply-To: <20190927095926.22230-1-berrange@redhat.com>
References: <20190927095926.22230-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 27 Sep 2019 09:59:44 +0000 (UTC)
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

This is just to make qcrypto_block_luks_open more
reasonable in size.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 223 +++++++++++++++++++++++++-------------------
 1 file changed, 125 insertions(+), 98 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 47371edf13..fa799fd21d 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -500,6 +500,129 @@ qcrypto_block_luks_load_header(QCryptoBlock *block,
     return 0;
 }
=20
+/*
+ * Does basic sanity checks on the LUKS header
+ */
+static int
+qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **er=
rp)
+{
+    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
+               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
+        error_setg(errp, "Volume is not in LUKS format");
+        return -1;
+    }
+
+    if (luks->header.version !=3D QCRYPTO_BLOCK_LUKS_VERSION) {
+        error_setg(errp, "LUKS version %" PRIu32 " is not supported",
+                   luks->header.version);
+        return -1;
+    }
+    return 0;
+}
+
+/*
+ * Parses the crypto parameters that are stored in the LUKS header
+ */
+
+static int
+qcrypto_block_luks_parse_header(QCryptoBlockLUKS *luks, Error **errp)
+{
+    g_autofree char *cipher_mode =3D g_strdup(luks->header.cipher_mode);
+    char *ivgen_name, *ivhash_name;
+    Error *local_err =3D NULL;
+
+    /*
+     * The cipher_mode header contains a string that we have
+     * to further parse, of the format
+     *
+     *    <cipher-mode>-<iv-generator>[:<iv-hash>]
+     *
+     * eg  cbc-essiv:sha256, cbc-plain64
+     */
+    ivgen_name =3D strchr(cipher_mode, '-');
+    if (!ivgen_name) {
+        error_setg(errp, "Unexpected cipher mode string format %s",
+                   luks->header.cipher_mode);
+        return -1;
+    }
+    *ivgen_name =3D '\0';
+    ivgen_name++;
+
+    ivhash_name =3D strchr(ivgen_name, ':');
+    if (!ivhash_name) {
+        luks->ivgen_hash_alg =3D 0;
+    } else {
+        *ivhash_name =3D '\0';
+        ivhash_name++;
+
+        luks->ivgen_hash_alg =3D qcrypto_block_luks_hash_name_lookup(ivh=
ash_name,
+                                                                   &loca=
l_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+    }
+
+    luks->cipher_mode =3D qcrypto_block_luks_cipher_mode_lookup(cipher_m=
ode,
+                                                              &local_err=
);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+
+    luks->cipher_alg =3D
+            qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_na=
me,
+                                                  luks->cipher_mode,
+                                                  luks->header.master_ke=
y_len,
+                                                  &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+
+    luks->hash_alg =3D
+            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
+                                                &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+
+    luks->ivgen_alg =3D qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
+                                                           &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+
+    if (luks->ivgen_alg =3D=3D QCRYPTO_IVGEN_ALG_ESSIV) {
+        if (!ivhash_name) {
+            error_setg(errp, "Missing IV generator hash specification");
+            return -1;
+        }
+        luks->ivgen_cipher_alg =3D
+                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
+                                                luks->ivgen_hash_alg,
+                                                &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+    } else {
+
+        /*
+         * Note we parsed the ivhash_name earlier in the cipher_mode
+         * spec string even with plain/plain64 ivgens, but we
+         * will ignore it, since it is irrelevant for these ivgens.
+         * This is for compat with dm-crypt which will silently
+         * ignore hash names with these ivgens rather than report
+         * an error about the invalid usage
+         */
+        luks->ivgen_cipher_alg =3D luks->cipher_alg;
+    }
+    return 0;
+}
+
 /*
  * Given a key slot, and user password, this will attempt to unlock
  * the master encryption key from the key slot.
@@ -712,11 +835,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                         Error **errp)
 {
     QCryptoBlockLUKS *luks =3D NULL;
-    Error *local_err =3D NULL;
     g_autofree uint8_t *masterkey =3D NULL;
-    char *ivgen_name, *ivhash_name;
     g_autofree char *password =3D NULL;
-    g_autofree char *cipher_mode =3D NULL;
=20
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         if (!options->u.luks.key_secret) {
@@ -738,107 +858,14 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         goto fail;
     }
=20
-    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
-               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
-        error_setg(errp, "Volume is not in LUKS format");
-        goto fail;
-    }
-    if (luks->header.version !=3D QCRYPTO_BLOCK_LUKS_VERSION) {
-        error_setg(errp, "LUKS version %" PRIu32 " is not supported",
-                   luks->header.version);
-        goto fail;
-    }
-
-    cipher_mode =3D g_strdup(luks->header.cipher_mode);
-
-    /*
-     * The cipher_mode header contains a string that we have
-     * to further parse, of the format
-     *
-     *    <cipher-mode>-<iv-generator>[:<iv-hash>]
-     *
-     * eg  cbc-essiv:sha256, cbc-plain64
-     */
-    ivgen_name =3D strchr(cipher_mode, '-');
-    if (!ivgen_name) {
-        error_setg(errp, "Unexpected cipher mode string format %s",
-                   cipher_mode);
-        goto fail;
-    }
-    *ivgen_name =3D '\0';
-    ivgen_name++;
-
-    ivhash_name =3D strchr(ivgen_name, ':');
-    if (!ivhash_name) {
-        luks->ivgen_hash_alg =3D 0;
-    } else {
-        *ivhash_name =3D '\0';
-        ivhash_name++;
-
-        luks->ivgen_hash_alg =3D qcrypto_block_luks_hash_name_lookup(ivh=
ash_name,
-                                                                   &loca=
l_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            goto fail;
-        }
-    }
-
-    luks->cipher_mode =3D qcrypto_block_luks_cipher_mode_lookup(cipher_m=
ode,
-                                                              &local_err=
);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-
-    luks->cipher_alg =3D
-        qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
-                                              luks->cipher_mode,
-                                              luks->header.master_key_le=
n,
-                                              &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-
-    luks->hash_alg =3D
-            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
-                                                &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (qcrypto_block_luks_check_header(luks, errp) < 0) {
         goto fail;
     }
=20
-    luks->ivgen_alg =3D qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
-                                                           &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (qcrypto_block_luks_parse_header(luks, errp) < 0) {
         goto fail;
     }
=20
-    if (luks->ivgen_alg =3D=3D QCRYPTO_IVGEN_ALG_ESSIV) {
-        if (!ivhash_name) {
-            error_setg(errp, "Missing IV generator hash specification");
-            goto fail;
-        }
-        luks->ivgen_cipher_alg =3D
-                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
-                                                luks->ivgen_hash_alg,
-                                                &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            goto fail;
-        }
-    } else {
-        /* Note we parsed the ivhash_name earlier in the cipher_mode
-         * spec string even with plain/plain64 ivgens, but we
-         * will ignore it, since it is irrelevant for these ivgens.
-         * This is for compat with dm-crypt which will silently
-         * ignore hash names with these ivgens rather than report
-         * an error about the invalid usage
-         */
-        luks->ivgen_cipher_alg =3D luks->cipher_alg;
-    }
-
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         /* Try to find which key slot our password is valid for
          * and unlock the master key from that slot.
--=20
2.21.0


