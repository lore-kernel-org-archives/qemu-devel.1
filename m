Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209DCC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44CB207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLlFohpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44CB207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6YA-00040F-0a
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1is6XF-0002k2-20
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1is6XA-0004ou-Uf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:54:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1is6XA-0004oG-Qf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579186447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkTpGjSngT+63eT11k7EYoND9omNu8vZmjzQZ3GmGOc=;
 b=QLlFohpet6tCUYgpr9Ds1gyS5AgK/DBNNav7h2QxwpFACV7Wan1cupeO28BIvFSpuNHnju
 YBKHgDHTngW+sEj81iGHArVAcQAMAQDkyVAXloXdCso1YUFBGRawKWc8wj68tpSNmBBAMm
 AAmUfTYmvOjk/6W3cSPfHX9ZldgKmYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-qFrH3xoRNmagJAQaMFYshw-1; Thu, 16 Jan 2020 09:54:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7BA0107ACC9;
 Thu, 16 Jan 2020 14:54:00 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B44160C85;
 Thu, 16 Jan 2020 14:54:00 +0000 (UTC)
Date: Thu, 16 Jan 2020 14:53:59 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
Message-ID: <20200116145359.GR3888@redhat.com>
References: <20200116141352.GA32053@redhat.com>
 <962aa54b-f6e5-bb43-50a0-c4cad59cd22e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <962aa54b-f6e5-bb43-50a0-c4cad59cd22e@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qFrH3xoRNmagJAQaMFYshw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ptoscano@redhat.com, sgarzare@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 03:47:30PM +0100, Max Reitz wrote:
> On 16.01.20 15:13, Richard W.M. Jones wrote:
> > I'm not necessarily saying this is a bug, but a change in behaviour in
> > qemu has caused virt-v2v to fail.  The reproducer is quite simple.
> >=20
> > Create sparse and preallocated qcow2 files of the same size:
> >=20
> >   $ qemu-img create -f qcow2 sparse.qcow2 50M
> >   Formatting 'sparse.qcow2', fmt=3Dqcow2 size=3D52428800 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> >=20
> >   $ qemu-img create -f qcow2 prealloc.qcow2 50M -o preallocation=3Dfall=
oc,compat=3D1.1
> >   Formatting 'prealloc.qcow2', fmt=3Dqcow2 size=3D52428800 compat=3D1.1=
 cluster_size=3D65536 preallocation=3Dfalloc lazy_refcounts=3Doff refcount_=
bits=3D16
> >=20
> >   $ du -m sparse.qcow2 prealloc.qcow2=20
> >   1 sparse.qcow2
> >   51=09prealloc.qcow2
> >=20
> > Now copy the sparse file into the preallocated file using the -n
> > option so qemu-img doesn't create the target:
> >=20
> >   $ qemu-img convert -p -n -f qcow2 -O qcow2 sparse.qcow2 prealloc.qcow=
2
> >       (100.00/100%)
> >=20
> > In new qemu that makes the target file sparse:
> >=20
> >   $ du -m sparse.qcow2 prealloc.qcow2=20
> >   1 sparse.qcow2
> >   1 prealloc.qcow2         <-- should still be 51
> >=20
> > In old qemu the target file remained preallocated, which is what
> > I and virt-v2v are expecting.
> >=20
> > I bisected this to the following commit:
> >=20
> > 4d7c487eac1652dfe4498fe84f32900ad461d61b is the first bad commit
> > commit 4d7c487eac1652dfe4498fe84f32900ad461d61b
> > Author: Max Reitz <mreitz@redhat.com>
> > Date:   Wed Jul 24 19:12:29 2019 +0200
> >=20
> >     qemu-img: Fix bdrv_has_zero_init() use in convert
> >    =20
> >     bdrv_has_zero_init() only has meaning for newly created images or i=
mage
> >     areas.  If qemu-img convert did not create the image itself, it can=
not
> >     rely on bdrv_has_zero_init()'s result to carry any meaning.
> >    =20
> >     Signed-off-by: Max Reitz <mreitz@redhat.com>
> >     Message-id: 20190724171239.8764-2-mreitz@redhat.com
> >     Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >     Signed-off-by: Max Reitz <mreitz@redhat.com>
> >=20
> >  qemu-img.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >=20
> > Reverting this commit on the current master branch restores the
> > expected behaviour.
>=20
> So what this commit changed was that when you take an existing image as
> the destination, you can=E2=80=99t assume anything about its contents.  B=
efore
> this commit, we assumed it=E2=80=99s zero.  That=E2=80=99s clearly wrong,=
 because it can
> be anything.
>=20
> So when you convert to the target image, you have to make sure all areas
> that are zero in the source are zero in the target, too.  The way we do
> that is to write zeroes to the target.  The problem is that this
> operation disregards the previous preallocation and discards the
> preallocated space.
>=20
> As for fixing the bug...  Can we fix it in qemu(-img)?
>=20
> We could try to detect whether areas that are zero in the source are
> zero in the (preallocated) target image, too.  But doing so what require
> reading the data from those areas and comparing it to zero.  That would
> take time and it isn=E2=80=99t trivial.  So that=E2=80=99s something I=E2=
=80=99d rather avoid.
>=20
> Off the top of my head, the only thing that comes to my mind would be to
> add a flag to qemu-img convert with which you can let it know that you
> guarantee the target image is zero.  I suppose we could document it also
> to imply that given this flag, areas that are zero in the source will
> then not be changed in the target image; i.e. that preallocation stays
> intact in those areas.
>=20
>=20
> OTOH, can it be fixed in virt-v2v?  Is there already a safe way to call
> qemu-img convert -n and keeping the target=E2=80=99s preallocation intact=
?
> Unfortunately, I don=E2=80=99t think so.  I don=E2=80=99t think we ever g=
uaranteed it
> would, and well, now it broke.

From the fixing virt-v2v point of view, it's a bit tricky since the
code has to deal with all kinds of output targets.  (For example we
sometimes qemu-img convert into an NBD target.)

However we do know when the target contains zeroes - in fact it always
contains zeroes, so:

> So would you be OK with a --target-is-zero flag?  (I think we could let
> this flag guarantee that your use case works, so it should be future-safe=
.)

this one should work.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


