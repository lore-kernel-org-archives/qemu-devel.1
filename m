Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B4C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA4F2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLV3oVVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA4F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWeJG-0007Nb-2Z
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWeIJ-000686-WD
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:02:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWeII-0004In-Ob
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588849341;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGKzYnlOMzGpmQG5UmtHO/giOncbIu10WfWcG/iWRwE=;
 b=bLV3oVVgkum09DeO2NeZdgOfJDvB++WoKkWgIcLz08voUgei2ke+GH9pwTQ7G3MUGpZe87
 ONIJBRLP2pxm/2zmhT8iZBHqfQ2FLlAQwBbG8UsVgR9u0TcAsLtkC6kqdS5NGDLTgshUqt
 t4w6N9KZz1MV3uJK9M2t4QwG9dDDdeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-mH9rtVt_MPC70eZZ8xk8cw-1; Thu, 07 May 2020 07:02:19 -0400
X-MC-Unique: mH9rtVt_MPC70eZZ8xk8cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC498800688;
 Thu,  7 May 2020 11:02:18 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 629681001920;
 Thu,  7 May 2020 11:02:13 +0000 (UTC)
Date: Thu, 7 May 2020 12:02:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v4 02/14] qcrypto/luks: implement encryption key management
Message-ID: <20200507110210.GE1104082@redhat.com>
References: <20200505200819.5662-1-mlevitsk@redhat.com>
 <20200505200819.5662-3-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200505200819.5662-3-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 11:08:07PM +0300, Maxim Levitsky wrote:
> Next few patches will expose that functionality
> to the user.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 395 +++++++++++++++++++++++++++++++++++++++++++-
>  qapi/crypto.json    |  61 ++++++-
>  2 files changed, 452 insertions(+), 4 deletions(-)
>=20
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 4861db810c..c108518df1 100644
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
> +    Error *local_err =3D NULL;
> +    int ret;
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
> +    ret =3D qcrypto_block_luks_store_header(block,  writefunc,
> +                                          opaque, &local_err);
> +
> +    if (ret) {

ret < 0

> +        error_propagate(errp, local_err);
> +    }
> +    /*
> +     * Now try to erase the key material, even if the header
> +     * update failed
> +     */
> +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
> +        if (qcrypto_random_bytes(garbagesplitkey,
> +                                 splitkeylen, &local_err) < 0) {
> +            /*
> +             * If we failed to get the random data, still write
> +             * at least zeros to the key slot at least once
> +             */
> +            error_propagate(errp, local_err);
> +
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
> +                      &local_err) !=3D splitkeylen) {
> +            error_propagate(errp, local_err);
> +            return -1;
> +        }
> +    }
> +    return 0;

We need to "return ret" here, in case the earlier store_header() failed

> +}
> =20



