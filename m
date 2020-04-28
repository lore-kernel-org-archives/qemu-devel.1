Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05ACC83006
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD49206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/NLxUqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD49206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQAd-00060T-E5
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:21:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTQ7r-0001ND-PU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTQ6r-0005V7-2x
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:18:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54484
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTQ6q-0005Uk-IJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588079831;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sm8WJO0ZA8IKEHrNSp9bigTOKnXCKLZyVozy2EABSjA=;
 b=L/NLxUqxfqmxuRb06AX3CUPy60ZpWBtsMIx0H0IxmhnpdssBvPWZoVO9ooT0fjyNvWJ++V
 hCj2W1762xujuSmsV9PjqsMcWcZ/FSAjSLAwT+gmZWJNUM32mlisC0CDlb51oWSRyK2bAw
 wYdTv9AuKlGJ6NSSq/dA5SzlMVZ3vf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-DdcMMIDZO4266EMcs4RRSg-1; Tue, 28 Apr 2020 09:16:59 -0400
X-MC-Unique: DdcMMIDZO4266EMcs4RRSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 769D018C35BC;
 Tue, 28 Apr 2020 13:16:58 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B27D45C220;
 Tue, 28 Apr 2020 13:16:55 +0000 (UTC)
Date: Tue, 28 Apr 2020 14:16:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 02/14] qcrypto/luks: implement encryption key management
Message-ID: <20200428131652.GA1467943@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-3-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308151903.25941-3-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 08, 2020 at 05:18:51PM +0200, Maxim Levitsky wrote:
> Next few patches will expose that functionality
> to the user.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 398 +++++++++++++++++++++++++++++++++++++++++++-
>  qapi/crypto.json    |  61 ++++++-
>  2 files changed, 455 insertions(+), 4 deletions(-)
>=20
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 4861db810c..b11ee08c6d 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c

> +/*
> + * Erases an keyslot given its index
> + * Returns:
> + *    0 if the keyslot was erased successfully
> + *   -1 if a error occurred while erasing the keyslot
> + *
> + */
> +static int
> +qcrypto_block_luks_erase_key(QCryptoBlock *block,
> +                             unsigned int slot_idx,
> +                             QCryptoBlockWriteFunc writefunc,
> +                             void *opaque,
> +                             Error **errp)
> +{
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot_idx];
> +    g_autofree uint8_t *garbagesplitkey =3D NULL;
> +    size_t splitkeylen =3D luks->header.master_key_len * slot->stripes;
> +    size_t i;
> +
> +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> +    assert(splitkeylen > 0);
> +    garbagesplitkey =3D g_new0(uint8_t, splitkeylen);
> +
> +    /* Reset the key slot header */
> +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> +    slot->iterations =3D 0;
> +    slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> +
> +    qcrypto_block_luks_store_header(block,  writefunc, opaque, errp);

This may set  errp and we don't return immediately, so....

> +    /*
> +     * Now try to erase the key material, even if the header
> +     * update failed
> +     */
> +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
> +        if (qcrypto_random_bytes(garbagesplitkey, splitkeylen, errp) < 0=
) {

...this may then set errp a second time, which is not permitted.

This call needs to use a "local_err", and error_propagate(errp, local_err).
The latter is a no-op if errp is already set.

> +            /*
> +             * If we failed to get the random data, still write
> +             * at least zeros to the key slot at least once
> +             */
> +            if (i > 0) {
> +                return -1;
> +            }
> +        }
> +        if (writefunc(block,
> +                      slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SECTO=
R_SIZE,
> +                      garbagesplitkey,
> +                      splitkeylen,
> +                      opaque,
> +                      errp) !=3D splitkeylen) {

same issue with errp here too.

> +            return -1;
> +        }
> +    }
> +    return 0;
> +}


