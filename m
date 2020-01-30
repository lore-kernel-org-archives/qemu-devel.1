Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93941C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABEB20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqqdIZcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABEB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDiW-0007Xp-A7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdU-0007UQ-AW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdR-0007bv-G7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixDdR-0007Z9-AX
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580405384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mG2nCBfPdDJCJgtfWPzNkAAe6bLhZVxccx46LiV+boY=;
 b=BqqdIZcM2IVdkXxJNEtg99PaCwuL3s9Ql4wl76G9r870/bXogTYZH4norAkfT/i1uD1zZb
 WRxtwms4E1Bdb+wIKQXYAcpSX4y07tsNDYJkc2jXbTd4cFcUUWP8Gg0NnjNhLIUL2K2D5T
 ct+s00r8Z4SuzTymZkgYKLzrTjk3V0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-KZGLiy1CMV6lngVmmHWhkw-1; Thu, 30 Jan 2020 12:29:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1BED100550E;
 Thu, 30 Jan 2020 17:29:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 426025D9E5;
 Thu, 30 Jan 2020 17:29:31 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/14] qcrypto/luks: implement encryption key management
Date: Thu, 30 Jan 2020 19:29:07 +0200
Message-Id: <20200130172919.13424-3-mlevitsk@redhat.com>
In-Reply-To: <20200130172919.13424-1-mlevitsk@redhat.com>
References: <20200130172919.13424-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: KZGLiy1CMV6lngVmmHWhkw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 crypto/block-luks.c | 391 +++++++++++++++++++++++++++++++++++++++++++-
 qapi/crypto.json    |  50 +++++-
 2 files changed, 438 insertions(+), 3 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 4861db810c..3a233e5fab 100644
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
@@ -1069,6 +1076,112 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
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
+
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
+
+    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+    assert(splitkeylen > 0);
+
+    garbagesplitkey =3D g_new0(uint8_t, splitkeylen);
+
+    /* Reset the key slot header */
+    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
+    slot->iterations =3D 0;
+    slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
+
+    qcrypto_block_luks_store_header(block,  writefunc, opaque, errp);
+
+    /*
+     * Now try to erase the key material, even if the header
+     * update failed
+     */
+    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
+        if (qcrypto_random_bytes(garbagesplitkey, splitkeylen, errp) < 0) =
{
+            /*
+             * If we failed to get the random data, still write
+             * at least zeros to the key slot at least once
+             */
+            if (i > 0) {
+                return -1;
+            }
+        }
+
+        if (writefunc(block,
+                      slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SECTOR_=
SIZE,
+                      garbagesplitkey,
+                      splitkeylen,
+                      opaque,
+                      errp) !=3D splitkeylen) {
+            return -1;
+        }
+    }
+    return 0;
+}
=20
 static int
 qcrypto_block_luks_open(QCryptoBlock *block,
@@ -1099,6 +1212,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
=20
     luks =3D g_new0(QCryptoBlockLUKS, 1);
     block->opaque =3D luks;
+    luks->secret =3D g_strdup(options->u.luks.key_secret);
=20
     if (qcrypto_block_luks_load_header(block, readfunc, opaque, errp) < 0)=
 {
         goto fail;
@@ -1164,6 +1278,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
  fail:
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
+    g_free(luks->secret);
     g_free(luks);
     return -1;
 }
@@ -1204,7 +1319,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
=20
     memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
     if (!luks_opts.has_iter_time) {
-        luks_opts.iter_time =3D 2000;
+        luks_opts.iter_time =3D QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
     }
     if (!luks_opts.has_cipher_alg) {
         luks_opts.cipher_alg =3D QCRYPTO_CIPHER_ALG_AES_256;
@@ -1244,6 +1359,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
                    optprefix ? optprefix : "");
         goto error;
     }
+    luks->secret =3D g_strdup(options->u.luks.key_secret);
+
     password =3D qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, errp)=
;
     if (!password) {
         goto error;
@@ -1471,10 +1588,275 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
=20
+    g_free(luks->secret);
     g_free(luks);
     return -1;
 }
