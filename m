Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5186C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665DA206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jvm+b9wW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665DA206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEKP-00039I-KF
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jiEHC-0006Po-Jf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:41:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jiEH3-0002AA-RH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591609256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgA7cj03JiBAhxINk8s8nnfNrrgiUmFUgzgXmHyszXQ=;
 b=Jvm+b9wWheS38hLavGFMGzMEk5ETOE/b+IbKfCi3+Eg+Wp2A7JIgZEhd1QibSOZ14GDtRq
 +mr4ASRBSWQo69Wq/UIJEuIoAtXireTVAbuEE1HXA5mtFAWzftxY1Sk0hfUVNv0nDYO1tB
 y3hm7rIY064mVnE5OAHXJoiDrirEPB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-teI6CbVzPG2NDKw0IDTnJQ-1; Mon, 08 Jun 2020 05:40:53 -0400
X-MC-Unique: teI6CbVzPG2NDKw0IDTnJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3A6B461;
 Mon,  8 Jun 2020 09:40:52 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6620891E0;
 Mon,  8 Jun 2020 09:40:47 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 05/14] block/amend: refactor qcow2 amend options
Date: Mon,  8 Jun 2020 12:40:21 +0300
Message-Id: <20200608094030.670121-6-mlevitsk@redhat.com>
In-Reply-To: <20200608094030.670121-1-mlevitsk@redhat.com>
References: <20200608094030.670121-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Some qcow2 create options can't be used for amend.
Remove them from the qcow2 create options and add generic logic to detect
such options in qemu-img

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/qcow2.c              | 138 ++++++++------------------
 qemu-img.c                 |  18 +++-
 tests/qemu-iotests/049.out | 102 ++++++++++----------
 tests/qemu-iotests/061.out |  12 ++-
 tests/qemu-iotests/079.out |  18 ++--
 tests/qemu-iotests/082.out | 158 ++++--------------------------
 tests/qemu-iotests/085.out |  38 ++++----
 tests/qemu-iotests/087.out |   6 +-
 tests/qemu-iotests/115.out |   2 +-
 tests/qemu-iotests/121.out |   4 +-
 tests/qemu-iotests/125.out | 192 ++++++++++++++++++-------------------
 tests/qemu-iotests/134.out |   2 +-
 tests/qemu-iotests/144.out |   4 +-
 tests/qemu-iotests/158.out |   4 +-
 tests/qemu-iotests/182.out |   2 +-
 tests/qemu-iotests/185.out |   8 +-
 tests/qemu-iotests/188.out |   2 +-
 tests/qemu-iotests/189.out |   4 +-
 tests/qemu-iotests/198.out |   4 +-
 tests/qemu-iotests/243.out |  16 ++--
 tests/qemu-iotests/250.out |   2 +-
 tests/qemu-iotests/255.out |   8 +-
 tests/qemu-iotests/259.out |   2 +-
 tests/qemu-iotests/263.out |   4 +-
 tests/qemu-iotests/274.out |  46 ++++-----
 tests/qemu-iotests/280.out |   2 +-
 tests/qemu-iotests/284.out |   6 +-
 27 files changed, 317 insertions(+), 487 deletions(-)

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
index a51ad1b5ba..65204f41c5 100644
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
 
diff --git a/tests/qemu-iotests/079.out b/tests/qemu-iotests/079.out
index aab922fb36..c7e37152f4 100644
--- a/tests/qemu-iotests/079.out
+++ b/tests/qemu-iotests/079.out
@@ -1,14 +1,14 @@
 QA output created by 079
 === Check option preallocation and cluster_size ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
 qemu-img: TEST_DIR/t.IMGFMT: Cluster size must be a power of two between 512 and 2048k
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=4294967296
 *** done
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
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 2d92ea847b..f23bffbbf1 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -34,7 +34,7 @@ QMP_VERSION
 
 === Encrypted image QCow ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -46,7 +46,7 @@ QMP_VERSION
 
 === Encrypted image LUKS ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encrypt.format=luks encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 size=134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -58,7 +58,7 @@ QMP_VERSION
 
 === Missing driver ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728
 Testing: -S
 QMP_VERSION
 {"return": {}}
diff --git a/tests/qemu-iotests/115.out b/tests/qemu-iotests/115.out
index dbdad17b27..074b5cc84d 100644
--- a/tests/qemu-iotests/115.out
+++ b/tests/qemu-iotests/115.out
@@ -2,7 +2,7 @@ QA output created by 115
 
 === Testing large refcount and L1 table ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=268435456 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=268435456
 No errors were found on the image.
 100.00% allocated clusters
 *** done
