Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973CDFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E8221882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMf5XoEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E8221882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6Mq-0003y1-5N
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT6Le-0002Xj-0V
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT6Lc-0007YK-TE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:38:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT6Lc-0007Y8-PC
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573227532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2KZgjNrkTr0sNd/vWmLjWoRd/IHX2yhYtP3tr1O4QI=;
 b=fMf5XoECz+uc11MFYEjyaNXIkB4+1thgaBF0JsJ+rTW3XeNeuQz+4+rGMnBswDOROHQsgz
 T/O1ZE3eyI/9O+PY8KzpXPb3EhQT4xJNJ1XTkUM2XZPdbaj7b1NEoLzBtfJpDQQTLF7AAz
 L9au29DN9yOZaQaE+rhGL6zUQQTpKH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-9FDJlvJcMfSdwfvuENhMWQ-1; Fri, 08 Nov 2019 10:38:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2DE88017DE;
 Fri,  8 Nov 2019 15:38:49 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D98B1001902;
 Fri,  8 Nov 2019 15:38:47 +0000 (UTC)
Message-ID: <19f074f5136036ace2ca72f3e69b23a6eeace8ae.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/11] block: add x-blockdev-amend qmp
 command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Fri, 08 Nov 2019 17:38:46 +0200
In-Reply-To: <87eezpj8j5.fsf@dusky.pond.sub.org>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-8-mlevitsk@redhat.com>
 <87eezpj8j5.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 9FDJlvJcMfSdwfvuENhMWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-10-07 at 09:53 +0200, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
>=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
>=20
> [...]
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index e6edd641f1..7900914506 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4650,6 +4650,32 @@
> >    'data': { 'job-id': 'str',
> >              'options': 'BlockdevCreateOptions' } }
> > =20
> > +##
> > +# @x-blockdev-amend:
> > +#
> > +# Starts a job to amend format specific options of an existing open bl=
ock device.
> > +# The job is automatically finalized, but a manual job-dismiss is requ=
ired.
> > +#
> > +# @job-id:          Identifier for the newly created job.
> > +#
> > +# @node-name:       Name of the block node to work on
> > +#
> > +# @options:         Options (same as for image creation)
> > +#
> > +# @force:           Allow unsafe operations, format specific
> > +#                   For luks that allows erase of the last active keys=
lot
> > +#                   (permanent loss of data),
> > +#                   and replacement of an active keyslot
> > +#                   (possible loss of data if IO error happens)
> > +#
> > +# Since: 4.2
> > +##
> > +{ 'command': 'x-blockdev-amend',
> > +  'data': { 'job-id': 'str',
> > +            'node-name': 'str',
> > +            'options': 'BlockdevCreateOptions',
> > +            '*force': 'bool' } }
> > +
> >  ##
> >  # @blockdev-open-tray:
> >  #
> > diff --git a/qapi/job.json b/qapi/job.json
> > index a121b615fb..342d29a7aa 100644
> > --- a/qapi/job.json
> > +++ b/qapi/job.json
> > @@ -19,10 +19,12 @@
> >  #
> >  # @create: image creation job type, see "blockdev-create" (since 3.0)
> >  #
> > +# @amend: image options amend job type, see "x-blockdev-amend" (since =
4.2)
> > +#
> >  # Since: 1.7
> >  ##
> >  { 'enum': 'JobType',
> > -  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
> > +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] =
}
> > =20
> >  ##
> >  # @JobStatus:
>=20
> Aha, you introduce "amend" after using the concept in PATCH 02.
> Rather confusing, I'm afraid.
>=20
> I guess secret deletion makes sense with amend somehow, and only with
> amend.  If yes, the QAPI documentaion should spell that out, and the
> code should diagnose invalid use (maybe it does already; I haven't
> looked at it).

I think I did mentioned that in QAPI,
and I do check for optional arguments in the code.

I will probably stop using the blockdev-create options for amend after all.

Best regards,
=09Maxim Levitsky




