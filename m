Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6396C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B64020679
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B64020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FeM-00040O-8i
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FPo-0008R2-NN
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FPl-00070e-Bt
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2FPc-0006oc-Lr; Mon, 26 Aug 2019 09:52:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 591FB86679;
 Mon, 26 Aug 2019 13:51:59 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 727585D6C8;
 Mon, 26 Aug 2019 13:51:42 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 16:50:55 +0300
Message-Id: <20190826135103.22410-6-mlevitsk@redhat.com>
In-Reply-To: <20190826135103.22410-1-mlevitsk@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 26 Aug 2019 13:51:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 05/13] qcrypto-luks: simplify masterkey and
 masterkey length
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let the caller allocate masterkey
Always use master key len from the header

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index e9ae3f6baa..331377293d 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -419,7 +419,6 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                             QCryptoCipherAlgorithm ivcipheralg,
                             QCryptoHashAlgorithm ivhash,
                             uint8_t *masterkey,
-                            size_t masterkeylen,
                             QCryptoBlockReadFunc readfunc,
                             void *opaque,
                             Error **errp)
@@ -438,9 +437,9 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
         return 0;
     }
 
-    splitkeylen = masterkeylen * slot->stripes;
+    splitkeylen = luks->header.master_key_len * slot->stripes;
     splitkey = g_new0(uint8_t, splitkeylen);
-    possiblekey = g_new0(uint8_t, masterkeylen);
+    possiblekey = g_new0(uint8_t, luks->header.master_key_len);
 
     /*
      * The user password is used to generate a (possible)
@@ -453,7 +452,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                        (const uint8_t *)password, strlen(password),
                        slot->salt, QCRYPTO_BLOCK_LUKS_SALT_LEN,
                        slot->iterations,
-                       possiblekey, masterkeylen,
+                       possiblekey, luks->header.master_key_len,
                        errp) < 0) {
         return -1;
     }
@@ -478,7 +477,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
     /* Setup the cipher/ivgen that we'll use to try to decrypt
      * the split master key material */
     cipher = qcrypto_cipher_new(cipheralg, ciphermode,
-                                possiblekey, masterkeylen,
+                                possiblekey, luks->header.master_key_len,
                                 errp);
     if (!cipher) {
         return -1;
@@ -489,7 +488,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
     ivgen = qcrypto_ivgen_new(ivalg,
                               ivcipheralg,
                               ivhash,
-                              possiblekey, masterkeylen,
+                              possiblekey, luks->header.master_key_len,
                               errp);
     if (!ivgen) {
         return -1;
@@ -519,7 +518,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * it back together to get the actual master key.
      */
     if (qcrypto_afsplit_decode(hash,
-                               masterkeylen,
+                               luks->header.master_key_len,
                                slot->stripes,
                                splitkey,
                                masterkey,
@@ -537,11 +536,13 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * header
      */
     if (qcrypto_pbkdf2(hash,
-                       masterkey, masterkeylen,
+                       masterkey,
+                       luks->header.master_key_len,
                        luks->header.master_key_salt,
                        QCRYPTO_BLOCK_LUKS_SALT_LEN,
                        luks->header.master_key_iterations,
-                       keydigest, G_N_ELEMENTS(keydigest),
+                       keydigest,
+                       G_N_ELEMENTS(keydigest),
                        errp) < 0) {
         return -1;
     }
@@ -574,8 +575,7 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
                             QCryptoIVGenAlgorithm ivalg,
                             QCryptoCipherAlgorithm ivcipheralg,
                             QCryptoHashAlgorithm ivhash,
-                            uint8_t **masterkey,
-                            size_t *masterkeylen,
+                            uint8_t *masterkey,
                             QCryptoBlockReadFunc readfunc,
                             void *opaque,
                             Error **errp)
@@ -584,9 +584,6 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
     size_t i;
     int rv;
 
-    *masterkey = g_new0(uint8_t, luks->header.master_key_len);
-    *masterkeylen = luks->header.master_key_len;
-
     for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         rv = qcrypto_block_luks_load_key(block,
                                          &luks->header.key_slots[i],
@@ -597,8 +594,7 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
                                          ivalg,
                                          ivcipheralg,
                                          ivhash,
-                                         *masterkey,
-                                         *masterkeylen,
+                                         masterkey,
                                          readfunc,
                                          opaque,
                                          errp);
@@ -613,9 +609,6 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
     error_setg(errp, "Invalid password, cannot unlock any keyslot");
 
  error:
-    g_free(*masterkey);
-    *masterkey = NULL;
-    *masterkeylen = 0;
     return -1;
 }
 
@@ -636,7 +629,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     size_t i;
     ssize_t rv;
     g_autofree uint8_t *masterkey = NULL;
-    size_t masterkeylen;
     char *ivgen_name, *ivhash_name;
     QCryptoCipherMode ciphermode;
     QCryptoCipherAlgorithm cipheralg;
@@ -802,6 +794,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         /* Try to find which key slot our password is valid for
          * and unlock the master key from that slot.
          */
+
+        masterkey = g_new0(uint8_t, luks->header.master_key_len);
+
         if (qcrypto_block_luks_find_key(block,
                                         password,
                                         cipheralg, ciphermode,
@@ -809,7 +804,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                         ivalg,
                                         ivcipheralg,
                                         ivhash,
-                                        &masterkey, &masterkeylen,
+                                        masterkey,
                                         readfunc, opaque,
                                         errp) < 0) {
             ret = -EACCES;
@@ -825,7 +820,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         block->ivgen = qcrypto_ivgen_new(ivalg,
                                          ivcipheralg,
                                          ivhash,
-                                         masterkey, masterkeylen,
+                                         masterkey,
+                                         luks->header.master_key_len,
                                          errp);
         if (!block->ivgen) {
             ret = -ENOTSUP;
@@ -833,7 +829,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         }
 
         ret = qcrypto_block_init_cipher(block, cipheralg, ciphermode,
-                                        masterkey, masterkeylen, n_threads,
+                                        masterkey,
+                                        luks->header.master_key_len,
+                                        n_threads,
                                         errp);
         if (ret < 0) {
             ret = -ENOTSUP;
-- 
2.17.2


