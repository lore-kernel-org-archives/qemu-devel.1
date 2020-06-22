Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820CA20716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8WMp/K8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820CA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOEb-0005kd-Ou
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO6z-0000kq-NL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:11:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO6v-00062v-OX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592838708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvEr6VBjj6pAeTBhu97AEaX5hwIrIyx9Rfdsp3COiGo=;
 b=D8WMp/K8Cbw2lG14lEzMwRW4Ct8dmUTjSXVBDT4YGqkliZU7h3PD9J1Qrpa4s9O8yveH0P
 4DHb2gz+CwPDTV22nBnXD87ikpMYOYLReAwzVJ4lb9Udc5Hb2qt9xQoYa+BAJpG/vKCBkX
 XUnAV+BhfxWWyx9XFRxSSxVH40EpXj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-YAsU5ykLN-SMClFOyv-tEQ-1; Mon, 22 Jun 2020 11:11:21 -0400
X-MC-Unique: YAsU5ykLN-SMClFOyv-tEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60408BFC2;
 Mon, 22 Jun 2020 15:11:20 +0000 (UTC)
Received: from localhost (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B0DA71676;
 Mon, 22 Jun 2020 15:11:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/18] block/amend: refactor qcow2 amend options
Date: Mon, 22 Jun 2020 17:10:49 +0200
Message-Id: <20200622151059.921191-9-mreitz@redhat.com>
In-Reply-To: <20200622151059.921191-1-mreitz@redhat.com>
References: <20200622151059.921191-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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

Some qcow2 create options can't be used for amend.
Remove them from the qcow2 create options and add generic logic to detect
such options in qemu-img

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200608094030.670121-6-mlevitsk@redhat.com>
[mreitz: Dropped some iotests reference output hunks that became
         unnecessary thanks to
         "iotests: Make _filter_img_create more active"]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              | 138 +++++++++-----------------------
 qemu-img.c                 |  18 ++++-
 tests/qemu-iotests/049.out | 102 ++++++++++++------------
 tests/qemu-iotests/061.out |  12 ++-
 tests/qemu-iotests/082.out | 158 ++++---------------------------------
 tests/qemu-iotests/085.out |  38 ++++-----
 tests/qemu-iotests/144.out |   4 +-
 tests/qemu-iotests/182.out |   2 +-
 tests/qemu-iotests/185.out |   8 +-
 tests/qemu-iotests/255.out |   8 +-
 tests/qemu-iotests/274.out |  46 +++++------
 tests/qemu-iotests/280.out |   2 +-
 12 files changed, 183 insertions(+), 353 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index fcfd90f2e2..b3ed173a9b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3042,17 +3042,6 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
     return qcow2_update_header(bs);
 }
 
-static int qcow2_crypt_method_from_format(const char *encryptfmt)
-{
-    if (g_str_equal(encryptfmt, "luks")) {
-        return QCOW_CRYPT_LUKS;
-    } else if (g_str_equal(encryptfmt, "aes")) {
-        return QCOW_CRYPT_AES;
-    } else {
-        return -EINVAL;
-    }
-}
-
 static int qcow2_set_up_encryption(BlockDriverState *bs,
                                    QCryptoBlockCreateOptions *cryptoopts,
                                    Error **errp)
@@ -5350,9 +5339,6 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     bool lazy_refcounts = s->use_lazy_refcounts;
     bool data_file_raw = data_file_is_raw(bs);
     const char *compat = NULL;
-    uint64_t cluster_size = s->cluster_size;
-    bool encrypt;
-    int encformat;
     int refcount_bits = s->refcount_bits;
     int ret;
     QemuOptDesc *desc = opts->list->desc;
@@ -5377,44 +5363,12 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                 error_setg(errp, "Unknown compatibility level %s", compat);
                 return -EINVAL;
             }