diff --git a/tests/qemu-iotests/121.out b/tests/qemu-iotests/121.out
index 613d56185e..fbe4b575f7 100644
--- a/tests/qemu-iotests/121.out
+++ b/tests/qemu-iotests/121.out
@@ -4,7 +4,7 @@ QA output created by 121
 
 --- Test 1 ---
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=66060288 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=66060288
 Image resized.
 wrote 1049600/1049600 bytes at offset 65011712
 1.001 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -14,7 +14,7 @@ No errors were found on the image.
 
 --- Test 2 ---
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=66061312 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=66061312
 Image resized.
 wrote 133120/133120 bytes at offset 66060288
 130 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/125.out b/tests/qemu-iotests/125.out
index 596905f533..767c52d622 100644
--- a/tests/qemu-iotests/125.out
+++ b/tests/qemu-iotests/125.out
@@ -1,6 +1,6 @@
 QA output created by 125
 --- cluster_size=512 growth_size=16 create_mode=off growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -8,7 +8,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=off growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -16,7 +16,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=off growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -24,7 +24,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=off growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -32,7 +32,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=metadata growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -40,7 +40,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=metadata growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -48,7 +48,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=metadata growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -56,7 +56,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=metadata growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -64,7 +64,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=falloc growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -72,7 +72,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=falloc growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -80,7 +80,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=falloc growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -88,7 +88,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=falloc growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -96,7 +96,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=full growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -104,7 +104,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=full growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -112,7 +112,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=full growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -120,7 +120,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=16 create_mode=full growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -128,7 +128,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=off growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -136,7 +136,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=off growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -144,7 +144,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=off growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -152,7 +152,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=off growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -160,7 +160,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=metadata growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -168,7 +168,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=metadata growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -176,7 +176,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=metadata growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -184,7 +184,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=metadata growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -192,7 +192,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=falloc growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -200,7 +200,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=falloc growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -208,7 +208,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=falloc growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -216,7 +216,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=falloc growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -224,7 +224,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=full growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -232,7 +232,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=full growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -240,7 +240,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=full growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -248,7 +248,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=48 create_mode=full growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -256,7 +256,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=off growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -264,7 +264,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=off growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -272,7 +272,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=off growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -280,7 +280,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=off growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -288,7 +288,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=metadata growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -296,7 +296,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=metadata growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -304,7 +304,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=metadata growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -312,7 +312,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=metadata growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -320,7 +320,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=falloc growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -328,7 +328,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=falloc growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -336,7 +336,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=falloc growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -344,7 +344,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=falloc growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -352,7 +352,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=full growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -360,7 +360,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=full growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -368,7 +368,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=full growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -376,7 +376,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=512 growth_size=80 create_mode=full growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -384,7 +384,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=off growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -392,7 +392,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=off growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -400,7 +400,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=off growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -408,7 +408,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=off growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -416,7 +416,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=metadata growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -424,7 +424,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=metadata growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -432,7 +432,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=metadata growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -440,7 +440,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=metadata growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -448,7 +448,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=falloc growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -456,7 +456,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=falloc growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -464,7 +464,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=falloc growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -472,7 +472,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=falloc growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -480,7 +480,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=full growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -488,7 +488,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=full growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -496,7 +496,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=full growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -504,7 +504,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=16 create_mode=full growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -512,7 +512,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=off growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -520,7 +520,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=off growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -528,7 +528,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=off growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -536,7 +536,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=off growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -544,7 +544,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=metadata growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -552,7 +552,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=metadata growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -560,7 +560,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=metadata growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -568,7 +568,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=metadata growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -576,7 +576,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=falloc growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -584,7 +584,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=falloc growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -592,7 +592,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=falloc growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -600,7 +600,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=falloc growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -608,7 +608,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=full growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -616,7 +616,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=full growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -624,7 +624,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=full growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -632,7 +632,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=48 create_mode=full growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -640,7 +640,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=off growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -648,7 +648,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=off growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -656,7 +656,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=off growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -664,7 +664,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=off growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -672,7 +672,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=metadata growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -680,7 +680,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=metadata growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -688,7 +688,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=metadata growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -696,7 +696,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=metadata growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -704,7 +704,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=falloc growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -712,7 +712,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=falloc growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -720,7 +720,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=falloc growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -728,7 +728,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=falloc growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -736,7 +736,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=full growth_mode=off ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -744,7 +744,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=full growth_mode=metadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -752,7 +752,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=full growth_mode=falloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -760,7 +760,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 --- cluster_size=64k growth_size=80 create_mode=full growth_mode=full ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 09d46f6b17..f2878f5f3a 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -1,5 +1,5 @@
 QA output created by 134
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728
 
 == reading whole image ==
 read 134217728/134217728 bytes at offset 0
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
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index 6def216e55..fa2294bb85 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -1,6 +1,6 @@
 QA output created by 158
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728
 
 == writing whole image ==
 wrote 134217728/134217728 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
 
 == writing part of a cluster ==
 wrote 1024/1024 bytes at offset 0
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
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index c568ef3701..4b9aadd51c 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -1,5 +1,5 @@
 QA output created by 188
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=16777216
 
 == reading whole image ==
 read 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index a0b7c9c24c..e536d95d53 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -1,6 +1,6 @@
 QA output created by 189
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=16777216
 
 == writing whole image ==
 wrote 16777216/16777216 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10 size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
 
 == writing part of a cluster ==
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 6280ae6eed..7714995c02 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -1,12 +1,12 @@
 QA output created by 198
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=16777216
 
 == writing whole image base ==
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10 size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
 
 == writing whole image layer ==
 wrote 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/243.out b/tests/qemu-iotests/243.out
