Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A801AFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C48214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL+r5CuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C48214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0eO-0001qp-Am
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0b7-0007os-0P
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0b5-0006g6-E6
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:30:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT0b5-0006fn-Ac
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573205426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CC6dvX5M3YsA/EhDtiFDRheD1BOzgYC18bDgt8A0q9w=;
 b=iL+r5CuZCZUjJORWgmrHlGSGjpYgJkPsmqOd7P0B8jhIiNiRgWmsHb1cE6rCtNIhfjLS1B
 WI77muoK0vdOAs3IGDHwmmuo3m1zWNZtAvQUXAE+KbkMYZGwPS0rjCQ32jJrdmX7wg7Tk/
 PnvpqVuofap4fW2WUarZeI+WPhzlh5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-lzHVd73IMSWZYAe5kN2Xdw-1; Fri, 08 Nov 2019 04:30:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D56B5800C72;
 Fri,  8 Nov 2019 09:30:22 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83179600D3;
 Fri,  8 Nov 2019 09:30:10 +0000 (UTC)
Message-ID: <afdbbabe3a81e69b0699bca9f69112c317a5ebdc.camel@redhat.com>
Subject: Re: [PATCH v2 05/11] block/crypto: implement the encryption key
 management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 11:30:09 +0200
In-Reply-To: <bcc8844d-ec0f-93d1-209b-7b7af4f2c24a@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-6-mlevitsk@redhat.com>
 <bcc8844d-ec0f-93d1-209b-7b7af4f2c24a@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: lzHVd73IMSWZYAe5kN2Xdw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-10-04 at 20:41 +0200, Max Reitz wrote:
> On 13.09.19 00:30, Maxim Levitsky wrote:
> > This implements the encryption key management
> > using the generic code in qcrypto layer
> > (currently only for qemu-img amend)
> >=20
> > This code adds another 'write_func' because the initialization
> > write_func works directly on the underlying file,
> > because during the creation, there is no open instance
> > of the luks driver, but during regular use, we have it,
> > and should use it instead.
> >=20
> >=20
> > This commit also adds a=09'hack/workaround' I and=09Kevin Wolf (thanks)
> > made to=09make the driver=09still support write sharing,
> > but be safe against concurrent  metadata update (the keys)
> > Eventually write sharing for luks driver will be deprecated
> > and removed together with this hack.
> >=20
> > The hack is that we ask=09(as a format driver) for
> > BLK_PERM_CONSISTENT_READ always
> > (technically always unless opened with BDRV_O_NO_IO)
> >=20
> > and then when we want to update=09the keys, we
> > unshare=09that permission. So if someone else
> > has the=09image open, even readonly, this=09will fail.
> >=20
> > Also thanks to Daniel Berrange for the variant of
> > that hack that involves=09asking for read,
> > rather that write permission
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 115 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index a6a3e1f1d8..f42fa057e6 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -36,6 +36,7 @@ typedef struct BlockCrypto BlockCrypto;
> > =20
> >  struct BlockCrypto {
> >      QCryptoBlock *block;
> > +    bool updating_keys;
> >  };
> > =20
> > =20
> > @@ -70,6 +71,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock *=
block,
> >      return ret;
> >  }
> > =20
> > +static ssize_t block_crypto_write_func(QCryptoBlock *block,
> > +                                       size_t offset,
> > +                                       const uint8_t *buf,
> > +                                       size_t buflen,
> > +                                       void *opaque,
> > +                                       Error **errp)
>=20
> There=E2=80=99s already a function of this name for creation.

There is a long story why two write functions are needed.
i tried to use only one, but at the end I and Daniel both agreed
that its just better to have two functions.

The reason is that during creation, the luks BlockDriverState doesn't exist=
 yet,
and so the creation routine basically just writes to the underlying protoco=
l driver.

Thats is why the block_crypto_create_write_func receives a BlockBackend poi=
nter,
to which the BlockDriverState of the underlying protocol driver is inserted=
.


On the other hand, for amend, the luks block device is open, and it only kn=
ows
about its own BlockDriverState, and thus the io should be done on bs->file

So instead of trying to coerce a single callback to do both of this,
we decided to just have a little code duplication.


>=20
> > +{
> > +    BlockDriverState *bs =3D opaque;
> > +    ssize_t ret;
> > +
> > +    ret =3D bdrv_pwrite(bs->file, offset, buf, buflen);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "Could not write encryption heade=
r");
> > +        return ret;
> > +    }
> > +    return ret;
> > +}
> > +
> > =20
> >  struct BlockCryptoCreateData {
> >      BlockBackend *blk;
>=20
> [...]
>=20
> > +static void
> > +block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> > +                         const BdrvChildRole *role,
> > +                         BlockReopenQueue *reopen_queue,
> > +                         uint64_t perm, uint64_t shared,
> > +                         uint64_t *nperm, uint64_t *nshared)
> > +{
> > +
> > +    BlockCrypto *crypto =3D bs->opaque;
> > +
> > +    /*
> > +     * Ask for consistent read permission so that if
> > +     * someone else tries to open this image with this permission
> > +     * neither will be able to edit encryption keys
> > +     */
> > +    if (!(bs->open_flags & BDRV_O_NO_IO)) {
> > +        perm |=3D BLK_PERM_CONSISTENT_READ;
> > +    }
> > +
> > +    /*
> > +     * This driver doesn't modify LUKS metadata except
> > +     * when updating the encryption slots.
> > +     * Thus unlike a proper format driver we don't ask for
> > +     * shared write permission. However we need it
> > +     * when we area updating keys, to ensure that only we
> > +     * had opened the device r/w
> > +     *
> > +     * Encryption update will set the crypto->updating_keys
> > +     * during that period and refresh permissions
> > +     *
> > +     */
> > +
> > +    if (crypto->updating_keys) {
> > +        /*need exclusive write access for header update  */
> > +        perm |=3D BLK_PERM_WRITE;
> > +        shared &=3D ~(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE);
> > +    }
> > +
> > +    bdrv_filter_default_perms(bs, c, role, reopen_queue,
> > +            perm, shared, nperm, nshared);
> > +}
>=20
> This will probably work, but usually drivers do it the other way around:
> First call any of the default_perms(), and then adjust *nperm and
> *nshared as required.
>=20
> (perm/shared are what the parents need, *nperm/*nshared is what this
> driver needs, so it makes more sense that way; and this way nobody has
> to check whether the settings survived the default_perms() call.)
>=20
> ((But the permissions themselves do look correct.))

You are right! I made this change now and include
it in the next iteration of the patches.

>=20
> Max
>=20

Best regards,
=09Maxim Levitsky





