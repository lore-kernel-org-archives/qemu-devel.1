Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5548DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E5520674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sws+PYIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E5520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDeW-0000UD-9b
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdH-0007Ai-HL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdG-0006bs-6v
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55547
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixDdG-0006ZM-2o
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580405373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4mD2j69lZMc/286pLcPBYvxejRLX142BSHlfkTXC/0=;
 b=Sws+PYIf0s/0KDurM8wYnCOGJ6cwHfq6KyF1hK0XBgTAypJMy9f5rAk33MBH1F4NVAmz2U
 n+rWpXFsJUjRugITIHptcYMp8VeCNwjaDAQpTQER2Rvr2AxN81QHspBQyQsoVZbp7c2J0x
 K2i0bMw75yCyxfE7f86g/KxK02p16M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-T1nu9StjMUGNfNMpxSUK5g-1; Thu, 30 Jan 2020 12:29:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAC18107ACC5;
 Thu, 30 Jan 2020 17:29:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 719E55D9E5;
 Thu, 30 Jan 2020 17:29:26 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/14] qcrypto/core: add generic infrastructure for crypto
 options amendment
Date: Thu, 30 Jan 2020 19:29:06 +0200
Message-Id: <20200130172919.13424-2-mlevitsk@redhat.com>
In-Reply-To: <20200130172919.13424-1-mlevitsk@redhat.com>
References: <20200130172919.13424-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: T1nu9StjMUGNfNMpxSUK5g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c         | 17 +++++++++++++++++
 block/crypto.h         |  3 +++
 crypto/block.c         | 31 +++++++++++++++++++++++++++++++
 crypto/blockpriv.h     |  8 ++++++++
 include/crypto/block.h | 22 ++++++++++++++++++++++
 qapi/crypto.json       | 16 ++++++++++++++++
 6 files changed, 97 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 24823835c1..ecf96a7a9b 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -184,6 +184,23 @@ block_crypto_create_opts_init(QDict *opts, Error **err=
p)
     return ret;
 }
=20
+QCryptoBlockAmendOptions *
+block_crypto_amend_opts_init(QDict *opts, Error **errp)
+{
+    Visitor *v;
+    QCryptoBlockAmendOptions *ret;
+
+    v =3D qobject_input_visitor_new_flat_confused(opts, errp);
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
=20
 static int block_crypto_open_generic(QCryptoBlockFormat format,
                                      QemuOptsList *opts_spec,
diff --git a/block/crypto.h b/block/crypto.h
index b935695e79..06e044c9be 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -91,6 +91,9 @@
 QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QDict *opts, Error **errp);
=20
+QCryptoBlockAmendOptions *
+block_crypto_amend_opts_init(QDict *opts, Error **errp);
+
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QDict *opts, Error **errp);
=20
diff --git a/crypto/block.c b/crypto/block.c
index 325752871c..0ce67db641 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -115,6 +115,37 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateO=
ptions *options,
 }
=20
=20
+int qcrypto_block_amend_options(QCryptoBlock *block,
+                                QCryptoBlockReadFunc readfunc,
+                                QCryptoBlockWriteFunc writefunc,
+                                void *opaque,
+                                QCryptoBlockAmendOptions *options,
+                                bool force,
+                                Error **errp)
+{
+    if (options->format !=3D block->format) {
+        error_setg(errp,
+                   "Cannot amend encryption format");
+        return -1;
+    }
+
+    if (!block->driver->amend) {
+        error_setg(errp,
+                   "Crypto format %s doesn't support format options amendm=
ent",
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
index 71c59cb542..3c7ccea504 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -62,6 +62,14 @@ struct QCryptoBlockDriver {
                   void *opaque,
                   Error **errp);
=20
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
index d49d2c2da9..e4553cf33d 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -144,6 +144,28 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateO=
ptions *options,
                                    void *opaque,
                                    Error **errp);
=20
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
=20
 /**
  * qcrypto_block_get_info:
diff --git a/qapi/crypto.json b/qapi/crypto.json
index b2a4cff683..3fd0ce177e 100644
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
+# Since: 5.0
+##
+{ 'union': 'QCryptoBlockAmendOptions',
+  'base': 'QCryptoBlockOptionsBase',
+  'discriminator': 'format',
+  'data': {
+            } }
--=20
2.17.2


