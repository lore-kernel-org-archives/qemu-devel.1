Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C496ECDE20
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CD5214AE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CD5214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8LNV-00035F-0x
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LEd-00029f-S6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LEc-0005w3-As
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8LEY-0005tn-RC; Thu, 12 Sep 2019 05:17:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2ADA14628B;
 Thu, 12 Sep 2019 09:17:46 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAB7A194B9;
 Thu, 12 Sep 2019 09:17:43 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 12:17:07 +0300
Message-Id: <20190912091710.21449-10-mlevitsk@redhat.com>
In-Reply-To: <20190912091710.21449-1-mlevitsk@redhat.com>
References: <20190912091710.21449-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 12 Sep 2019 09:17:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 09/12] qcrypto-luks: extract check and parse
 header
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

This is just to make qcrypto_block_luks_open more
reasonable in size.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 235 ++++++++++++++++++++++++--------------------
 1 file changed, 127 insertions(+), 108 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index c3f3488222..24c1da3739 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -500,6 +500,129 @@ qcrypto_block_luks_load_header(QCryptoBlock *block,
     return 0;
 }
 
+/*
+ * Does basic sanity checks on the LUKS header
+ */
+static int
+qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
+{
+    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
+               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
+        error_setg(errp, "Volume is not in LUKS format");
+        return -1;
+    }
+
+    if (luks->header.version != QCRYPTO_BLOCK_LUKS_VERSION) {
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
+    g_autofree char *cipher_mode = g_strdup(luks->header.cipher_mode);
+    char *ivgen_name, *ivhash_name;
+    Error *local_err = NULL;
+
+    /*
+     * The cipher_mode header contains a string that we have
+     * to further parse, of the format
+     *
+     *    <cipher-mode>-<iv-generator>[:<iv-hash>]
+     *
+     * eg  cbc-essiv:sha256, cbc-plain64
+     */
+    ivgen_name = strchr(cipher_mode, '-');
+    if (!ivgen_name) {
+        error_setg(errp, "Unexpected cipher mode string format %s",
+                   luks->header.cipher_mode);
+        return -1;
+    }
+    *ivgen_name = '\0';
+    ivgen_name++;
+
+    ivhash_name = strchr(ivgen_name, ':');
+    if (!ivhash_name) {
+        luks->ivgen_hash_alg = 0;
+    } else {
+        *ivhash_name = '\0';
+        ivhash_name++;
+
+        luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
+                                                                   &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+    }
+
+    luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
+                                                              &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+
+    luks->cipher_alg =
+            qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
+                                                  luks->cipher_mode,
+                                                  luks->header.master_key_len,
+                                                  &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+
+    luks->hash_alg =
+            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
+                                                &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+
+    luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
+                                                           &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+
+    if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
+        if (!ivhash_name) {
+            error_setg(errp, "Missing IV generator hash specification");
+            return -1;
+        }
+        luks->ivgen_cipher_alg =
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
+        luks->ivgen_cipher_alg = luks->cipher_alg;
+    }
+    return 0;
+}
+
 /*
  * Given a key slot, and user password, this will attempt to unlock
  * the master encryption key from the key slot.
@@ -712,12 +835,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                         Error **errp)
 {
     QCryptoBlockLUKS *luks = NULL;
-    Error *local_err = NULL;
     int ret = 0;
     g_autofree uint8_t *masterkey = NULL;
-    char *ivgen_name, *ivhash_name;
     g_autofree char *password = NULL;
-    g_autofree char *cipher_mode = NULL;
 
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         if (!options->u.luks.key_secret) {
@@ -741,117 +861,16 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     }
 
 
-    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
-               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
-        error_setg(errp, "Volume is not in LUKS format");
-        ret = -1;
-        goto fail;
-    }
-    if (luks->header.version != QCRYPTO_BLOCK_LUKS_VERSION) {
-        error_setg(errp, "LUKS version %" PRIu32 " is not supported",
-                   luks->header.version);
-        ret = -1;
-        goto fail;
-    }
-
-    cipher_mode = g_strdup(luks->header.cipher_mode);
-
-    /*
-     * The cipher_mode header contains a string that we have
-     * to further parse, of the format
-     *
-     *    <cipher-mode>-<iv-generator>[:<iv-hash>]
-     *
-     * eg  cbc-essiv:sha256, cbc-plain64
-     */
-    ivgen_name = strchr(cipher_mode, '-');
-    if (!ivgen_name) {
-        ret = -1;
-        error_setg(errp, "Unexpected cipher mode string format %s",
-                   cipher_mode);
-        goto fail;
-    }
-    *ivgen_name = '\0';
-    ivgen_name++;
-
-    ivhash_name = strchr(ivgen_name, ':');
-    if (!ivhash_name) {
-        luks->ivgen_hash_alg = 0;
-    } else {
-        *ivhash_name = '\0';
-        ivhash_name++;
-
-        luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
-                                                                   &local_err);
-        if (local_err) {
-            ret = -1;
-            error_propagate(errp, local_err);
-            goto fail;
-        }
-    }
-
-    luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
-                                                              &local_err);
-    if (local_err) {
-        ret = -1;
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-
-    luks->cipher_alg =
-        qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
-                                              luks->cipher_mode,
-                                              luks->header.master_key_len,
-                                              &local_err);
-    if (local_err) {
-        ret = -1;
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-
-    luks->hash_alg =
-            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
-                                                &local_err);
-    if (local_err) {
-        ret = -1;
-        error_propagate(errp, local_err);
+    ret = qcrypto_block_luks_check_header(luks, errp);
+    if (ret < 0) {
         goto fail;
     }
 
-    luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
-                                                           &local_err);
-    if (local_err) {
-        ret = -1;
-        error_propagate(errp, local_err);
+    ret = qcrypto_block_luks_parse_header(luks, errp);
+    if (ret < 0) {
         goto fail;
     }
 
-    if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
-        if (!ivhash_name) {
-            ret = -1;
-            error_setg(errp, "Missing IV generator hash specification");
-            goto fail;
-        }
-        luks->ivgen_cipher_alg =
-                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
-                                                luks->ivgen_hash_alg,
-                                                &local_err);
-        if (local_err) {
-            ret = -1;
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
-        luks->ivgen_cipher_alg = luks->cipher_alg;
-    }
-
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         /* Try to find which key slot our password is valid for
          * and unlock the master key from that slot.
-- 
2.17.2


