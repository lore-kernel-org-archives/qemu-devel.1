Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8DDC10F28
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803102072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPaVdgfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803102072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxnG-0000aQ-KH
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiO-0000ei-HJ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiD-0001cy-BC
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46204
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxiD-0001ck-1T
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRxqZDVTETdL3QKoNq7W4FzYxbdV+JlhR0wDqeFnMqg=;
 b=OPaVdgfyzTyWUkQ1VKVZ2AgWCSYdWejDJWZD5bcrAcXei6PazgXqTZ5T3PaUomaXT2tQ1w
 BFXKyiAyFbEx/LUb30S+nqoGO8qPYJZJfgW19o6GAQ34F2qCE8Zvuy66E9xmffUY1exVD8
 944KKvGHm13/i8yzibJuMoHm3aRRmfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-uyQv2S6GNbewNGg-Fcz4wA-1; Sun, 08 Mar 2020 11:19:25 -0400
X-MC-Unique: uyQv2S6GNbewNGg-Fcz4wA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D91B61005512;
 Sun,  8 Mar 2020 15:19:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1529C5C1B0;
 Sun,  8 Mar 2020 15:19:21 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/14] block/amend: refactor qcow2 amend options
Date: Sun,  8 Mar 2020 17:18:54 +0200
Message-Id: <20200308151903.25941-6-mlevitsk@redhat.com>
In-Reply-To: <20200308151903.25941-1-mlevitsk@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Some qcow2 create options can't be used for amend.
Remove them from the qcow2 create options and add generic logic to detect
such options in qemu-img

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2.c              | 108 ++++++---------------
 qemu-img.c                 |  18 +++-
 tests/qemu-iotests/049.out | 102 ++++++++++----------
 tests/qemu-iotests/061.out |  12 ++-
 tests/qemu-iotests/079.out |  18 ++--
 tests/qemu-iotests/082.out | 149 ++++------------------------
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
 tests/qemu-iotests/263.out |   4 +-
 tests/qemu-iotests/280.out |   2 +-
 24 files changed, 283 insertions(+), 428 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 9574085772..81e7895e7c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2946,17 +2946,6 @@ static int qcow2_change_backing_file(BlockDriverStat=
e *bs,
     return qcow2_update_header(bs);
 }
=20
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
@@ -5155,9 +5144,6 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
     bool lazy_refcounts =3D s->use_lazy_refcounts;
     bool data_file_raw =3D data_file_is_raw(bs);
     const char *compat =3D NULL;
-    uint64_t cluster_size =3D s->cluster_size;
-    bool encrypt;
-    int encformat;
     int refcount_bits =3D s->refcount_bits;
     int ret;
     QemuOptDesc *desc =3D opts->list->desc;
@@ -5182,44 +5168,12 @@ static int qcow2_amend_options(BlockDriverState *bs=
, QemuOpts *opts,
                 error_setg(errp, "Unknown compatibility level %s", compat)=
;
                 return -EINVAL;
             }
