Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A602C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBA020702
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f09Oll3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBA020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix9QV-0006wK-0l
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ix9PS-0005uh-FL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ix9PQ-00056M-Cz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:59:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ix9PQ-00055N-8d
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580389139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PRkaBLBxBbhYxCAhRuWU6q6SM1AukYU25HLYHonLNbc=;
 b=f09Oll3rXNgorPaoWbPzM+IGjSkx2R+X3zCxqV29kg9mAPnDTBqjGq7FEfZ5lsM/4UtAML
 5MrlGJ02jRWbNpuNCbzDJl12MRx4lyVTlLjWKqWfhkxXSgA4nsq9YVakBjmwa6kny6OkIz
 s4QTM5SGpNNH89aXlIxl/VqEnJc8vIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-JMruYnUPO6KuskmijQ2g8Q-1; Thu, 30 Jan 2020 07:58:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8595800D4E;
 Thu, 30 Jan 2020 12:58:54 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA24019756;
 Thu, 30 Jan 2020 12:58:49 +0000 (UTC)
Message-ID: <d05d9eadcf5bc9173bd5d24d09a0e168a268b015.camel@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 30 Jan 2020 14:58:48 +0200
In-Reply-To: <20200128172129.GV1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <20200128172129.GV1446339@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: JMruYnUPO6KuskmijQ2g8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-28 at 17:21 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 14, 2020 at 09:33:39PM +0200, Maxim Levitsky wrote:
> > Next few patches will expose that functionality
> > to the user.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 374 +++++++++++++++++++++++++++++++++++++++++++-
> >  qapi/crypto.json    |  50 +++++-
> >  2 files changed, 421 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index 4861db810c..349e95fed3 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -32,6 +32,7 @@
> >  #include "qemu/uuid.h"
> > =20
> >  #include "qemu/coroutine.h"
> > +#include "qemu/bitmap.h"
> > =20
> >  /*
> >   * Reference for the LUKS format implemented here is
> > @@ -70,6 +71,9 @@ typedef struct QCryptoBlockLUKSKeySlot QCryptoBlockLU=
KSKeySlot;
> > =20
> >  #define QCRYPTO_BLOCK_LUKS_SECTOR_SIZE 512LL
> > =20
> > +#define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS 2000
> > +#define QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS 40
> > +
> >  static const char qcrypto_block_luks_magic[QCRYPTO_BLOCK_LUKS_MAGIC_LE=
N] =3D {
> >      'L', 'U', 'K', 'S', 0xBA, 0xBE
> >  };
> > @@ -219,6 +223,9 @@ struct QCryptoBlockLUKS {
> > =20
> >      /* Hash algorithm used in pbkdf2 function */
> >      QCryptoHashAlgorithm hash_alg;
> > +
> > +    /* Name of the secret that was used to open the image */
> > +    char *secret;
> >  };
> > =20
> > =20
> > @@ -1069,6 +1076,112 @@ qcrypto_block_luks_find_key(QCryptoBlock *block=
,
> >      return -1;
> >  }
> > =20
> > +/*
> > + * Returns true if a slot i is marked as active
> > + * (contains encrypted copy of the master key)
> > + */
> > +static bool
> > +qcrypto_block_luks_slot_active(const QCryptoBlockLUKS *luks,
> > +                               unsigned int slot_idx)
> > +{
> > +    uint32_t val =3D luks->header.key_slots[slot_idx].active;
> > +    return val =3D=3D  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
> > +}
> > +
> > +/*
> > + * Returns the number of slots that are marked as active
> > + * (slots that contain encrypted copy of the master key)
> > + */
> > +static unsigned int
> > +qcrypto_block_luks_count_active_slots(const QCryptoBlockLUKS *luks)
> > +{
> > +    size_t i =3D 0;
> > +    unsigned int ret =3D 0;
> > +
> > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +        if (qcrypto_block_luks_slot_active(luks, i)) {
> > +            ret++;
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> > +/*
> > + * Finds first key slot which is not active
> > + * Returns the key slot index, or -1 if it doesn't exist
> > + */
> > +static int
> > +qcrypto_block_luks_find_free_keyslot(const QCryptoBlockLUKS *luks)
> > +{
> > +    size_t i;
> > +
> > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +        if (!qcrypto_block_luks_slot_active(luks, i)) {
> > +            return i;
> > +        }
> > +    }
> > +    return -1;
> > +
> > +}
> > +
> > +/*
> > + * Erases an keyslot given its index
> > + * Returns:
> > + *    0 if the keyslot was erased successfully
> > + *   -1 if a error occurred while erasing the keyslot
> > + *
> > + */
> > +static int
> > +qcrypto_block_luks_erase_key(QCryptoBlock *block,
> > +                             unsigned int slot_idx,
> > +                             QCryptoBlockWriteFunc writefunc,
> > +                             void *opaque,
> > +                             Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot_idx=
];
> > +    g_autofree uint8_t *garbagesplitkey =3D NULL;
> > +    size_t splitkeylen =3D luks->header.master_key_len * slot->stripes=
;
> > +    size_t i;
> > +
> > +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> > +    assert(splitkeylen > 0);
> > +
> > +    garbagesplitkey =3D g_new0(uint8_t, splitkeylen);
> > +
> > +    /* Reset the key slot header */
> > +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> > +    slot->iterations =3D 0;
> > +    slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> > +
> > +    qcrypto_block_luks_store_header(block,  writefunc, opaque, errp);
> > +
> > +    /*
> > +     * Now try to erase the key material, even if the header
> > +     * update failed
> > +     */
> > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
> > +        if (qcrypto_random_bytes(garbagesplitkey, splitkeylen, errp) <=
 0) {
> > +            /*
> > +             * If we failed to get the random data, still write
> > +             * at least zeros to the key slot at least once
> > +             */
> > +            if (i > 0) {
> > +                return -1;
> > +            }
> > +        }
> > +
> > +        if (writefunc(block,
> > +                      slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SEC=
TOR_SIZE,
> > +                      garbagesplitkey,
> > +                      splitkeylen,
> > +                      opaque,
> > +                      errp) !=3D splitkeylen) {
> > +            return -1;
> > +        }
> > +    }
> > +    return 0;
> > +}
> > =20
> >  static int
> >  qcrypto_block_luks_open(QCryptoBlock *block,
> > @@ -1099,6 +1212,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> > =20
> >      luks =3D g_new0(QCryptoBlockLUKS, 1);
> >      block->opaque =3D luks;
> > +    luks->secret =3D g_strdup(options->u.luks.key_secret);
> > =20
> >      if (qcrypto_block_luks_load_header(block, readfunc, opaque, errp) =
< 0) {
> >          goto fail;
> > @@ -1164,6 +1278,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> >   fail:
> >      qcrypto_block_free_cipher(block);
> >      qcrypto_ivgen_free(block->ivgen);
> > +    g_free(luks->secret);
> >      g_free(luks);
> >      return -1;
> >  }
> > @@ -1204,7 +1319,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
> > =20
> >      memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
> >      if (!luks_opts.has_iter_time) {
> > -        luks_opts.iter_time =3D 2000;
> > +        luks_opts.iter_time =3D QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_M=
S;
> >      }
> >      if (!luks_opts.has_cipher_alg) {
> >          luks_opts.cipher_alg =3D QCRYPTO_CIPHER_ALG_AES_256;
> > @@ -1244,6 +1359,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
> >                     optprefix ? optprefix : "");
> >          goto error;
> >      }
> > +    luks->secret =3D g_strdup(options->u.luks.key_secret);
> > +
> >      password =3D qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, e=
rrp);
> >      if (!password) {
> >          goto error;
> > @@ -1471,10 +1588,260 @@ qcrypto_block_luks_create(QCryptoBlock *block,
> >      qcrypto_block_free_cipher(block);
> >      qcrypto_ivgen_free(block->ivgen);
> > =20
> > +    g_free(luks->secret);
> >      g_free(luks);
> >      return -1;
> >  }
> > =20
> > +/*
> > + * Given LUKSKeyslotUpdate command, return @slots_bitmap with all slot=
s
> > + * that will be updated with new password (or erased)
> > + * returns number of affected slots
> > + */
> > +static int qcrypto_block_luks_get_slots_bitmap(QCryptoBlock *block,
> > +                                               QCryptoBlockReadFunc re=
adfunc,
> > +                                               void *opaque,
> > +                                               const LUKSKeyslotUpdate=
 *command,
> > +                                               unsigned long *slots_bi=
tmap,
> > +                                               Error **errp)
> > +{
> > +    const QCryptoBlockLUKS *luks =3D block->opaque;
> > +    size_t i;
> > +    int ret =3D 0;
> > +
> > +    if (command->has_keyslot) {
> > +        /* keyslot set, select only this keyslot */
> > +        int keyslot =3D command->keyslot;
> > +
> > +        if (keyslot < 0 || keyslot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLO=
TS) {
> > +            error_setg(errp,
> > +                       "Invalid slot %u specified, must be between 0 a=
nd %u",
> > +                       keyslot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1);
> > +            goto error;
> > +        }
> > +        bitmap_set(slots_bitmap, keyslot, 1);
> > +        ret++;
> > +
> > +    } else if (command->has_old_secret) {
> > +        /* initially select all active keyslots */
> > +        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +            if (qcrypto_block_luks_slot_active(luks, i)) {
> > +                bitmap_set(slots_bitmap, i, 1);
> > +                ret++;
> > +            }
> > +        }
> > +    } else {
> > +        /* find a free keyslot */
> > +        int slot =3D qcrypto_block_luks_find_free_keyslot(luks);
> > +
> > +        if (slot =3D=3D -1) {
> > +            error_setg(errp,
> > +                       "Can't add a keyslot - all key slots are in use=
");
> > +            goto error;
> > +        }
> > +        bitmap_set(slots_bitmap, slot, 1);
> > +        ret++;
> > +    }
> > +
> > +    if (command->has_old_secret) {
> > +        /* now deselect all keyslots that don't contain the password *=
/
> > +        g_autofree uint8_t *tmpkey =3D g_new0(uint8_t,
> > +                                            luks->header.master_key_le=
n);
> > +
> > +        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +            g_autofree char *old_password =3D NULL;
> > +            int rv;
> > +
> > +            if (!test_bit(i, slots_bitmap)) {
> > +                continue;
> > +            }
> > +
> > +            old_password =3D qcrypto_secret_lookup_as_utf8(command->ol=
d_secret,
> > +                                                         errp);
> > +            if (!old_password) {
> > +                goto error;
> > +            }
> > +
> > +            rv =3D qcrypto_block_luks_load_key(block,
> > +                                             i,
> > +                                             old_password,
> > +                                             tmpkey,
> > +                                             readfunc,
> > +                                             opaque,
> > +                                             errp);
> > +            if (rv =3D=3D -1)
> > +                goto error;
> > +            else if (rv =3D=3D 0) {
> > +                bitmap_clear(slots_bitmap, i, 1);
> > +                ret--;
> > +            }
> > +        }
> > +    }
> > +    return ret;
> > +error:
> > +    return -1;
> > +}
> > +
> > +/*
> > + * Apply a single keyslot update command as described in @command
> > + * Optionally use @unlock_secret to retrieve the master key
> > + */
> > +static int
> > +qcrypto_block_luks_apply_keyslot_update(QCryptoBlock *block,
> > +                                        QCryptoBlockReadFunc readfunc,
> > +                                        QCryptoBlockWriteFunc writefun=
c,
> > +                                        void *opaque,
> > +                                        LUKSKeyslotUpdate *command,
> > +                                        const char *unlock_secret,
> > +                                        uint8_t **master_key,
> > +                                        bool force,
> > +                                        Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    g_autofree unsigned long *slots_bitmap =3D NULL;
> > +    int64_t iter_time =3D QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
> > +    int slot_count;
> > +    size_t i;
> > +    char *new_password;
> > +    bool erasing;
> > +
> > +    slots_bitmap =3D bitmap_new(QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> > +    slot_count =3D qcrypto_block_luks_get_slots_bitmap(block, readfunc=
, opaque,
> > +                                                     command, slots_bi=
tmap,
> > +                                                     errp);
> > +    if (slot_count =3D=3D -1) {
> > +        goto error;
> > +    }
> > +    /* no matching slots, so nothing to do */
> > +    if (slot_count =3D=3D 0) {
> > +        error_setg(errp, "Requested operation didn't match any slots")=
;
> > +        goto error;
> > +    }
> > +    /*
> > +     * slot is erased when the password is set to null, or empty strin=
g
> > +     * (for compatibility with command line)
> > +     */
> > +    erasing =3D command->new_secret->type =3D=3D QTYPE_QNULL ||
> > +              strlen(command->new_secret->u.s) =3D=3D 0;
> > +
> > +    /* safety checks */
> > +    if (!force) {
> > +        if (erasing) {
> > +            if (slot_count =3D=3D qcrypto_block_luks_count_active_slot=
s(luks)) {
> > +                error_setg(errp,
> > +                           "Requested operation will erase all active =
keyslots"
> > +                           " which will erase all the data in the imag=
e"
> > +                           " irreversibly - refusing operation");
> > +                goto error;
> > +            }
> > +        } else {
> > +            for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +                if (!test_bit(i, slots_bitmap)) {
> > +                    continue;
> > +                }
> > +                if (qcrypto_block_luks_slot_active(luks, i)) {
> > +                    error_setg(errp,
> > +                               "Refusing to overwrite active slot %zu =
- "
> > +                               "please erase it first", i);
> > +                    goto error;
> > +                }
> > +            }
> > +        }
> > +    }
> > +
> > +    /* setup the data needed for storing the new keyslot */
> > +    if (!erasing) {
> > +        /* Load the master key if it wasn't already loaded */
> > +        if (!*master_key) {
> > +            g_autofree char *old_password;
> > +            old_password =3D qcrypto_secret_lookup_as_utf8(unlock_secr=
et,  errp);
> > +            if (!old_password) {
> > +                goto error;
> > +            }
> > +            *master_key =3D g_new0(uint8_t, luks->header.master_key_le=
n);
> > +
> > +            if (qcrypto_block_luks_find_key(block, old_password, *mast=
er_key,
> > +                                            readfunc, opaque, errp) < =
0) {
> > +                error_append_hint(errp, "Failed to retrieve the master=
 key");
> > +                goto error;
> > +            }
> > +        }
> > +        new_password =3D qcrypto_secret_lookup_as_utf8(command->new_se=
cret->u.s,
> > +                                                     errp);
> > +        if (!new_password) {
> > +            goto error;
> > +        }
> > +        if (command->has_iter_time) {
> > +            iter_time =3D command->iter_time;
> > +        }
> > +    }
> > +
> > +    /* new apply the update */
> > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +        if (!test_bit(i, slots_bitmap)) {
> > +            continue;
> > +        }
> > +        if (erasing) {
> > +            if (qcrypto_block_luks_erase_key(block, i,
> > +                                             writefunc,
> > +                                             opaque,
> > +                                             errp)) {
> > +                error_append_hint(errp, "Failed to erase keyslot %zu",=
 i);
> > +                goto error;
> > +            }
> > +        } else {
> > +            if (qcrypto_block_luks_store_key(block, i,
> > +                                             new_password,
> > +                                             *master_key,
> > +                                             iter_time,
> > +                                             writefunc,
> > +                                             opaque,
> > +                                             errp)) {
> > +                error_append_hint(errp, "Failed to write to keyslot %z=
u", i);
> > +                goto error;
> > +            }
> > +        }
> > +    }
> > +    return 0;
> > +error:
> > +    return -EINVAL;
> > +}
>=20
> I feel the this method is confusing from trying to handle both
> adding and erasing keyslots....
>=20
>=20
> > +
> > +static int
> > +qcrypto_block_luks_amend_options(QCryptoBlock *block,
> > +                                 QCryptoBlockReadFunc readfunc,
> > +                                 QCryptoBlockWriteFunc writefunc,
> > +                                 void *opaque,
> > +                                 QCryptoBlockAmendOptions *options,
> > +                                 bool force,
> > +                                 Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    QCryptoBlockAmendOptionsLUKS *options_luks =3D &options->u.luks;
> > +    LUKSKeyslotUpdateList *ptr;
> > +    g_autofree uint8_t *master_key =3D NULL;
> > +    int ret;
> > +
> > +    char *unlock_secret =3D options_luks->has_unlock_secret ?
> > +                          options_luks->unlock_secret :
> > +                          luks->secret;
> > +
> > +    for (ptr =3D options_luks->keys; ptr; ptr =3D ptr->next) {
> > +        ret =3D qcrypto_block_luks_apply_keyslot_update(block, readfun=
c,
> > +                                                      writefunc, opaqu=
e,
> > +                                                      ptr->value,
> > +                                                      unlock_secret,
> > +                                                      &master_key,
> > +                                                      force, errp);
>=20
> .... imho we sould do
>=20
>     bool  erasing =3D command->new_secret->type =3D=3D QTYPE_QNULL;
>=20
>     if (erasing) {
>          ret =3D qcrypto_block_luks_disable_keyslot(block, readfunc,
>                                                        writefunc, opaque,
>                                                        ptr->value,
>                                                        unlock_secret,
>                                                        &master_key,
>                                                        force, errp);
>     } else {
>         ret =3D qcrypto_block_luks_enable_keyslot(block, readfunc,
>                                                        writefunc, opaque,
>                                                        ptr->value,
>                                                        unlock_secret,
>                                                        &master_key,
>                                                        force, errp);
>     }

I implemented something like that now, I'll send this in next version of th=
e patches.

>=20
> > +
> > +        if (ret !=3D 0) {
> > +            goto error;
> > +        }
> > +    }
> > +    return 0;
> > +error:
> > +    return -1;
> > +}
>=20
> If there's no code to run in the 'error' label, then we should just
> get rid of it and 'return -1' instead of "goto error"
Old habit. Fixed now.

>=20
> > =20
> >  static int qcrypto_block_luks_get_info(QCryptoBlock *block,
> >                                         QCryptoBlockInfo *info,
> > @@ -1523,7 +1890,9 @@ static int qcrypto_block_luks_get_info(QCryptoBlo=
ck *block,
> > =20
> >  static void qcrypto_block_luks_cleanup(QCryptoBlock *block)
> >  {
> > -    g_free(block->opaque);
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    g_free(luks->secret);
>=20
> Check if "luks" is non-NULL for robustness in early failure scenarios
100% agree. Fixed.

>=20
> > +    g_free(luks);
> >  }
> > =20
>=20
> Regards,
> Daniel

Thanks for the review,
=09Best regards,
=09=09Maxim Levitsky