> +/*
> + * Given LUKSKeyslotUpdate command, set @slots_bitmap with all slots
> + * that will be updated with new password (or erased)
> + * returns 0 on success, and -1 on failure
> + */
> +static int
> +qcrypto_block_luks_get_update_bitmap(QCryptoBlock *block,
> +                                     QCryptoBlockReadFunc readfunc,
> +                                     void *opaque,
> +                                     const QCryptoBlockAmendOptionsLUKS =
*opts,
> +                                     unsigned long *slots_bitmap,
> +                                     Error **errp)
> +{
> +    const QCryptoBlockLUKS *luks =3D block->opaque;
> +    size_t i;
> +
> +    bitmap_zero(slots_bitmap, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> +
> +    if (opts->has_keyslot) {
> +        /* keyslot set, select only this keyslot */
> +        int keyslot =3D opts->keyslot;
> +
> +        if (keyslot < 0 || keyslot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS=
) {
> +            error_setg(errp,
> +                       "Invalid slot %u specified, must be between 0 and=
 %u",
> +                       keyslot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1);
> +            return -1;
> +        }
> +        bitmap_set(slots_bitmap, keyslot, 1);
> +
> +    } else if (opts->has_old_secret) {
> +        /* initially select all active keyslots */
> +        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +            if (qcrypto_block_luks_slot_active(luks, i)) {
> +                bitmap_set(slots_bitmap, i, 1);
> +            }
> +        }
> +    } else {
> +        /* find a free keyslot */
> +        int slot =3D qcrypto_block_luks_find_free_keyslot(luks);
> +
> +        if (slot =3D=3D -1) {
> +            error_setg(errp,
> +                       "Can't add a keyslot - all key slots are in use")=
;
> +            return -1;
> +        }
> +        bitmap_set(slots_bitmap, slot, 1);
> +    }
> +
> +    if (opts->has_old_secret) {
> +        /* now deselect all keyslots that don't contain the password */
> +        g_autofree uint8_t *tmpkey =3D g_new0(uint8_t,
> +                                            luks->header.master_key_len)=
;
> +
> +        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +            g_autofree char *old_password =3D NULL;
> +            int rv;
> +
> +            if (!test_bit(i, slots_bitmap)) {
> +                continue;
> +            }
> +
> +            old_password =3D qcrypto_secret_lookup_as_utf8(opts->old_sec=
ret,
> +                                                         errp);
> +            if (!old_password) {
> +                return -1;
> +            }
> +
> +            rv =3D qcrypto_block_luks_load_key(block,
> +                                             i,
> +                                             old_password,
> +                                             tmpkey,
> +                                             readfunc,
> +                                             opaque,
> +                                             errp);
> +            if (rv =3D=3D -1) {
> +                return -1;
> +            } else if (rv =3D=3D 0) {
> +                bitmap_clear(slots_bitmap, i, 1);
> +            }
> +        }
> +    }
> +    return 0;
> +}

I'm not really liking this function as a concept. Some of the code
only applies to the "add key" code path, while some of it only
applies to the "erase key" code path.

I'd prefer it if qcrypto_block_luks_erase_keys directly had the
required logic, likewise qcrypto_block_luks_set_keys, and thus
get rid of the bitmap concept entirely. I thin kit'd make the
logic easier to understand.

