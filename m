Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E444C47258
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0959D20721
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTZmyLAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0959D20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3tG-0005y9-4j
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jW3rn-0003SU-Hw
 for qemu-devel@nongnu.org; Tue, 05 May 2020 16:08:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jW3rl-0000kG-32
 for qemu-devel@nongnu.org; Tue, 05 May 2020 16:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588709312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uF4B6uG1mhuTt9wnVIlQe/KZFE77IOFLZFwwO7aHt7E=;
 b=CTZmyLAVB+AGARLmU8onkzaWHmP9Zuupb+SOO30JIhR6HgOk0wAK40BrJ3uGcSEQ4lXcXC
 nAwZFwxNm8xT66cw/GEvZjNOnFF5WdKrfBeT7j87tgU3tX04btJuEMNysrpQapfQFZU5T8
 bvFbwB+V8DdpfU3a5p4QGxDuGlw4D3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-V1me2vNeNQO7psh4nI3d5Q-1; Tue, 05 May 2020 16:08:30 -0400
X-MC-Unique: V1me2vNeNQO7psh4nI3d5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45BFA107ACF2;
 Tue,  5 May 2020 20:08:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3C3663F95;
 Tue,  5 May 2020 20:08:26 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/14] qcrypto/luks: implement encryption key management
Date: Tue,  5 May 2020 23:08:07 +0300
Message-Id: <20200505200819.5662-3-mlevitsk@redhat.com>
In-Reply-To: <20200505200819.5662-1-mlevitsk@redhat.com>
References: <20200505200819.5662-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 15:23:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Next few patches will expose that functionality
to the user.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 395 +++++++++++++++++++++++++++++++++++++++++++-
 qapi/crypto.json    |  61 ++++++-
 2 files changed, 452 insertions(+), 4 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 4861db810c..c108518df1 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -32,6 +32,7 @@
 #include "qemu/uuid.h"
=20
 #include "qemu/coroutine.h"
+#include "qemu/bitmap.h"
=20
 /*
  * Reference for the LUKS format implemented here is
@@ -70,6 +71,9 @@ typedef struct QCryptoBlockLUKSKeySlot QCryptoBlockLUKSKe=
ySlot;
=20
 #define QCRYPTO_BLOCK_LUKS_SECTOR_SIZE 512LL
=20
+#define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS 2000
+#define QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS 40
+
 static const char qcrypto_block_luks_magic[QCRYPTO_BLOCK_LUKS_MAGIC_LEN] =
=3D {
     'L', 'U', 'K', 'S', 0xBA, 0xBE
 };
@@ -219,6 +223,9 @@ struct QCryptoBlockLUKS {
=20
     /* Hash algorithm used in pbkdf2 function */
     QCryptoHashAlgorithm hash_alg;
+
+    /* Name of the secret that was used to open the image */
+    char *secret;
 };
=20
=20
@@ -1069,6 +1076,119 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
     return -1;
 }
