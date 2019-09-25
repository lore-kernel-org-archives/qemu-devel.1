Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE1C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E521205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E521205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDF5X-0004TS-6l
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDExN-0006mq-Ue
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDExI-0006VI-8e
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iDExB-0006Lt-9I; Wed, 25 Sep 2019 17:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 612B6308FF30;
 Wed, 25 Sep 2019 21:36:04 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C138719C5B;
 Wed, 25 Sep 2019 21:36:01 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/13] qcrypto-luks: use the parsed encryption settings in
 QCryptoBlockLUKS
Date: Thu, 26 Sep 2019 00:35:20 +0300
Message-Id: <20190925213527.9117-7-mlevitsk@redhat.com>
In-Reply-To: <20190925213527.9117-1-mlevitsk@redhat.com>
References: <20190925213527.9117-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 25 Sep 2019 21:36:04 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prior to that patch, the parsed encryption settings
were already stored into the QCryptoBlockLUKS but not
used anywhere but in qcrypto_block_luks_get_info

Using them simplifies the code

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 169 +++++++++++++++++++++-----------------------
 1 file changed, 79 insertions(+), 90 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index b759cc8d19..f3bfc921b2 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -199,13 +199,25 @@ QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSHea=
der) !=3D 592);
 struct QCryptoBlockLUKS {
     QCryptoBlockLUKSHeader header;
=20
-    /* Cache parsed versions of what's in header fields,
-     * as we can't rely on QCryptoBlock.cipher being
-     * non-NULL */
+    /* Main encryption algorithm used for encryption*/
     QCryptoCipherAlgorithm cipher_alg;
+
+    /* Mode of encryption for the selected encryption algorithm */
     QCryptoCipherMode cipher_mode;
+
+    /* Initialization vector generation algorithm */
     QCryptoIVGenAlgorithm ivgen_alg;
+
+    /* Hash algorithm used for IV generation*/
     QCryptoHashAlgorithm ivgen_hash_alg;
+
+    /*
+     * Encryption algorithm used for IV generation.
+     * Usually the same as main encryption algorithm
+     */
+    QCryptoCipherAlgorithm ivgen_cipher_alg;
+
+    /* Hash algorithm used in pbkdf2 function */
     QCryptoHashAlgorithm hash_alg;
 };
