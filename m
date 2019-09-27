Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D48AC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020FD206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020FD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqI3-0008O8-W1
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDpvV-0005no-Hu
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDpvS-0004Tn-DF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iDpvR-0004Su-Q2
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C16E53090FDD
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:59:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C2F0608C2;
 Fri, 27 Sep 2019 09:59:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] qcrypto-luks: extract store and load header
Date: Fri, 27 Sep 2019 10:59:22 +0100
Message-Id: <20190927095926.22230-8-berrange@redhat.com>
In-Reply-To: <20190927095926.22230-1-berrange@redhat.com>
References: <20190927095926.22230-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 27 Sep 2019 09:59:42 +0000 (UTC)
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

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 155 ++++++++++++++++++++++++++------------------
 1 file changed, 93 insertions(+), 62 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index b8f9b9c20a..47371edf13 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -409,6 +409,97 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorit=
hm cipher,
     }
 }
=20
+/*
+ * Stores the main LUKS header, taking care of endianess
+ */
+static int
+qcrypto_block_luks_store_header(QCryptoBlock *block,
+                                QCryptoBlockWriteFunc writefunc,
+                                void *opaque,
+                                Error **errp)
+{
+    const QCryptoBlockLUKS *luks =3D block->opaque;
+    Error *local_err =3D NULL;
+    size_t i;
+    g_autofree QCryptoBlockLUKSHeader *hdr_copy =3D NULL;
+
+    /* Create a copy of the header */
+    hdr_copy =3D g_new0(QCryptoBlockLUKSHeader, 1);
+    memcpy(hdr_copy, &luks->header, sizeof(QCryptoBlockLUKSHeader));
+
+    /*
+     * Everything on disk uses Big Endian (tm), so flip header fields
+     * before writing them
+     */
+    cpu_to_be16s(&hdr_copy->version);
+    cpu_to_be32s(&hdr_copy->payload_offset_sector);
+    cpu_to_be32s(&hdr_copy->master_key_len);
+    cpu_to_be32s(&hdr_copy->master_key_iterations);
+
+    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        cpu_to_be32s(&hdr_copy->key_slots[i].active);
+        cpu_to_be32s(&hdr_copy->key_slots[i].iterations);
+        cpu_to_be32s(&hdr_copy->key_slots[i].key_offset_sector);
+        cpu_to_be32s(&hdr_copy->key_slots[i].stripes);
+    }
+
+    /* Write out the partition header and key slot headers */
+    writefunc(block, 0, (const uint8_t *)hdr_copy, sizeof(*hdr_copy),
+              opaque, &local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+    return 0;
+}
+
+/*
+ * Loads the main LUKS header,and byteswaps it to native endianess
+ * And run basic sanity checks on it
+ */
+static int
+qcrypto_block_luks_load_header(QCryptoBlock *block,
+                                QCryptoBlockReadFunc readfunc,
+                                void *opaque,
+                                Error **errp)
+{
+    ssize_t rv;
+    size_t i;
+    QCryptoBlockLUKS *luks =3D block->opaque;
+
+    /*
+     * Read the entire LUKS header, minus the key material from
+     * the underlying device
+     */
+    rv =3D readfunc(block, 0,
+                  (uint8_t *)&luks->header,
+                  sizeof(luks->header),
+                  opaque,
+                  errp);
+    if (rv < 0) {
+        return rv;
+    }
+
+    /*
+     * The header is always stored in big-endian format, so
+     * convert everything to native
+     */
+    be16_to_cpus(&luks->header.version);
+    be32_to_cpus(&luks->header.payload_offset_sector);
+    be32_to_cpus(&luks->header.master_key_len);
+    be32_to_cpus(&luks->header.master_key_iterations);
+
+    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        be32_to_cpus(&luks->header.key_slots[i].active);
+        be32_to_cpus(&luks->header.key_slots[i].iterations);
+        be32_to_cpus(&luks->header.key_slots[i].key_offset_sector);
+        be32_to_cpus(&luks->header.key_slots[i].stripes);
+    }
+
+    return 0;
+}
+
 /*
  * Given a key slot, and user password, this will attempt to unlock
  * the master encryption key from the key slot.
@@ -622,7 +713,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 {
     QCryptoBlockLUKS *luks =3D NULL;
     Error *local_err =3D NULL;
-    size_t i;
     g_autofree uint8_t *masterkey =3D NULL;
     char *ivgen_name, *ivhash_name;
     g_autofree char *password =3D NULL;
@@ -644,30 +734,10 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks =3D g_new0(QCryptoBlockLUKS, 1);
     block->opaque =3D luks;
=20
-    /* Read the entire LUKS header, minus the key material from
-     * the underlying device */
-    if (readfunc(block, 0,
-                 (uint8_t *)&luks->header,
-                 sizeof(luks->header),
-                 opaque,
-                 errp) < 0) {
+    if (qcrypto_block_luks_load_header(block, readfunc, opaque, errp) < =
0) {
         goto fail;
     }
=20
-    /* The header is always stored in big-endian format, so
-     * convert everything to native */
-    be16_to_cpus(&luks->header.version);
-    be32_to_cpus(&luks->header.payload_offset_sector);
-    be32_to_cpus(&luks->header.master_key_len);
-    be32_to_cpus(&luks->header.master_key_iterations);
-
-    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        be32_to_cpus(&luks->header.key_slots[i].active);
-        be32_to_cpus(&luks->header.key_slots[i].iterations);
-        be32_to_cpus(&luks->header.key_slots[i].key_offset_sector);
-        be32_to_cpus(&luks->header.key_slots[i].stripes);
-    }
-
     if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
                QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
         error_setg(errp, "Volume is not in LUKS format");
@@ -1216,46 +1286,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
=20
-    /* Everything on disk uses Big Endian, so flip header fields
-     * before writing them */
-    cpu_to_be16s(&luks->header.version);
-    cpu_to_be32s(&luks->header.payload_offset_sector);
-    cpu_to_be32s(&luks->header.master_key_len);
-    cpu_to_be32s(&luks->header.master_key_iterations);
-
-    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        cpu_to_be32s(&luks->header.key_slots[i].active);
-        cpu_to_be32s(&luks->header.key_slots[i].iterations);
-        cpu_to_be32s(&luks->header.key_slots[i].key_offset_sector);
-        cpu_to_be32s(&luks->header.key_slots[i].stripes);
-    }
-
-
-    /* Write out the partition header and key slot headers */
-    writefunc(block, 0,
-              (const uint8_t *)&luks->header,
-              sizeof(luks->header),
-              opaque,
-              &local_err);
-
-    /* Delay checking local_err until we've byte-swapped */
-
-    /* Byte swap the header back to native, in case we need
-     * to read it again later */
-    be16_to_cpus(&luks->header.version);
-    be32_to_cpus(&luks->header.payload_offset_sector);
-    be32_to_cpus(&luks->header.master_key_len);
-    be32_to_cpus(&luks->header.master_key_iterations);
-
-    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        be32_to_cpus(&luks->header.key_slots[i].active);
-        be32_to_cpus(&luks->header.key_slots[i].iterations);
-        be32_to_cpus(&luks->header.key_slots[i].key_offset_sector);
-        be32_to_cpus(&luks->header.key_slots[i].stripes);
-    }
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (qcrypto_block_luks_store_header(block,  writefunc, opaque, errp)=
 < 0) {
         goto error;
     }
=20
--=20
2.21.0


