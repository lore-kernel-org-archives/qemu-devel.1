Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBA6C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970692133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970692133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxztD-0001X4-Fo
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznL-00047k-8C
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznI-00040d-Oe
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxzn7-0003sq-67; Wed, 14 Aug 2019 16:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B38F5317464A;
 Wed, 14 Aug 2019 20:22:39 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 515541000321;
 Wed, 14 Aug 2019 20:22:37 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:10 +0300
Message-Id: <20190814202219.1870-5-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 14 Aug 2019 20:22:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 04/13] qcrypto-luks: refactoring: simplify the
 math used for keyslot locations
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
 crypto/block-luks.c | 64 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 6bb369f3b4..e1a4df94b7 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -417,6 +417,33 @@ static int masterkeylen(QCryptoBlockLUKS *luks)
 }
 
 
+/*
+ * Returns number of sectors needed to store the key material
+ * given number of anti forensic stripes
+ */
+static int splitkeylen_sectors(QCryptoBlockLUKS *luks, int stripes)
+
+{
+    /*
+     * This calculation doesn't match that shown in the spec,
+     * but instead follows the cryptsetup implementation.
+     */
+
+    size_t header_sectors = QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
+                     QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+
+    size_t splitkeylen = masterkeylen(luks) * stripes;
+
+    /* First align the key material size to block size*/
+    size_t splitkeylen_sectors =
+            DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE);
+
+    /* Then also align the key material size to the size of the header */
+    return ROUND_UP(splitkeylen_sectors, header_sectors);
+}
+
+
+
 /*
  * Stores the main LUKS header, taking care of endianess
  */
@@ -1169,7 +1196,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     QCryptoBlockCreateOptionsLUKS luks_opts;
     Error *local_err = NULL;
     uint8_t *masterkey = NULL;
-    size_t splitkeylen = 0;
+    size_t next_sector;
     size_t i;
     char *password;
     const char *cipher_alg;
@@ -1388,23 +1415,16 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
 
+    /* start with the sector that follows the header*/
+    next_sector = QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
+                  QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
 
-    /* Although LUKS has multiple key slots, we're just going
-     * to use the first key slot */
-    splitkeylen = luks->header.key_bytes * QCRYPTO_BLOCK_LUKS_STRIPES;
     for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        luks->header.key_slots[i].active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
-        luks->header.key_slots[i].stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
-
-        /* This calculation doesn't match that shown in the spec,
-         * but instead follows the cryptsetup implementation.
-         */
-        luks->header.key_slots[i].key_offset =
-            (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-             QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
-            (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE),
-                      (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-                       QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) * i);
+        QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[i];
+        slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
+        slot->key_offset = next_sector;
+        slot->stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
+        next_sector += splitkeylen_sectors(luks, QCRYPTO_BLOCK_LUKS_STRIPES);
     }
 
 
@@ -1412,17 +1432,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
      * slot headers, rounded up to the nearest sector, combined with
      * the size of each master key material region, also rounded up
      * to the nearest sector */
-    luks->header.payload_offset =
-        (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
-        (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE),
-                  (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) *
-         QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
-
+    luks->header.payload_offset = next_sector;
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
-    block->payload_offset = luks->header.payload_offset *
-        block->sector_size;
+    block->payload_offset = luks->header.payload_offset * block->sector_size;
 
     /* Reserve header space to match payload offset */
     initfunc(block, block->payload_offset, opaque, &local_err);
-- 
2.17.2