-        } else if (!strcmp(desc->name, BLOCK_OPT_PREALLOC)) {
-            error_setg(errp, "Cannot change preallocation mode");
-            return -ENOTSUP;
         } else if (!strcmp(desc->name, BLOCK_OPT_SIZE)) {
             new_size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
         } else if (!strcmp(desc->name, BLOCK_OPT_BACKING_FILE)) {
             backing_file =3D qemu_opt_get(opts, BLOCK_OPT_BACKING_FILE);
         } else if (!strcmp(desc->name, BLOCK_OPT_BACKING_FMT)) {
             backing_format =3D qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
-        } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPT)) {
-            encrypt =3D qemu_opt_get_bool(opts, BLOCK_OPT_ENCRYPT,
-                                        !!s->crypto);
-
-            if (encrypt !=3D !!s->crypto) {
-                error_setg(errp,
-                           "Changing the encryption flag is not supported"=
);
-                return -ENOTSUP;
-            }
-        } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPT_FORMAT)) {
-            encformat =3D qcow2_crypt_method_from_format(
-                qemu_opt_get(opts, BLOCK_OPT_ENCRYPT_FORMAT));
-
-            if (encformat !=3D s->crypt_method_header) {
-                error_setg(errp,
-                           "Changing the encryption format is not supporte=
d");
-                return -ENOTSUP;
-            }
-        } else if (g_str_has_prefix(desc->name, "encrypt.")) {
-            error_setg(errp,
-                       "Changing the encryption parameters is not supporte=
d");
-            return -ENOTSUP;
-        } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
-            cluster_size =3D qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZ=
E,
-                                             cluster_size);
-            if (cluster_size !=3D s->cluster_size) {
-                error_setg(errp, "Changing the cluster size is not support=
ed");
-                return -ENOTSUP;
-            }
         } else if (!strcmp(desc->name, BLOCK_OPT_LAZY_REFCOUNTS)) {
             lazy_refcounts =3D qemu_opt_get_bool(opts, BLOCK_OPT_LAZY_REFC=
OUNTS,
                                                lazy_refcounts);
@@ -5472,37 +5426,6 @@ void qcow2_signal_corruption(BlockDriverState *bs, b=
ool fatal, int64_t offset,
         .help =3D "The external data file must stay valid "           \
                 "as a raw image"                                    \
     },                                                              \
-    {                                                               \
-        .name =3D BLOCK_OPT_ENCRYPT,                                  \
-        .type =3D QEMU_OPT_BOOL,                                      \
-        .help =3D "Encrypt the image with format 'aes'. (Deprecated " \
-                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",    \
-    },                                                              \
-    {                                                               \
-        .name =3D BLOCK_OPT_ENCRYPT_FORMAT,                           \
-        .type =3D QEMU_OPT_STRING,                                    \
-        .help =3D "Encrypt the image, format choices: 'aes', 'luks'", \
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
-        .name =3D BLOCK_OPT_CLUSTER_SIZE,                             \
-        .type =3D QEMU_OPT_SIZE,                                      \
-        .help =3D "qcow2 cluster size",                               \
-        .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)            \
-    },                                                              \
-    {                                                               \
-        .name =3D BLOCK_OPT_PREALLOC,                                 \
-        .type =3D QEMU_OPT_STRING,                                    \
-        .help =3D "Preallocation mode (allowed values: off, "         \
-                "metadata, falloc, full)"                           \
-    },                                                              \
     {                                                               \
         .name =3D BLOCK_OPT_LAZY_REFCOUNTS,                           \
         .type =3D QEMU_OPT_BOOL,                                      \
@@ -5520,6 +5443,37 @@ static QemuOptsList qcow2_create_opts =3D {
     .name =3D "qcow2-create-opts",
     .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
     .desc =3D {
+        {                                                               \
+            .name =3D BLOCK_OPT_ENCRYPT,                                  =
\
+            .type =3D QEMU_OPT_BOOL,                                      =
\
+            .help =3D "Encrypt the image with format 'aes'. (Deprecated " =
\
+                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",    =
\
+        },                                                              \
+        {                                                               \
+            .name =3D BLOCK_OPT_ENCRYPT_FORMAT,                           =
\
+            .type =3D QEMU_OPT_STRING,                                    =
\
+            .help =3D "Encrypt the image, format choices: 'aes', 'luks'", =
\
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
+            .name =3D BLOCK_OPT_CLUSTER_SIZE,                             =
\
+            .type =3D QEMU_OPT_SIZE,                                      =
\
+            .help =3D "qcow2 cluster size",                               =
\
+            .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)            =
\
+        },                                                              \
+        {                                                               \
+            .name =3D BLOCK_OPT_PREALLOC,                                 =
\
+            .type =3D QEMU_OPT_STRING,                                    =
\
+            .help =3D "Preallocation mode (allowed values: off, "         =
\
+                    "metadata, falloc, full)"                           \
+        },                                                              \
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
     }
diff --git a/qemu-img.c b/qemu-img.c
index 2555aedee9..ddb25fad8f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3901,9 +3901,8 @@ static int print_amend_option_help(const char *format=
)
     /* Every driver supporting amendment must have amend_opts */
     assert(drv->amend_opts);
=20
-    printf("Creation options for '%s':\n", format);
+    printf("Amend options for '%s':\n", format);
     qemu_opts_print_help(drv->amend_opts, false);
-    printf("\nNote that not all of these options may be amendable.\n");
     return 0;
 }
=20
@@ -4057,7 +4056,22 @@ static int img_amend(int argc, char **argv)
     amend_opts =3D qemu_opts_append(amend_opts, bs->drv->amend_opts);
     opts =3D qemu_opts_create(amend_opts, NULL, 0, &error_abort);
     qemu_opts_do_parse(opts, options, NULL, &err);
+
     if (err) {
+        /* Try to parse options using the create options*/
+        Error *err1 =3D NULL;
+        amend_opts =3D qemu_opts_append(amend_opts, bs->drv->create_opts);
+        qemu_opts_del(opts);
+        opts =3D qemu_opts_create(amend_opts, NULL, 0, &error_abort);
+        qemu_opts_do_parse(opts, options, NULL, &err1);
+
+        if (!err1) {
+            error_append_hint(&err,
+                              "This option is only supported for image cre=
ation\n");
+        } else {
+            error_free(err1);
+        }
+
         error_report_err(err);
         ret =3D -1;
         goto out;
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index affa55b341..dad3be70d3 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -4,90 +4,90 @@ QA output created by 049
 =3D=3D 1. Traditional size parameter =3D=3D
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D104=
8576 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D107=
3741824 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D109=
9511627776 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D153=
6 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D153=
6 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D157=
2864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D161=
0612736 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D164=
9267441664 lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D 2. Specifying size via -o =3D=3D
=20
 qemu-img create -f qcow2 -o size=3D1024 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1024b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D104=
8576 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D107=
3741824 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D109=
9511627776 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1024.0 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1024.0b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D102=
4 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1.5k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D153=
6 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1.5K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6553=
6 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D153=
6 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1.5M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D157=
2864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1.5G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D161=
0612736 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o size=3D1.5T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D164=
9267441664 lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D 3. Invalid sizes =3D=3D
=20
@@ -129,84 +129,84 @@ qemu-img: TEST_DIR/t.qcow2: The image size must be sp=
ecified only once
 =3D=3D Check correct interpretation of suffixes for cluster size =3D=3D
=20
 qemu-img create -f qcow2 -o cluster_size=3D1024 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
1024 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D1024 size=3D6710=
8864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D1024b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
1024 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D1024 size=3D6710=
8864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D1k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
1024 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D1024 size=3D6710=
8864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D1K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
1024 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D1024 size=3D6710=
8864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D1M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
1048576 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D1048576 size=3D6=
7108864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D1024.0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
1024 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D1024 size=3D6710=
8864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D1024.0b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
1024 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D1024 size=3D6710=
8864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D0.5k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
512 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D512 size=3D67108=
864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D0.5K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
512 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D512 size=3D67108=
864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o cluster_size=3D0.5M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
524288 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D524288 size=3D67=
108864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D Check compat level option =3D=3D
=20
 qemu-img create -f qcow2 -o compat=3D0.10 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.10 c=
luster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 compat=3D0.10 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3D1.1 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1 cl=
uster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 compat=3D1.1 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3D0.42 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.42 c=
luster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 compat=3D0.42 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3Dfoobar TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3Dfoobar=
 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 compat=3Dfoobar lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D Check preallocation option =3D=3D
=20
 qemu-img create -f qcow2 -o preallocation=3Doff TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
65536 preallocation=3Doff lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 preallocat=
ion=3Doff size=3D67108864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o preallocation=3Dmetadata TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
65536 preallocation=3Dmetadata lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 preallocat=
ion=3Dmetadata size=3D67108864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o preallocation=3D1234 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
65536 preallocation=3D1234 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 preallocat=
ion=3D1234 size=3D67108864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D Check encryption option =3D=3D
=20
 qemu-img create -f qcow2 -o encryption=3Doff TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Dof=
f cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 encryption=3Doff cluster_size=
=3D65536 size=3D67108864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 --object secret,id=3Dsec0,data=3D123456 -o encryp=
tion=3Don,encrypt.key-secret=3Dsec0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Don=
 encrypt.key-secret=3Dsec0 cluster_size=3D65536 lazy_refcounts=3Doff refcou=
nt_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 encryption=3Don encrypt.key-sec=
ret=3Dsec0 cluster_size=3D65536 size=3D67108864 lazy_refcounts=3Doff refcou=
nt_bits=3D16
=20
 =3D=3D Check lazy_refcounts option (only with v3) =3D=3D
=20
 qemu-img create -f qcow2 -o compat=3D1.1,lazy_refcounts=3Doff TEST_DIR/t.q=
cow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1 cl=
uster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 compat=3D1.1 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3D1.1,lazy_refcounts=3Don TEST_DIR/t.qc=
ow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1 cl=
uster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 compat=3D1.1 lazy_refcounts=3Don refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3D0.10,lazy_refcounts=3Doff TEST_DIR/t.=
qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.10 c=
luster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 compat=3D0.10 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3D0.10,lazy_refcounts=3Don TEST_DIR/t.q=
cow2 64M
 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibili=
ty level 1.1 and above (use version=3Dv3 or greater)
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.10 c=
luster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 compat=3D0.10 lazy_refcounts=3Don refcount_bits=3D16
=20
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 8b3091a412..2ce6bcff06 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -353,16 +353,20 @@ qemu-img: Lazy refcounts only supported with compatib=
ility level 1.1 and above (
 qemu-img: Lazy refcounts only supported with compatibility level 1.1 and a=
bove (use compat=3D1.1 or greater)
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
=20
 =3D=3D=3D Testing correct handling of unset value =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Should work:
 Should not work:
-qemu-img: Changing the cluster size is not supported
+qemu-img: Invalid parameter 'cluster_size'
+This option is only supported for image creation
=20
 =3D=3D=3D Testing zero expansion on inactive clusters =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/079.out b/tests/qemu-iotests/079.out
index aab922fb36..c7e37152f4 100644
--- a/tests/qemu-iotests/079.out
+++ b/tests/qemu-iotests/079.out
@@ -1,14 +1,14 @@
 QA output created by 079
 =3D=3D=3D Check option preallocation and cluster_size =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
 qemu-img: TEST_DIR/t.IMGFMT: Cluster size must be a power of two between 5=
12 and 2048k
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D4294967296
 *** done
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 9d4ed4dc9d..c68458da8c 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -3,14 +3,14 @@ QA output created by 082
 =3D=3D=3D create: Options specified more than once =3D=3D=3D
=20
 Testing: create -f foo -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D134=
217728 lazy_refcounts=3Doff refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
=20
 Testing: create -f qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don TEST_=
DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D4096 lazy_refcounts=3Don refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D4096 size=3D1342=
17728 lazy_refcounts=3Don refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -22,7 +22,7 @@ Format specific information:
     corrupt: false
=20
 Testing: create -f qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don -o cl=
uster_size=3D8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D8192 lazy_refcounts=3Don refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D8192 size=3D1342=
17728 lazy_refcounts=3Don refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -34,7 +34,7 @@ Format specific information:
     corrupt: false
=20
 Testing: create -f qcow2 -o cluster_size=3D4k,cluster_size=3D8k TEST_DIR/t=
.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D8192 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D8192 size=3D1342=
17728 lazy_refcounts=3Doff refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -227,10 +227,10 @@ Supported options:
   size=3D<size>            - Virtual disk size
=20
 Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,help TEST_=
DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_file=
=3DTEST_DIR/t.qcow2,,help cluster_size=3D65536 lazy_refcounts=3Doff refcoun=
t_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D134=
217728 backing_file=3DTEST_DIR/t.qcow2,,help lazy_refcounts=3Doff refcount_=
bits=3D16
=20
 Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,? TEST_DIR=
/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_file=
=3DTEST_DIR/t.qcow2,,? cluster_size=3D65536 lazy_refcounts=3Doff refcount_b=
its=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D134=
217728 backing_file=3DTEST_DIR/t.qcow2,,? lazy_refcounts=3Doff refcount_bit=
s=3D16
=20
 Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2, -o help TEST_=
DIR/t.qcow2 128M
 qemu-img: Invalid option list: backing_file=3DTEST_DIR/t.qcow2,
@@ -279,7 +279,7 @@ qemu-img: Format driver 'bochs' does not support image =
creation
 =3D=3D=3D convert: Options specified more than once =3D=3D=3D
=20
 Testing: create -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D134=
217728 lazy_refcounts=3Doff refcount_bits=3D16
=20
 Testing: convert -f foo -f qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -614,197 +614,93 @@ cluster_size: 65536
 =3D=3D=3D amend: help for -o =3D=3D=3D
=20
 Testing: amend -f qcow2 -o help TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o ? TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o cluster_size=3D4k,help TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o cluster_size=3D4k,? TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o help,cluster_size=3D4k TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o ?,cluster_size=3D4k TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o cluster_size=3D4k -o help TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o cluster_size=3D4k -o ? TEST_DIR/t.qcow2
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,help TEST_DIR/=
t.qcow2
=20
 Testing: rebase -u -b  -f qcow2 TEST_DIR/t.qcow2
@@ -823,29 +719,16 @@ Testing: amend -f qcow2 -o backing_file=3DTEST_DIR/t.=
qcow2 -o ,, -o help TEST_DIR/
 qemu-img: Invalid option list: ,,
=20
 Testing: amend -f qcow2 -o help
-Creation options for 'qcow2':
+Amend options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
-  cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
-  encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
-  encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
-  encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', 'lu=
ks'
-  encrypt.hash-alg=3D<str> - Name of encryption hash algorithm
-  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
-  encrypt.ivgen-alg=3D<str> - Name of IV generator algorithm
-  encrypt.ivgen-hash-alg=3D<str> - Name of IV generator hash algorithm
-  encrypt.key-secret=3D<str> - ID of secret providing qcow AES key or LUKS=
 passphrase
-  encryption=3D<bool (on/off)> - Encrypt the image with format 'aes'. (Dep=
recated in favor of encrypt.format=3Daes)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
-  preallocation=3D<str>    - Preallocation mode (allowed values: off, meta=
data, falloc, full)
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
-Note that not all of these options may be amendable.
-
 Testing: amend -o help
 qemu-img: Expecting one image file name
=20
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index d94ad22f70..eade125a33 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -13,7 +13,7 @@ Formatting 'TEST_DIR/t.IMGFMT.2', fmt=3DIMGFMT size=3D134=
217728
 =3D=3D=3D Create a single snapshot on virtio0 =3D=3D=3D
=20
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0',=
 'snapshot-file':'TEST_DIR/1-snapshot-v0.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/t.qcow2.1 backing_fmt=3Dqcow2 cluster_size=3D65536 la=
zy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/t.qcow2.1 backing_fmt=3Dqcow2 la=
zy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
=20
 =3D=3D=3D Invalid command - missing device and nodename =3D=3D=3D
@@ -30,40 +30,40 @@ Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=3Dqcow2 =
size=3D134217728 backing_file
 =3D=3D=3D Create several transactional group snapshots =3D=3D=3D
=20
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/2-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/2-snapshot-v1.IMGFMT' } } ]=
 } }
-Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/1-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/t.qcow2.2 backing_fmt=3Dqcow2 cluster_size=3D65536 la=
zy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/1-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/t.qcow2.2 backing_fmt=3Dqcow2 la=
zy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/3-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/3-snapshot-v1.IMGFMT' } } ]=
 } }
-Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/2-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/2-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/2-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/2-snapshot-v1.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/4-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/4-snapshot-v1.IMGFMT' } } ]=
 } }
-Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/3-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/3-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/3-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/3-snapshot-v1.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/5-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/5-snapshot-v1.IMGFMT' } } ]=
 } }
-Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/4-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/4-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/4-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/4-snapshot-v1.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/6-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/6-snapshot-v1.IMGFMT' } } ]=
 } }
-Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/5-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/5-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/5-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/5-snapshot-v1.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/7-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/7-snapshot-v1.IMGFMT' } } ]=
 } }
-Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/6-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/6-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/6-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/6-snapshot-v1.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/8-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/8-snapshot-v1.IMGFMT' } } ]=
 } }
-Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/7-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/7-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/7-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/7-snapshot-v1.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/9-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/9-snapshot-v1.IMGFMT' } } ]=
 } }
-Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/8-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/8-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/8-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D6553=
6 size=3D134217728 backing_file=3DTEST_DIR/8-snapshot-v1.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/10-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : {=
 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/10-snapshot-v1.IMGFMT' } }=
 ] } }
-Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 b=
acking_file=3DTEST_DIR/9-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 b=
acking_file=3DTEST_DIR/9-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=3Dqcow2 cluster_size=3D655=
36 size=3D134217728 backing_file=3DTEST_DIR/9-snapshot-v0.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=3Dqcow2 cluster_size=3D655=
36 size=3D134217728 backing_file=3DTEST_DIR/9-snapshot-v1.qcow2 backing_fmt=
=3Dqcow2 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
=20
 =3D=3D=3D Create a couple of snapshots using blockdev-snapshot =3D=3D=3D
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 2d92ea847b..f23bffbbf1 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -34,7 +34,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image QCow =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -46,7 +46,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image LUKS =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypt.form=
at=3Dluks encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 size=3D134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -58,7 +58,7 @@ QMP_VERSION
=20
 =3D=3D=3D Missing driver =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
 Testing: -S
 QMP_VERSION
 {"return": {}}
