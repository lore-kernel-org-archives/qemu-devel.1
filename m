Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19106C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F54F20870
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWazqKGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F54F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWeTo-0004j8-Hy
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jWeTE-0004Fi-T7
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:13:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jWeTD-0001Zl-O4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588850018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIYx9WV3hxHNRv0AB2UjjFAQ0pzVxRIPYxJ4VyiZfHA=;
 b=YWazqKGaJpKjQU9C1lPGVrlxex9H7qongdBaqyV2Y2lEfb6nHW1/UqlCoFgvd/xdY+NwTH
 nPePU0VXqRGgpZ4Qlhf+Dd8CUcQA0Ucr/aW6/OocKuzlgdWlPMmJbP0mqpOSCQf9rRUpr8
 UiUkOR2OOAgiOvkGcYaZzMbxAfnNPUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-evKJPeLYP8O2R8l5Jbn9cA-1; Thu, 07 May 2020 07:13:36 -0400
X-MC-Unique: evKJPeLYP8O2R8l5Jbn9cA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62F9580058A;
 Thu,  7 May 2020 11:13:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4312F649A9;
 Thu,  7 May 2020 11:13:33 +0000 (UTC)
Message-ID: <5026226250dbd62e011424ce52d7bf8aeb5d1cb4.camel@redhat.com>
Subject: Re: [PATCH v4 02/14] qcrypto/luks: implement encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 07 May 2020 14:13:32 +0300
In-Reply-To: <20200507110210.GE1104082@redhat.com>
References: <20200505200819.5662-1-mlevitsk@redhat.com>
 <20200505200819.5662-3-mlevitsk@redhat.com>
 <20200507110210.GE1104082@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-05-07 at 12:02 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 05, 2020 at 11:08:07PM +0300, Maxim Levitsky wrote:
> > Next few patches will expose that functionality
> > to the user.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 395 +++++++++++++++++++++++++++++++++++++++++++-
> >  qapi/crypto.json    |  61 ++++++-
> >  2 files changed, 452 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index 4861db810c..c108518df1 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
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
> > +    Error *local_err =3D NULL;
> > +    int ret;
> > +
> > +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> > +    assert(splitkeylen > 0);
> > +    garbagesplitkey =3D g_new0(uint8_t, splitkeylen);
> > +
> > +    /* Reset the key slot header */
> > +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> > +    slot->iterations =3D 0;
> > +    slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> > +
> > +    ret =3D qcrypto_block_luks_store_header(block,  writefunc,
> > +                                          opaque, &local_err);
> > +
> > +    if (ret) {
>=20
> ret < 0
Fixed.
>=20
> > +        error_propagate(errp, local_err);
> > +    }
> > +    /*
> > +     * Now try to erase the key material, even if the header
> > +     * update failed
> > +     */
> > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
> > +        if (qcrypto_random_bytes(garbagesplitkey,
> > +                                 splitkeylen, &local_err) < 0) {
> > +            /*
> > +             * If we failed to get the random data, still write
> > +             * at least zeros to the key slot at least once
> > +             */
> > +            error_propagate(errp, local_err);
> > +
> > +            if (i > 0) {
> > +                return -1;
> > +            }
> > +        }
> > +        if (writefunc(block,
> > +                      slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SEC=
TOR_SIZE,
> > +                      garbagesplitkey,
> > +                      splitkeylen,
> > +                      opaque,
> > +                      &local_err) !=3D splitkeylen) {
> > +            error_propagate(errp, local_err);
> > +            return -1;
> > +        }
> > +    }
> > +    return 0;
>=20
> We need to "return ret" here, in case the earlier store_header() failed

