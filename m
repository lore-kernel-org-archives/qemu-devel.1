Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A13C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A6B206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgWXY6AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A6B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOLc-00017t-BI
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO8I-0003Jw-GM
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:13:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO8G-0006Lw-TE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592838792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFPDXmgbYSuMNSPmz3MGqWSs7F5g1xKW8/+M7CudBSk=;
 b=XgWXY6APdFCFtIkMDHBorQm7h9vDUSNVSuh3Yr3tEZ5YXscthVnpb8AifT5aQ4XfDThJEj
 KG9T+f7Mjoq1Osr99retxYir/Kk6F9Td6BL7NBYEfzS9v1I7nUoBt4nHmyTJ+i9Edvj0jc
 ++U89TY0A/6TBhyWENsBWyzEh8xBSI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Cn6UjYs7NT-Bf8obpZHsQg-1; Mon, 22 Jun 2020 11:11:38 -0400
X-MC-Unique: Cn6UjYs7NT-Bf8obpZHsQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7584107ACCA;
 Mon, 22 Jun 2020 15:11:37 +0000 (UTC)
Received: from localhost (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 695FE5C220;
 Mon, 22 Jun 2020 15:11:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/18] block/qcow2: implement blockdev-amend
Date: Mon, 22 Jun 2020 17:10:56 +0200
Message-Id: <20200622151059.921191-16-mreitz@redhat.com>
In-Reply-To: <20200622151059.921191-1-mreitz@redhat.com>
References: <20200622151059.921191-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Currently the implementation only supports amending the encryption
options, unlike the qemu-img version

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200608094030.670121-14-mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 16 +++++++++++++++-
 block/qcow2.c        | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cd679ad435..b20332e592 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4686,6 +4686,19 @@
   'data': { }
 }
 
+##
+# @BlockdevAmendOptionsQcow2:
+#
+# Driver specific image amend options for qcow2.
+# For now, only encryption options can be amended
+#
+# @encrypt          Encryption options to be amended
+#
+# Since: 5.1
+##
+{ 'struct': 'BlockdevAmendOptionsQcow2',
+  'data': { '*encrypt':         'QCryptoBlockAmendOptions' } }
+
 ##
 # @BlockdevAmendOptions:
 #
@@ -4700,7 +4713,8 @@
       'driver':         'BlockdevDriver' },
   'discriminator': 'driver',
   'data': {
-      'luks':           'BlockdevAmendOptionsLUKS' } }
+      'luks':           'BlockdevAmendOptionsLUKS',
+      'qcow2':          'BlockdevAmendOptionsQcow2' } }
 
 ##
 # @x-blockdev-amend:
diff --git a/block/qcow2.c b/block/qcow2.c
index 0e72e8fc39..0d2d05d1f7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5585,6 +5585,44 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     return 0;
 }
 
+static int coroutine_fn qcow2_co_amend(BlockDriverState *bs,
+                                       BlockdevAmendOptions *opts,
+                                       bool force,
+                                       Error **errp)
+{
+    BlockdevAmendOptionsQcow2 *qopts = &opts->u.qcow2;
+    BDRVQcow2State *s = bs->opaque;
+    int ret = 0;
+
+    if (qopts->has_encrypt) {
+        if (!s->crypto) {
+            error_setg(errp, "image is not encrypted, can't amend");
+            return -EOPNOTSUPP;
+        }
+
+        if (qopts->encrypt->format != Q_CRYPTO_BLOCK_FORMAT_LUKS) {
+            error_setg(errp,
+                       "Amend can't be used to change the qcow2 encryption format");
+            return -EOPNOTSUPP;
+        }
+
+        if (s->crypt_method_header != QCOW_CRYPT_LUKS) {
+            error_setg(errp,
+                       "Only LUKS encryption options can be amended for qcow2 with blockdev-amend");
+            return -EOPNOTSUPP;
+        }
+
+        ret = qcrypto_block_amend_options(s->crypto,
+                                          qcow2_crypto_hdr_read_func,
+                                          qcow2_crypto_hdr_write_func,
+                                          bs,
+                                          qopts->encrypt,
+                                          force,
+                                          errp);
+    }
+    return ret;
+}
+
 /*
  * If offset or size are negative, respectively, they will not be included in
  * the BLOCK_IMAGE_CORRUPTED event emitted.
@@ -5802,6 +5840,7 @@ BlockDriver bdrv_qcow2 = {
     .mutable_opts        = mutable_opts,
     .bdrv_co_check       = qcow2_co_check,
     .bdrv_amend_options  = qcow2_amend_options,
+    .bdrv_co_amend       = qcow2_co_amend,
 
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
-- 
2.26.2


