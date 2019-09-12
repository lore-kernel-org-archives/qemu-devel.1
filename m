Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9877C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05C52084F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05C52084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8LPy-0006ON-FC
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LEk-0002H7-GN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LEj-000614-9Q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8LEg-0005yo-Bz; Thu, 12 Sep 2019 05:17:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFAEE8A1C90;
 Thu, 12 Sep 2019 09:17:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F1391C92A;
 Thu, 12 Sep 2019 09:17:48 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 12:17:09 +0300
Message-Id: <20190912091710.21449-12-mlevitsk@redhat.com>
In-Reply-To: <20190912091710.21449-1-mlevitsk@redhat.com>
References: <20190912091710.21449-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 12 Sep 2019 09:17:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 11/12] qcrypto-luks: simplify the math used for
 keyslot locations
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

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 63 ++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index c6045da33e..0d155c6614 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -409,6 +409,30 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorit=
hm cipher,
     }
 }
=20
+/*
+ * Returns number of sectors needed to store the key material
+ * given number of anti forensic stripes
+ */
+static int
+qcrypto_block_luks_splitkeylen_sectors(const QCryptoBlockLUKS *luks,
+                                       unsigned int header_sectors,
+                                       unsigned int stripes)
+{
+    /*
+     * This calculation doesn't match that shown in the spec,
+     * but instead follows the cryptsetup implementation.
+     */
+
+    size_t splitkeylen =3D luks->header.master_key_len * stripes;
+
+    /* First align the key material size to block size*/
+    size_t splitkeylen_sectors =3D
+        DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE);
+
+    /* Then also align the key material size to the size of the header *=
/
+    return ROUND_UP(splitkeylen_sectors, header_sectors);
+}
+
 /*
  * Stores the main LUKS header, taking care of endianess
  */
@@ -1124,7 +1148,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     QCryptoBlockCreateOptionsLUKS luks_opts;
     Error *local_err =3D NULL;
     g_autofree uint8_t *masterkey =3D NULL;
-    size_t splitkeylen =3D 0;
+    size_t header_sectors;
+    size_t split_key_sectors;
     size_t i;
     g_autofree char *password =3D NULL;
     const char *cipher_alg;
@@ -1343,37 +1368,29 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
=20
+    /* start with the sector that follows the header*/
+    header_sectors =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
+        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+
+    split_key_sectors =3D
+        qcrypto_block_luks_splitkeylen_sectors(luks,
+                                               header_sectors,
+                                               QCRYPTO_BLOCK_LUKS_STRIPE=
S);
=20
-    /* Although LUKS has multiple key slots, we're just going
-     * to use the first key slot */
-    splitkeylen =3D luks->header.master_key_len * QCRYPTO_BLOCK_LUKS_STR=
IPES;
     for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        luks->header.key_slots[i].active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT=
_DISABLED;
-        luks->header.key_slots[i].stripes =3D QCRYPTO_BLOCK_LUKS_STRIPES=
;
+        QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[i];
+        slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
=20
-        /* This calculation doesn't match that shown in the spec,
-         * but instead follows the cryptsetup implementation.
-         */
-        luks->header.key_slots[i].key_offset_sector =3D
-            (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-             QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
-            (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTO=
R_SIZE),
-                      (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-                       QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) * i);
+        slot->key_offset_sector =3D header_sectors + i * split_key_secto=
rs;
+        slot->stripes =3D QCRYPTO_BLOCK_LUKS_STRIPES;
     }
=20
-
     /* The total size of the LUKS headers is the partition header + key
      * slot headers, rounded up to the nearest sector, combined with
      * the size of each master key material region, also rounded up
      * to the nearest sector */
-    luks->header.payload_offset_sector =3D
-        (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
-        (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SI=
ZE),
-                  (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
-                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) *
-         QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+    luks->header.payload_offset_sector =3D header_sectors +
+            QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
=20
     block->sector_size =3D QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset =3D luks->header.payload_offset_sector *
--=20
2.17.2