=20
+/*
+ * Given LUKSKeyslotUpdate command, set @slots_bitmap with all slots
+ * that will be updated with new password (or erased)
+ * returns 0 on success, and -1 on failure
+ */
+static int qcrypto_block_luks_get_slots_bitmap(QCryptoBlock *block,
+                                               QCryptoBlockReadFunc readfu=
nc,
+                                               void *opaque,
+                                               const LUKSKeyslotUpdate *co=
mmand,
+                                               unsigned long *slots_bitmap=
,
+                                               Error **errp)
+{
+    const QCryptoBlockLUKS *luks =3D block->opaque;
+    size_t i;
+
+    bitmap_zero(slots_bitmap, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+
+    if (command->has_keyslot) {
+        /* keyslot set, select only this keyslot */
+        int keyslot =3D command->keyslot;
+
+        if (keyslot < 0 || keyslot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS) =
{
+            error_setg(errp,
+                       "Invalid slot %u specified, must be between 0 and %=
u",
+                       keyslot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1);
+            return -1;
+        }
+        bitmap_set(slots_bitmap, keyslot, 1);
+
+    } else if (command->has_old_secret) {
+        /* initially select all active keyslots */
+        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+            if (qcrypto_block_luks_slot_active(luks, i)) {
+                bitmap_set(slots_bitmap, i, 1);
+            }
+        }
+    } else {
+        /* find a free keyslot */
+        int slot =3D qcrypto_block_luks_find_free_keyslot(luks);
+
+        if (slot =3D=3D -1) {
+            error_setg(errp,
+                       "Can't add a keyslot - all key slots are in use");
+            return -1;
+        }
+        bitmap_set(slots_bitmap, slot, 1);
+    }
+
+    if (command->has_old_secret) {
+        /* now deselect all keyslots that don't contain the password */
+        g_autofree uint8_t *tmpkey =3D g_new0(uint8_t,
+                                            luks->header.master_key_len);
+
+        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+            g_autofree char *old_password =3D NULL;
+            int rv;
+
+            if (!test_bit(i, slots_bitmap)) {
+                continue;
+            }
+
+            old_password =3D qcrypto_secret_lookup_as_utf8(command->old_se=
cret,
+                                                         errp);
+            if (!old_password) {
+                return -1;
+            }
+
+            rv =3D qcrypto_block_luks_load_key(block,
+                                             i,
+                                             old_password,
+                                             tmpkey,
+                                             readfunc,
+                                             opaque,
+                                             errp);
+            if (rv =3D=3D -1) {
+                return -1;
+            } else if (rv =3D=3D 0) {
+                bitmap_clear(slots_bitmap, i, 1);
+            }
+        }
+    }
+    return 0;
+}
+
+/*
+ * Erase a set of keyslots given in @slots_bitmap
+ */
+static int qcrypto_block_luks_erase_keys(QCryptoBlock *block,
+                                         QCryptoBlockReadFunc readfunc,
+                                         QCryptoBlockWriteFunc writefunc,
+                                         void *opaque,
+                                         unsigned long *slots_bitmap,
+                                         bool force,
+                                         Error **errp)
+{
+    QCryptoBlockLUKS *luks =3D block->opaque;
+    long slot_count =3D bitmap_count_one(slots_bitmap,
+                                       QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+    size_t i;
+
+    /* safety checks */
+    if (!force && slot_count =3D=3D qcrypto_block_luks_count_active_slots(=
luks)) {
+        error_setg(errp,
+                   "Requested operation will erase all active keyslots"
+                   " which will erase all the data in the image"
+                   " irreversibly - refusing operation");
+        return -EINVAL;
+    }
+
+    /* new apply the update */
+    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        if (!test_bit(i, slots_bitmap)) {
+            continue;
+        }
+        if (qcrypto_block_luks_erase_key(block, i, writefunc, opaque, errp=
)) {
+            error_append_hint(errp, "Failed to erase keyslot %zu", i);
+            return -EINVAL;
+        }
+    }
+    return 0;
+}
+
+/*
+ * Set a set of keyslots to @master_key encrypted by @new_secret
+ */
+static int qcrypto_block_luks_set_keys(QCryptoBlock *block,
+                                       QCryptoBlockReadFunc readfunc,
+                                       QCryptoBlockWriteFunc writefunc,
+                                       void *opaque,
+                                       unsigned long *slots_bitmap,
+                                       uint8_t *master_key,
+                                       uint64_t iter_time,
+                                       char *new_secret,
+                                       bool force,
+                                       Error **errp)
+{
+    QCryptoBlockLUKS *luks =3D block->opaque;
+    g_autofree char *new_password =3D NULL;
+    size_t i;
+
+    /* safety checks */
+    if (!force) {
+        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+            if (!test_bit(i, slots_bitmap)) {
+                continue;
+            }
+            if (qcrypto_block_luks_slot_active(luks, i)) {
+                error_setg(errp,
+                           "Refusing to overwrite active slot %zu - "
+                           "please erase it first", i);
+                return -EINVAL;
+            }
+        }
+    }
+
+    /* Load the new password */
+    new_password =3D qcrypto_secret_lookup_as_utf8(new_secret, errp);
+    if (!new_password) {
+        return -EINVAL;
+    }
+
+    /* Apply the update */
+    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        if (!test_bit(i, slots_bitmap)) {
+            continue;
+        }
+        if (qcrypto_block_luks_store_key(block, i, new_password, master_ke=
y,
+                                         iter_time, writefunc, opaque, err=
p)) {
+            error_append_hint(errp, "Failed to write to keyslot %zu", i);
+            return -EINVAL;
+        }
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
+    QCryptoBlockLUKS *luks =3D block->opaque;
+    QCryptoBlockAmendOptionsLUKS *options_luks =3D &options->u.luks;
+    LUKSKeyslotUpdateList *ptr;
+    g_autofree uint8_t *master_key =3D NULL;
+    g_autofree unsigned long *slots_bitmap =3D NULL;
+
+    char *unlock_secret =3D options_luks->has_unlock_secret ?
+                          options_luks->unlock_secret :
+                          luks->secret;
+
+    slots_bitmap =3D bitmap_new(QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+
+    for (ptr =3D options_luks->keys; ptr; ptr =3D ptr->next) {
+
+        LUKSKeyslotUpdate *command =3D ptr->value;
+        long slot_count;
+        bool erasing;
+
+        /* Retrieve set of slots that we need to update */
+        if (qcrypto_block_luks_get_slots_bitmap(block, readfunc, opaque,
+                                                command, slots_bitmap,
+                                                errp) !=3D 0) {
+            return -1;
+        }
+
+        slot_count =3D bitmap_count_one(slots_bitmap,
+                                      QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+
+        /* no matching slots, so nothing to do */
+        if (slot_count =3D=3D 0) {
+            error_setg(errp, "Requested operation didn't match any slots")=
;
+            return -1;
+        }
+
+        /*
+         * slot is erased when the password is set to null, or empty strin=
g
+         * (for compatibility with command line)
+         */
+
+        erasing =3D command->new_secret->type =3D=3D QTYPE_QNULL ||
+                  strlen(command->new_secret->u.s) =3D=3D 0;
+
+        /* Load the master key if it wasn't already loaded */
+        if (!erasing && !master_key) {
+            g_autofree char *old_password;
+            old_password =3D qcrypto_secret_lookup_as_utf8(unlock_secret, =
 errp);
+            if (!old_password) {
+                return -EINVAL;
+            }
+            master_key =3D g_new0(uint8_t, luks->header.master_key_len);
+
+            if (qcrypto_block_luks_find_key(block, old_password, master_ke=
y,
+                                            readfunc, opaque, errp) < 0) {
+                error_append_hint(errp, "Failed to retrieve the master key=
");
+                return -EINVAL;
+            }
+        }
+
+        /* Apply the update*/
+        if (erasing) {
+            if (qcrypto_block_luks_erase_keys(block, readfunc, writefunc,
+                                              opaque, slots_bitmap, force,
+                                              errp) !=3D 0) {
+                return -1;
+            }
+        } else {
+            uint64_t iter_time =3D command->has_iter_time ? command->iter_=
time :
+                                 QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
+
+            if (qcrypto_block_luks_set_keys(block, readfunc, writefunc,
+                                            opaque, slots_bitmap, master_k=
ey,
+                                            iter_time,
+                                            command->new_secret->u.s,
+                                            force, errp) !=3D 0) {
+                return -1;
+            }
+        }
+    }
+    return 0;
+}
=20
 static int qcrypto_block_luks_get_info(QCryptoBlock *block,
                                        QCryptoBlockInfo *info,
@@ -1523,7 +1905,11 @@ static int qcrypto_block_luks_get_info(QCryptoBlock =
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
@@ -1560,6 +1946,7 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
 const QCryptoBlockDriver qcrypto_block_driver_luks =3D {
     .open =3D qcrypto_block_luks_open,
     .create =3D qcrypto_block_luks_create,
+    .amend =3D qcrypto_block_luks_amend_options,
     .get_info =3D qcrypto_block_luks_get_info,
     .cleanup =3D qcrypto_block_luks_cleanup,
     .decrypt =3D qcrypto_block_luks_decrypt,
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 3fd0ce177e..48c6635318 100644
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
@@ -310,6 +312,52 @@
   'discriminator': 'format',
   'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
=20
+##
+# @LUKSKeyslotUpdate:
+#
+# @keyslot:         If specified, will update only keyslot with this index
+#
+# @old-secret:      If specified, will only update keyslots that
+#                   can be opened with password which is contained in
+#                   QCryptoSecret with @old-secret ID
+#
+#                   If neither @keyslot nor @old-secret is specified,
+#                   first empty keyslot is selected for the update
+#
+# @new-secret:      The ID of a QCryptoSecret object providing a new decry=
ption
+#                   key to place in all matching keyslots.
+#                   null/empty string erases all matching keyslots unless
+#                   last valid keyslot is erased.
+#
+# @iter-time:       number of milliseconds to spend in
+#                   PBKDF passphrase processing
+# Since: 5.0
+##
+{ 'struct': 'LUKSKeyslotUpdate',
+  'data': {
+           '*keyslot': 'int',
+           '*old-secret': 'str',
+           'new-secret' : 'StrOrNull',
+           '*iter-time' : 'int' } }
+
+
+##
+# @QCryptoBlockAmendOptionsLUKS:
+#
+# The options that can be changed on existing luks encrypted device
+# @keys:           list of keyslot updates to perform
+#                  (updates are performed in order)
+# @unlock-secret:  use this secret to retrieve the current master key
+#                  if not given will use the same secret as one
+#                  that was used to open the image
+#
+# Since: 5.0
+##
+{ 'struct': 'QCryptoBlockAmendOptionsLUKS',
+  'data' : {
+            'keys': ['LUKSKeyslotUpdate'],
+             '*unlock-secret' : 'str' } }
+
=20
=20
 ##
@@ -324,4 +372,4 @@
   'base': 'QCryptoBlockOptionsBase',
   'discriminator': 'format',
   'data': {
-            } }
+          'luks': 'QCryptoBlockAmendOptionsLUKS' } }
--=20
2.17.2


