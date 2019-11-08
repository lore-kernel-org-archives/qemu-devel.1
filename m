Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDC0FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D29E21882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Avv7g+YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D29E21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6NQ-0004iq-8O
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT6JR-0007pV-RV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT6JQ-0006Yg-O1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:36:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36126
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT6JQ-0006YV-KB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573227396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CZ6YxnJta3cGMgdVV2KZQtr9KwD2o5C2rYjxEfZ4LcI=;
 b=Avv7g+YL6/TtExWf9B19P+CiH3JGxgUifMcBvyuq39Mn9YXTf7XZYexC7IkSI1+JXVTrjr
 GrVL7t15EU1nlHTBIz7dz3IUXN1GQN8Ak37NgFkb0Un2IM3DNk1duukdiOkB5wcAZlrNZA
 O8PnISpq6jwLX8z+Y4ku/jUUNgQpA4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-8gkb7h5IOBmYF1m3nUjEmg-1; Fri, 08 Nov 2019 10:36:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 964DD800A1A;
 Fri,  8 Nov 2019 15:36:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A7C61001281;
 Fri,  8 Nov 2019 15:36:29 +0000 (UTC)
Message-ID: <2d69c78d5acdc3884b91eb0e6c632df0ecdfd986.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/11] block/crypto: implement
 blockdev-amend
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Fri, 08 Nov 2019 17:36:28 +0200
In-Reply-To: <87a7adj8az.fsf@dusky.pond.sub.org>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-9-mlevitsk@redhat.com>
 <87a7adj8az.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 8gkb7h5IOBmYF1m3nUjEmg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-10-07 at 09:58 +0200, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
>=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
>=20
> [...]
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7900914506..4a6db98938 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4211,8 +4211,11 @@
> >  # Driver specific image creation options for LUKS.
> >  #
> >  # @file             Node to create the image format on
> > +#                   Mandatory for create
> >  # @size             Size of the virtual disk in bytes
> > +#                   Mandatory for create
> >  # @preallocation    Preallocation mode for the new image
> > +#                   Only for create
> >  #                   (since: 4.2)
> >  #                   (default: off; allowed values: off, metadata, fall=
oc, full)
> >  #
> > @@ -4220,8 +4223,8 @@
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsLUKS',
> >    'base': 'QCryptoBlockCreateOptionsLUKS',
> > -  'data': { 'file':             'BlockdevRef',
> > -            'size':             'size',
> > +  'data': { '*file':             'BlockdevRef',
> > +            '*size':             'size',
> >              '*preallocation':   'PreallocMode' } }
> > =20
> >  ##
>=20
> Why is this change needed?
>=20
> When the commit message says "implement FOO" and nothing else, then I
> don't expect QAPI schema changes.  Working the answer to my question
> into the commit message might avoid the surprise.

It is because for the amend interface, it doesn't make much sense to pass t=
he size,
and the underlying block device.

Thats why I made these optional but I check that these parameters are prese=
nt on creation
and not present on amend.

Still I am more and more inclined to think that I should not use the create=
 options for amend,
but rather split into a new structure. This is just not worth it IMHO.


Best regards,
=09Maxim Levitsky




