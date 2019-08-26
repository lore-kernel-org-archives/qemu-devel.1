Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428AFC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157082053B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157082053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FfD-0005Dc-IP
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FQF-0000Ng-30
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FQ6-0007P2-KH
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:52:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2FQ3-0007M0-Jn; Mon, 26 Aug 2019 09:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E94F78666C;
 Mon, 26 Aug 2019 13:52:26 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 812835D6C8;
 Mon, 26 Aug 2019 13:52:24 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 16:51:02 +0300
Message-Id: <20190826135103.22410-13-mlevitsk@redhat.com>
In-Reply-To: <20190826135103.22410-1-mlevitsk@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 26 Aug 2019 13:52:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 12/13] qcrypto-luks: use g_autowipe
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

This patch makes the luks crypto driver use the g_autowipe to erase the master keys,
and the passwords from the memory.

Note that this is not a complete solution, since these keys are also present in the
chipers, and in the secrets.

Some of them still can be erased, at least at driver instance close.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 61 ++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 6a43d97ce5..db0fb764b4 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -32,6 +32,7 @@
 #include "qemu/uuid.h"
 
 #include "qemu/coroutine.h"
+#include "autowipe.h"
 
 /*
  * Reference for the LUKS format implemented here is
@@ -698,19 +699,18 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
 {
     QCryptoBlockLUKS *luks = block->opaque;
     QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
-    g_autofree uint8_t *splitkey = NULL;
+    g_autowipe uint8_t *splitkey = NULL;
     size_t splitkeylen;
-    g_autofree uint8_t *slotkey = NULL;
+    g_autowipe uint8_t *slotkey = NULL;
     g_autoptr(QCryptoCipher) cipher = NULL;
     g_autoptr(QCryptoIVGen) ivgen = NULL;
     Error *local_err = NULL;
     uint64_t iters;
-    int ret = -1;
 
     if (qcrypto_random_bytes(slot->salt,
                              QCRYPTO_BLOCK_LUKS_SALT_LEN,
                              errp) < 0) {
-        goto cleanup;
+        return -1;
     }
 
     splitkeylen = luks->header.master_key_len * slot->stripes;
@@ -728,14 +728,14 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
                                        &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto cleanup;
+        return -1;
     }
 
     if (iters > (ULLONG_MAX / iter_time)) {
         error_setg_errno(errp, ERANGE,
                          "PBKDF iterations %llu too large to scale",
                          (unsigned long long)iters);
-        goto cleanup;
+        return -1;
     }
 
     /* iter_time was in millis, but count_iters reported for secs */
@@ -745,7 +745,7 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
         error_setg_errno(errp, ERANGE,
                          "PBKDF iterations %llu larger than %u",
                          (unsigned long long)iters, UINT32_MAX);
-        goto cleanup;
+        return -1;
     }
 
     slot->iterations =
@@ -764,7 +764,7 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
                        slot->iterations,
                        slotkey, luks->header.master_key_len,
                        errp) < 0) {
-        goto cleanup;
+        return -1;
     }
 
 
@@ -777,7 +777,7 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
                                 slotkey, luks->header.master_key_len,
                                 errp);
     if (!cipher) {
-        goto cleanup;
+        return -1;
     }
 
     ivgen = qcrypto_ivgen_new(luks->ivgen_alg,
@@ -786,7 +786,7 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
                               slotkey, luks->header.master_key_len,
                               errp);
     if (!ivgen) {
-        goto cleanup;
+        return -1;
     }
 
     /*
@@ -802,7 +802,7 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
                                masterkey,
                                splitkey,
                                errp) < 0) {
-        goto cleanup;
+        return -1;
     }
 
     /*
@@ -815,7 +815,7 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
                                             splitkey,
                                             splitkeylen,
                                             errp) < 0) {
-        goto cleanup;
+        return -1;
     }
 
     /* Write out the slot's master key material. */
@@ -825,25 +825,16 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
                   splitkey, splitkeylen,
                   opaque,
                   errp) != splitkeylen) {
-        goto cleanup;
+        return -1;
     }
 
     slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
 
     if (qcrypto_block_luks_store_header(block,  writefunc, opaque, errp)) {
-        goto cleanup;
+        return -1;
     }
 
-    ret = 0;
-
-cleanup:
-    if (slotkey) {
-        memset(slotkey, 0, luks->header.master_key_len);
-    }
-    if (splitkey) {
-        memset(splitkey, 0, splitkeylen);
-    }
-    return ret;
+    return 0;
 }
 
 /*
@@ -868,9 +859,9 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
 {
     QCryptoBlockLUKS *luks = block->opaque;
     const QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
-    g_autofree uint8_t *splitkey = NULL;
+    g_autowipe uint8_t *splitkey = NULL;
     size_t splitkeylen;
-    g_autofree uint8_t *possiblekey = NULL;
+    g_autowipe uint8_t *possiblekey = NULL;
     ssize_t rv;
     g_autoptr(QCryptoCipher) cipher = NULL;
     uint8_t keydigest[QCRYPTO_BLOCK_LUKS_DIGEST_LEN];
@@ -1059,8 +1050,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 {
     QCryptoBlockLUKS *luks = NULL;
     int ret = 0;
-    g_autofree uint8_t *masterkey = NULL;
-    g_autofree char *password = NULL;
+    g_autowipe uint8_t *masterkey = NULL;
+    g_autowipe char *password = NULL;
 
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         if (!options->u.luks.key_secret) {
@@ -1151,6 +1142,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
  fail:
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
+
     g_free(luks);
     return ret;
 }
@@ -1176,11 +1168,11 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     QCryptoBlockLUKS *luks;
     QCryptoBlockCreateOptionsLUKS luks_opts;
     Error *local_err = NULL;
-    g_autofree uint8_t *masterkey = NULL;
+    g_autowipe uint8_t *masterkey = NULL;
     size_t header_sectors;
     size_t split_key_sectors;
     size_t i;
-    g_autofree char *password;
+    g_autowipe char *password;
     const char *cipher_alg;
     const char *cipher_mode;
     const char *ivgen_alg;
@@ -1445,23 +1437,14 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
      }
 
-
-    memset(masterkey, 0, luks->header.master_key_len);
     return 0;
-
  error:
-    if (masterkey) {
-        memset(masterkey, 0, luks->header.master_key_len);
-    }
-
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
-
     g_free(luks);
     return -1;
 }
 
-
 static int qcrypto_block_luks_get_info(QCryptoBlock *block,
                                        QCryptoBlockInfo *info,
                                        Error **errp)
-- 
2.17.2


