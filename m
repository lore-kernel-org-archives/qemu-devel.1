Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC4AC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6412146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpL24qL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6412146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0ua-0004jU-I9
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jC0tx-0004B4-JN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jC0tw-0002Cl-71
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:55:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31013
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jC0tw-0002BI-3N
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583931355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2YBxrNItJzCtGmaCYxp7rYRIESZbi7Ci/p0Cqj/Wb8=;
 b=CpL24qL/19Z+iXPswQM5B4wb8GrnuBSF+VETRpQovqJBoChtZRX38v9YSxvJaZatUu0Kn+
 +UWXxMmToqEZUzk+rZx4mLG1CGY7FO31spD8ySpSWy4Cv9vurkDuSgzj612wziu1ENXqTv
 a50beayMC06Q7IVnnEheGd6rJfHXwpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-eQhWnAwCNd-CGQ6PfdXtzA-1; Wed, 11 Mar 2020 08:55:53 -0400
X-MC-Unique: eQhWnAwCNd-CGQ6PfdXtzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07531100726A;
 Wed, 11 Mar 2020 12:55:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D31F828981;
 Wed, 11 Mar 2020 12:55:50 +0000 (UTC)
Message-ID: <3c174977e2e28ec31d3e6e9980ba1f4be93a54f2.camel@redhat.com>
Subject: Re: [PATCH v2 02/14] qcrypto/luks: implement encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 11 Mar 2020 14:55:49 +0200
In-Reply-To: <d24c41cc125f3d9295dc40825878ef7fc62c289e.camel@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-3-mlevitsk@redhat.com>
 <704e841b-a5e1-2bea-0a1f-1b6fe1058a17@redhat.com>
 <5f1390648d98ac52928985185522cb58f1bc7253.camel@redhat.com>
 <20200310115926.GC6926@linux.fritz.box>
 <d24c41cc125f3d9295dc40825878ef7fc62c289e.camel@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-10 at 14:02 +0200, Maxim Levitsky wrote:
> On Tue, 2020-03-10 at 12:59 +0100, Kevin Wolf wrote:
> > Am 10.03.2020 um 12:05 hat Maxim Levitsky geschrieben:
> > > On Tue, 2020-03-10 at 11:58 +0100, Max Reitz wrote:
> > > > On 08.03.20 16:18, Maxim Levitsky wrote:
> > > > > Next few patches will expose that functionality
> > > > > to the user.
> > > > >=20
> > > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > > ---
> > > > >  crypto/block-luks.c | 398 ++++++++++++++++++++++++++++++++++++++=
+++++-
> > > > >  qapi/crypto.json    |  61 ++++++-
> > > > >  2 files changed, 455 insertions(+), 4 deletions(-)
> > > >=20
> > > > [...]
> > > >=20
> > > > > +##
> > > > > +# @QCryptoBlockAmendOptionsLUKS:
> > > > > +#
> > > > > +# This struct defines the update parameters that activate/de-act=
ivate set
> > > > > +# of keyslots
> > > > > +#
> > > > > +# @state: the desired state of the keyslots
> > > > > +#
> > > > > +# @new-secret:    The ID of a QCryptoSecret object providing the=
 password to be
> > > > > +#                 written into added active keyslots
> > > > > +#
> > > > > +# @old-secret:    Optional (for deactivation only)
> > > > > +#                 If given will deactive all keyslots that
> > > > > +#                 match password located in QCryptoSecret with t=
his ID
> > > > > +#
> > > > > +# @iter-time:     Optional (for activation only)
> > > > > +#                 Number of milliseconds to spend in
> > > > > +#                 PBKDF passphrase processing for the newly acti=
vated keyslot.
> > > > > +#                 Currently defaults to 2000.
> > > > > +#
> > > > > +# @keyslot:       Optional. ID of the keyslot to activate/deacti=
vate.
> > > > > +#                 For keyslot activation, keyslot should not be =
active already
> > > > > +#                 (this is unsafe to update an active keyslot),
> > > > > +#                 but possible if 'force' parameter is given.
> > > > > +#                 If keyslot is not given, first free keyslot wi=
ll be written.
> > > > > +#
> > > > > +#                 For keyslot deactivation, this parameter speci=
fies the exact
> > > > > +#                 keyslot to deactivate
> > > > > +#
> > > > > +# @unlock-secret: Optional. The ID of a QCryptoSecret object pro=
viding the
> > > > > +#                 password to use to retrive current master key.
> > > > > +#                 Defaults to the same secret that was used to o=
pen the image
> > > >=20
> > > > So this matches Markus=E2=80=99 proposal except everything is flatt=
ened (because
> > > > we don=E2=80=99t support nested unions, AFAIU).  Sounds OK to me.  =
The only
> > > > difference is @unlock-secret, which did not appear in his proposal.=
  Why
> > > > do we need it again?
> > >=20
> > > That a little undocumented hack that will disappear one day.
> >=20
> > It is very much documented (just a few lines above this one), and even
> > if it weren't documented, that wouldn't make it an unstable ABI.
> >=20
> > If you don't want to make it to become stable ABI, you either need to
> > drop it or it needs an x- prefix, and its documentation should specify
> > what prevents it from being a stable ABI.
> >=20
> > > Its because the driver currently doesn't keep a copy of the master ke=
y,
> > > and instead only keeps ciper objects, often from outside libraries,
> > > and in theory these objects might even be implemented in hardware so =
that
> > > master key might be not in memory at all, so I kind of don't want yet
> > > to keep it in memory.
> > > Thus when doing the key management, I need to retrieve the master key=
 again,
> > > similar to how it is done on image opening. I use the same secret as =
was used for opening,
> > > but in case the keys were changed already, that secret might not work=
 anymore.
> > > Thus I added this parameter to specify basically the old password, wh=
ich is reasonable
> > > when updating passwords.
> > > I usually omit this hack in the discussions as it is orthogonal to th=
e rest of the API.
> >=20
> > How will this requirement disappear one day?
>=20
> If I cave in and keep a copy of the master key in the memory :-)
>=20
> Best regards,
> =09Maxim Levitsky
>=20
> >=20
> > Kevin
>=20
>=20
OK folks, besides this hack (which I can remove if you insist, although I d=
on't
think it matters), what else should I do to move forward to get this accept=
ed?

Best regards,
=09Maxim Levitsky