> +static int
> +qcrypto_block_luks_amend_add_keyslot(QCryptoBlock *block,
> +                                     QCryptoBlockReadFunc readfunc,
> +                                     QCryptoBlockWriteFunc writefunc,
> +                                     void *opaque,
> +                                     QCryptoBlockAmendOptionsLUKS *opts_=
luks,
> +                                     bool force,
> +                                     Error **errp)
> +{
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    uint64_t iter_time =3D opts_luks->has_iter_time ?
> +                         opts_luks->iter_time :
> +                         QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
> +    int keyslot;
> +    g_autofree char *old_password =3D NULL;
> +    g_autofree char *new_password =3D NULL;
> +    g_autofree uint8_t *master_key =3D NULL;
> +
> +    char *secret =3D opts_luks->has_secret ? opts_luks->secret : luks->s=
ecret;
> +
> +    if (!opts_luks->has_new_secret) {
> +        error_setg(errp, "'new-secret' is required to activate a keyslot=
");
> +        return -1;
> +    }
> +    if (opts_luks->has_old_secret) {
> +        error_setg(errp,
> +                   "'old-secret' must not be given when activating keysl=
ots");
> +        return -1;
> +    }
> +
> +    if (opts_luks->has_keyslot) {
> +        keyslot =3D opts_luks->keyslot;
> +        if (keyslot < 0 || keyslot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS=
) {
> +            error_setg(errp,
> +                       "Invalid keyslot %u specified, must be between 0 =
and %u",
> +                       keyslot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1);
> +            return -1;
> +        }
> +    } else {
> +        keyslot =3D qcrypto_block_luks_find_free_keyslot(luks);
> +        if (keyslot =3D=3D -1) {
> +            error_setg(errp,
> +                       "Can't add a keyslot - all keyslots are in use");
> +            return -1;
> +        }
> +    }
> +
> +    if (!force && qcrypto_block_luks_slot_active(luks, keyslot)) {
> +        error_setg(errp,
> +                   "Refusing to overwrite active keyslot %i - "
> +                   "please erase it first",
> +                   keyslot);
> +        return -EINVAL;

s/-EINVAL/-1/

> +    }
> +
> +    /* Locate the password that will be used to retrieve the master key =
*/
> +    old_password =3D qcrypto_secret_lookup_as_utf8(secret, errp);
> +    if (!old_password) {
> +        return -1;
> +    }
> +
> +    /* Retrieve the master key */
> +    master_key =3D g_new0(uint8_t, luks->header.master_key_len);
> +
> +    if (qcrypto_block_luks_find_key(block, old_password, master_key,
> +                                    readfunc, opaque, errp) < 0) {
> +        error_append_hint(errp, "Failed to retrieve the master key");
> +        return -1;
> +    }
> +
> +    /* Locate the new password*/
> +    new_password =3D qcrypto_secret_lookup_as_utf8(opts_luks->new_secret=
, errp);
> +    if (!new_password) {
> +        return -EINVAL;

s/-EINVAL/-1/

> +    }
> +
> +    /* Now set the new keyslots */
> +    if (qcrypto_block_luks_store_key(block, keyslot, new_password, maste=
r_key,
> +                                     iter_time, writefunc, opaque, errp)=
) {
> +        error_append_hint(errp, "Failed to write to keyslot %i", keyslot=
);
> +        return -EINVAL;

s/-EINVAL/-1/

> +    }
> +    return 0;
> +}
> +
> +static int
> +qcrypto_block_luks_amend_erase_keyslots(QCryptoBlock *block,
> +                                        QCryptoBlockReadFunc readfunc,
> +                                        QCryptoBlockWriteFunc writefunc,
> +                                        void *opaque,
> +                                        QCryptoBlockAmendOptionsLUKS *op=
ts_luks,
> +                                        bool force,
> +                                        Error **errp)
> +{
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    g_autofree uint8_t *tmpkey =3D NULL;
> +    g_autofree char *old_password =3D NULL;
> +
> +    if (opts_luks->has_new_secret) {
> +        error_setg(errp,
> +                   "'new-secret' must not be given when erasing keyslots=
");
> +        return -1;
> +    }
> +    if (opts_luks->has_iter_time) {
> +        error_setg(errp,
> +                   "'iter-time' must not be given when erasing keyslots"=
);
> +        return -1;
> +    }
> +    if (opts_luks->has_secret) {
> +        error_setg(errp,
> +                   "'secret' must not be given when erasing keyslots");
> +        return -1;
> +    }
> +
> +    /* Load the old password if given */
> +    if (opts_luks->has_old_secret) {
> +        old_password =3D qcrypto_secret_lookup_as_utf8(opts_luks->old_se=
cret,
> +                                                     errp);
> +        if (!old_password) {
> +            return -1;
> +        }
> +
> +        /*
> +         * Allocate a temporary key buffer that we will need when
> +         * checking if slot matches the given old password
> +         */
> +        tmpkey =3D g_new0(uint8_t, luks->header.master_key_len);
> +}

Indent missing



With the minor points fixed

   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


