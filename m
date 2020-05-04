Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41B8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFCB206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrkYK+2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFCB206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXGR-0001NE-Kc
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVXF9-0000CU-Eg
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:18:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59984
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVXF7-0002pj-7m
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588583908;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePrbW0uZmx7LB2vhjdML671PljuizG9wsyYfT3t9O1M=;
 b=TrkYK+2Y9wYzHbPbaG6+oZ/h3XatjUAhwklgaxWWgoJQhQSVI/obcXJ+cWML9Qpo+7S9Cs
 Qlof3rjxbytAqzC8T2dXS3hUawXN8MUvDEsZ/2Hb+5k0RmUBoU/wTBgqMDTouuqmLdQ7DC
 +YNnaF3+D6ZihWw2I3O0JocZSxNS4rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Ya-ab49jNr2kJwj5VyxNAA-1; Mon, 04 May 2020 05:18:24 -0400
X-MC-Unique: Ya-ab49jNr2kJwj5VyxNAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 178586DADA;
 Mon,  4 May 2020 09:18:15 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31883100238A;
 Mon,  4 May 2020 09:18:11 +0000 (UTC)
Date: Mon, 4 May 2020 10:18:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 02/14] qcrypto/luks: implement encryption key management
Message-ID: <20200504091808.GD115875@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-3-mlevitsk@redhat.com>
 <20200428131652.GA1467943@redhat.com>
 <2f191d8fde9c12231b5976dca8429459fa559ce8.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2f191d8fde9c12231b5976dca8429459fa559ce8.camel@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 03, 2020 at 11:55:35AM +0300, Maxim Levitsky wrote:
> On Tue, 2020-04-28 at 14:16 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Sun, Mar 08, 2020 at 05:18:51PM +0200, Maxim Levitsky wrote:
> > > Next few patches will expose that functionality
> > > to the user.
> > >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  crypto/block-luks.c | 398 ++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  qapi/crypto.json    |  61 ++++++-
> > >  2 files changed, 455 insertions(+), 4 deletions(-)


> > > +/*
> > > + * Given LUKSKeyslotUpdate command, set @slots_bitmap with all slots
> > > + * that will be updated with new password (or erased)
> > > + * returns 0 on success, and -1 on failure
> > > + */
> > > +static int
> > > +qcrypto_block_luks_get_update_bitmap(QCryptoBlock *block,
> > > +                                     QCryptoBlockReadFunc readfunc,
> > > +                                     void *opaque,
> > > +                                     const QCryptoBlockAmendOptionsL=
UKS *opts,
> > > +                                     unsigned long *slots_bitmap,
> > > +                                     Error **errp)
> > > +{
> > > +    const QCryptoBlockLUKS *luks =3D block->opaque;
> > > +    size_t i;
> > > +
> > > +    bitmap_zero(slots_bitmap, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> > > +
> > > +    if (opts->has_keyslot) {
> > > +        /* keyslot set, select only this keyslot */
> > > +        int keyslot =3D opts->keyslot;
> > > +
> > > +        if (keyslot < 0 || keyslot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_S=
LOTS) {
> > > +            error_setg(errp,
> > > +                       "Invalid slot %u specified, must be between 0=
 and %u",
> > > +                       keyslot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1=
);
> > > +            return -1;
> > > +        }
> > > +        bitmap_set(slots_bitmap, keyslot, 1);
> > > +
> > > +    } else if (opts->has_old_secret) {
> > > +        /* initially select all active keyslots */
> > > +        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > > +            if (qcrypto_block_luks_slot_active(luks, i)) {
> > > +                bitmap_set(slots_bitmap, i, 1);
> > > +            }
> > > +        }
> > > +    } else {
> > > +        /* find a free keyslot */
> > > +        int slot =3D qcrypto_block_luks_find_free_keyslot(luks);
> > > +
> > > +        if (slot =3D=3D -1) {
> > > +            error_setg(errp,
> > > +                       "Can't add a keyslot - all key slots are in u=
se");
> > > +            return -1;
> > > +        }
> > > +        bitmap_set(slots_bitmap, slot, 1);
> > > +    }
> > > +
> > > +    if (opts->has_old_secret) {
> > > +        /* now deselect all keyslots that don't contain the password=
 */
> > > +        g_autofree uint8_t *tmpkey =3D g_new0(uint8_t,
> > > +                                            luks->header.master_key_=
len);
> > > +
> > > +        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > > +            g_autofree char *old_password =3D NULL;
> > > +            int rv;
> > > +
> > > +            if (!test_bit(i, slots_bitmap)) {
> > > +                continue;
> > > +            }
> > > +
> > > +            old_password =3D qcrypto_secret_lookup_as_utf8(opts->old=
_secret,
> > > +                                                         errp);
> > > +            if (!old_password) {
> > > +                return -1;
> > > +            }
> > > +
> > > +            rv =3D qcrypto_block_luks_load_key(block,
> > > +                                             i,
> > > +                                             old_password,
> > > +                                             tmpkey,
> > > +                                             readfunc,
> > > +                                             opaque,
> > > +                                             errp);
> > > +            if (rv =3D=3D -1) {
> > > +                return -1;
> > > +            } else if (rv =3D=3D 0) {
> > > +                bitmap_clear(slots_bitmap, i, 1);
> > > +            }
> > > +        }
> > > +    }
> > > +    return 0;
> > > +}
> >=20
> > I'm not really liking this function as a concept. Some of the code
> > only applies to the "add key" code path, while some of it only
> > applies to the "erase key" code path.
> >=20
> > I'd prefer it if qcrypto_block_luks_erase_keys directly had the
> > required logic, likewise qcrypto_block_luks_set_keys, and thus
> > get rid of the bitmap concept entirely. I thin kit'd make the
> > logic easier to understand.
>=20
> It used to be like that in former versions that I did send, I added the c=
oncept
> of the bitmap very recently to reflect the way we defined this in the spe=
c.
> I don't mind that much coming back to older version of doing this,
> but beware that it won't be that clear either.