=20
@@ -412,12 +424,6 @@ static int
 qcrypto_block_luks_load_key(QCryptoBlock *block,
                             size_t slot_idx,
                             const char *password,
-                            QCryptoCipherAlgorithm cipheralg,
-                            QCryptoCipherMode ciphermode,
-                            QCryptoHashAlgorithm hash,
-                            QCryptoIVGenAlgorithm ivalg,
-                            QCryptoCipherAlgorithm ivcipheralg,
-                            QCryptoHashAlgorithm ivhash,
                             uint8_t *masterkey,
                             QCryptoBlockReadFunc readfunc,
                             void *opaque,
@@ -449,7 +455,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * the key is correct and validate the results of
      * decryption later.
      */
-    if (qcrypto_pbkdf2(hash,
+    if (qcrypto_pbkdf2(luks->hash_alg,
                        (const uint8_t *)password, strlen(password),
                        slot->salt, QCRYPTO_BLOCK_LUKS_SALT_LEN,
                        slot->iterations,
@@ -477,19 +483,23 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
=20
     /* Setup the cipher/ivgen that we'll use to try to decrypt
      * the split master key material */
-    cipher =3D qcrypto_cipher_new(cipheralg, ciphermode,
-                                possiblekey, luks->header.master_key_len=
,
+    cipher =3D qcrypto_cipher_new(luks->cipher_alg,
+                                luks->cipher_mode,
+                                possiblekey,
+                                luks->header.master_key_len,
                                 errp);
     if (!cipher) {
         return -1;
     }
=20
-    niv =3D qcrypto_cipher_get_iv_len(cipheralg,
-                                    ciphermode);
-    ivgen =3D qcrypto_ivgen_new(ivalg,
-                              ivcipheralg,
-                              ivhash,
-                              possiblekey, luks->header.master_key_len,
+    niv =3D qcrypto_cipher_get_iv_len(luks->cipher_alg,
+                                    luks->cipher_mode);
+
+    ivgen =3D qcrypto_ivgen_new(luks->ivgen_alg,
+                              luks->ivgen_cipher_alg,
+                              luks->ivgen_hash_alg,
+                              possiblekey,
+                              luks->header.master_key_len,
                               errp);
     if (!ivgen) {
         return -1;
@@ -518,7 +528,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * Now we've decrypted the split master key, join
      * it back together to get the actual master key.
      */
-    if (qcrypto_afsplit_decode(hash,
+    if (qcrypto_afsplit_decode(luks->hash_alg,
                                luks->header.master_key_len,
                                slot->stripes,
                                splitkey,
@@ -536,7 +546,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * then comparing that to the hash stored in the key slot
      * header
      */
-    if (qcrypto_pbkdf2(hash,
+    if (qcrypto_pbkdf2(luks->hash_alg,
                        masterkey,
                        luks->header.master_key_len,
                        luks->header.master_key_salt,
@@ -570,12 +580,6 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
 static int
 qcrypto_block_luks_find_key(QCryptoBlock *block,
                             const char *password,
-                            QCryptoCipherAlgorithm cipheralg,
-                            QCryptoCipherMode ciphermode,
-                            QCryptoHashAlgorithm hash,
-                            QCryptoIVGenAlgorithm ivalg,
-                            QCryptoCipherAlgorithm ivcipheralg,
-                            QCryptoHashAlgorithm ivhash,
                             uint8_t *masterkey,
                             QCryptoBlockReadFunc readfunc,
                             void *opaque,
@@ -588,12 +592,6 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
         rv =3D qcrypto_block_luks_load_key(block,
                                          i,
                                          password,
-                                         cipheralg,
-                                         ciphermode,
-                                         hash,
-                                         ivalg,
-                                         ivcipheralg,
-                                         ivhash,
                                          masterkey,
                                          readfunc,
                                          opaque,
@@ -607,7 +605,6 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
     }
=20
     error_setg(errp, "Invalid password, cannot unlock any keyslot");
-
  error:
     return -1;
 }
@@ -623,19 +620,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                         size_t n_threads,
                         Error **errp)
 {
-    QCryptoBlockLUKS *luks;
+    QCryptoBlockLUKS *luks =3D NULL;
     Error *local_err =3D NULL;
     int ret =3D 0;
     size_t i;
     ssize_t rv;
     g_autofree uint8_t *masterkey =3D NULL;
     char *ivgen_name, *ivhash_name;
-    QCryptoCipherMode ciphermode;
-    QCryptoCipherAlgorithm cipheralg;
-    QCryptoIVGenAlgorithm ivalg;
-    QCryptoCipherAlgorithm ivcipheralg;
-    QCryptoHashAlgorithm hash;
-    QCryptoHashAlgorithm ivhash;
     g_autofree char *password =3D NULL;
     g_autofree char *cipher_mode =3D NULL;
=20
@@ -716,13 +707,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
=20
     ivhash_name =3D strchr(ivgen_name, ':');
     if (!ivhash_name) {
-        ivhash =3D 0;
+        luks->ivgen_hash_alg =3D 0;
     } else {
         *ivhash_name =3D '\0';
         ivhash_name++;
=20
-        ivhash =3D qcrypto_block_luks_hash_name_lookup(ivhash_name,
-                                                     &local_err);
+        luks->ivgen_hash_alg =3D qcrypto_block_luks_hash_name_lookup(ivh=
ash_name,
+                                                                   &loca=
l_err);
         if (local_err) {
             ret =3D -ENOTSUP;
             error_propagate(errp, local_err);
@@ -730,17 +721,17 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         }
     }
=20
-    ciphermode =3D qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
-                                                       &local_err);
+    luks->cipher_mode =3D qcrypto_block_luks_cipher_mode_lookup(cipher_m=
ode,
+                                                              &local_err=
);
     if (local_err) {
         ret =3D -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
=20
-    cipheralg =3D
+    luks->cipher_alg =3D
         qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
-                                              ciphermode,
+                                              luks->cipher_mode,
                                               luks->header.master_key_le=
n,
                                               &local_err);
     if (local_err) {
@@ -749,31 +740,33 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         goto fail;
     }
=20
-    hash =3D qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
-                                               &local_err);
+    luks->hash_alg =3D
+            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
+                                                &local_err);
     if (local_err) {
         ret =3D -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
=20
-    ivalg =3D qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
-                                                 &local_err);
+    luks->ivgen_alg =3D qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
+                                                           &local_err);
     if (local_err) {
         ret =3D -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
=20
-    if (ivalg =3D=3D QCRYPTO_IVGEN_ALG_ESSIV) {
+    if (luks->ivgen_alg =3D=3D QCRYPTO_IVGEN_ALG_ESSIV) {
         if (!ivhash_name) {
             ret =3D -EINVAL;
             error_setg(errp, "Missing IV generator hash specification");
             goto fail;
         }
-        ivcipheralg =3D qcrypto_block_luks_essiv_cipher(cipheralg,
-                                                      ivhash,
-                                                      &local_err);
+        luks->ivgen_cipher_alg =3D
+                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
+                                                luks->ivgen_hash_alg,
+                                                &local_err);
         if (local_err) {
             ret =3D -ENOTSUP;
             error_propagate(errp, local_err);
@@ -787,7 +780,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
          * ignore hash names with these ivgens rather than report
          * an error about the invalid usage
          */
-        ivcipheralg =3D cipheralg;
+        luks->ivgen_cipher_alg =3D luks->cipher_alg;
     }
=20
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
@@ -799,11 +792,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
=20
         if (qcrypto_block_luks_find_key(block,
                                         password,
-                                        cipheralg, ciphermode,
-                                        hash,
-                                        ivalg,
-                                        ivcipheralg,
-                                        ivhash,
                                         masterkey,
                                         readfunc, opaque,
                                         errp) < 0) {
@@ -814,12 +802,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         /* We have a valid master key now, so can setup the
          * block device payload decryption objects
          */
-        block->kdfhash =3D hash;
-        block->niv =3D qcrypto_cipher_get_iv_len(cipheralg,
-                                               ciphermode);
-        block->ivgen =3D qcrypto_ivgen_new(ivalg,
-                                         ivcipheralg,
-                                         ivhash,
+        block->kdfhash =3D luks->hash_alg;
+        block->niv =3D qcrypto_cipher_get_iv_len(luks->cipher_alg,
+                                               luks->cipher_mode);
+
+        block->ivgen =3D qcrypto_ivgen_new(luks->ivgen_alg,
+                                         luks->ivgen_cipher_alg,
+                                         luks->ivgen_hash_alg,
                                          masterkey,
                                          luks->header.master_key_len,
                                          errp);
@@ -828,7 +817,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
             goto fail;
         }
=20
-        ret =3D qcrypto_block_init_cipher(block, cipheralg, ciphermode,
+        ret =3D qcrypto_block_init_cipher(block,
+                                        luks->cipher_alg,
+                                        luks->cipher_mode,
                                         masterkey,
                                         luks->header.master_key_len,
                                         n_threads,
@@ -843,11 +834,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     block->payload_offset =3D luks->header.payload_offset_sector *
         block->sector_size;
=20
-    luks->cipher_alg =3D cipheralg;
-    luks->cipher_mode =3D ciphermode;
-    luks->ivgen_alg =3D ivalg;
-    luks->ivgen_hash_alg =3D ivhash;
-    luks->hash_alg =3D hash;
=20
     return 0;
=20
@@ -893,7 +879,6 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     const char *ivgen_hash_alg =3D NULL;
     const char *hash_alg;
     g_autofree char *cipher_mode_spec =3D NULL;
-    QCryptoCipherAlgorithm ivcipheralg =3D 0;
     uint64_t iters;
=20
     memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
@@ -918,6 +903,17 @@ qcrypto_block_luks_create(QCryptoBlock *block,
             luks_opts.has_ivgen_hash_alg =3D true;
         }
     }
+
+    luks =3D g_new0(QCryptoBlockLUKS, 1);
+    block->opaque =3D luks;
+
+    luks->cipher_alg =3D luks_opts.cipher_alg;
+    luks->cipher_mode =3D luks_opts.cipher_mode;
+    luks->ivgen_alg =3D luks_opts.ivgen_alg;
+    luks->ivgen_hash_alg =3D luks_opts.ivgen_hash_alg;
+    luks->hash_alg =3D luks_opts.hash_alg;
+
+
     /* Note we're allowing ivgen_hash_alg to be set even for
      * non-essiv iv generators that don't need a hash. It will
      * be silently ignored, for compatibility with dm-crypt */
@@ -925,15 +921,13 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     if (!options->u.luks.key_secret) {
         error_setg(errp, "Parameter '%skey-secret' is required for ciphe=
r",
                    optprefix ? optprefix : "");
-        return -1;
+        goto error;
     }
     password =3D qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, err=
p);
     if (!password) {
-        return -1;
+        goto error;
     }
=20
-    luks =3D g_new0(QCryptoBlockLUKS, 1);
-    block->opaque =3D luks;
=20
     memcpy(luks->header.magic, qcrypto_block_luks_magic,
            QCRYPTO_BLOCK_LUKS_MAGIC_LEN);
@@ -980,15 +974,16 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     }
=20
     if (luks_opts.ivgen_alg =3D=3D QCRYPTO_IVGEN_ALG_ESSIV) {
-        ivcipheralg =3D qcrypto_block_luks_essiv_cipher(luks_opts.cipher=
_alg,
-                                                      luks_opts.ivgen_ha=
sh_alg,
-                                                      &local_err);
+        luks->ivgen_cipher_alg =3D
+                qcrypto_block_luks_essiv_cipher(luks_opts.cipher_alg,
+                                                luks_opts.ivgen_hash_alg=
,
+                                                &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto error;
         }
     } else {
-        ivcipheralg =3D luks_opts.cipher_alg;
+        luks->ivgen_cipher_alg =3D luks_opts.cipher_alg;
     }
=20
     strcpy(luks->header.cipher_name, cipher_alg);
@@ -1030,7 +1025,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     block->niv =3D qcrypto_cipher_get_iv_len(luks_opts.cipher_alg,
                                            luks_opts.cipher_mode);
     block->ivgen =3D qcrypto_ivgen_new(luks_opts.ivgen_alg,
-                                     ivcipheralg,
+                                     luks->ivgen_cipher_alg,
                                      luks_opts.ivgen_hash_alg,
                                      masterkey, luks->header.master_key_=
len,
                                      errp);
@@ -1183,7 +1178,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     }
=20
     ivgen =3D qcrypto_ivgen_new(luks_opts.ivgen_alg,
-                              ivcipheralg,
+                              luks->ivgen_cipher_alg,
                               luks_opts.ivgen_hash_alg,
                               slotkey, luks->header.master_key_len,
                               errp);
@@ -1294,12 +1289,6 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
=20
-    luks->cipher_alg =3D luks_opts.cipher_alg;
-    luks->cipher_mode =3D luks_opts.cipher_mode;
-    luks->ivgen_alg =3D luks_opts.ivgen_alg;
-    luks->ivgen_hash_alg =3D luks_opts.ivgen_hash_alg;
-    luks->hash_alg =3D luks_opts.hash_alg;
-
     memset(masterkey, 0, luks->header.master_key_len);
     memset(slotkey, 0, luks->header.master_key_len);
=20
--=20
2.17.2


