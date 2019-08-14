Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC359C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37D72133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37D72133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxzpE-0005sU-CJ
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxzn1-0003uc-5K
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxzn0-0003or-5d
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxzmx-0003ld-Ic; Wed, 14 Aug 2019 16:22:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9BFC31CD7A;
 Wed, 14 Aug 2019 20:22:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 674B410016EB;
 Wed, 14 Aug 2019 20:22:28 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:07 +0300
Message-Id: <20190814202219.1870-2-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 14 Aug 2019 20:22:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 01/13] block-crypto: misc refactoring
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

* rename the write_func to create_write_func,
  and init_func to create_init_func
  this is  preparation for other write_func that will
  be used to update the encryption keys.

No functional changes

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/crypto.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 8237424ae6..42a3f0898b 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -51,7 +51,6 @@ static int block_crypto_probe_generic(QCryptoBlockFormat format,
     }
 }
 
-
 static ssize_t block_crypto_read_func(QCryptoBlock *block,
                                       size_t offset,
                                       uint8_t *buf,
@@ -77,7 +76,7 @@ struct BlockCryptoCreateData {
 };
 
 
-static ssize_t block_crypto_write_func(QCryptoBlock *block,
+static ssize_t block_crypto_create_write_func(QCryptoBlock *block,
                                        size_t offset,
                                        const uint8_t *buf,
                                        size_t buflen,
@@ -95,8 +94,7 @@ static ssize_t block_crypto_write_func(QCryptoBlock *block,
     return ret;
 }
 
-
-static ssize_t block_crypto_init_func(QCryptoBlock *block,
+static ssize_t block_crypto_create_init_func(QCryptoBlock *block,
                                       size_t headerlen,
                                       void *opaque,
                                       Error **errp)
@@ -108,7 +106,8 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
         return -EFBIG;
     }
 
-    /* User provided size should reflect amount of space made
+    /*
+     * User provided size should reflect amount of space made
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
@@ -117,6 +116,8 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
 }
 
 
+
+
 static QemuOptsList block_crypto_runtime_opts_luks = {
     .name = "crypto",
     .head = QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.head),
@@ -272,8 +273,8 @@ static int block_crypto_co_create_generic(BlockDriverState *bs,
     };
 
     crypto = qcrypto_block_create(opts, NULL,
-                                  block_crypto_init_func,
-                                  block_crypto_write_func,
+                                  block_crypto_create_init_func,
+                                  block_crypto_create_write_func,
                                   &data,
                                   errp);
 
-- 
2.17.2