=20
+/*
+ * Returns true if a slot i is marked as active
+ * (contains encrypted copy of the master key)
+ */
+static bool
+qcrypto_block_luks_slot_active(const QCryptoBlockLUKS *luks,
+                               unsigned int slot_idx)
+{
+    uint32_t val =3D luks->header.key_slots[slot_idx].active;
+    return val =3D=3D  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
+}
+
+/*
+ * Returns the number of slots that are marked as active
+ * (slots that contain encrypted copy of the master key)
+ */
+static unsigned int
+qcrypto_block_luks_count_active_slots(const QCryptoBlockLUKS *luks)
+{
+    size_t i =3D 0;
+    unsigned int ret =3D 0;
+
+    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        if (qcrypto_block_luks_slot_active(luks, i)) {
+            ret++;
+        }
+    }
+    return ret;
+}
+
+/*
+ * Finds first key slot which is not active
+ * Returns the key slot index, or -1 if it doesn't exist
+ */
+static int
+qcrypto_block_luks_find_free_keyslot(const QCryptoBlockLUKS *luks)
+{
+    size_t i;
+
+    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        if (!qcrypto_block_luks_slot_active(luks, i)) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+/*
+ * Erases an keyslot given its index
+ * Returns:
+ *    0 if the keyslot was erased successfully
+ *   -1 if a error occurred while erasing the keyslot
+ *
+ */
+static int
+qcrypto_block_luks_erase_key(QCryptoBlock *block,
+                             unsigned int slot_idx,
+                             QCryptoBlockWriteFunc writefunc,
+                             void *opaque,
+                             Error **errp)
+{
+    QCryptoBlockLUKS *luks =3D block->opaque;
+    QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot_idx];
+    g_autofree uint8_t *garbagesplitkey =3D NULL;
+    size_t splitkeylen =3D luks->header.master_key_len * slot->stripes;
+    size_t i;
+    Error *local_err =3D NULL;
+    int ret;
+
+    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+    assert(splitkeylen > 0);
+    garbagesplitkey =3D g_new0(uint8_t, splitkeylen);
+
+    /* Reset the key slot header */
+    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
+    slot->iterations =3D 0;
+    slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
+
+    ret =3D qcrypto_block_luks_store_header(block,  writefunc,
+                                          opaque, &local_err);
+
+    if (ret) {
+        error_propagate(errp, local_err);
+    }
+    /*
+     * Now try to erase the key material, even if the header
+     * update failed
+     */
+    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
+        if (qcrypto_random_bytes(garbagesplitkey,
+                                 splitkeylen, &local_err) < 0) {
+            /*
+             * If we failed to get the random data, still write
+             * at least zeros to the key slot at least once
+             */
+            error_propagate(errp, local_err);
+
+            if (i > 0) {
+                return -1;
+            }
+        }
+        if (writefunc(block,
+                      slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SECTOR_=
SIZE,
+                      garbagesplitkey,
+                      splitkeylen,
+                      opaque,
+                      &local_err) !=3D splitkeylen) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+    }
+    return 0;
+}
=20
 static int
 qcrypto_block_luks_open(QCryptoBlock *block,
@@ -1099,6 +1219,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
=20
     luks =3D g_new0(QCryptoBlockLUKS, 1);
     block->opaque =3D luks;
+    luks->secret =3D g_strdup(options->u.luks.key_secret);
=20
     if (qcrypto_block_luks_load_header(block, readfunc, opaque, errp) < 0)=
 {
         goto fail;
@@ -1164,6 +1285,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
  fail:
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
+    g_free(luks->secret);
     g_free(luks);
     return -1;
 }
@@ -1204,7 +1326,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
=20
     memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
     if (!luks_opts.has_iter_time) {
-        luks_opts.iter_time =3D 2000;
+        luks_opts.iter_time =3D QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
     }
     if (!luks_opts.has_cipher_alg) {
         luks_opts.cipher_alg =3D QCRYPTO_CIPHER_ALG_AES_256;
@@ -1244,6 +1366,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
                    optprefix ? optprefix : "");
         goto error;
     }
+    luks->secret =3D g_strdup(options->u.luks.key_secret);
+
     password =3D qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, errp)=
;
     if (!password) {
         goto error;
@@ -1471,10 +1595,272 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
=20
+    g_free(luks->secret);
     g_free(luks);
     return -1;
 }
