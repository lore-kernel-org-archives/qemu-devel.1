Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C9C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF8C2173E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF8C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FWn-0006kw-DG
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FQ4-0000G0-Oy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FQ3-0007MI-EF
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2FQ0-0007J6-Po; Mon, 26 Aug 2019 09:52:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29588796E6;
 Mon, 26 Aug 2019 13:52:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1B8B5D704;
 Mon, 26 Aug 2019 13:52:21 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 16:51:01 +0300
Message-Id: <20190826135103.22410-12-mlevitsk@redhat.com>
In-Reply-To: <20190826135103.22410-1-mlevitsk@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 26 Aug 2019 13:52:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 11/13] qcrypto-luks: refactoring: simplify
 the math used for keyslot locations
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

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 64 +++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index d713125925..6a43d97ce5 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -409,6 +409,32 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorithm cipher,
     }
 }
 
+/*
+ * Returns number of sectors needed to store the key material
+ * given number of anti forensic stripes
+ */
+static int
+qcrypto_block_luks_splitkeylen_sectors(const QCryptoBlockLUKS *luks,
+                                       unsigned int stripes)
+{
+    /*
+     * This calculation doesn't match that shown in the spec,
+     * but instead follows the cryptsetup implementation.
+     */
+
+    size_t header_sectors = QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
+        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+
+    size_t splitkeylen = luks->header.master_key_len * stripes;
+
+    /* First align the key material size to block size*/
+    size_t splitkeylen_sectors =
+        DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE);
+
+    /* Then also align the key material size to the size of the header */
+    return ROUND_UP(splitkeylen_sectors, header_sectors);
+}
+
 /*
  * Stores the main LUKS header, taking care of endianess
  */
@@ -1151,7 +1177,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     QCryptoBlockCreateOptionsLUKS luks_opts;
     Error *local_err = NULL;
     g_autofree uint8_t *masterkey = NULL;
-    size_t splitkeylen = 0;
+    size_t header_sectors;
+    size_t split_key_sectors;
     size_t i;
     g_autofree char *password;
     const char *cipher_alg;
@@ -1370,37 +1397,28 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
 
+    /* start with the sector that follows the header*/
+    header_sectors = QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
+        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+
+    split_key_sectors =
+        qcrypto_block_luks_splitkeylen_sectors(luks,
+                                               QCRYPTO_BLOCK_LUKS_STRIPES);
 
-    /* Although LUKS has multiple key slots, we're just going
-     * to use the first key slot */
-    splitkeylen = luks->header.master_key_len * QCRYPTO_BLOCK_LUKS_STRIPES;
     for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        luks->header.key_slots[i].active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
-        luks->header.key_slots[i].stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
+        QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[i];
+        slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
 
-        /* This calculation doesn't match that shown in the spec,
-         * but instead follows the cryptsetup implementation.
-         */
-        luks->header.key_slots[i].key_offset_sector =
-            (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-             QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
-            (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE),
-                      (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-                       QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) * i);
+        slot->key_offset_sector = header_sectors + i * split_key_sectors;
+        slot->stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
     }
 
-
     /* The total size of the LUKS headers is the partition header + key
      * slot headers, rounded up to the nearest sector, combined with
      * the size of each master key material region, also rounded up
      * to the nearest sector */
-    luks->header.payload_offset_sector =
-        (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
-        (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE),
-                  (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) *
-         QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+    luks->header.payload_offset_sector = header_sectors +
+            QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
 
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset = luks->header.payload_offset_sector *
-- 
2.17.2