diff --git a/tests/qemu-iotests/115.out b/tests/qemu-iotests/115.out
index dbdad17b27..074b5cc84d 100644
--- a/tests/qemu-iotests/115.out
+++ b/tests/qemu-iotests/115.out
@@ -2,7 +2,7 @@ QA output created by 115
=20
 =3D=3D=3D Testing large refcount and L1 table =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D268435456 preallocatio=
n=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D268435456
 No errors were found on the image.
 100.00% allocated clusters
 *** done
diff --git a/tests/qemu-iotests/121.out b/tests/qemu-iotests/121.out
index 613d56185e..fbe4b575f7 100644
--- a/tests/qemu-iotests/121.out
+++ b/tests/qemu-iotests/121.out
@@ -4,7 +4,7 @@ QA output created by 121
=20
 --- Test 1 ---
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D66060288 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D66060288
 Image resized.
 wrote 1049600/1049600 bytes at offset 65011712
 1.001 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -14,7 +14,7 @@ No errors were found on the image.
=20
 --- Test 2 ---
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D66061312 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D66061312
 Image resized.
 wrote 133120/133120 bytes at offset 66060288
 130 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/125.out b/tests/qemu-iotests/125.out
index 596905f533..767c52d622 100644
--- a/tests/qemu-iotests/125.out
+++ b/tests/qemu-iotests/125.out
@@ -1,6 +1,6 @@
 QA output created by 125
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Doff growth_mode=3Dof=
f ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -8,7 +8,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Doff growth_mode=3Dme=
tadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -16,7 +16,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Doff growth_mode=3Dfa=
lloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -24,7 +24,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Doff growth_mode=3Dfu=
ll ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -32,7 +32,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dmetadata growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -40,7 +40,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dmetadata growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -48,7 +48,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dmetadata growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -56,7 +56,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dmetadata growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -64,7 +64,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dfalloc growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -72,7 +72,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dfalloc growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -80,7 +80,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dfalloc growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -88,7 +88,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dfalloc growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -96,7 +96,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dfull growth_mode=3Do=
ff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -104,7 +104,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dfull growth_mode=3Dm=
etadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -112,7 +112,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dfull growth_mode=3Df=
alloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -120,7 +120,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D16 create_mode=3Dfull growth_mode=3Df=
ull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -128,7 +128,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Doff growth_mode=3Dof=
f ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -136,7 +136,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Doff growth_mode=3Dme=
tadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -144,7 +144,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Doff growth_mode=3Dfa=
lloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -152,7 +152,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Doff growth_mode=3Dfu=
ll ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -160,7 +160,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dmetadata growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -168,7 +168,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dmetadata growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -176,7 +176,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dmetadata growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -184,7 +184,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dmetadata growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -192,7 +192,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dfalloc growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -200,7 +200,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dfalloc growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -208,7 +208,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dfalloc growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -216,7 +216,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dfalloc growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -224,7 +224,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dfull growth_mode=3Do=
ff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -232,7 +232,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dfull growth_mode=3Dm=
etadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -240,7 +240,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dfull growth_mode=3Df=
alloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -248,7 +248,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D48 create_mode=3Dfull growth_mode=3Df=
ull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -256,7 +256,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Doff growth_mode=3Dof=
f ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -264,7 +264,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Doff growth_mode=3Dme=
tadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -272,7 +272,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Doff growth_mode=3Dfa=
lloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -280,7 +280,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Doff growth_mode=3Dfu=
ll ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -288,7 +288,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dmetadata growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -296,7 +296,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dmetadata growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -304,7 +304,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dmetadata growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -312,7 +312,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dmetadata growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -320,7 +320,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dfalloc growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -328,7 +328,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dfalloc growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -336,7 +336,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dfalloc growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -344,7 +344,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dfalloc growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -352,7 +352,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dfull growth_mode=3Do=
ff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -360,7 +360,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dfull growth_mode=3Dm=
etadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -368,7 +368,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dfull growth_mode=3Df=
alloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -376,7 +376,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D512 growth_size=3D80 create_mode=3Dfull growth_mode=3Df=
ull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -384,7 +384,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Doff growth_mode=3Dof=
f ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -392,7 +392,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Doff growth_mode=3Dme=
tadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -400,7 +400,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Doff growth_mode=3Dfa=
lloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -408,7 +408,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Doff growth_mode=3Dfu=
ll ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -416,7 +416,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dmetadata growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -424,7 +424,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dmetadata growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -432,7 +432,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dmetadata growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -440,7 +440,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dmetadata growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -448,7 +448,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dfalloc growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -456,7 +456,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dfalloc growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -464,7 +464,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dfalloc growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -472,7 +472,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dfalloc growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -480,7 +480,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dfull growth_mode=3Do=
ff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -488,7 +488,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dfull growth_mode=3Dm=
etadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -496,7 +496,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dfull growth_mode=3Df=
alloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -504,7 +504,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D16 create_mode=3Dfull growth_mode=3Df=
ull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -512,7 +512,7 @@ wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Doff growth_mode=3Dof=
f ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -520,7 +520,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Doff growth_mode=3Dme=
tadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -528,7 +528,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Doff growth_mode=3Dfa=
lloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -536,7 +536,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Doff growth_mode=3Dfu=
ll ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -544,7 +544,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dmetadata growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -552,7 +552,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dmetadata growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -560,7 +560,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dmetadata growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -568,7 +568,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dmetadata growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -576,7 +576,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dfalloc growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -584,7 +584,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dfalloc growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -592,7 +592,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dfalloc growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -600,7 +600,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dfalloc growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -608,7 +608,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dfull growth_mode=3Do=
ff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -616,7 +616,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dfull growth_mode=3Dm=
etadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -624,7 +624,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dfull growth_mode=3Df=
alloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -632,7 +632,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D48 create_mode=3Dfull growth_mode=3Df=
ull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -640,7 +640,7 @@ wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Doff growth_mode=3Dof=
f ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -648,7 +648,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Doff growth_mode=3Dme=
tadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -656,7 +656,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Doff growth_mode=3Dfa=
lloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -664,7 +664,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Doff growth_mode=3Dfu=
ll ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D20=
48000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -672,7 +672,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dmetadata growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -680,7 +680,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dmetadata growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -688,7 +688,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dmetadata growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -696,7 +696,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dmetadata growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -704,7 +704,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dfalloc growth_mode=
=3Doff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -712,7 +712,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dfalloc growth_mode=
=3Dmetadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -720,7 +720,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dfalloc growth_mode=
=3Dfalloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -728,7 +728,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dfalloc growth_mode=
=3Dfull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D2048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -736,7 +736,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dfull growth_mode=3Do=
ff ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -744,7 +744,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dfull growth_mode=3Dm=
etadata ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -752,7 +752,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dfull growth_mode=3Df=
alloc ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -760,7 +760,7 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 --- cluster_size=3D64k growth_size=3D80 create_mode=3Dfull growth_mode=3Df=
ull ---
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2048000 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D2=
048000
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
 1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 09d46f6b17..f2878f5f3a 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -1,5 +1,5 @@
 QA output created by 134
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
=20
 =3D=3D reading whole image =3D=3D
 read 134217728/134217728 bytes at offset 0
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index c7aa2e4820..3900a46ed0 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D5368709=
12
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0',=
 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D536870912 backing_file=
