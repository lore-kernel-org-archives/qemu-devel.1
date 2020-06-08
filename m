Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76235C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD0A206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URMga0c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD0A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEJu-0002L4-DF
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jiEGp-0005u6-Cu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:40:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jiEGo-00023p-Ao
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591609241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/x2yp1Zom7TibLzciJu4Stg8OPWQzuVY8t0Vy7LY2k=;
 b=URMga0c5j1UEKuF6kMsRM8Q2eIgCBZe6lEhMigHg+9WqCXcD42seBqsdYxlhgk+RFIPSuf
 tXEvVZy6B2RQrjy2EyvyCsEFw0AwGVlBBkkMA0RqOjZsD+s4PAdJ2WGdOxZUSNcTuluq0U
 66XcnpcEM8ZX9h24avwbRkIKWIgP/7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-l094Qc-tOWe5fdZm-x8PqQ-1; Mon, 08 Jun 2020 05:40:39 -0400
X-MC-Unique: l094Qc-tOWe5fdZm-x8PqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D23C1940925;
 Mon,  8 Jun 2020 09:40:38 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0268D1CA;
 Mon,  8 Jun 2020 09:40:35 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 01/14] qcrypto/core: add generic infrastructure for crypto
 options amendment
Date: Mon,  8 Jun 2020 12:40:17 +0300
Message-Id: <20200608094030.670121-2-mlevitsk@redhat.com>
In-Reply-To: <20200608094030.670121-1-mlevitsk@redhat.com>
References: <20200608094030.670121-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

This will be used first to implement luks keyslot management.

block_crypto_amend_opts_init will be used to convert
qemu-img cmdline to QCryptoBlockAmendOptions

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/crypto.c         | 17 +++++++++++++++++
 block/crypto.h         |  3 +++
 crypto/block.c         | 29 +++++++++++++++++++++++++++++
 crypto/blockpriv.h     |  8 ++++++++
 include/crypto/block.h | 22 ++++++++++++++++++++++
 qapi/crypto.json       | 16 ++++++++++++++++
 6 files changed, 95 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 973b57b3eb..dcf8b42bb2 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -202,6 +202,23 @@ block_crypto_create_opts_init(QDict *opts, Error **errp)
     return ret;
 }
 
+QCryptoBlockAmendOptions *
+block_crypto_amend_opts_init(QDict *opts, Error **errp)
+{
+    Visitor *v;
+    QCryptoBlockAmendOptions *ret;
+
+    v = qobject_input_visitor_new_flat_confused(opts, errp);
+    if (!v) {
+        return NULL;
+    }
+
+    visit_type_QCryptoBlockAmendOptions(v, NULL, &ret, errp);
+
+    visit_free(v);
+    return ret;
+}
+
 
 static int block_crypto_open_generic(QCryptoBlockFormat format,
                                      QemuOptsList *opts_spec,
diff --git a/block/crypto.h b/block/crypto.h
index b935695e79..06e044c9be 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -91,6 +91,9 @@
 QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QDict *opts, Error **errp);
 
+QCryptoBlockAmendOptions *
+block_crypto_amend_opts_init(QDict *opts, Error **errp);
+
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QDict *opts, Error **errp);
 
diff --git a/crypto/block.c b/crypto/block.c
index 6f42b32f1e..eb057948b5 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -150,6 +150,35 @@ qcrypto_block_calculate_payload_offset(QCryptoBlockCreateOptions *create_opts,
     return crypto != NULL;
 }
 
+int qcrypto_block_amend_options(QCryptoBlock *block,
+                                QCryptoBlockReadFunc readfunc,
+                                QCryptoBlockWriteFunc writefunc,
+                                void *opaque,
+                                QCryptoBlockAmendOptions *options,
+                                bool force,
+                                Error **errp)
+{
+    if (options->format != block->format) {
+        error_setg(errp,
+                   "Cannot amend encryption format");
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
 
 QCryptoBlockInfo *qcrypto_block_get_info(QCryptoBlock *block,
                                          Error **errp)
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 71c59cb542..3c7ccea504 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -62,6 +62,14 @@ struct QCryptoBlockDriver {
                   void *opaque,
                   Error **errp);
 
+    int (*amend)(QCryptoBlock *block,
+                 QCryptoBlockReadFunc readfunc,
+                 QCryptoBlockWriteFunc writefunc,
+                 void *opaque,
+                 QCryptoBlockAmendOptions *options,
+                 bool force,
+                 Error **errp);
+
     int (*get_info)(QCryptoBlock *block,
                     QCryptoBlockInfo *info,
                     Error **errp);
diff --git a/include/crypto/block.h b/include/crypto/block.h
index c77ccaf9c0..d274819791 100644
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
+                                QCryptoBlockAmendOptions *options,
+                                bool force,
+                                Error **errp);
+
 
 /**
  * qcrypto_block_calculate_payload_offset:
diff --git a/qapi/crypto.json b/qapi/crypto.json
index b2a4cff683..aeb6c7ef7b 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -309,3 +309,19 @@
   'base': 'QCryptoBlockInfoBase',
   'discriminator': 'format',
   'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
+
+
+
+##
+# @QCryptoBlockAmendOptions:
+#
+# The options that are available for all encryption formats
+# when amending encryption settings
+#
+# Since: 5.1
+##
+{ 'union': 'QCryptoBlockAmendOptions',
+  'base': 'QCryptoBlockOptionsBase',
+  'discriminator': 'format',
+  'data': {
+            } }
-- 
2.25.4