-        } else if (!strcmp(desc->name, BLOCK_OPT_PREALLOC)) {
-            error_setg(errp, "Cannot change preallocation mode");
-            return -ENOTSUP;
         } else if (!strcmp(desc->name, BLOCK_OPT_SIZE)) {
             new_size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
         } else if (!strcmp(desc->name, BLOCK_OPT_BACKING_FILE)) {
             backing_file = qemu_opt_get(opts, BLOCK_OPT_BACKING_FILE);
         } else if (!strcmp(desc->name, BLOCK_OPT_BACKING_FMT)) {
             backing_format = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
-        } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPT)) {
-            encrypt = qemu_opt_get_bool(opts, BLOCK_OPT_ENCRYPT,
-                                        !!s->crypto);
-
-            if (encrypt != !!s->crypto) {
-                error_setg(errp,
-                           "Changing the encryption flag is not supported");
-                return -ENOTSUP;
-            }
-        } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPT_FORMAT)) {
-            encformat = qcow2_crypt_method_from_format(
-                qemu_opt_get(opts, BLOCK_OPT_ENCRYPT_FORMAT));
-
-            if (encformat != s->crypt_method_header) {
-                error_setg(errp,
-                           "Changing the encryption format is not supported");
-                return -ENOTSUP;
-            }
-        } else if (g_str_has_prefix(desc->name, "encrypt.")) {
-            error_setg(errp,
-                       "Changing the encryption parameters is not supported");
-            return -ENOTSUP;
-        } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
-            cluster_size = qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZE,
-                                             cluster_size);
-            if (cluster_size != s->cluster_size) {
-                error_setg(errp, "Changing the cluster size is not supported");
-                return -ENOTSUP;
-            }
         } else if (!strcmp(desc->name, BLOCK_OPT_LAZY_REFCOUNTS)) {
             lazy_refcounts = qemu_opt_get_bool(opts, BLOCK_OPT_LAZY_REFCOUNTS,
                                                lazy_refcounts);
@@ -5444,22 +5398,6 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                                  "images");
                 return -EINVAL;
             }
-        } else if (!strcmp(desc->name, BLOCK_OPT_COMPRESSION_TYPE)) {
-            const char *ct_name =
-                qemu_opt_get(opts, BLOCK_OPT_COMPRESSION_TYPE);
-            int compression_type =
-                qapi_enum_parse(&Qcow2CompressionType_lookup, ct_name, -1,
-                                NULL);
-            if (compression_type == -1) {
-                error_setg(errp, "Unknown compression type: %s", ct_name);
-                return -ENOTSUP;
-            }
-
-            if (compression_type != s->compression_type) {
-                error_setg(errp, "Changing the compression type "
-                                 "is not supported");
-                return -ENOTSUP;
-            }
         } else {
             /* if this point is reached, this probably means a new option was
              * added without having it covered here */
@@ -5681,37 +5619,6 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
         .help = "The external data file must stay valid "           \
                 "as a raw image"                                    \
     },                                                              \
