Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B742C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 18:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89E5206E9
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 18:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2QvJhkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89E5206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVJfB-0002DD-W6
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 14:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVJan-0003SH-ID
 for qemu-devel@nongnu.org; Sun, 03 May 2020 14:43:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVJal-0000IO-6S
 for qemu-devel@nongnu.org; Sun, 03 May 2020 14:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588531434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHOhOjn9eEMKqRbbgC6hH96NXhbUuGaYAC6Q8EDS7rA=;
 b=U2QvJhkZR+us5LiPAX3xeR6MY98jGUba6IKdVuqPP1YoSBYOeue0mPw+0fyh9Xt9WjRXFr
 XGDPULOdquqoqbAAwrL89vOgUQP1Lj4KJOoE1P7XT1bgpQ62wvTQDWqRvdSeNyI2ehU35g
 k6ARKt0S15h6wg+NHOMzZ99WGk+dWUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-ZuWCZt37O1iQkhCC-S4vKA-1; Sun, 03 May 2020 14:43:52 -0400
X-MC-Unique: ZuWCZt37O1iQkhCC-S4vKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671D3107ACF2;
 Sun,  3 May 2020 18:43:51 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 274145C1B2;
 Sun,  3 May 2020 18:43:48 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/14] block/qcow2: extend qemu-img amend interface with
 crypto options
Date: Sun,  3 May 2020 21:43:18 +0300
Message-Id: <20200503184324.12506-9-mlevitsk@redhat.com>
In-Reply-To: <20200503184324.12506-1-mlevitsk@redhat.com>
References: <20200503184324.12506-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/03 14:43:34
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we have all the infrastructure in place,
wire it in the qcow2 driver and expose this to the user.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/qcow2.c              | 72 +++++++++++++++++++++++++++++++++-----
 tests/qemu-iotests/082.out | 45 ++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index e6c4d0b0b4..ce1e25f341 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -176,6 +176,19 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBloc=
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
+    qdict_put_str(cryptoopts_qdict, "format", fmt);
+    return cryptoopts_qdict;
+}
=20
 /*
  * read qcow2 extension and fill bs
@@ -4733,17 +4746,11 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *op=
ts, BlockDriverState *in_bs,
     g_free(optstr);
=20
     if (has_luks) {
+
         g_autoptr(QCryptoBlockCreateOptions) create_opts =3D NULL;
-        QDict *opts_qdict;
-        QDict *cryptoopts;
+        QDict *cryptoopts =3D qcow2_extract_crypto_opts(opts, "luks", errp=
);
         size_t headerlen;
=20
-        opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
-        qdict_extract_subqdict(opts_qdict, &cryptoopts, "encrypt.");
-        qobject_unref(opts_qdict);
-
-        qdict_put_str(cryptoopts, "format", "luks");
-
         create_opts =3D block_crypto_create_opts_init(cryptoopts, errp);
         qobject_unref(cryptoopts);
         if (!create_opts) {
@@ -5122,6 +5129,7 @@ typedef enum Qcow2AmendOperation {
     QCOW2_NO_OPERATION =3D 0,
=20
     QCOW2_UPGRADING,
+    QCOW2_UPDATING_ENCRYPTION,
     QCOW2_CHANGING_REFCOUNT_ORDER,
     QCOW2_DOWNGRADING,
 } Qcow2AmendOperation;
@@ -5203,6 +5211,7 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
     int ret;
     QemuOptDesc *desc =3D opts->list->desc;
     Qcow2AmendHelperCBInfo helper_cb_info;
+    bool encryption_update =3D false;
=20
     while (desc && desc->name) {
         if (!qemu_opt_find(opts, desc->name)) {
@@ -5229,6 +5238,18 @@ static int qcow2_amend_options(BlockDriverState *bs,=
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
@@ -5271,7 +5292,8 @@ static int qcow2_amend_options(BlockDriverState *bs, =
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
@@ -5284,6 +5306,33 @@ static int qcow2_amend_options(BlockDriverState *bs,=
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
@@ -5538,6 +5587,11 @@ static QemuOptsList qcow2_amend_opts =3D {
     .name =3D "qcow2-amend-opts",
     .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_amend_opts.head),
     .desc =3D {
+        BLOCK_CRYPTO_OPT_DEF_LUKS_STATE("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_OLD_SECRET("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_NEW_SECRET("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
     }
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index c68458da8c..6558f38ba8 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -620,6 +620,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -631,6 +636,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -642,6 +652,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -653,6 +668,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -664,6 +684,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -675,6 +700,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -686,6 +716,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -697,6 +732,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
@@ -725,6 +765,11 @@ Amend options for 'qcow2':
   compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay valid=
 as a raw image
+  encrypt.iter-time=3D<num> - Time to spend in PBKDF in milliseconds
+  encrypt.keyslot=3D<num>  - Select a single keyslot to modify explicitly
+  encrypt.new-secret=3D<str> - New secret to set in the matching keyslots.=
 Empty string to erase
+  encrypt.old-secret=3D<str> - Select all keyslots that match this passwor=
d
+  encrypt.state=3D<str>    - Select new state of affected keyslots (active=
/inactive)
   lazy_refcounts=3D<bool (on/off)> - Postpone refcount updates
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
--=20
2.17.2


