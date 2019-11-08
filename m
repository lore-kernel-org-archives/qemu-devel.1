Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEFDC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6324121848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzNn7np0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6324121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4U1-0007dA-Jz
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT4Sf-0006Gs-Vu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT4Se-0005ZR-Oo
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:38:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT4Se-0005Z6-LU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573220280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEbHBaKxRysmwWfoSuGJbl0+dCktqKqYedZW0yR+66A=;
 b=ZzNn7np0Ot6L4K6VQHvi9sdSG/ESUQ8n4XcmiW4Mnmz+TOIb85SqothBTNZ4Lj3FP4CbWm
 Z7nwW1Nnh3XhYnK8Nmx5W7/GCPAzCVEkoasV4Ez5WIf68lMaK/rPaynWv/LanRFsGxrAmV
 UdkTUXTix0EbBRYAQLT3FMwKGqAM/aI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-jBxXjZrpN5eBFDVOpnnMrA-1; Fri, 08 Nov 2019 08:37:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E62B8477;
 Fri,  8 Nov 2019 13:37:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 674676084E;
 Fri,  8 Nov 2019 13:37:51 +0000 (UTC)
Message-ID: <10cac06a4e11b3002d476ba38c40097476136119.camel@redhat.com>
Subject: Re: [PATCH v2 07/11] block: add x-blockdev-amend qmp command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 15:37:50 +0200
In-Reply-To: <4bcbb15d-4566-77a4-de0a-c9c3833543cc@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-8-mlevitsk@redhat.com>
 <931af700-bb9a-ae84-bd01-215560f66494@redhat.com>
 <268fd0b724a685b69e2d41067e34e403b68e244e.camel@redhat.com>
 <4bcbb15d-4566-77a4-de0a-c9c3833543cc@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jBxXjZrpN5eBFDVOpnnMrA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-11-08 at 11:36 +0100, Max Reitz wrote:
> On 08.11.19 10:26, Maxim Levitsky wrote:
> > On Fri, 2019-10-04 at 20:53 +0200, Max Reitz wrote:
> > > On 13.09.19 00:30, Maxim Levitsky wrote:
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  block/Makefile.objs       |   2 +-
> > > >  block/amend.c             | 116 ++++++++++++++++++++++++++++++++++=
++++
> > > >  include/block/block_int.h |  23 ++++++--
> > > >  qapi/block-core.json      |  26 +++++++++
> > > >  qapi/job.json             |   4 +-
> > > >  5 files changed, 163 insertions(+), 8 deletions(-)
> > > >  create mode 100644 block/amend.c
>=20
> [...]
>=20
> > > > +static int coroutine_fn blockdev_amend_run(Job *job, Error **errp)
> > > > +{
> > > > +    BlockdevAmendJob *s =3D container_of(job, BlockdevAmendJob, co=
mmon);
> > > > +    int ret;
> > > > +
> > > > +    job_progress_set_remaining(&s->common, 1);
> > > > +    ret =3D s->bs->drv->bdrv_co_amend(s->bs, s->opts, s->force, er=
rp);
> > > > +    job_progress_update(&s->common, 1);
> > >=20
> > > It would be nice if the amend job could make use of the progress
> > > reporting that we have in place for amend.
> >=20
> > I also thought about it, but is it worth it?
> >=20
> > I looked through the status reporting of the qcow2 amend
> > code (which doesn't really allowed to be run through
> > qmp blockdev-amend, due to complexity of changing=20
> > the qcow2 format on the fly).
>=20
> True, and we could always add it later.
>=20
> I suppose I was mostly wondering because bdrv_amend_options already has
> all of that infrastructure and I was assuming that qcow2's bdrv_co_amend
> implementation would make some use of the existing function.  Well, it
> doesn=E2=80=99t, so *shrug*
>=20
> [...]
>=20
> > > > +    /*
> > > > +     * Create the block job
> > > > +     * TODO Running in the main context. Block drivers need to err=
or out or add
> > > > +     * locking when they use a BDS in a different AioContext.
> > >=20
> > > Why shouldn=E2=80=99t the job just run in the node=E2=80=99s context?
> >=20
> > This is shameless copy&pasta from the blockdev-create code
> > (which I did note in the copyright of the file)
>=20
> Well, you noted that it=E2=80=99s heavily based on it, not that it=E2=80=
=99s just C&P.

'heavily based' is a polite way to say that file is copied and then changed
to fit new purpose, isn't it :-)


>=20
> So I suppose the comment is just wrong here?
Yes, I absolutely missed this part since I don't know the block layer well =
enough.
Thanks for explaining this on IRC, that blockdev_create job is special
in a sense that block device state doesn't exit yet for it (I also was alre=
ady bitten
by this in luks block driver), thus the job runs in main AIO context.
No need to do so in amend, and thus I'll remove that wrongly copy&pasta'ed =
comment.

Thanks a lot!!

Best regards,
=09Maxim Levitsky


>=20
> Max
>=20



