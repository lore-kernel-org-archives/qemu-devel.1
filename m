Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB193C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D2C20678
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX6cBql7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D2C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZX9e-0006fv-MA
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iZX8s-00062I-MK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iZX8p-0008Ay-TZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:28:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iZX8p-0008AU-7w
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574760493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fBG4bWFrcphBroESl6tSdVzXGHd1jhi7I5REbeQqWM=;
 b=VX6cBql7ZFaWOp9Sps1GYgCWPUv43EpPLELGM2igX4uA6nfuPgA1OK5koNbckWFAonJOBy
 Pw4jLmKMKR0rzMUk5HCPl6uCp9uKoOz4mnI0TZpSKkNCG61Ret/k/eUKzkbXTQe81tAW1p
 qiWVzdzA/pYUjJFQun+6RNWrHRTixBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-wHsJ_VUgOnygF35SwO4vEg-1; Tue, 26 Nov 2019 04:28:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF9AC800EBF;
 Tue, 26 Nov 2019 09:28:11 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6449919C69;
 Tue, 26 Nov 2019 09:28:04 +0000 (UTC)
Message-ID: <affeae207765d4e20125d8b76417189f742551ff.camel@redhat.com>
Subject: Re: API definition for LUKS key management [V2]
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>
Date: Tue, 26 Nov 2019 11:28:03 +0200
In-Reply-To: <0b5fec2a-1d93-7e31-55d2-1a80bde89f0b@redhat.com>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191112100253.GM2366658@redhat.com>
 <d6ead0c3f9758b5def21dd690217bc9deeace2a9.camel@redhat.com>
 <0b5fec2a-1d93-7e31-55d2-1a80bde89f0b@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wHsJ_VUgOnygF35SwO4vEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-11-25 at 19:45 +0100, Max Reitz wrote:
> On 22.11.19 15:22, Maxim Levitsky wrote:
> > Hi!
> >=20
> > This is the second version of the proposed QMP API for key management,
> > after discussion with Keven and Max.
> >=20
> > Will this work?
> >=20
> > Adding Peter Krempa to CC, to hear his opinion from the=20
> > libvirt side.
> >=20
> > Best regards,
> > =09Maxim Levitsky
>=20
> Looks good to me overall.  I don=E2=80=99t think we need to overly push h=
aving
> the same interface for create and amend, because I don=E2=80=99t see much=
 to be
> gained from it.

Thanks!!
>=20
> [...]
>=20
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index b2a4cff683..019db682cd 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -309,3 +309,56 @@
> >    'base': 'QCryptoBlockInfoBase',
> >    'discriminator': 'format',
> >    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> > +
> > +
> > +##
> > +# @LUKSKeyslotUpdate:
> > +#
> > +# @keyslot:         If specified, will update only keyslot with this i=
ndex
> > +#
> > +# @old-secret:      If specified, will only update keyslots that
> > +#                   can be opened with password which is contained in
> > +#                   QCryptoSecret with @old-secret ID
> > +#
> > +#                   If neither @keyslot nor @old-secret is specified,
> > +#                   first empty keyslot is selected for the update
> > +#
> > +# @new-secret:      The ID of a QCryptoSecret object providing a new d=
ecryption
> > +#                   key to place in all matching keyslots. Empty strin=
g erases the
> > +#                   keyslot.
>=20
> Hm...  Can=E2=80=99t we make this some string-or-null alternate type so t=
hat
> null will erase the keyslot?  That would make more sense to me.

Agree. I'll see if can get an alternate to work here.

>=20
> Max
>=20
> > +# @iter-time:       number of milliseconds to spend in
> > +#                   PBKDF passphrase processing
> > +##
> > +{ 'struct': 'LUKSKeyslotUpdate',
> > +  'data': {
> > +         '*keyslot': 'int',
> > +         '*old-secret': 'str',
> > +         'new-secret' : 'str',
> > +         '*iter-time' : 'int' } }
>=20
>=20

Best regards,
=09Maxim Levitsky