=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcounts=
=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D5=
36870912 backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 lazy_refcounts=
=3Doff refcount_bits=3D16
 {"return": {}}
=20
 =3D=3D=3D Performing block-commit on active layer =3D=3D=3D
@@ -31,6 +31,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D53687=
0912 backing_file=3DTEST_DIR/
 =3D=3D=3D Performing Live Snapshot 2 =3D=3D=3D
=20
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0',=
 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp2.qcow2', fmt=3Dqcow2 size=3D536870912 backing_fil=
e=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcount=
s=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/tmp2.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D=
536870912 backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 lazy_refcount=
s=3Doff refcount_bits=3D16
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index 6def216e55..fa2294bb85 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -1,6 +1,6 @@
 QA output created by 158
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728 encrypt=
ion=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encryption=3Don encrypt.=
key-secret=3Dsec0 size=3D134217728
=20
 =3D=3D writing whole image =3D=3D
 wrote 134217728/134217728 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base encryption=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728 backing_file=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index a8eea166c3..a31bfb57b3 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -13,7 +13,7 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0', 'driver':=
 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
 {'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name': 'node0',=
 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'snapshot-node-name': 'node1=
' } }
-Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=3D197120 backing_f=
ile=3DTEST_DIR/t.qcow2 backing_fmt=3Dfile cluster_size=3D65536 lazy_refcoun=
ts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 cluster_size=3D65536 si=
ze=3D197120 backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dfile lazy_refcoun=
ts=3Doff refcount_bits=3D16
 {"return": {}}
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1', 'driver':=
 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 9a3b65782b..41c4773edc 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -9,14 +9,14 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 =3D=3D=3D Creating backing chain =3D=3D=3D
=20
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 's=
napshot-file': 'TEST_DIR/t.IMGFMT.mid', 'format': 'IMGFMT', 'mode': 'absolu=
te-paths' } }
-Formatting 'TEST_DIR/t.qcow2.mid', fmt=3Dqcow2 size=3D67108864 backing_fil=
e=3DTEST_DIR/t.qcow2.base backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_ref=
counts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2.mid', fmt=3Dqcow2 cluster_size=3D65536 size=
=3D67108864 backing_file=3DTEST_DIR/t.qcow2.base backing_fmt=3Dqcow2 lazy_r=
efcounts=3Doff refcount_bits=3D16
 {"return": {}}
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io disk "write 0 4M"' } }
 wrote 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 's=
napshot-file': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'absolute-p=
aths' } }
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 backing_file=3D=
TEST_DIR/t.qcow2.mid backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcount=
s=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=3D671=
08864 backing_file=3DTEST_DIR/t.qcow2.mid backing_fmt=3Dqcow2 lazy_refcount=
s=3Doff refcount_bits=3D16
 {"return": {}}
=20
 =3D=3D=3D Start commit job and exit qemu =3D=3D=3D
@@ -48,7 +48,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D6710886=
4 backing_file=3DTEST_DIR/t.q
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-mirror', 'arguments': { 'device': 'disk', 'target': 'T=
EST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 =
} }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D67108864 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 cluster_size=3D65536 size=
=3D67108864 lazy_refcounts=3Doff refcount_bits=3D16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
@@ -62,7 +62,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D67=
108864 cluster_size=3D65536 l
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'T=
EST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 =
} }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D67108864 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 cluster_size=3D65536 size=
=3D67108864 lazy_refcounts=3Doff refcount_bits=3D16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index c568ef3701..4b9aadd51c 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -1,5 +1,5 @@
 QA output created by 188
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 encrypt.forma=
t=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
=20
 =3D=3D reading whole image =3D=3D
 read 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index a0b7c9c24c..e536d95d53 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -1,6 +1,6 @@
 QA output created by 189
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216 encrypt.=
format=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encrypt.format=3Dluks en=
crypt.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
=20
 =3D=3D writing whole image =3D=3D
 wrote 16777216/16777216 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base encrypt.format=3Dluks encrypt.key-secret=3Dsec1 e=
ncrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec1 encrypt.iter-time=3D10 size=3D16777216 backing_file=3DTE=
ST_DIR/t.IMGFMT.base
=20
 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 831ce3a289..b0f2d417af 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -1,12 +1,12 @@
 QA output created by 198
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216 encrypt.=
format=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encrypt.format=3Dluks en=
crypt.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
=20
 =3D=3D writing whole image base =3D=3D
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base encrypt.format=3Dluks encrypt.key-secret=3Dsec1 e=
ncrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec1 encrypt.iter-time=3D10 size=3D16777216 backing_file=3DTE=
ST_DIR/t.IMGFMT.base
=20
 =3D=3D writing whole image layer =3D=3D
 wrote 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/243.out b/tests/qemu-iotests/243.out
index dcb33fac32..341ef3b7d0 100644
--- a/tests/qemu-iotests/243.out
+++ b/tests/qemu-iotests/243.out
@@ -2,31 +2,31 @@ QA output created by 243
=20
 =3D=3D=3D preallocation=3Doff =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocation=
=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D67=
108864
 File size: 196616
 Disk usage: low
=20
 =3D=3D=3D preallocation=3Dmetadata =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocation=
=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D67108864
 File size: 67436544
 Disk usage: low
=20
 =3D=3D=3D preallocation=3Dfalloc =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocation=
