Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C150C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C3D2464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRCSRMxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C3D2464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdZU-0004W4-9N
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdXy-0002vd-UM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdXv-0001xI-4g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:59:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34903
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdXr-0001tx-5p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZDwBwkYgPt0TOu0vlpswih9P/jzvnxpCAGdq+mzunA=;
 b=PRCSRMxTXQlqFnLjn0O/VVwDHFHcmLQ7CJ+Q1krCp60A5poqnBeEDLLU+WMD0TVEjw43Vw
 7C5samfgYRMBshx3ea0sTYbgmGhr2vIobf111nvLJw/nu4FUyfzF9XzYQUnAN73I7fzlkD
 Ffsm1WpL73De4/nqwCXE0HmbYutgvuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329--JAIbGKFMO6vQON5LF4Yxw-1; Tue, 10 Mar 2020 07:59:30 -0400
X-MC-Unique: -JAIbGKFMO6vQON5LF4Yxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42F86100550E;
 Tue, 10 Mar 2020 11:59:29 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C2D419C58;
 Tue, 10 Mar 2020 11:59:27 +0000 (UTC)
Date: Tue, 10 Mar 2020 12:59:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 02/14] qcrypto/luks: implement encryption key management
Message-ID: <20200310115926.GC6926@linux.fritz.box>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-3-mlevitsk@redhat.com>
 <704e841b-a5e1-2bea-0a1f-1b6fe1058a17@redhat.com>
 <5f1390648d98ac52928985185522cb58f1bc7253.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5f1390648d98ac52928985185522cb58f1bc7253.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.03.2020 um 12:05 hat Maxim Levitsky geschrieben:
> On Tue, 2020-03-10 at 11:58 +0100, Max Reitz wrote:
> > On 08.03.20 16:18, Maxim Levitsky wrote:
> > > Next few patches will expose that functionality
> > > to the user.
> > >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  crypto/block-luks.c | 398 ++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  qapi/crypto.json    |  61 ++++++-
> > >  2 files changed, 455 insertions(+), 4 deletions(-)
> >=20
> > [...]
> >=20
> > > +##
> > > +# @QCryptoBlockAmendOptionsLUKS:
> > > +#
> > > +# This struct defines the update parameters that activate/de-activat=
e set
> > > +# of keyslots
> > > +#
> > > +# @state: the desired state of the keyslots
> > > +#
> > > +# @new-secret:    The ID of a QCryptoSecret object providing the pas=
sword to be
> > > +#                 written into added active keyslots
> > > +#
> > > +# @old-secret:    Optional (for deactivation only)
> > > +#                 If given will deactive all keyslots that
> > > +#                 match password located in QCryptoSecret with this =
ID
> > > +#
> > > +# @iter-time:     Optional (for activation only)
> > > +#                 Number of milliseconds to spend in
> > > +#                 PBKDF passphrase processing for the newly activate=
d keyslot.
> > > +#                 Currently defaults to 2000.
> > > +#
> > > +# @keyslot:       Optional. ID of the keyslot to activate/deactivate=
.
> > > +#                 For keyslot activation, keyslot should not be acti=
ve already
> > > +#                 (this is unsafe to update an active keyslot),
> > > +#                 but possible if 'force' parameter is given.
> > > +#                 If keyslot is not given, first free keyslot will b=
e written.
> > > +#
> > > +#                 For keyslot deactivation, this parameter specifies=
 the exact
> > > +#                 keyslot to deactivate
> > > +#
> > > +# @unlock-secret: Optional. The ID of a QCryptoSecret object providi=
ng the
> > > +#                 password to use to retrive current master key.
> > > +#                 Defaults to the same secret that was used to open =
the image
> >=20
> > So this matches Markus=E2=80=99 proposal except everything is flattened=
 (because
> > we don=E2=80=99t support nested unions, AFAIU).  Sounds OK to me.  The =
only
> > difference is @unlock-secret, which did not appear in his proposal.  Wh=
y
> > do we need it again?
>=20
> That a little undocumented hack that will disappear one day.

It is very much documented (just a few lines above this one), and even
if it weren't documented, that wouldn't make it an unstable ABI.

If you don't want to make it to become stable ABI, you either need to
drop it or it needs an x- prefix, and its documentation should specify
what prevents it from being a stable ABI.

> Its because the driver currently doesn't keep a copy of the master key,
> and instead only keeps ciper objects, often from outside libraries,
> and in theory these objects might even be implemented in hardware so that
> master key might be not in memory at all, so I kind of don't want yet
> to keep it in memory.
> Thus when doing the key management, I need to retrieve the master key aga=
in,
> similar to how it is done on image opening. I use the same secret as was =
used for opening,
> but in case the keys were changed already, that secret might not work any=
more.
> Thus I added this parameter to specify basically the old password, which =
is reasonable
> when updating passwords.
> I usually omit this hack in the discussions as it is orthogonal to the re=
st of the API.

How will this requirement disappear one day?

Kevin