> +
> +/*
> + * Erase a set of keyslots given in @slots_bitmap
> + */
> +static int qcrypto_block_luks_erase_keys(QCryptoBlock *block,
> +                                         QCryptoBlockReadFunc readfunc,
> +                                         QCryptoBlockWriteFunc writefunc=
,
> +                                         void *opaque,
> +                                         unsigned long *slots_bitmap,
> +                                         bool force,
> +                                         Error **errp)
> +{
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    long slot_count =3D bitmap_count_one(slots_bitmap,
> +                                       QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS)=
;
> +    size_t i;
> +
> +    /* safety checks */
> +    if (!force && slot_count =3D=3D qcrypto_block_luks_count_active_slot=
s(luks)) {
> +        error_setg(errp,
> +                   "Requested operation will erase all active keyslots"
> +                   " which will erase all the data in the image"
> +                   " irreversibly - refusing operation");
> +        return -EINVAL;
> +    }
> +
> +    /* new apply the update */
> +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +        if (!test_bit(i, slots_bitmap)) {
> +            continue;
> +        }
> +        if (qcrypto_block_luks_erase_key(block, i, writefunc, opaque, er=
rp)) {
> +            error_append_hint(errp, "Failed to erase keyslot %zu", i);
> +            return -EINVAL;
> +        }
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Set a set of keyslots to @master_key encrypted by @new_secret
> + */
> +static int qcrypto_block_luks_set_keys(QCryptoBlock *block,
> +                                       QCryptoBlockReadFunc readfunc,
> +                                       QCryptoBlockWriteFunc writefunc,
> +                                       void *opaque,
> +                                       unsigned long *slots_bitmap,
> +                                       uint8_t *master_key,
> +                                       uint64_t iter_time,
> +                                       char *new_secret,
> +                                       bool force,
> +                                       Error **errp)

I'd call this  "add_key" instead of "set_keys".  I'm also unclear why
we need to support setting a range of keyslots. AFAIK, adding a key
should only ever affect a single keyslot.

> +{
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    g_autofree char *new_password =3D NULL;
> +    size_t i;
> +
> +    /* safety checks */
> +    if (!force) {
> +        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +            if (!test_bit(i, slots_bitmap)) {
> +                continue;
> +            }
> +            if (qcrypto_block_luks_slot_active(luks, i)) {
> +                error_setg(errp,
> +                           "Refusing to overwrite active slot %zu - "
> +                           "please erase it first", i);
> +                return -EINVAL;
> +            }
> +        }
> +    }
> +
> +    /* Load the new password */
> +    new_password =3D qcrypto_secret_lookup_as_utf8(new_secret, errp);
> +    if (!new_password) {
> +        return -EINVAL;
> +    }
> +
> +    /* Apply the update */
> +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +        if (!test_bit(i, slots_bitmap)) {
> +            continue;
> +        }
> +        if (qcrypto_block_luks_store_key(block, i, new_password, master_=
key,
> +                                         iter_time, writefunc, opaque, e=
rrp)) {
> +            error_append_hint(errp, "Failed to write to keyslot %zu", i)=
;
> +            return -EINVAL;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int
> +qcrypto_block_luks_amend_options(QCryptoBlock *block,
> +                                 QCryptoBlockReadFunc readfunc,
> +                                 QCryptoBlockWriteFunc writefunc,
> +                                 void *opaque,
> +                                 QCryptoBlockAmendOptions *options,
> +                                 bool force,
> +                                 Error **errp)
> +{
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    QCryptoBlockAmendOptionsLUKS *opts_luks =3D &options->u.luks;
> +    g_autofree uint8_t *master_key =3D NULL;
> +    g_autofree unsigned long *update_bitmap =3D NULL;
> +    char *unlock_secret =3D NULL;
> +    long slot_count;
> +
> +    unlock_secret =3D opts_luks->has_unlock_secret ? opts_luks->unlock_s=
ecret :
> +                                                   luks->secret;
> +
> +    /* Retrieve set of slots that we need to update */
> +    update_bitmap =3D bitmap_new(QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> +    if (qcrypto_block_luks_get_update_bitmap(block, readfunc, opaque, op=
ts_luks,
> +                                             update_bitmap, errp) !=3D 0=
) {
> +        return -1;
> +    }
> +
> +    slot_count =3D bitmap_count_one(update_bitmap,
> +                                  QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> +
> +    /* no matching slots, so nothing to do */
> +    if (slot_count =3D=3D 0) {
> +        error_setg(errp, "Requested operation didn't match any slots");
> +        return -1;
> +    }
> +
> +    if (opts_luks->state =3D=3D LUKS_KEYSLOT_STATE_ACTIVE) {
> +
> +        uint64_t iter_time =3D opts_luks->has_iter_time ?
> +                             opts_luks->iter_time :
> +                             QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
> +
> +        if (!opts_luks->has_new_secret) {
> +            error_setg(errp, "'new-secret' is required to activate a key=
slot");
> +            return -EINVAL;

return -1,   we shouldn't return errno values in luks code in general
as we use  Error **errp.

> +        }
> +        if (opts_luks->has_old_secret) {
> +            error_setg(errp,
> +                       "'old-secret' must not be given when activating k=
eyslots");
> +            return -EINVAL;
> +        }
> +
> +        /* Locate the password that will be used to retrieve the master =
key */
> +        g_autofree char *old_password;
> +        old_password =3D qcrypto_secret_lookup_as_utf8(unlock_secret,  e=
rrp);
> +        if (!old_password) {
> +            return -EINVAL;
> +        }
> +
> +        /* Try to retrieve the master key */
> +        master_key =3D g_new0(uint8_t, luks->header.master_key_len);
> +        if (qcrypto_block_luks_find_key(block, old_password, master_key,
> +                                        readfunc, opaque, errp) < 0) {
> +            error_append_hint(errp, "Failed to retrieve the master key")=
;
> +            return -EINVAL;
> +        }
> +
> +        /* Now set the new keyslots */
> +        if (qcrypto_block_luks_set_keys(block, readfunc, writefunc,
> +                                        opaque, update_bitmap, master_ke=
y,
> +                                        iter_time,
> +                                        opts_luks->new_secret,
> +                                        force, errp) !=3D 0) {
> +            return -1;
> +        }
> +    } else {
> +        if (opts_luks->has_new_secret) {
> +            error_setg(errp,
> +                       "'new-secret' must not be given when erasing keys=
lots");
> +            return -EINVAL;
> +        }
> +        if (opts_luks->has_iter_time) {
> +            error_setg(errp,
> +                       "'iter-time' must not be given when erasing keysl=
ots");
> +            return -EINVAL;
> +        }
> +        if (opts_luks->has_unlock_secret) {
> +            error_setg(errp,
> +                       "'unlock_secret' must not be given when erasing k=
eyslots");
> +            return -EINVAL;
> +        }
> +
> +        if (qcrypto_block_luks_erase_keys(block, readfunc, writefunc,
> +                                          opaque, update_bitmap, force,
> +                                          errp) !=3D 0) {
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> =20
>  static int qcrypto_block_luks_get_info(QCryptoBlock *block,
>                                         QCryptoBlockInfo *info,
> @@ -1523,7 +1912,11 @@ static int qcrypto_block_luks_get_info(QCryptoBloc=
k *block,
> =20
>  static void qcrypto_block_luks_cleanup(QCryptoBlock *block)
>  {
> -    g_free(block->opaque);
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    if (luks) {
> +        g_free(luks->secret);
> +        g_free(luks);
> +    }
>  }
> =20
> =20
> @@ -1560,6 +1953,7 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
>  const QCryptoBlockDriver qcrypto_block_driver_luks =3D {
>      .open =3D qcrypto_block_luks_open,
>      .create =3D qcrypto_block_luks_create,
> +    .amend =3D qcrypto_block_luks_amend_options,
>      .get_info =3D qcrypto_block_luks_get_info,
>      .cleanup =3D qcrypto_block_luks_cleanup,
>      .decrypt =3D qcrypto_block_luks_decrypt,
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 3fd0ce177e..fe600fc608 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -1,6 +1,8 @@
>  # -*- Mode: Python -*-
>  #
> =20
> +{ 'include': 'common.json' }
> +
>  ##
>  # =3D Cryptography
>  ##
> @@ -297,7 +299,6 @@
>             'uuid': 'str',
>             'slots': [ 'QCryptoBlockInfoLUKSSlot' ] }}
> =20
> -
>  ##
>  # @QCryptoBlockInfo:
>  #
> @@ -310,7 +311,63 @@
>    'discriminator': 'format',
>    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> =20
> +##
> +# @LUKSKeyslotState:
> +#
> +# Defines state of keyslots that are affected by the update
> +#
> +# @active:    The slots contain the given password and marked as active
> +# @inactive:  The slots are erased (contain garbage) and marked as inact=
ive
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'LUKSKeyslotState',
> +  'data': [ 'active', 'inactive' ] }

This should be called  QCryptoBLockLUKSKeyslotState

> +##
> +# @QCryptoBlockAmendOptionsLUKS:
> +#
> +# This struct defines the update parameters that activate/de-activate se=
t
> +# of keyslots
> +#
> +# @state: the desired state of the keyslots
> +#
> +# @new-secret:    The ID of a QCryptoSecret object providing the passwor=
d to be
> +#                 written into added active keyslots
> +#
> +# @old-secret:    Optional (for deactivation only)
> +#                 If given will deactive all keyslots that
> +#                 match password located in QCryptoSecret with this ID
> +#
> +# @iter-time:     Optional (for activation only)
> +#                 Number of milliseconds to spend in
> +#                 PBKDF passphrase processing for the newly activated ke=
yslot.
> +#                 Currently defaults to 2000.
> +#
> +# @keyslot:       Optional. ID of the keyslot to activate/deactivate.
> +#                 For keyslot activation, keyslot should not be active a=
lready
> +#                 (this is unsafe to update an active keyslot),
> +#                 but possible if 'force' parameter is given.
> +#                 If keyslot is not given, first free keyslot will be wr=
itten.
> +#
> +#                 For keyslot deactivation, this parameter specifies the=
 exact
> +#                 keyslot to deactivate
> +#
> +# @unlock-secret: Optional. The ID of a QCryptoSecret object providing t=
he
> +#                 password to use to retrive current master key.
> +#                 Defaults to the same secret that was used to open the =
image

My inclination would be to just call this  "@secret", as it serves the
same purpose as the "@secret" parameter used when opening the image.

> +{ 'struct': 'QCryptoBlockAmendOptionsLUKS',
> +  'data': { 'state': 'LUKSKeyslotState',
> +            '*new-secret': 'str',
> +            '*old-secret': 'str',
> +            '*keyslot': 'int',
> +            '*iter-time': 'int',
> +            '*unlock-secret': 'str' } }
> =20
>  ##
>  # @QCryptoBlockAmendOptions:
> @@ -324,4 +381,4 @@
>    'base': 'QCryptoBlockOptionsBase',
>    'discriminator': 'format',
>    'data': {
> -            } }
> +          'luks': 'QCryptoBlockAmendOptionsLUKS' } }

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