Fixed, thanks!
>=20
> > +}
> > =20
>=20
>=20
>=20
> > +static int
> > +qcrypto_block_luks_amend_add_keyslot(QCryptoBlock *block,
> > +                                     QCryptoBlockReadFunc readfunc,
> > +                                     QCryptoBlockWriteFunc writefunc,
> > +                                     void *opaque,
> > +                                     QCryptoBlockAmendOptionsLUKS *opt=
s_luks,
> > +                                     bool force,
> > +                                     Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    uint64_t iter_time =3D opts_luks->has_iter_time ?
> > +                         opts_luks->iter_time :
> > +                         QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
> > +    int keyslot;
> > +    g_autofree char *old_password =3D NULL;
> > +    g_autofree char *new_password =3D NULL;
> > +    g_autofree uint8_t *master_key =3D NULL;
> > +
> > +    char *secret =3D opts_luks->has_secret ? opts_luks->secret : luks-=
>secret;
> > +
> > +    if (!opts_luks->has_new_secret) {
> > +        error_setg(errp, "'new-secret' is required to activate a keysl=
ot");
> > +        return -1;
> > +    }
> > +    if (opts_luks->has_old_secret) {
> > +        error_setg(errp,
> > +                   "'old-secret' must not be given when activating key=
slots");
> > +        return -1;
> > +    }
> > +
> > +    if (opts_luks->has_keyslot) {
> > +        keyslot =3D opts_luks->keyslot;
> > +        if (keyslot < 0 || keyslot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLO=
TS) {
> > +            error_setg(errp,
> > +                       "Invalid keyslot %u specified, must be between =
0 and %u",
> > +                       keyslot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1);
> > +            return -1;
> > +        }
> > +    } else {
> > +        keyslot =3D qcrypto_block_luks_find_free_keyslot(luks);
> > +        if (keyslot =3D=3D -1) {
> > +            error_setg(errp,
> > +                       "Can't add a keyslot - all keyslots are in use"=
);
> > +            return -1;
> > +        }
> > +    }
> > +
> > +    if (!force && qcrypto_block_luks_slot_active(luks, keyslot)) {
> > +        error_setg(errp,
> > +                   "Refusing to overwrite active keyslot %i - "
> > +                   "please erase it first",
> > +                   keyslot);
> > +        return -EINVAL;
>=20
> s/-EINVAL/-1/
>=20
> > +    }
> > +
> > +    /* Locate the password that will be used to retrieve the master ke=
y */
> > +    old_password =3D qcrypto_secret_lookup_as_utf8(secret, errp);
> > +    if (!old_password) {
> > +        return -1;
> > +    }
> > +
> > +    /* Retrieve the master key */
> > +    master_key =3D g_new0(uint8_t, luks->header.master_key_len);
> > +
> > +    if (qcrypto_block_luks_find_key(block, old_password, master_key,
> > +                                    readfunc, opaque, errp) < 0) {
> > +        error_append_hint(errp, "Failed to retrieve the master key");
> > +        return -1;
> > +    }
> > +
> > +    /* Locate the new password*/
> > +    new_password =3D qcrypto_secret_lookup_as_utf8(opts_luks->new_secr=
et, errp);
> > +    if (!new_password) {
> > +        return -EINVAL;
>=20
> s/-EINVAL/-1/
>=20
> > +    }
> > +
> > +    /* Now set the new keyslots */
> > +    if (qcrypto_block_luks_store_key(block, keyslot, new_password, mas=
ter_key,
> > +                                     iter_time, writefunc, opaque, err=
p)) {
> > +        error_append_hint(errp, "Failed to write to keyslot %i", keysl=
ot);
> > +        return -EINVAL;
>=20
> s/-EINVAL/-1/
Fixed, sorry about this.


>=20
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int
> > +qcrypto_block_luks_amend_erase_keyslots(QCryptoBlock *block,
> > +                                        QCryptoBlockReadFunc readfunc,
> > +                                        QCryptoBlockWriteFunc writefun=
c,
> > +                                        void *opaque,
> > +                                        QCryptoBlockAmendOptionsLUKS *=
opts_luks,
> > +                                        bool force,
> > +                                        Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    g_autofree uint8_t *tmpkey =3D NULL;
> > +    g_autofree char *old_password =3D NULL;
> > +
> > +    if (opts_luks->has_new_secret) {
> > +        error_setg(errp,
> > +                   "'new-secret' must not be given when erasing keyslo=
ts");
> > +        return -1;
> > +    }
> > +    if (opts_luks->has_iter_time) {
> > +        error_setg(errp,
> > +                   "'iter-time' must not be given when erasing keyslot=
s");
> > +        return -1;
> > +    }
> > +    if (opts_luks->has_secret) {
> > +        error_setg(errp,
> > +                   "'secret' must not be given when erasing keyslots")=
;
> > +        return -1;
> > +    }
> > +
> > +    /* Load the old password if given */
> > +    if (opts_luks->has_old_secret) {
> > +        old_password =3D qcrypto_secret_lookup_as_utf8(opts_luks->old_=
secret,
> > +                                                     errp);
> > +        if (!old_password) {
> > +            return -1;
> > +        }
> > +
> > +        /*
> > +         * Allocate a temporary key buffer that we will need when
> > +         * checking if slot matches the given old password
> > +         */
> > +        tmpkey =3D g_new0(uint8_t, luks->header.master_key_len);
> > +}
>=20
> Indent missing
Fixed.
>=20
>=20
>=20
> With the minor points fixed
>=20
>    Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> Regards,
> Daniel


Best regards,
=09Maxim Levitsky