=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D67108864
 File size: 67436544
 Disk usage: high
=20
 =3D=3D=3D preallocation=3Dfull =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocation=
=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D6=
7108864
 File size: 67436544
 Disk usage: high
=20
 =3D=3D=3D External data file: preallocation=3Doff =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3DT=
EST_DIR/t.IMGFMT.data preallocation=3Doff
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Doff size=3D67=
108864 data_file=3DTEST_DIR/t.IMGFMT.data
 qcow2 file size: 196616
 data file size:  67108864
 qcow2 disk usage: low
@@ -34,7 +34,7 @@ data disk usage:  low
=20
 =3D=3D=3D External data file: preallocation=3Dmetadata =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3DT=
EST_DIR/t.IMGFMT.data preallocation=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D67108864 data_file=3DTEST_DIR/t.IMGFMT.data
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
@@ -42,7 +42,7 @@ data disk usage:  low
=20
 =3D=3D=3D External data file: preallocation=3Dfalloc =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3DT=
EST_DIR/t.IMGFMT.data preallocation=3Dfalloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfalloc size=
=3D67108864 data_file=3DTEST_DIR/t.IMGFMT.data
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
@@ -50,7 +50,7 @@ data disk usage:  high
=20
 =3D=3D=3D External data file: preallocation=3Dfull =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3DT=
