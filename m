Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24A3C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CBC2464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdZeETsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CBC2464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBddg-0001XS-Je
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jBdb9-0006YW-98
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jBdb7-0004pT-Az
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:02:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jBdb7-0004mA-3q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kazORsQqbHcXYgDlDbERsJ3TqvOE8kzXaavbFTp+Yc=;
 b=cdZeETsOldpqQtjZmDFReWF6GZmkw6gbCi84Na9hQfQmpgadU7ZIAcAWL//8C29gP/i3ZY
 b5qCGEjeb2+FKmUx5j2tSwnPgYR5KG9Lfd3CgdOidvF1IInouQKwoS7DJsb8nYtop5cVDp
 MJlropMjTv6VyR2r3nMsEz06veV1ezg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-v6IA4f65NKaH48MY70saSw-1; Tue, 10 Mar 2020 08:02:54 -0400
X-MC-Unique: v6IA4f65NKaH48MY70saSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57622107ACC7;
 Tue, 10 Mar 2020 12:02:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0B6C92972;
 Tue, 10 Mar 2020 12:02:47 +0000 (UTC)
Message-ID: <d24c41cc125f3d9295dc40825878ef7fc62c289e.camel@redhat.com>
Subject: Re: [PATCH v2 02/14] qcrypto/luks: implement encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Mar 2020 14:02:43 +0200
In-Reply-To: <20200310115926.GC6926@linux.fritz.box>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-3-mlevitsk@redhat.com>
 <704e841b-a5e1-2bea-0a1f-1b6fe1058a17@redhat.com>
 <5f1390648d98ac52928985185522cb58f1bc7253.camel@redhat.com>
 <20200310115926.GC6926@linux.fritz.box>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-10 at 12:59 +0100, Kevin Wolf wrote:
> Am 10.03.2020 um 12:05 hat Maxim Levitsky geschrieben:
> > On Tue, 2020-03-10 at 11:58 +0100, Max Reitz wrote:
> > > On 08.03.20 16:18, Maxim Levitsky wrote:
> > > > Next few patches will expose that functionality
> > > > to the user.
> > > >=20
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  crypto/block-luks.c | 398 ++++++++++++++++++++++++++++++++++++++++=
+++-
> > > >  qapi/crypto.json    |  61 ++++++-
> > > >  2 files changed, 455 insertions(+), 4 deletions(-)
> > >=20
> > > [...]
> > >=20
> > > > +##
> > > > +# @QCryptoBlockAmendOptionsLUKS:
> > > > +#
> > > > +# This struct defines the update parameters that activate/de-activ=
ate set
> > > > +# of keyslots
> > > > +#
> > > > +# @state: the desired state of the keyslots
> > > > +#
> > > > +# @new-secret:    The ID of a QCryptoSecret object providing the p=
assword to be
> > > > +#                 written into added active keyslots
> > > > +#
> > > > +# @old-secret:    Optional (for deactivation only)
> > > > +#                 If given will deactive all keyslots that
> > > > +#                 match password located in QCryptoSecret with thi=
s ID
> > > > +#
> > > > +# @iter-time:     Optional (for activation only)
> > > > +#                 Number of milliseconds to spend in
> > > > +#                 PBKDF passphrase processing for the newly activa=
ted keyslot.
> > > > +#                 Currently defaults to 2000.
> > > > +#
> > > > +# @keyslot:       Optional. ID of the keyslot to activate/deactiva=
te.
> > > > +#                 For keyslot activation, keyslot should not be ac=
tive already
> > > > +#                 (this is unsafe to update an active keyslot),
> > > > +#                 but possible if 'force' parameter is given.
> > > > +#                 If keyslot is not given, first free keyslot will=
 be written.
> > > > +#
> > > > +#                 For keyslot deactivation, this parameter specifi=
es the exact
> > > > +#                 keyslot to deactivate
> > > > +#
> > > > +# @unlock-secret: Optional. The ID of a QCryptoSecret object provi=
ding the
> > > > +#                 password to use to retrive current master key.
> > > > +#                 Defaults to the same secret that was used to ope=
n the image
> > >=20
> > > So this matches Markus=E2=80=99 proposal except everything is flatten=
ed (because
> > > we don=E2=80=99t support nested unions, AFAIU).  Sounds OK to me.  Th=
e only
> > > difference is @unlock-secret, which did not appear in his proposal.  =
Why
> > > do we need it again?
> >=20
> > That a little undocumented hack that will disappear one day.
>=20
> It is very much documented (just a few lines above this one), and even
> if it weren't documented, that wouldn't make it an unstable ABI.
>=20
> If you don't want to make it to become stable ABI, you either need to
> drop it or it needs an x- prefix, and its documentation should specify
> what prevents it from being a stable ABI.
>=20
> > Its because the driver currently doesn't keep a copy of the master key,
> > and instead only keeps ciper objects, often from outside libraries,
> > and in theory these objects might even be implemented in hardware so th=
at
> > master key might be not in memory at all, so I kind of don't want yet
> > to keep it in memory.
> > Thus when doing the key management, I need to retrieve the master key a=
gain,
> > similar to how it is done on image opening. I use the same secret as wa=
s used for opening,
> > but in case the keys were changed already, that secret might not work a=
nymore.
> > Thus I added this parameter to specify basically the old password, whic=
h is reasonable
> > when updating passwords.
> > I usually omit this hack in the discussions as it is orthogonal to the =
rest of the API.
>=20
> How will this requirement disappear one day?
If I cave in and keep a copy of the master key in the memory :-)

Best regards,
=09Maxim Levitsky

>=20
> Kevin



