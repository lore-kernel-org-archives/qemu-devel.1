Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB1C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF41206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6Xpjl+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF41206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7EU-0005k0-DR
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1is7Dr-0005GG-2X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1is7Dp-0007DL-Q5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:38:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1is7Dp-0007Ci-MN
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579189092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHD6Jrn8VLRULYgP+7HumpZ+QvPPZpdj2jeMyUuyPuw=;
 b=A6Xpjl+xb7ec+BoG+fS3Aqmo8DVo4jE8BSNosKClCmmY7bhMKAWZtevcvFXhaFgmAfEHeP
 EPlW2kjoFQtkJQrHAuKQbWDd4eAXpMqz5QOarBm6pWsKRlrDcCDWTykpc0u51vlDFkTyo8
 ECPKzLNhdanI3SuSTlUZi5eYQzEGt5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-iXrI8AX2NberpNyqFRL_MQ-1; Thu, 16 Jan 2020 10:38:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C99AA0CC1;
 Thu, 16 Jan 2020 15:38:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2765B60C85;
 Thu, 16 Jan 2020 15:38:03 +0000 (UTC)
Message-ID: <03ebf1f7ad780fca65dfc7486e860beb33c71d20.camel@redhat.com>
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Date: Thu, 16 Jan 2020 17:38:03 +0200
In-Reply-To: <5fcb531c-24ef-6e91-294d-517631c5a2cb@redhat.com>
References: <20200116141352.GA32053@redhat.com>
 <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
 <20200116145048.GG9470@linux.fritz.box>
 <5fcb531c-24ef-6e91-294d-517631c5a2cb@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iXrI8AX2NberpNyqFRL_MQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: sgarzare@redhat.com, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-01-16 at 15:55 +0100, Max Reitz wrote:
> On 16.01.20 15:50, Kevin Wolf wrote:
> > Am 16.01.2020 um 15:37 hat Max Reitz geschrieben:
> > > On 16.01.20 15:13, Richard W.M. Jones wrote:
> > > > I'm not necessarily saying this is a bug, but a change in behaviour=
 in
> > > > qemu has caused virt-v2v to fail.  The reproducer is quite simple.
> > > >=20
> > > > Create sparse and preallocated qcow2 files of the same size:
> > > >=20
> > > >   $ qemu-img create -f qcow2 sparse.qcow2 50M
> > > >   Formatting 'sparse.qcow2', fmt=3Dqcow2 size=3D52428800 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> > > >=20
> > > >   $ qemu-img create -f qcow2 prealloc.qcow2 50M -o preallocation=3D=
falloc,compat=3D1.1
> > > >   Formatting 'prealloc.qcow2', fmt=3Dqcow2 size=3D52428800 compat=
=3D1.1 cluster_size=3D65536 preallocation=3Dfalloc lazy_refcounts=3Doff ref=
count_bits=3D16
> > > >=20
> > > >   $ du -m sparse.qcow2 prealloc.qcow2=20
> > > >   1 sparse.qcow2
> > > >   51=09prealloc.qcow2
> > > >=20
> > > > Now copy the sparse file into the preallocated file using the -n
> > > > option so qemu-img doesn't create the target:
> > > >=20
> > > >   $ qemu-img convert -p -n -f qcow2 -O qcow2 sparse.qcow2 prealloc.=
qcow2
> > > >       (100.00/100%)
> > > >=20
> > > > In new qemu that makes the target file sparse:
> > > >=20
> > > >   $ du -m sparse.qcow2 prealloc.qcow2=20
> > > >   1 sparse.qcow2
> > > >   1 prealloc.qcow2         <-- should still be 51
> > > >=20
> > > > In old qemu the target file remained preallocated, which is what
> > > > I and virt-v2v are expecting.
> > > >=20
> > > > I bisected this to the following commit:
> > > >=20
> > > > 4d7c487eac1652dfe4498fe84f32900ad461d61b is the first bad commit
> > > > commit 4d7c487eac1652dfe4498fe84f32900ad461d61b
> > > > Author: Max Reitz <mreitz@redhat.com>
> > > > Date:   Wed Jul 24 19:12:29 2019 +0200
> > > >=20
> > > >     qemu-img: Fix bdrv_has_zero_init() use in convert
> > > >    =20
> > > >     bdrv_has_zero_init() only has meaning for newly created images =
or image
> > > >     areas.  If qemu-img convert did not create the image itself, it=
 cannot
> > > >     rely on bdrv_has_zero_init()'s result to carry any meaning.
> > > >    =20
> > > >     Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > >     Message-id: 20190724171239.8764-2-mreitz@redhat.com
> > > >     Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >     Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > >=20
> > > >  qemu-img.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >=20
> > > > Reverting this commit on the current master branch restores the
> > > > expected behaviour.
> > >=20
> > > The commit changed the behavior because now qemu-img realizes that it
> > > cannot skip writing to areas that are supposed to be zero when it
> > > converts to an existing image (because we have no idea what data that
> > > existing image contains).  So that=E2=80=99s a bug fix, and I don=E2=
=80=99t think we can
> > > undo it without being wrong.
> > >=20
> > > The problem is that qemu-img will try to be quickthat about making th=
ese
> > > areas zero, and so it does zero writes (actually, it even zeroes the
> > > whole image) and in the process it will of course discard all preallo=
cation.
> > >=20
> > > Now, about fixing the problem I=E2=80=99m not so sure.
> >=20
> > Wouldn't just passing -S 0 solve the problem? It should tell qemu-img
> > convert that you don't want it to sparsify anything.
>=20
> But it would also convert the falloc preallocation to a full one.
>=20
> (I had a section to this effect in my first draft, but then I
> accidentally deleted it and forgot it in my second version...)
>=20
> Max
>=20

How about doing write zeros without discard only in this particular case (c=
onvert to existing image)
Basically omitting the BDRV_REQ_MAY_UNMAP flag to blk_co_pwrite_zeroes.
It will be slow, but maybe for this particular case, it is acceptable?

Best regards,
=09Maxim Levitsky