EST_DIR/t.IMGFMT.data preallocation=3Dfull
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dfull size=3D6=
7108864 data_file=3DTEST_DIR/t.IMGFMT.data
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
diff --git a/tests/qemu-iotests/250.out b/tests/qemu-iotests/250.out
index f480fd273b..0b737097f3 100644
--- a/tests/qemu-iotests/250.out
+++ b/tests/qemu-iotests/250.out
@@ -1,5 +1,5 @@
 QA output created by 250
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202009600 preallocati=
on=3Dmetadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT preallocation=3Dmetadata size=
=3D2202009600
 discard 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 discard 10485760/10485760 bytes at offset 2191523840
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
index 348909fdef..96502e4336 100644
--- a/tests/qemu-iotests/255.out
+++ b/tests/qemu-iotests/255.out
@@ -3,9 +3,9 @@ Finishing a commit job with background reads
=20
 =3D=3D=3D Create backing chain and start VM =3D=3D=3D
=20
-Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=3Dqcow2 size=3D134217728 cluste=
r_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=3Dqcow2 cluster_size=3D65536 si=
ze=3D134217728 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-t.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=
=3D134217728 lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D=3D Start background read requests =3D=3D=3D
=20
@@ -23,9 +23,9 @@ Closing the VM while a job is being cancelled
=20
 =3D=3D=3D Create images and start VM =3D=3D=3D
=20
-Formatting 'TEST_DIR/PID-src.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_=
size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-src.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=
=3D134217728 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-dst.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_=
size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-dst.qcow2', fmt=3Dqcow2 cluster_size=3D65536 size=
=3D134217728 lazy_refcounts=3Doff refcount_bits=3D16
=20
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
index 0c982c55cb..4cf5c79ed8 100644
--- a/tests/qemu-iotests/263.out
+++ b/tests/qemu-iotests/263.out
@@ -2,7 +2,7 @@ QA output created by 263
=20
 testing LUKS qcow2 encryption
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D1048576
 =3D=3D reading the whole image =3D=3D
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -21,7 +21,7 @@ read 982528/982528 bytes at offset 66048
=20
 testing legacy AES qcow2 encryption
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Daes encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Daes encrypt.=
key-secret=3Dsec0 size=3D1048576
 =3D=3D reading the whole image =3D=3D
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index 5d382faaa8..0c0a30456b 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -1,4 +1,4 @@
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D67=
108864 lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D=3D Launch VM =3D=3D=3D
 Enabling migration QMP events on VM...
--=20
2.17.2


