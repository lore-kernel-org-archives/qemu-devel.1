Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA0BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E90620661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cK8+CFaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E90620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDlH-00032I-HO
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdg-0007tu-Ce
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdb-0008Ln-QR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:30:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58721
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixDdb-0008Je-KL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580405395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkB9ZEa0m8XBFo3M3uPzZ3ujCfkv9rb9bOzu/2URZaI=;
 b=cK8+CFaR+4rGKDlq5iemZm6T9bTxrcFyrvhmed2okhdHJZBxhpJ1XSGZ2oHjQWlH4rag+x
 +foMQYa5GH2Duy7x1I2OyzYlEhOYDntQvyc07ISWql51ECDdQQlJLpunQOwvUfy29HCQsm
 XQJejqEnlPXv8d2FOE4uoxmOCOBuRHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-tgb7e4wpMlGjuhNo8SR8jA-1; Thu, 30 Jan 2020 12:29:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D84BF800D41;
 Thu, 30 Jan 2020 17:29:51 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2D75D9E5;
 Thu, 30 Jan 2020 17:29:49 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/14] block/qcow2: extend qemu-img amend interface with
 crypto options
Date: Thu, 30 Jan 2020 19:29:13 +0200
Message-Id: <20200130172919.13424-9-mlevitsk@redhat.com>
In-Reply-To: <20200130172919.13424-1-mlevitsk@redhat.com>
References: <20200130172919.13424-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: tgb7e4wpMlGjuhNo8SR8jA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Now that we have all the infrastructure in place,
wire it in the qcow2 driver and expose this to the user.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2.c              |  83 +++++++++--
 tests/qemu-iotests/082.out | 288 +++++++++++++++++++++++++++++++++++++
 2 files changed, 360 insertions(+), 11 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b1a03a56a5..59c8a772cc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -173,6 +173,19 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBloc=
k *block, size_t offset,
     return ret;
 }
=20
+static QDict*
+qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
+{
+    QDict *cryptoopts_qdict;
+    QDict *opts_qdict;
+
+    /* Extract "encrypt." options into a qdict */
+    opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
+    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
+    qobject_unref(opts_qdict);
+    qdict_put_str(cryptoopts_qdict, "format", "luks");
+    return cryptoopts_qdict;
+}
=20
 /*=20
  * read qcow2 extension and fill bs
@@ -4620,20 +4633,18 @@ static ssize_t qcow2_measure_crypto_hdr_write_func(=
QCryptoBlock *block,
 static bool qcow2_measure_luks_headerlen(QemuOpts *opts, size_t *len,
                                          Error **errp)
 {
-    QDict *opts_qdict;
-    QDict *cryptoopts_qdict;
     QCryptoBlockCreateOptions *cryptoopts;
+    QDict *crypto_opts_dict;
     QCryptoBlock *crypto;
=20
-    /* Extract "encrypt." options into a qdict */
-    opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
-    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
-    qobject_unref(opts_qdict);
+    crypto_opts_dict =3D qcow2_extract_crypto_opts(opts, "luks", errp);
+    if (!crypto_opts_dict) {
+        return false;
+    }
+
+    cryptoopts =3D block_crypto_create_opts_init(crypto_opts_dict, errp);
+    qobject_unref(crypto_opts_dict);
=20
-    /* Build QCryptoBlockCreateOptions object from qdict */
-    qdict_put_str(cryptoopts_qdict, "format", "luks");
-    cryptoopts =3D block_crypto_create_opts_init(cryptoopts_qdict, errp);
-    qobject_unref(cryptoopts_qdict);
     if (!cryptoopts) {
         return false;
     }
@@ -5072,6 +5083,7 @@ typedef enum Qcow2AmendOperation {
     QCOW2_NO_OPERATION =3D 0,
=20
     QCOW2_UPGRADING,
+    QCOW2_UPDATING_ENCRYPTION,
     QCOW2_CHANGING_REFCOUNT_ORDER,
     QCOW2_DOWNGRADING,
 } Qcow2AmendOperation;
