Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5976C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B146E2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMzTBUTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B146E2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6CG-0008Qb-OF
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT5yR-0001TR-Fr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT5yO-0000gy-F5
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:14:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT5yJ-0000We-1v
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573226085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDGwFyFaPDMQsa98ajDgpD9BuVrmr/Hxqai98WB2Mu8=;
 b=bMzTBUTdYH7iS46TwSK2jt7Hp4QzidFrIJiGPl9aDvKHqxunvGWm1H2aI1Q0T5Hxpv38qb
 YodQpQ2+JmQDR4Z/6SbDHYK7uAa/Z+jUR4o9A5lNKtCWKVnUsiNSvZLMba89K3qHxDcHdj
 D7XORhf4iDdmCl0wyqkqz2GqwilXgP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-VQ1Lt9ZAMq6nm4OHEjZQtQ-1; Fri, 08 Nov 2019 10:14:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45A211005500;
 Fri,  8 Nov 2019 15:14:43 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 407CC5E1AD;
 Fri,  8 Nov 2019 15:14:32 +0000 (UTC)
Message-ID: <e49ef0f8fd1044d846bc7c089154294505bea083.camel@redhat.com>
Subject: Re: [PATCH v2 09/11] block/qcow2: implement blockdev-amend
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Date: Fri, 08 Nov 2019 17:14:32 +0200
In-Reply-To: <875zl1j81y.fsf@dusky.pond.sub.org>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-10-mlevitsk@redhat.com>
 <c26f4f4a-2f2e-84d9-a516-36c7150b6332@redhat.com>
 <875zl1j81y.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: VQ1Lt9ZAMq6nm4OHEjZQtQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-10-07 at 10:04 +0200, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
> > On 13.09.19 00:30, Maxim Levitsky wrote:
> > > Currently only for changing crypto parameters
> >=20
> > Yep, that elegantly avoids most of the problems we=E2=80=99d have other=
wise. :-)
> >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> [...]
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index 4a6db98938..0eb4e45168 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -4294,6 +4294,7 @@
> > >  # Driver specific image creation options for qcow2.
> > >  #
> > >  # @file             Node to create the image format on
> > > +#                   Mandatory for create
> > >  # @data-file        Node to use as an external data file in which al=
l guest
> > >  #                   data is stored so that only metadata remains in =
the qcow2
> > >  #                   file (since: 4.0)
> > > @@ -4301,6 +4302,7 @@
> > >  #                   standalone (read-only) raw image without looking=
 at qcow2
> > >  #                   metadata (default: false; since: 4.0)
> > >  # @size             Size of the virtual disk in bytes
> > > +#                   Mandatory for create
> > >  # @version          Compatibility level (default: v3)
> > >  # @backing-file     File name of the backing file if a backing file
> > >  #                   should be used
> > > @@ -4315,10 +4317,10 @@
> > >  # Since: 2.12
> > >  ##
> > >  { 'struct': 'BlockdevCreateOptionsQcow2',
> > > -  'data': { 'file':             'BlockdevRef',
> > > +  'data': { '*file':            'BlockdevRef',
> > >              '*data-file':       'BlockdevRef',
> > >              '*data-file-raw':   'bool',
> > > -            'size':             'size',
> > > +            '*size':            'size',
> > >              '*version':         'BlockdevQcow2Version',
> > >              '*backing-file':    'str',
> > >              '*backing-fmt':     'BlockdevDriver',
> > >=20
>=20
> My comments to the previous patch apply.
>=20
> > Making these fields optional makes me wonder whether it actually make
> > sense to have both create and amend share a single QAPI structure.
> > Wouldn=E2=80=99t it better to have a separate amend structure that then=
 actually
> > reflects what we support?  (This would also solve the problem of how to
> > express in the code what is and what isn=E2=80=99t supported through
> > blockdev-amend.)
>=20
> Good point.  As is, the schema is rather confusing, at least to me.  We
> reduce or avoid the confusion in documentation or in code.  I'd prefer
> code unless it leads to too much duplication.  "Too much" is of course
> subjective.  Maxim, would you mind exploring it for us?

Nothing against having a separate amend structure, I actually prefer this,
and I don't think it will complicate the code.=20


Best regards,
=09Maxim Levitsky