My view is that removing and adding keys are fundamentally different
operations, so although there's some parts that are in common, overall
it is better to keep them clearly separate.

> > > +/*
> > > + * Erase a set of keyslots given in @slots_bitmap
> > > + */
> > > +static int qcrypto_block_luks_erase_keys(QCryptoBlock *block,
> > > +                                         QCryptoBlockReadFunc readfu=
nc,
> > > +                                         QCryptoBlockWriteFunc write=
func,
> > > +                                         void *opaque,
> > > +                                         unsigned long *slots_bitmap=
,
> > > +                                         bool force,
> > > +                                         Error **errp)
> > > +{
> > > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > > +    long slot_count =3D bitmap_count_one(slots_bitmap,
> > > +                                       QCRYPTO_BLOCK_LUKS_NUM_KEY_SL=
OTS);
> > > +    size_t i;
> > > +
> > > +    /* safety checks */
> > > +    if (!force && slot_count =3D=3D qcrypto_block_luks_count_active_=
slots(luks)) {
> > > +        error_setg(errp,
> > > +                   "Requested operation will erase all active keyslo=
ts"
> > > +                   " which will erase all the data in the image"
> > > +                   " irreversibly - refusing operation");
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    /* new apply the update */
> > > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > > +        if (!test_bit(i, slots_bitmap)) {
> > > +            continue;
> > > +        }
> > > +        if (qcrypto_block_luks_erase_key(block, i, writefunc, opaque=
, errp)) {
> > > +            error_append_hint(errp, "Failed to erase keyslot %zu", i=
);
> > > +            return -EINVAL;
> > > +        }
> > > +    }
> > > +    return 0;
> > > +}
> > > +
> > > +/*
> > > + * Set a set of keyslots to @master_key encrypted by @new_secret
> > > + */
> > > +static int qcrypto_block_luks_set_keys(QCryptoBlock *block,
> > > +                                       QCryptoBlockReadFunc readfunc=
,
> > > +                                       QCryptoBlockWriteFunc writefu=
nc,
> > > +                                       void *opaque,
> > > +                                       unsigned long *slots_bitmap,
> > > +                                       uint8_t *master_key,
> > > +                                       uint64_t iter_time,
> > > +                                       char *new_secret,
> > > +                                       bool force,
> > > +                                       Error **errp)
> >=20
> > I'd call this  "add_key" instead of "set_keys".  I'm also unclear why
> > we need to support setting a range of keyslots. AFAIK, adding a key
> > should only ever affect a single keyslot.
> Mostly for consistency. There is a very corner case of inline replacing
> all keys that match one password with another.

I don't see that as a use case we care about. There's no benefit to having
the same password repeated in multiple slots.

> If possible I would like to keep it this way though.

IMHO the the bitmap just needlessly complicates the code for a feature
that is irrelevant to us.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