@@ -5153,6 +5165,7 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
     int ret;
     QemuOptDesc *desc =3D opts->list->desc;
     Qcow2AmendHelperCBInfo helper_cb_info;
+    bool encryption_update =3D false;
=20
     while (desc && desc->name) {
         if (!qemu_opt_find(opts, desc->name)) {
@@ -5179,6 +5192,18 @@ static int qcow2_amend_options(BlockDriverState *bs,=
 QemuOpts *opts,
             backing_file =3D qemu_opt_get(opts, BLOCK_OPT_BACKING_FILE);
         } else if (!strcmp(desc->name, BLOCK_OPT_BACKING_FMT)) {
             backing_format =3D qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
+        } else if (g_str_has_prefix(desc->name, "encrypt.")) {
+            if (!s->crypto) {
+                error_setg(errp,
+                           "Can't amend encryption options - encryption no=
t present");
+                return -EINVAL;
+            }
+            if (s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
+                error_setg(errp,
+                           "Only LUKS encryption options can be amended");
+                return -ENOTSUP;
+            }
+            encryption_update =3D true;
         } else if (!strcmp(desc->name, BLOCK_OPT_LAZY_REFCOUNTS)) {
             lazy_refcounts =3D qemu_opt_get_bool(opts, BLOCK_OPT_LAZY_REFC=
OUNTS,
                                                lazy_refcounts);
@@ -5221,7 +5246,8 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
         .original_status_cb =3D status_cb,
         .original_cb_opaque =3D cb_opaque,
         .total_operations =3D (new_version !=3D old_version)
-                          + (s->refcount_bits !=3D refcount_bits)
+                          + (s->refcount_bits !=3D refcount_bits) +
+                            (encryption_update =3D=3D true)
     };
=20
     /* Upgrade first (some features may require compat=3D1.1) */
@@ -5234,6 +5260,33 @@ static int qcow2_amend_options(BlockDriverState *bs,=
 QemuOpts *opts,
         }
     }
=20
+    if (encryption_update) {
+        QDict *amend_opts_dict;
+        QCryptoBlockAmendOptions *amend_opts;
+
+        helper_cb_info.current_operation =3D QCOW2_UPDATING_ENCRYPTION;
+        amend_opts_dict =3D qcow2_extract_crypto_opts(opts, "luks", errp);
+        if (!amend_opts_dict) {
+            return -EINVAL;
+        }
+        amend_opts =3D block_crypto_amend_opts_init(amend_opts_dict, errp)=
;
+        qobject_unref(amend_opts_dict);
+        if (!amend_opts) {
+            return -EINVAL;
+        }
+        ret =3D qcrypto_block_amend_options(s->crypto,
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
     if (s->refcount_bits !=3D refcount_bits) {
         int refcount_order =3D ctz32(refcount_bits);
=20
@@ -5488,6 +5541,14 @@ static QemuOptsList qcow2_amend_opts =3D {
     .name =3D "qcow2-amend-opts",
     .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_amend_opts.head),
     .desc =3D {
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.0."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.1."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.2."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.3."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.4."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.5."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.6."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.7."),
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
     }
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index c68458da8c..56461267e3 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -620,6 +620,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -631,6 +663,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -642,6 +706,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -653,6 +749,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -664,6 +792,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -675,6 +835,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -686,6 +878,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -697,6 +921,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -725,6 +981,38 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.keys.0.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.0.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.0.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.0.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.1.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.1.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.1.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.1.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.2.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.2.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.2.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.2.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.3.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.3.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.3.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.3.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.4.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.4.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.4.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.4.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.5.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.5.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.5.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.5.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.6.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.6.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.6.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.6.old-secret=3D<str> - Select all keyslots that match this =
password
+  encrypt.keys.7.iter-time=3D<num> - Time to spend in PBKDF in millisecond=
s
+  encrypt.keys.7.keyslot=3D<num> - Select a single keyslot to modify expli=
citly
+  encrypt.keys.7.new-secret=3D<str> - New secret to set in the matching ke=
yslots. Empty string to erase
+  encrypt.keys.7.old-secret=3D<str> - Select all keyslots that match this =
password
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
--=20
2.17.2


