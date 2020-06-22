Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53949C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDEE206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MU0qRUws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDEE206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOAt-0007hJ-SL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO73-0000qq-JV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:12:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33892
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO71-00063t-FG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592838714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAEXRPqSVLnfGgce7xKxSYC+g3K5y0E98zEh2o4GYCM=;
 b=MU0qRUwscrz4tdrdAPQ3uHUT5CkPDb0sYxQKZzubln5mUTUlhLCTVJ1gE3kSlI5a0LX0CE
 ggqKurTqZt1Ic/xJmt+hA/6cvIHZVd807sNglZ9HXbOohTkUT1bgEZdwLW9O8PP4QFvPwJ
 pZnQKstSo8Jj01vO9xDx/FiCj3lswX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-l6j4SG6RNSyxU6TLOtN0Gw-1; Mon, 22 Jun 2020 11:11:28 -0400
X-MC-Unique: l6j4SG6RNSyxU6TLOtN0Gw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CB221083E83;
 Mon, 22 Jun 2020 15:11:27 +0000 (UTC)
Received: from localhost (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C592D71664;
 Mon, 22 Jun 2020 15:11:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/18] block/qcow2: extend qemu-img amend interface with crypto
 options
Date: Mon, 22 Jun 2020 17:10:52 +0200
Message-Id: <20200622151059.921191-12-mreitz@redhat.com>
In-Reply-To: <20200622151059.921191-1-mreitz@redhat.com>
References: <20200622151059.921191-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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

Now that we have all the infrastructure in place,
wire it in the qcow2 driver and expose this to the user.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200608094030.670121-9-mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              | 71 +++++++++++++++++++++++++++++++++-----
 tests/qemu-iotests/082.out | 45 ++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b3ed173a9b..0e72e8fc39 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -176,6 +176,19 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
     return ret;
 }
 
+static QDict*
+qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
+{
+    QDict *cryptoopts_qdict;
+    QDict *opts_qdict;
+
+    /* Extract "encrypt." options into a qdict */
+    opts_qdict = qemu_opts_to_qdict(opts, NULL);
+    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
+    qobject_unref(opts_qdict);
+    qdict_put_str(cryptoopts_qdict, "format", fmt);
+    return cryptoopts_qdict;
+}
 
 /*
  * read qcow2 extension and fill bs
@@ -4849,16 +4862,9 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
 
     if (has_luks) {
         g_autoptr(QCryptoBlockCreateOptions) create_opts = NULL;
-        QDict *opts_qdict;
-        QDict *cryptoopts;
+        QDict *cryptoopts = qcow2_extract_crypto_opts(opts, "luks", errp);
         size_t headerlen;
 
-        opts_qdict = qemu_opts_to_qdict(opts, NULL);
-        qdict_extract_subqdict(opts_qdict, &cryptoopts, "encrypt.");
-        qobject_unref(opts_qdict);
-
-        qdict_put_str(cryptoopts, "format", "luks");
-
         create_opts = block_crypto_create_opts_init(cryptoopts, errp);
         qobject_unref(cryptoopts);
         if (!create_opts) {
@@ -5262,6 +5268,7 @@ typedef enum Qcow2AmendOperation {
     QCOW2_NO_OPERATION = 0,
 
     QCOW2_UPGRADING,
+    QCOW2_UPDATING_ENCRYPTION,
     QCOW2_CHANGING_REFCOUNT_ORDER,
     QCOW2_DOWNGRADING,
 } Qcow2AmendOperation;
@@ -5343,6 +5350,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     int ret;
     QemuOptDesc *desc = opts->list->desc;
     Qcow2AmendHelperCBInfo helper_cb_info;
+    bool encryption_update = false;
 
     while (desc && desc->name) {
         if (!qemu_opt_find(opts, desc->name)) {
@@ -5369,6 +5377,18 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             backing_file = qemu_opt_get(opts, BLOCK_OPT_BACKING_FILE);
         } else if (!strcmp(desc->name, BLOCK_OPT_BACKING_FMT)) {
             backing_format = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
+        } else if (g_str_has_prefix(desc->name, "encrypt.")) {
+            if (!s->crypto) {
+                error_setg(errp,
+                           "Can't amend encryption options - encryption not present");
+                return -EINVAL;
+            }
+            if (s->crypt_method_header != QCOW_CRYPT_LUKS) {
+                error_setg(errp,
+                           "Only LUKS encryption options can be amended");
+                return -ENOTSUP;
+            }
+            encryption_update = true;
         } else if (!strcmp(desc->name, BLOCK_OPT_LAZY_REFCOUNTS)) {
             lazy_refcounts = qemu_opt_get_bool(opts, BLOCK_OPT_LAZY_REFCOUNTS,
                                                lazy_refcounts);
@@ -5411,7 +5431,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
         .original_status_cb = status_cb,
         .original_cb_opaque = cb_opaque,
         .total_operations = (new_version != old_version)
-                          + (s->refcount_bits != refcount_bits)
+                          + (s->refcount_bits != refcount_bits) +
+                            (encryption_update == true)
     };
 
     /* Upgrade first (some features may require compat=1.1) */
@@ -5424,6 +5445,33 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
         }
     }
 
+    if (encryption_update) {
+        QDict *amend_opts_dict;
+        QCryptoBlockAmendOptions *amend_opts;
+
+        helper_cb_info.current_operation = QCOW2_UPDATING_ENCRYPTION;
+        amend_opts_dict = qcow2_extract_crypto_opts(opts, "luks", errp);
+        if (!amend_opts_dict) {
+            return -EINVAL;
+        }
+        amend_opts = block_crypto_amend_opts_init(amend_opts_dict, errp);
+        qobject_unref(amend_opts_dict);
+        if (!amend_opts) {
+            return -EINVAL;
+        }
+        ret = qcrypto_block_amend_options(s->crypto,
+                                          qcow2_crypto_hdr_read_func,
+                                          qcow2_crypto_hdr_write_func,
+                                          bs,
+                                          amend_opts,
+                                          force,
+                                          errp);
+        qapi_free_QCryptoBlockAmendOptions(amend_opts);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     if (s->refcount_bits != refcount_bits) {
         int refcount_order = ctz32(refcount_bits);
 
@@ -5683,6 +5731,11 @@ static QemuOptsList qcow2_amend_opts = {
     .name = "qcow2-amend-opts",
     .head = QTAILQ_HEAD_INITIALIZER(qcow2_amend_opts.head),
     .desc = {
+        BLOCK_CRYPTO_OPT_DEF_LUKS_STATE("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_OLD_SECRET("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_NEW_SECRET("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
     }
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index b1cf5dfe43..a4a2b69030 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -645,6 +645,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
@@ -656,6 +661,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
@@ -667,6 +677,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
@@ -678,6 +693,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
@@ -689,6 +709,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
@@ -700,6 +725,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
@@ -711,6 +741,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
@@ -722,6 +757,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
@@ -750,6 +790,11 @@ Amend options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=<str> - New secret to set in the matching keyslots. Empty string to erase
+  encrypt.old-secret=<str> - Select all keyslots that match this password
+  encrypt.state=<str>    - Select new state of affected keyslots (active/inactive)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
-- 
2.26.2


