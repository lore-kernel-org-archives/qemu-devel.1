Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DCFFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14420206BA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY+tchjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14420206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT24s-0007y8-9b
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT23w-0007S7-Vr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT23v-0005a9-5D
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:04:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56214
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT23v-0005Z5-18
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573211058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sI9pHvZA+W1iTbu35pYWmopU0jXktYeWFc3infxdThI=;
 b=LY+tchjFcEAKb/aDgLnOuTcJMxrYEzAGyhA4V/jtb0vy6hWt/Y4lNViGsxI2kWzhMjzCCM
 el9sSglRPAxZuC3DSiaEHLXsuwENJJp4xCGTiIqG4RBfcWSIgh14IClwniwNJNPqd/k69F
 BOXh+xdJMGaS+gJGBIH7rj3QK0NHRVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-sqfWJRULNcydg_VQvhk4Tg-1; Fri, 08 Nov 2019 06:04:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 650D61800D7B;
 Fri,  8 Nov 2019 11:04:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 088325DA7F;
 Fri,  8 Nov 2019 11:04:11 +0000 (UTC)
Message-ID: <248adc2a05942db73a310a7d3a0339345f4628a5.camel@redhat.com>
Subject: Re: [PATCH v2 05/11] block/crypto: implement the encryption key
 management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 13:04:11 +0200
In-Reply-To: <05065ed2-6b42-ccae-64d9-4960885a7b8f@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-6-mlevitsk@redhat.com>
 <bcc8844d-ec0f-93d1-209b-7b7af4f2c24a@redhat.com>
 <afdbbabe3a81e69b0699bca9f69112c317a5ebdc.camel@redhat.com>
 <05065ed2-6b42-ccae-64d9-4960885a7b8f@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sqfWJRULNcydg_VQvhk4Tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-11-08 at 11:49 +0100, Max Reitz wrote:
> On 08.11.19 10:30, Maxim Levitsky wrote:
> > On Fri, 2019-10-04 at 20:41 +0200, Max Reitz wrote:
> > > On 13.09.19 00:30, Maxim Levitsky wrote:
> > > > This implements the encryption key management
> > > > using the generic code in qcrypto layer
> > > > (currently only for qemu-img amend)
> > > >=20
> > > > This code adds another 'write_func' because the initialization
> > > > write_func works directly on the underlying file,
> > > > because during the creation, there is no open instance
> > > > of the luks driver, but during regular use, we have it,
> > > > and should use it instead.
> > > >=20
> > > >=20
> > > > This commit also adds a=09'hack/workaround' I and=09Kevin Wolf (tha=
nks)
> > > > made to=09make the driver=09still support write sharing,
> > > > but be safe against concurrent  metadata update (the keys)
> > > > Eventually write sharing for luks driver will be deprecated
> > > > and removed together with this hack.
> > > >=20
> > > > The hack is that we ask=09(as a format driver) for
> > > > BLK_PERM_CONSISTENT_READ always
> > > > (technically always unless opened with BDRV_O_NO_IO)
> > > >=20
> > > > and then when we want to update=09the keys, we
> > > > unshare=09that permission. So if someone else
> > > > has the=09image open, even readonly, this=09will fail.
> > > >=20
> > > > Also thanks to Daniel Berrange for the variant of
> > > > that hack that involves=09asking for read,
> > > > rather that write permission
> > > >=20
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  block/crypto.c | 118 +++++++++++++++++++++++++++++++++++++++++++++=
++--
> > > >  1 file changed, 115 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/block/crypto.c b/block/crypto.c
> > > > index a6a3e1f1d8..f42fa057e6 100644
> > > > --- a/block/crypto.c
> > > > +++ b/block/crypto.c
> > > > @@ -36,6 +36,7 @@ typedef struct BlockCrypto BlockCrypto;
> > > > =20
> > > >  struct BlockCrypto {
> > > >      QCryptoBlock *block;
> > > > +    bool updating_keys;
> > > >  };
> > > > =20
> > > > =20
> > > > @@ -70,6 +71,24 @@ static ssize_t block_crypto_read_func(QCryptoBlo=
ck *block,
> > > >      return ret;
> > > >  }
> > > > =20
> > > > +static ssize_t block_crypto_write_func(QCryptoBlock *block,
> > > > +                                       size_t offset,
> > > > +                                       const uint8_t *buf,
> > > > +                                       size_t buflen,
> > > > +                                       void *opaque,
> > > > +                                       Error **errp)
> > >=20
> > > There=E2=80=99s already a function of this name for creation.
> >=20
> > There is a long story why two write functions are needed.
> > i tried to use only one, but at the end I and Daniel both agreed
> > that its just better to have two functions.
> >=20
> > The reason is that during creation, the luks BlockDriverState doesn't e=
xist yet,
> > and so the creation routine basically just writes to the underlying pro=
tocol driver.
> >=20
> > Thats is why the block_crypto_create_write_func receives a BlockBackend=
 pointer,
> > to which the BlockDriverState of the underlying protocol driver is inse=
rted.
> >=20
> >=20
> > On the other hand, for amend, the luks block device is open, and it onl=
y knows
> > about its own BlockDriverState, and thus the io should be done on bs->f=
ile
> >=20
> > So instead of trying to coerce a single callback to do both of this,
> > we decided to just have a little code duplication.
>=20
> I meant: This doesn=E2=80=99t compile.  There=E2=80=99s already another f=
unction of this
> name.
>=20

You probably didn't apply the 'block-crypto: misc refactoring' patch,=20
or I forgot to send it.
All that patch does is to rename block_crypto_write_func to block_crypto_cr=
eate_write_func
and same (for consistency) for block_crypto_init_func -> block_crypto_creat=
e_init_func

And then in this patch I add the block_crypto_write_func, to be used for an=
ything
but creation code, together with existing block_crypto_read_func which is a=
lready
not used for creation.


Best regards,
=09Maxim Levitsky