=20
+static int
+qcrypto_block_luks_amend_add_keyslot(QCryptoBlock *block,
+                                     QCryptoBlockReadFunc readfunc,
+                                     QCryptoBlockWriteFunc writefunc,
+                                     void *opaque,
+                                     QCryptoBlockAmendOptionsLUKS *opts_lu=
ks,
+                                     bool force,
+                                     Error **errp)
+{
+    QCryptoBlockLUKS *luks =3D block->opaque;
+    uint64_t iter_time =3D opts_luks->has_iter_time ?
+                         opts_luks->iter_time :
+                         QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
+    int keyslot;
+    g_autofree char *old_password =3D NULL;
+    g_autofree char *new_password =3D NULL;
+    g_autofree uint8_t *master_key =3D NULL;
+
+    char *secret =3D opts_luks->has_secret ? opts_luks->secret : luks->sec=
ret;
+
+    if (!opts_luks->has_new_secret) {
+        error_setg(errp, "'new-secret' is required to activate a keyslot")=
;
+        return -1;
+    }
+    if (opts_luks->has_old_secret) {
+        error_setg(errp,
+                   "'old-secret' must not be given when activating keyslot=
s");
+        return -1;
+    }
+
+    if (opts_luks->has_keyslot) {
+        keyslot =3D opts_luks->keyslot;
+        if (keyslot < 0 || keyslot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS) =
{
+            error_setg(errp,
+                       "Invalid keyslot %u specified, must be between 0 an=
d %u",
+                       keyslot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1);
+            return -1;
+        }
+    } else {
+        keyslot =3D qcrypto_block_luks_find_free_keyslot(luks);
+        if (keyslot =3D=3D -1) {
+            error_setg(errp,
+                       "Can't add a keyslot - all keyslots are in use");
+            return -1;
+        }
+    }
+
+    if (!force && qcrypto_block_luks_slot_active(luks, keyslot)) {
+        error_setg(errp,
+                   "Refusing to overwrite active keyslot %i - "
+                   "please erase it first",
+                   keyslot);
+        return -EINVAL;
+    }
+
+    /* Locate the password that will be used to retrieve the master key */
+    old_password =3D qcrypto_secret_lookup_as_utf8(secret, errp);
+    if (!old_password) {
+        return -1;
+    }
+
+    /* Retrieve the master key */
+    master_key =3D g_new0(uint8_t, luks->header.master_key_len);
+
+    if (qcrypto_block_luks_find_key(block, old_password, master_key,
+                                    readfunc, opaque, errp) < 0) {
+        error_append_hint(errp, "Failed to retrieve the master key");
+        return -1;
+    }
+
+    /* Locate the new password*/
+    new_password =3D qcrypto_secret_lookup_as_utf8(opts_luks->new_secret, =
errp);
+    if (!new_password) {
+        return -EINVAL;
+    }
+
+    /* Now set the new keyslots */
+    if (qcrypto_block_luks_store_key(block, keyslot, new_password, master_=
key,
+                                     iter_time, writefunc, opaque, errp)) =
{
+        error_append_hint(errp, "Failed to write to keyslot %i", keyslot);
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int
+qcrypto_block_luks_amend_erase_keyslots(QCryptoBlock *block,
+                                        QCryptoBlockReadFunc readfunc,
+                                        QCryptoBlockWriteFunc writefunc,
+                                        void *opaque,
+                                        QCryptoBlockAmendOptionsLUKS *opts=
_luks,
+                                        bool force,
+                                        Error **errp)
+{
+    QCryptoBlockLUKS *luks =3D block->opaque;
+    g_autofree uint8_t *tmpkey =3D NULL;
+    g_autofree char *old_password =3D NULL;
+
+    if (opts_luks->has_new_secret) {
+        error_setg(errp,
+                   "'new-secret' must not be given when erasing keyslots")=
;
+        return -1;
+    }
+    if (opts_luks->has_iter_time) {
+        error_setg(errp,
+                   "'iter-time' must not be given when erasing keyslots");
+        return -1;
+    }
+    if (opts_luks->has_secret) {
+        error_setg(errp,
+                   "'secret' must not be given when erasing keyslots");
+        return -1;
+    }
+
+    /* Load the old password if given */
+    if (opts_luks->has_old_secret) {
+        old_password =3D qcrypto_secret_lookup_as_utf8(opts_luks->old_secr=
et,
+                                                     errp);
+        if (!old_password) {
+            return -1;
+        }
+
+        /*
+         * Allocate a temporary key buffer that we will need when
+         * checking if slot matches the given old password
+         */
+        tmpkey =3D g_new0(uint8_t, luks->header.master_key_len);
+}
+
+    /* Erase an explicitly given keyslot */
+    if (opts_luks->has_keyslot) {
+        int keyslot =3D opts_luks->keyslot;
+
+        if (keyslot < 0 || keyslot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS) =
{
+            error_setg(errp,
+                       "Invalid keyslot %i specified, must be between 0 an=
d %i",
+                       keyslot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1);
+            return -1;
+        }
+
+        if (opts_luks->has_old_secret) {
+            int rv =3D qcrypto_block_luks_load_key(block,
+                                                 keyslot,
+                                                 old_password,
+                                                 tmpkey,
+                                                 readfunc,
+                                                 opaque,
+                                                 errp);
+            if (rv =3D=3D -1) {
+                return -1;
+            } else if (rv =3D=3D 0) {
+                error_setg(errp,
+                           "Given keyslot %i doesn't contain the given "
+                           "old password for erase operation",
+                           keyslot);
+                return -1;
+            }
+        }
+
+        if (!force && !qcrypto_block_luks_slot_active(luks, keyslot)) {
+            error_setg(errp,
+                       "Given keyslot %i is already erased (inactive) ",
+                       keyslot);
+            return -1;
+        }
+
+        if (!force && qcrypto_block_luks_count_active_slots(luks) =3D=3D 1=
) {
+            error_setg(errp,
+                       "Attempt to erase the only active keyslot %i "
+                       "which will erase all the data in the image "
+                       "irreversibly - refusing operation",
+                       keyslot);
+            return -1;
+        }
+
+        if (qcrypto_block_luks_erase_key(block, keyslot,
+                                         writefunc, opaque, errp)) {
+            error_append_hint(errp, "Failed to erase keyslot %i", keyslot)=
;
+            return -1;
+        }
+
+    /* Erase all keyslots that match the given old password */
+    } else if (opts_luks->has_old_secret) {
+
+        unsigned long slots_to_erase_bitmap =3D 0;
+        size_t i;
+        int slot_count;
+
+        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+            int rv =3D qcrypto_block_luks_load_key(block,
+                                                 i,
+                                                 old_password,
+                                                 tmpkey,
+                                                 readfunc,
+                                                 opaque,
+                                                 errp);
+            if (rv =3D=3D -1) {
+                return -1;
+            } else if (rv =3D=3D 1) {
+                bitmap_set(&slots_to_erase_bitmap, i, 1);
+            }
+        }
+
+        slot_count =3D bitmap_count_one(&slots_to_erase_bitmap,
+                                      QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+        if (slot_count =3D=3D 0) {
+            error_setg(errp,
+                       "No keyslots match given (old) password for erase o=
peration");
+            return -1;
+        }
+
+        if (!force &&
+            slot_count =3D=3D qcrypto_block_luks_count_active_slots(luks))=
 {
+            error_setg(errp,
+                       "All the active keyslots match the (old) password t=
hat "
+                       "was given and erasing them will erase all the data=
 in "
+                       "the image irreversibly - refusing operation");
+            return -1;
+        }
+
+        /* Now apply the update */
+        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+            if (!test_bit(i, &slots_to_erase_bitmap)) {
+                continue;
+            }
+            if (qcrypto_block_luks_erase_key(block, i, writefunc,
+                opaque, errp)) {
+                error_append_hint(errp, "Failed to erase keyslot %zu", i);
+                return -1;
+            }
+        }
+    } else {
+        error_setg(errp,
+                   "To erase keyslot(s), either explicit keyslot index "
+                   "or the password currently contained in them must be gi=
ven");
+        return -1;
+    }
+    return 0;
+}
+
+static int
+qcrypto_block_luks_amend_options(QCryptoBlock *block,
+                                 QCryptoBlockReadFunc readfunc,
+                                 QCryptoBlockWriteFunc writefunc,
+                                 void *opaque,
+                                 QCryptoBlockAmendOptions *options,
+                                 bool force,
+                                 Error **errp)
+{
+    QCryptoBlockAmendOptionsLUKS *opts_luks =3D &options->u.luks;
+
+    if (opts_luks->state =3D=3D Q_CRYPTO_BLOCKLUKS_KEYSLOT_STATE_ACTIVE) {
+        return qcrypto_block_luks_amend_add_keyslot(block, readfunc,
+                                                    writefunc, opaque,
+                                                    opts_luks, force, errp=
);
+    } else {
+        return qcrypto_block_luks_amend_erase_keyslots(block, readfunc,
+                                                       writefunc, opaque,
+                                                       opts_luks, force, e=
rrp);
+    }
+}
=20
 static int qcrypto_block_luks_get_info(QCryptoBlock *block,
                                        QCryptoBlockInfo *info,
@@ -1523,7 +1909,11 @@ static int qcrypto_block_luks_get_info(QCryptoBlock =
*block,
=20
 static void qcrypto_block_luks_cleanup(QCryptoBlock *block)
 {
-    g_free(block->opaque);
+    QCryptoBlockLUKS *luks =3D block->opaque;
+    if (luks) {
+        g_free(luks->secret);
+        g_free(luks);
+    }
 }
=20
=20
@@ -1560,6 +1950,7 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
 const QCryptoBlockDriver qcrypto_block_driver_luks =3D {
     .open =3D qcrypto_block_luks_open,
     .create =3D qcrypto_block_luks_create,
+    .amend =3D qcrypto_block_luks_amend_options,
     .get_info =3D qcrypto_block_luks_get_info,
     .cleanup =3D qcrypto_block_luks_cleanup,
     .decrypt =3D qcrypto_block_luks_decrypt,
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 3fd0ce177e..a076b3b938 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -1,6 +1,8 @@
 # -*- Mode: Python -*-
 #
=20
+{ 'include': 'common.json' }
+
 ##
 # =3D Cryptography
 ##
@@ -297,7 +299,6 @@
            'uuid': 'str',
            'slots': [ 'QCryptoBlockInfoLUKSSlot' ] }}
=20
-
 ##
 # @QCryptoBlockInfo:
 #
@@ -310,7 +311,63 @@
   'discriminator': 'format',
   'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
=20
+##
+# @QCryptoBlockLUKSKeyslotState:
+#
+# Defines state of keyslots that are affected by the update
+#
+# @active:    The slots contain the given password and marked as active
+# @inactive:  The slots are erased (contain garbage) and marked as inactiv=
e
+#
+# Since: 5.0
+##
+{ 'enum': 'QCryptoBlockLUKSKeyslotState',
+  'data': [ 'active', 'inactive' ] }
+
=20
+##
+# @QCryptoBlockAmendOptionsLUKS:
+#
+# This struct defines the update parameters that activate/de-activate set
+# of keyslots
+#
+# @state: the desired state of the keyslots
+#
+# @new-secret:    The ID of a QCryptoSecret object providing the password =
to be
+#                 written into added active keyslots
+#
+# @old-secret:    Optional (for deactivation only)
+#                 If given will deactive all keyslots that
+#                 match password located in QCryptoSecret with this ID
+#
+# @iter-time:     Optional (for activation only)
+#                 Number of milliseconds to spend in
+#                 PBKDF passphrase processing for the newly activated keys=
lot.
+#                 Currently defaults to 2000.
+#
+# @keyslot:       Optional. ID of the keyslot to activate/deactivate.
+#                 For keyslot activation, keyslot should not be active alr=
eady
+#                 (this is unsafe to update an active keyslot),
+#                 but possible if 'force' parameter is given.
+#                 If keyslot is not given, first free keyslot will be writ=
ten.
+#
+#                 For keyslot deactivation, this parameter specifies the e=
xact
+#                 keyslot to deactivate
+#
+# @secret:        Optional. The ID of a QCryptoSecret object providing the
+#                 password to use to retrive current master key.
+#                 Defaults to the same secret that was used to open the im=
age
+#
+#
+# Since 5.0
+##
+{ 'struct': 'QCryptoBlockAmendOptionsLUKS',
+  'data': { 'state': 'QCryptoBlockLUKSKeyslotState',
+            '*new-secret': 'str',
+            '*old-secret': 'str',
+            '*keyslot': 'int',
+            '*iter-time': 'int',
+            '*secret': 'str' } }
=20
 ##
 # @QCryptoBlockAmendOptions:
@@ -324,4 +381,4 @@
   'base': 'QCryptoBlockOptionsBase',
   'discriminator': 'format',
   'data': {
-            } }
+          'luks': 'QCryptoBlockAmendOptionsLUKS' } }
--=20
2.17.2