-    {                                                               \
-        .name = BLOCK_OPT_ENCRYPT,                                  \
-        .type = QEMU_OPT_BOOL,                                      \
-        .help = "Encrypt the image with format 'aes'. (Deprecated " \
-                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",    \
-    },                                                              \
-    {                                                               \
-        .name = BLOCK_OPT_ENCRYPT_FORMAT,                           \
-        .type = QEMU_OPT_STRING,                                    \
-        .help = "Encrypt the image, format choices: 'aes', 'luks'", \
-    },                                                              \
-    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
-        "ID of secret providing qcow AES key or LUKS passphrase"),  \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
-    {                                                               \
-        .name = BLOCK_OPT_CLUSTER_SIZE,                             \
-        .type = QEMU_OPT_SIZE,                                      \
-        .help = "qcow2 cluster size",                               \
-        .def_value_str = stringify(DEFAULT_CLUSTER_SIZE)            \
-    },                                                              \
-    {                                                               \
-        .name = BLOCK_OPT_PREALLOC,                                 \
-        .type = QEMU_OPT_STRING,                                    \
-        .help = "Preallocation mode (allowed values: off, "         \
-                "metadata, falloc, full)"                           \
-    },                                                              \
     {                                                               \
         .name = BLOCK_OPT_LAZY_REFCOUNTS,                           \
         .type = QEMU_OPT_BOOL,                                      \
@@ -5723,19 +5630,50 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
         .type = QEMU_OPT_NUMBER,                                    \
         .help = "Width of a reference count entry in bits",         \
         .def_value_str = "16"                                       \
-    },                                                              \
-    {                                                               \
-        .name = BLOCK_OPT_COMPRESSION_TYPE,                         \
-        .type = QEMU_OPT_STRING,                                    \
-        .help = "Compression method used for image cluster "        \
-                "compression",                                      \
-        .def_value_str = "zlib"                                     \
     }
 
 static QemuOptsList qcow2_create_opts = {
     .name = "qcow2-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
     .desc = {
+        {                                                               \
+            .name = BLOCK_OPT_ENCRYPT,                                  \
+            .type = QEMU_OPT_BOOL,                                      \
+            .help = "Encrypt the image with format 'aes'. (Deprecated " \
+                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ENCRYPT_FORMAT,                           \
+            .type = QEMU_OPT_STRING,                                    \
+            .help = "Encrypt the image, format choices: 'aes', 'luks'", \
+        },                                                              \
+        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
+            "ID of secret providing qcow AES key or LUKS passphrase"),  \
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
+        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
+        {                                                               \
+            .name = BLOCK_OPT_CLUSTER_SIZE,                             \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "qcow2 cluster size",                               \
+            .def_value_str = stringify(DEFAULT_CLUSTER_SIZE)            \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_PREALLOC,                                 \
+            .type = QEMU_OPT_STRING,                                    \
+            .help = "Preallocation mode (allowed values: off, "         \
+                    "metadata, falloc, full)"                           \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_COMPRESSION_TYPE,                         \
+            .type = QEMU_OPT_STRING,                                    \
+            .help = "Compression method used for image cluster "        \
+                    "compression",                                      \
+            .def_value_str = "zlib"                                     \
+        },
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
     }
diff --git a/qemu-img.c b/qemu-img.c
index 0c4541b017..381271a74e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4080,9 +4080,8 @@ static int print_amend_option_help(const char *format)
     /* Every driver supporting amendment must have amend_opts */
     assert(drv->amend_opts);
 
-    printf("Creation options for '%s':\n", format);
+    printf("Amend options for '%s':\n", format);
     qemu_opts_print_help(drv->amend_opts, false);
-    printf("\nNote that not all of these options may be amendable.\n");
     return 0;
 }
 
@@ -4228,7 +4227,22 @@ static int img_amend(int argc, char **argv)
     amend_opts = qemu_opts_append(amend_opts, bs->drv->amend_opts);
     opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
     qemu_opts_do_parse(opts, options, NULL, &err);
