Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA53C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344CC2133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344CC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxztJ-0001iU-TA
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznf-0004Er-AU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznd-0004Dw-4I
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxznW-00049J-RT; Wed, 14 Aug 2019 16:23:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CB303067294;
 Wed, 14 Aug 2019 20:23:05 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 065321000321;
 Wed, 14 Aug 2019 20:22:50 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:14 +0300
Message-Id: <20190814202219.1870-9-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 14 Aug 2019 20:23:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 08/13] qcrypto: add the plumbing for encryption
 management
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

This adds qcrypto_block_manage_encryption, which
 is thin wrapper around manage_encryption of the crypto driver
 which is also added

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block.c         | 29 +++++++++++++++++++++++++++++
 crypto/blockpriv.h     |  9 +++++++++
 include/crypto/block.h | 27 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/crypto/block.c b/crypto/block.c
index ee96759f7d..5916e49aba 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+
 #include "blockpriv.h"
 #include "block-qcow.h"
 #include "block-luks.h"
@@ -282,6 +283,34 @@ void qcrypto_block_free(QCryptoBlock *block)
 }
 
 
+int qcrypto_block_setup_encryption(QCryptoBlock *block,
+                                   QCryptoBlockReadFunc readfunc,
+                                   QCryptoBlockWriteFunc writefunc,
+                                   void *opaque,
+                                   enum BlkSetupEncryptionAction action,
+                                   QCryptoEncryptionSetupOptions *options,
+                                   bool force,
+                                   Error **errp)
+{
+    if (!block->driver->setup_encryption) {
+        error_setg(errp,
+                "Crypto format %s doesn't support management of encryption keys",
+                QCryptoBlockFormat_str(block->format));
+        return -1;
+    }
+
+    return block->driver->setup_encryption(block,
+                                           readfunc,
+                                           writefunc,
+                                           opaque,
+                                           action,
+                                           options,
+                                           force,
+                                           errp);
+}
+
+
+
 typedef int (*QCryptoCipherEncDecFunc)(QCryptoCipher *cipher,
                                         const void *in,
                                         void *out,
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 71c59cb542..804965dca3 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -81,6 +81,15 @@ struct QCryptoBlockDriver {
 
     bool (*has_format)(const uint8_t *buf,
                        size_t buflen);
+
+    int (*setup_encryption)(QCryptoBlock *block,
+                            QCryptoBlockReadFunc readfunc,
+                            QCryptoBlockWriteFunc writefunc,
+                            void *opaque,
+                            enum BlkSetupEncryptionAction action,
+                            QCryptoEncryptionSetupOptions *options,
+                            bool force,
+                            Error **errp);
 };
 
 
diff --git a/include/crypto/block.h b/include/crypto/block.h
index fe12899831..60d46e3efc 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -23,6 +23,7 @@
 
 #include "crypto/cipher.h"
 #include "crypto/ivgen.h"
+#include "block/block.h"
 
 typedef struct QCryptoBlock QCryptoBlock;
 
@@ -268,4 +269,30 @@ uint64_t qcrypto_block_get_sector_size(QCryptoBlock *block);
  */
 void qcrypto_block_free(QCryptoBlock *block);
 
+
+/**
+ * qcrypto_block_setup_encryption:
+ * @block: the block encryption object
+ *
+ * @readfunc: callback for reading data from the volume header
+ * @writefunc: callback for writing data to the volume header
+ * @opaque: data to pass to @readfunc and @writefunc
+ * @action: tell the driver the setup action (add/erase currently)
+ * @options: driver specific options, that specify
+ *           what encryption settings to manage
+ * @force: hint for the driver to allow unsafe operation
+ * @errp: error pointer
+ *
+ * Adds/Erases a new encryption key using @options
+ *
+ */
+int qcrypto_block_setup_encryption(QCryptoBlock *block,
+                                   QCryptoBlockReadFunc readfunc,
+                                   QCryptoBlockWriteFunc writefunc,
+                                   void *opaque,
+                                   enum BlkSetupEncryptionAction action,
+                                   QCryptoEncryptionSetupOptions *options,
+                                   bool force,
+                                   Error **errp);
+
 #endif /* QCRYPTO_BLOCK_H */
-- 
2.17.2


