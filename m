Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE97C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504D2205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504D2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDF5R-0004VM-OR
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDEyE-0006z3-Vn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDEy7-0006ul-Tm
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iDExq-0006eW-UI; Wed, 25 Sep 2019 17:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CDDA8553A;
 Wed, 25 Sep 2019 21:36:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F4C519C5B;
 Wed, 25 Sep 2019 21:36:27 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/13] qcrypto-luks: more rigorous header checking
Date: Thu, 26 Sep 2019 00:35:26 +0300
Message-Id: <20190925213527.9117-13-mlevitsk@redhat.com>
In-Reply-To: <20190925213527.9117-1-mlevitsk@redhat.com>
References: <20190925213527.9117-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 25 Sep 2019 21:36:30 +0000 (UTC)
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

Check that keyslots don't overlap with the data,
and check that keyslots don't overlap with each other.
(this is done using naive O(n^2) nested loops,
but since there are just 8 keyslots, this doesn't really matter.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index a53d5d1916..4861db810c 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -530,6 +530,11 @@ qcrypto_block_luks_load_header(QCryptoBlock *block,
 static int
 qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **er=
rp)
 {
+    size_t i, j;
+
+    unsigned int header_sectors =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
+        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+
     if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
                QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
         error_setg(errp, "Volume is not in LUKS format");
@@ -541,6 +546,53 @@ qcrypto_block_luks_check_header(const QCryptoBlockLU=
KS *luks, Error **errp)
                    luks->header.version);
         return -1;
     }
+
+    /* Check all keyslots for corruption  */
+    for (i =3D 0 ; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; i++) {
+
+        const QCryptoBlockLUKSKeySlot *slot1 =3D &luks->header.key_slots=
[i];
+        unsigned int start1 =3D slot1->key_offset_sector;
+        unsigned int len1 =3D
+            qcrypto_block_luks_splitkeylen_sectors(luks,
+                                                   header_sectors,
+                                                   slot1->stripes);
+
+        if (slot1->stripes =3D=3D 0) {
+            error_setg(errp, "Keyslot %zu is corrupted (stripes =3D=3D 0=
)", i);
+            return -1;
+        }
+
+        if (slot1->active !=3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED &&
+            slot1->active !=3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED) {
+            error_setg(errp,
+                       "Keyslot %zu state (active/disable) is corrupted"=
, i);
+            return -1;
+        }
+
+        if (start1 + len1 > luks->header.payload_offset_sector) {
+            error_setg(errp,
+                       "Keyslot %zu is overlapping with the encrypted pa=
yload",
+                       i);
+            return -1;
+        }
+
+        for (j =3D i + 1 ; j < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; j++) {
+            const QCryptoBlockLUKSKeySlot *slot2 =3D &luks->header.key_s=
lots[j];
+            unsigned int start2 =3D slot2->key_offset_sector;
+            unsigned int len2 =3D
+                qcrypto_block_luks_splitkeylen_sectors(luks,
+                                                       header_sectors,
+                                                       slot2->stripes);
+
+            if (start1 + len1 > start2 && start2 + len2 > start1) {
+                error_setg(errp,
+                           "Keyslots %zu and %zu are overlapping in the =
header",
+                           i, j);
+                return -1;
+            }
+        }
+
+    }
     return 0;
 }
=20
--=20
2.17.2


