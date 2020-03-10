Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DDFC18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD3E2467F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI41R7Qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD3E2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcip-00061f-5F
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jBchl-000559-J9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jBchk-0004AY-9S
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:05:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jBchk-00047m-4V
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583838343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOrYtebzWs5T8vZLph595O+4tY01ibwYEiZfW61llmk=;
 b=hI41R7QoTSm6Ep+Sbxfj8UvpHw9SH6YWMbBWkiLS5R9LG9MpWuqUk3dToBDrgpm/E04ujN
 g6HCTPWWb+vRLhHf1RRUVF+64tV7Hbkf+sxyhEcYifae5izoqSSnkYUi59hGyS/XzTx54f
 49n2ClHup/AnjTKYcQGxy37g89zA4dM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-14tsecbYPNOPTpTYZLR1mw-1; Tue, 10 Mar 2020 07:05:42 -0400
X-MC-Unique: 14tsecbYPNOPTpTYZLR1mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 016F5107ACC4;
 Tue, 10 Mar 2020 11:05:41 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B94B419C70;
 Tue, 10 Mar 2020 11:05:38 +0000 (UTC)
Message-ID: <5f1390648d98ac52928985185522cb58f1bc7253.camel@redhat.com>
Subject: Re: [PATCH v2 02/14] qcrypto/luks: implement encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 10 Mar 2020 13:05:37 +0200
In-Reply-To: <704e841b-a5e1-2bea-0a1f-1b6fe1058a17@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-3-mlevitsk@redhat.com>
 <704e841b-a5e1-2bea-0a1f-1b6fe1058a17@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-10 at 11:58 +0100, Max Reitz wrote:
> On 08.03.20 16:18, Maxim Levitsky wrote:
> > Next few patches will expose that functionality
> > to the user.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 398 +++++++++++++++++++++++++++++++++++++++++++-
> >  qapi/crypto.json    |  61 ++++++-
> >  2 files changed, 455 insertions(+), 4 deletions(-)
>=20
> [...]
>=20
> > +##
> > +# @QCryptoBlockAmendOptionsLUKS:
> > +#
> > +# This struct defines the update parameters that activate/de-activate =
set
> > +# of keyslots
> > +#
> > +# @state: the desired state of the keyslots
> > +#
> > +# @new-secret:    The ID of a QCryptoSecret object providing the passw=
ord to be
> > +#                 written into added active keyslots
> > +#
> > +# @old-secret:    Optional (for deactivation only)
> > +#                 If given will deactive all keyslots that
> > +#                 match password located in QCryptoSecret with this ID
> > +#
> > +# @iter-time:     Optional (for activation only)
> > +#                 Number of milliseconds to spend in
> > +#                 PBKDF passphrase processing for the newly activated =
keyslot.
> > +#                 Currently defaults to 2000.
> > +#
> > +# @keyslot:       Optional. ID of the keyslot to activate/deactivate.
> > +#                 For keyslot activation, keyslot should not be active=
 already
> > +#                 (this is unsafe to update an active keyslot),
> > +#                 but possible if 'force' parameter is given.
> > +#                 If keyslot is not given, first free keyslot will be =
written.
> > +#
> > +#                 For keyslot deactivation, this parameter specifies t=
he exact
> > +#                 keyslot to deactivate
> > +#
> > +# @unlock-secret: Optional. The ID of a QCryptoSecret object providing=
 the
> > +#                 password to use to retrive current master key.
> > +#                 Defaults to the same secret that was used to open th=
e image
>=20
> So this matches Markus=E2=80=99 proposal except everything is flattened (=
because
> we don=E2=80=99t support nested unions, AFAIU).  Sounds OK to me.  The on=
ly
> difference is @unlock-secret, which did not appear in his proposal.  Why
> do we need it again?

That a little undocumented hack that will disappear one day.
Its because the driver currently doesn't keep a copy of the master key,
and instead only keeps ciper objects, often from outside libraries,
and in theory these objects might even be implemented in hardware so that
master key might be not in memory at all, so I kind of don't want yet
to keep it in memory.
Thus when doing the key management, I need to retrieve the master key again=
,
similar to how it is done on image opening. I use the same secret as was us=
ed for opening,
but in case the keys were changed already, that secret might not work anymo=
re.
Thus I added this parameter to specify basically the old password, which is=
 reasonable
when updating passwords.
I usually omit this hack in the discussions as it is orthogonal to the rest=
 of the API.

Best regards,
=09Maxim Levitsky


>=20
> Max
>=20