index dcb33fac32..341ef3b7d0 100644
--- a/tests/qemu-iotests/243.out
+++ b/tests/qemu-iotests/243.out
@@ -2,31 +2,31 @@ QA output created by 243
 
 === preallocation=off ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=67108864
 File size: 196616
 Disk usage: low
 
 === preallocation=metadata ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=67108864
 File size: 67436544
 Disk usage: low
 
 === preallocation=falloc ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=67108864
 File size: 67436544
 Disk usage: high
 
 === preallocation=full ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=67108864
 File size: 67436544
 Disk usage: high
 
 === External data file: preallocation=off ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=off size=67108864 data_file=TEST_DIR/t.IMGFMT.data
 qcow2 file size: 196616
 data file size:  67108864
 qcow2 disk usage: low
@@ -34,7 +34,7 @@ data disk usage:  low
 
 === External data file: preallocation=metadata ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=67108864 data_file=TEST_DIR/t.IMGFMT.data
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
@@ -42,7 +42,7 @@ data disk usage:  low
 
 === External data file: preallocation=falloc ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=falloc size=67108864 data_file=TEST_DIR/t.IMGFMT.data
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
@@ -50,7 +50,7 @@ data disk usage:  high
 
 === External data file: preallocation=full ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=full size=67108864 data_file=TEST_DIR/t.IMGFMT.data
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
diff --git a/tests/qemu-iotests/250.out b/tests/qemu-iotests/250.out
index f480fd273b..0b737097f3 100644
--- a/tests/qemu-iotests/250.out
+++ b/tests/qemu-iotests/250.out
@@ -1,5 +1,5 @@
 QA output created by 250
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT preallocation=metadata size=2202009600
 discard 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 discard 10485760/10485760 bytes at offset 2191523840
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
diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out
index ffed19c2a0..edf4377650 100644
--- a/tests/qemu-iotests/259.out
+++ b/tests/qemu-iotests/259.out
@@ -10,5 +10,5 @@ disk size: unavailable
 
 --- Testing creation for which the node would need to grow ---
 qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Image format driver does not support resize
-Formatting 'TEST_DIR/t.IMGFMT', fmt=qcow2 size=67108864 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=qcow2 preallocation=metadata size=67108864
 *** done
diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
index 0c982c55cb..4cf5c79ed8 100644
--- a/tests/qemu-iotests/263.out
+++ b/tests/qemu-iotests/263.out
@@ -2,7 +2,7 @@ QA output created by 263
 
 testing LUKS qcow2 encryption
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=1048576
 == reading the whole image ==
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -21,7 +21,7 @@ read 982528/982528 bytes at offset 66048
 
 testing legacy AES qcow2 encryption
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=aes encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=aes encrypt.key-secret=sec0 size=1048576
 == reading the whole image ==
 read 1048576/1048576 bytes at offset 0
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
diff --git a/tests/qemu-iotests/284.out b/tests/qemu-iotests/284.out
index 48216f5742..1855369c56 100644
--- a/tests/qemu-iotests/284.out
+++ b/tests/qemu-iotests/284.out
@@ -2,7 +2,7 @@ QA output created by 284
 
 testing LUKS qcow2 encryption
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=1048576
 
 == cluster size 512
 == checking image refcounts ==
@@ -21,7 +21,7 @@ wrote 1/1 bytes at offset 512
 
 == rechecking image refcounts ==
 No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=1048576
 
 == cluster size 2048
 == checking image refcounts ==
@@ -40,7 +40,7 @@ wrote 1/1 bytes at offset 2048
 
 == rechecking image refcounts ==
 No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=1048576
 
 == cluster size 32768
 == checking image refcounts ==
-- 
2.25.4


