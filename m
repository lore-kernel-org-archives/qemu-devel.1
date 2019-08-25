Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1462CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 14:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBB32080C
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 14:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBB32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1tYt-0007Ju-12
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 10:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1tXN-0006qx-Lf
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 10:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1tXL-0008CX-8W
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 10:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1tXH-0007vL-BN; Sun, 25 Aug 2019 10:30:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B364387B1;
 Sun, 25 Aug 2019 14:30:26 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42DA360BEC;
 Sun, 25 Aug 2019 14:30:21 +0000 (UTC)
Message-ID: <7cf4bde6ca7bb74adf1dfc40e2d1ad61b83c6b28.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Sun, 25 Aug 2019 17:30:20 +0300
In-Reply-To: <20190822104704.GI3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-5-mlevitsk@redhat.com>
 <20190822104704.GI3267@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Sun, 25 Aug 2019 14:30:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/13] qcrypto-luks: refactoring: simplify
 the math used for keyslot locations
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 11:47 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Aug 14, 2019 at 11:22:10PM +0300, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 64 +++++++++++++++++++++++++++----------------=
--
> >  1 file changed, 38 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index 6bb369f3b4..e1a4df94b7 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -417,6 +417,33 @@ static int masterkeylen(QCryptoBlockLUKS *luks)
> >  }
> > =20
> > =20
> > +/*
> > + * Returns number of sectors needed to store the key material
> > + * given number of anti forensic stripes
> > + */
> > +static int splitkeylen_sectors(QCryptoBlockLUKS *luks, int stripes)
>=20
> Needs a qcrypto_block_luks_ prefix on method name.
Done.

>=20
> I'd also put 'static int' on a separate line from method name
> to reduce too long lines.
Done.
>=20
> > +
> > +{
> > +    /*
> > +     * This calculation doesn't match that shown in the spec,
> > +     * but instead follows the cryptsetup implementation.
> > +     */
> > +
> > +    size_t header_sectors =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> > +                     QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
>=20
> Following line indent should only be 4 spaces
I didn't knew that. Fixed.
>=20
> > +
> > +    size_t splitkeylen =3D masterkeylen(luks) * stripes;
> > +
> > +    /* First align the key material size to block size*/
> > +    size_t splitkeylen_sectors =3D
> > +            DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE=
);
>=20
> Again 4 space indent.
>=20
> > +
> > +    /* Then also align the key material size to the size of the head=
er */
> > +    return ROUND_UP(splitkeylen_sectors, header_sectors);
> > +}
> > +
> > +
> > +
> >  /*
> >   * Stores the main LUKS header, taking care of endianess
> >   */
> > @@ -1169,7 +1196,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
> >      QCryptoBlockCreateOptionsLUKS luks_opts;
> >      Error *local_err =3D NULL;
> >      uint8_t *masterkey =3D NULL;
> > -    size_t splitkeylen =3D 0;
> > +    size_t next_sector;
> >      size_t i;
> >      char *password;
> >      const char *cipher_alg;
> > @@ -1388,23 +1415,16 @@ qcrypto_block_luks_create(QCryptoBlock *block=
,
> >          goto error;
> >      }
> > =20
> > +    /* start with the sector that follows the header*/
> > +    next_sector =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> > +                  QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
>=20
> I'd suggest 'post_header_sector'
I called it now header_sectors, and each split key, split_key_sectors.
I hope that this is good enough.
>=20
> > =20
> > -    /* Although LUKS has multiple key slots, we're just going
> > -     * to use the first key slot */
> > -    splitkeylen =3D luks->header.key_bytes * QCRYPTO_BLOCK_LUKS_STRI=
PES;
> >      for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > -        luks->header.key_slots[i].active =3D QCRYPTO_BLOCK_LUKS_KEY_=
SLOT_DISABLED;
> > -        luks->header.key_slots[i].stripes =3D QCRYPTO_BLOCK_LUKS_STR=
IPES;
> > -
> > -        /* This calculation doesn't match that shown in the spec,
> > -         * but instead follows the cryptsetup implementation.
> > -         */
> > -        luks->header.key_slots[i].key_offset =3D
> > -            (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> > -             QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
> > -            (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_S=
ECTOR_SIZE),
> > -                      (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> > -                       QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) * i);
> > +        QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[i]=
;
> > +        slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> > +        slot->key_offset =3D next_sector;
> > +        slot->stripes =3D QCRYPTO_BLOCK_LUKS_STRIPES;
> > +        next_sector +=3D splitkeylen_sectors(luks, QCRYPTO_BLOCK_LUK=
S_STRIPES);
>=20
> I'm not a fan of the next_sector accumulator .
I actually think that accumulator is cleaner here,
but I won't argue about this. Fixed.


>=20
> I'd prefer to see the '* i' part done in splitkeylen_sectors, so that
> we have
>=20
>   slot->key_offset =3D post_header_sector +
>         splitkeylen_sectors(luks, QCRYPTO_BLOCK_LUKS_STRIPES, i);
>=20
> > @@ -1412,17 +1432,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
> >       * slot headers, rounded up to the nearest sector, combined with
> >       * the size of each master key material region, also rounded up
> >       * to the nearest sector */
> > -    luks->header.payload_offset =3D
> > -        (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> > -         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
> > -        (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTO=
R_SIZE),
> > -                  (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> > -                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) *
> > -         QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> > -
> > +    luks->header.payload_offset =3D next_sector;
>=20
>   luks->header.payload_offset =3D post_header_sector +
>         splitkeylen_sectors(luks, QCRYPTO_BLOCK_LUKS_STRIPES,
> 	                    QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
>=20
>=20
> >      block->sector_size =3D QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
> > -    block->payload_offset =3D luks->header.payload_offset *
> > -        block->sector_size;
> > +    block->payload_offset =3D luks->header.payload_offset * block->s=
ector_size;
>=20
>=20
> This is reverting a whitspace change done in previous method
True. Fixed.

>=20
> Regards,
> Daniel


Best regards,
	Maxim Levitsky


