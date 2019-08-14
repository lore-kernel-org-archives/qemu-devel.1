Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75AAC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F776214C6
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F776214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxzwT-0005IW-Tn
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznN-00049C-2D
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznL-00042S-7T
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxznA-0003uv-Jz; Wed, 14 Aug 2019 16:22:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83BDA30BA1C9;
 Wed, 14 Aug 2019 20:22:42 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A6F210002BA;
 Wed, 14 Aug 2019 20:22:39 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:11 +0300
Message-Id: <20190814202219.1870-6-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 14 Aug 2019 20:22:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 05/13] qcrypto-luks: clear the masterkey and
 password before freeing them always
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

While there are other places where these are still stored in memory,
this is still one less key material area that can be sniffed with
various side channel attacks



Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 52 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index e1a4df94b7..336e633df4 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1023,8 +1023,18 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
  cleanup:
     qcrypto_ivgen_free(ivgen);
     qcrypto_cipher_free(cipher);
-    g_free(splitkey);
-    g_free(possiblekey);
+
+    if (splitkey) {
+        memset(splitkey, 0, splitkeylen);
+        g_free(splitkey);
+    }
+
+    if (possiblekey) {
+        memset(possiblekey, 0, masterkeylen(luks));
+        g_free(possiblekey);
+
+    }
+
     return ret;
 }
 
@@ -1161,16 +1171,34 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset = luks->header.payload_offset * block->sector_size;
 
-    g_free(masterkey);
-    g_free(password);
+    if (masterkey) {
+        memset(masterkey, 0, masterkeylen(luks));
+        g_free(masterkey);
+    }
+
+    if (password) {
+        memset(password, 0, strlen(password));
+        g_free(password);
+    }
+
     return 0;
 
  fail:
-    g_free(masterkey);
+
+    if (masterkey) {
+        memset(masterkey, 0, masterkeylen(luks));
+        g_free(masterkey);
+    }
+
+    if (password) {
+        memset(password, 0, strlen(password));
+        g_free(password);
+    }
+
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
+
     g_free(luks);
-    g_free(password);
     return ret;
 }
 
@@ -1459,7 +1487,10 @@ qcrypto_block_luks_create(QCryptoBlock *block,
 
     memset(masterkey, 0, luks->header.key_bytes);
     g_free(masterkey);
+
+    memset(password, 0, strlen(password));
     g_free(password);
+
     g_free(cipher_mode_spec);
 
     return 0;
@@ -1467,9 +1498,14 @@ qcrypto_block_luks_create(QCryptoBlock *block,
  error:
     if (masterkey) {
         memset(masterkey, 0, luks->header.key_bytes);
+        g_free(masterkey);
     }
-    g_free(masterkey);
-    g_free(password);
+
+    if (password) {
+        memset(password, 0, strlen(password));
+        g_free(password);
+    }
+
     g_free(cipher_mode_spec);
 
     qcrypto_block_free_cipher(block);
-- 
2.17.2