+
     if (err) {
+        /* Try to parse options using the create options */
+        Error *err1 = NULL;
+        amend_opts = qemu_opts_append(amend_opts, bs->drv->create_opts);
+        qemu_opts_del(opts);
+        opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
+        qemu_opts_do_parse(opts, options, NULL, &err1);
+
+        if (!err1) {
+            error_append_hint(&err,
+                              "This option is only supported for image creation\n");
+        } else {
+            error_free(err1);
+        }
+
         error_report_err(err);
         ret = -1;
         goto out;
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index c54ae21b86..e77966446b 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -4,90 +4,90 @@ QA output created by 049
 == 1. Traditional size parameter ==
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1099511627776 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1572864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1610612736 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1649267441664 lazy_refcounts=off refcount_bits=16
 
 == 2. Specifying size via -o ==
 
 qemu-img create -f qcow2 -o size=1024 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1099511627776 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024.0 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024.0b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1572864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1610612736 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1649267441664 lazy_refcounts=off refcount_bits=16
 
 == 3. Invalid sizes ==
 
@@ -129,84 +129,84 @@ qemu-img: TEST_DIR/t.qcow2: The image size must be specified only once
 == Check correct interpretation of suffixes for cluster size ==
 
 qemu-img create -f qcow2 -o cluster_size=1024 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1048576 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1048576 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024.0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024.0b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=512 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=512 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=524288 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=524288 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 == Check compat level option ==
 
 qemu-img create -f qcow2 -o compat=0.10 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.42 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=foobar TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=foobar lazy_refcounts=off refcount_bits=16
 
 == Check preallocation option ==
 
 qemu-img create -f qcow2 -o preallocation=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 preallocation=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=metadata TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 preallocation=metadata compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=1234 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 preallocation=1234 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 == Check encryption option ==
 
 qemu-img create -f qcow2 -o encryption=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 encryption=off cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 encryption=on encrypt.key-secret=sec0 cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 == Check lazy_refcounts option (only with v3) ==
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=on refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=on refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=on refcount_bits=16
 
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 2f03cf045c..b0f8befe30 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -381,16 +381,20 @@ qemu-img: Lazy refcounts only supported with compatibility level 1.1 and above (
 qemu-img: Lazy refcounts only supported with compatibility level 1.1 and above (use compat=1.1 or greater)
 qemu-img: Unknown compatibility level 0.42
 qemu-img: Invalid parameter 'foo'
-qemu-img: Changing the cluster size is not supported
-qemu-img: Changing the encryption flag is not supported
-qemu-img: Cannot change preallocation mode
+qemu-img: Invalid parameter 'cluster_size'
+This option is only supported for image creation
+qemu-img: Invalid parameter 'encryption'
+This option is only supported for image creation
+qemu-img: Invalid parameter 'preallocation'
+This option is only supported for image creation
 
 === Testing correct handling of unset value ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Should work:
 Should not work:
-qemu-img: Changing the cluster size is not supported
+qemu-img: Invalid parameter 'cluster_size'
+This option is only supported for image creation
 
 === Testing zero expansion on inactive clusters ===
 
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 529a1214e1..b1cf5dfe43 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -3,14 +3,14 @@ QA output created by 082
 === create: Options specified more than once ===
 
 Testing: create -f foo -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=4096 lazy_refcounts=on refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=4096 compression_type=zlib size=134217728 lazy_refcounts=on refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -23,7 +23,7 @@ Format specific information:
     corrupt: false
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on -o cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=on refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=8192 compression_type=zlib size=134217728 lazy_refcounts=on refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -36,7 +36,7 @@ Format specific information:
     corrupt: false
 
 Testing: create -f qcow2 -o cluster_size=4k,cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=8192 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -237,10 +237,10 @@ Supported options:
   size=<size>            - Virtual disk size
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2,,help lazy_refcounts=off refcount_bits=16
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2,,? lazy_refcounts=off refcount_bits=16
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 128M
 qemu-img: Invalid option list: backing_file=TEST_DIR/t.qcow2,
@@ -290,7 +290,7 @@ qemu-img: Format driver 'bochs' does not support image creation
 === convert: Options specified more than once ===
 
 Testing: create -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
 Testing: convert -f foo -f qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -639,205 +639,93 @@ cluster_size: 65536
 === amend: help for -o ===
 
 Testing: amend -f qcow2 -o help TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o ? TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2
 
 Testing: rebase -u -b  -f qcow2 TEST_DIR/t.qcow2
@@ -856,30 +744,16 @@ Testing: amend -f qcow2 -o backing_file=TEST_DIR/t.qcow2 -o ,, -o help TEST_DIR/
 qemu-img: Invalid option list: ,,
 
 Testing: amend -f qcow2 -o help
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=<str>     - File name of a base image
   backing_fmt=<str>      - Image format of the base image
-  cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
-  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
-  encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=<str> - Name of encryption cipher mode
-  encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
-  encrypt.hash-alg=<str> - Name of encryption hash algorithm
-  encrypt.iter-time=<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
-  encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
-  preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Note that not all of these options may be amendable.
-
 Testing: amend -o help
 qemu-img: Expecting one image file name
 
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index a822ff4ef6..d68c06efdf 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -13,7 +13,7 @@ Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=134217728
 === Create a single snapshot on virtio0 ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/1-snapshot-v0.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Invalid command - missing device and nodename ===
@@ -30,40 +30,40 @@ Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file
 === Create several transactional group snapshots ===
 
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/2-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/2-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/3-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/3-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/4-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/4-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/5-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/5-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/6-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/6-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/7-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/7-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/8-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/8-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/9-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/9-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/10-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/10-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Create a couple of snapshots using blockdev-snapshot ===
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index 885a8874a5..a2172a1308 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=536870912
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Performing block-commit on active layer ===
@@ -31,6 +31,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/
 === Performing Live Snapshot 2 ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index ae43654d32..29e9db3497 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -13,7 +13,7 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
 {'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name': 'node0', 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'snapshot-node-name': 'node1' } }
-Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 cluster_size=65536 compression_type=zlib size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file lazy_refcounts=off refcount_bits=16
 {"return": {}}
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index ac5ab16bc8..62d1ab74d3 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -9,14 +9,14 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 === Creating backing chain ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 'snapshot-file': 'TEST_DIR/t.IMGFMT.mid', 'format': 'IMGFMT', 'mode': 'absolute-paths' } }
-Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu-io disk "write 0 4M"' } }
 wrote 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 'snapshot-file': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'absolute-paths' } }
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Start commit job and exit qemu ===
@@ -48,7 +48,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-mirror', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
@@ -62,7 +62,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
index a3c99fd62e..d74903db99 100644
--- a/tests/qemu-iotests/255.out
+++ b/tests/qemu-iotests/255.out
@@ -3,9 +3,9 @@ Finishing a commit job with background reads
 
 === Create backing chain and start VM ===
 
-Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
 === Start background read requests ===
 
@@ -23,9 +23,9 @@ Closing the VM while a job is being cancelled
 
 === Create images and start VM ===
 
-Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index d24ff681af..d248a1e21b 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -1,9 +1,9 @@
 == Commit tests ==
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid lazy_refcounts=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -64,11 +64,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing HMP commit (top -> mid) ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid lazy_refcounts=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -94,11 +94,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing QMP active commit (top -> mid) ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid lazy_refcounts=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -131,9 +131,9 @@ read 1048576/1048576 bytes at offset 1048576
 
 == Resize tests ==
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=6442450944 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=6442450944 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=1073741824 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1073741824 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 5368709120
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -150,9 +150,9 @@ read 65536/65536 bytes at offset 5368709120
 { "start": 1073741824, "length": 7516192768, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=metadata ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=34359738368 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=34359738368 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=32212254720 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=32212254720 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 33285996544
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -174,9 +174,9 @@ read 65536/65536 bytes at offset 33285996544
 { "start": 34896609280, "length": 536870912, "depth": 0, "zero": true, "data": false, "offset": 2685075456}]
 
 === preallocation=falloc ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=10485760 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=10485760 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=5242880 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=5242880 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 9437184
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -193,9 +193,9 @@ read 65536/65536 bytes at offset 9437184
 { "start": 5242880, "length": 10485760, "depth": 0, "zero": false, "data": true, "offset": 327680}]
 
 === preallocation=full ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=16777216 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=16777216 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=8388608 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=8388608 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 11534336
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -212,9 +212,9 @@ read 65536/65536 bytes at offset 11534336
 { "start": 8388608, "length": 4194304, "depth": 0, "zero": false, "data": true, "offset": 327680}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=393216 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=393216 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=259072 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=259072 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 259072
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -232,9 +232,9 @@ read 65536/65536 bytes at offset 259072
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=409600 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=409600 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=262144 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 344064
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -251,9 +251,9 @@ read 65536/65536 bytes at offset 344064
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=524288 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=524288 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=262144 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 446464
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index 92e4d14079..fc59b9bc5c 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -1,4 +1,4 @@
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 === Launch VM ===
 Enabling migration QMP events on VM...
-- 
2.26.2


