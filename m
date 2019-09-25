Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03B8C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B22205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B22205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDF5x-0004uz-9F
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDExC-0006To-3h
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDExA-0006MQ-Up
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iDEx8-0006HJ-7K; Wed, 25 Sep 2019 17:36:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 657AE30044CE;
 Wed, 25 Sep 2019 21:36:01 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3953A19C5B;
 Wed, 25 Sep 2019 21:35:53 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/13] qcrypto-luks: pass keyslot index rather that pointer
 to the keyslot
Date: Thu, 26 Sep 2019 00:35:19 +0300
Message-Id: <20190925213527.9117-6-mlevitsk@redhat.com>
In-Reply-To: <20190925213527.9117-1-mlevitsk@redhat.com>
References: <20190925213527.9117-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 25 Sep 2019 21:36:01 +0000 (UTC)
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

Another minor refactoring

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 9e59a791a6..b759cc8d19 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -410,7 +410,7 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorith=
m cipher,
  */
 static int
 qcrypto_block_luks_load_key(QCryptoBlock *block,
-                            QCryptoBlockLUKSKeySlot *slot,
+                            size_t slot_idx,
                             const char *password,
                             QCryptoCipherAlgorithm cipheralg,
                             QCryptoCipherMode ciphermode,
@@ -424,6 +424,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                             Error **errp)
 {
     QCryptoBlockLUKS *luks =3D block->opaque;
+    const QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot=
_idx];
     g_autofree uint8_t *splitkey =3D NULL;
     size_t splitkeylen;
     g_autofree uint8_t *possiblekey =3D NULL;
@@ -580,13 +581,12 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
                             void *opaque,
                             Error **errp)
 {
-    QCryptoBlockLUKS *luks =3D block->opaque;
     size_t i;
     int rv;
=20
     for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         rv =3D qcrypto_block_luks_load_key(block,
-                                         &luks->header.key_slots[i],
+                                         i,
                                          password,
                                          cipheralg,
                                          ciphermode,
--=20
2.17.2


