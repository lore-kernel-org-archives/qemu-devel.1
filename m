Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46735C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 20:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1859923429
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 20:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1859923429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3nza-0004hU-1p
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 16:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwV-0002y5-AB
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwU-0001J9-1l
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i3nwR-0001Gd-L0; Fri, 30 Aug 2019 16:56:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E10293001836;
 Fri, 30 Aug 2019 20:56:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 932485D9CA;
 Fri, 30 Aug 2019 20:56:16 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 23:55:59 +0300
Message-Id: <20190830205608.18192-2-mlevitsk@redhat.com>
In-Reply-To: <20190830205608.18192-1-mlevitsk@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 30 Aug 2019 20:56:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 01/10] qcrypto: add suport for amend options
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds the qcrypto_amend_options and corresponding
crypto driver callbacks for the  for encrypted
key managedment

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block.c         | 31 +++++++++++++++++++++++++++++++
 crypto/blockpriv.h     |  8 ++++++++
 include/crypto/block.h | 22 ++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/crypto/block.c b/crypto/block.c
index 325752871c..14b684de7f 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -115,6 +115,37 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
 }
 
 
+int qcrypto_block_amend_options(QCryptoBlock *block,
+                                QCryptoBlockReadFunc readfunc,
+                                QCryptoBlockWriteFunc writefunc,
+                                void *opaque,
+                                QCryptoBlockCreateOptions *options,
+                                bool force,
+                                Error **errp)
+{
+    if (options->format != block->format) {
+        error_setg(errp,
+                   "Its not possible to change encryption format with amend interface");
+        return -1;
+    }
+
+    if (!block->driver->amend) {
+        error_setg(errp,
+                   "Crypto format %s doesn't support format options amendment",
+                   QCryptoBlockFormat_str(block->format));
+        return -1;
+    }
+
+    return block->driver->amend(block,
+                                readfunc,
+                                writefunc,
+                                opaque,
+                                options,
+                                force,
+                                errp);
+}
+
+
 QCryptoBlockInfo *qcrypto_block_get_info(QCryptoBlock *block,
                                          Error **errp)
 {
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 71c59cb542..c18a4e0b43 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -62,6 +62,14 @@ struct QCryptoBlockDriver {
                   void *opaque,
                   Error **errp);
 
+    int (*amend)(QCryptoBlock *block,
+                 QCryptoBlockReadFunc readfunc,
+                 QCryptoBlockWriteFunc writefunc,
+                 void *opaque,
+                 QCryptoBlockCreateOptions *options,
+                 bool force,
+                 Error **errp);
+
     int (*get_info)(QCryptoBlock *block,
                     QCryptoBlockInfo *info,
                     Error **errp);
diff --git a/include/crypto/block.h b/include/crypto/block.h
index d49d2c2da9..777fd51ebe 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -144,6 +144,28 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
                                    void *opaque,
                                    Error **errp);
 
+/**
+ * qcrypto_block_amend_options:
+ * @block: the block encryption object
+ *
+ * @readfunc: callback for reading data from the volume header
+ * @writefunc: callback for writing data to the volume header
+ * @opaque: data to pass to @readfunc and @writefunc
+ * @options: the new/amended encryption options
+ * @force: hint for the driver to allow unsafe operation
+ * @errp: error pointer
+ *
+ * Changes the crypto options of the encryption format
+ *
+ */
+int qcrypto_block_amend_options(QCryptoBlock *block,
+                                QCryptoBlockReadFunc readfunc,
+                                QCryptoBlockWriteFunc writefunc,
+                                void *opaque,
+                                QCryptoBlockCreateOptions *options,
+                                bool force,
+                                Error **errp);
+
 
 /**
  * qcrypto_block_get_info:
-- 
2.17.2


