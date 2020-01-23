Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97E6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79662077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEwOH57K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79662077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuidK-0005Br-Rn
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1iuhyh-0005IS-Oo
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1iuhyg-0007QU-5t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:17:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1iuhye-0007Oe-PI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579807036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkR58KqxofQpgdgmcAyBAl8uI8mZ7kXFKca+7VTMeUo=;
 b=hEwOH57KSHfaF/jyuMGKdI5YyuO/Dh23c/9TtEs9sBSC5vvCNl+c8uhpbqAgRQD5710raF
 z76aQKdG6OENs8uHEzK3eN5D3/k8uxe1ecdmcgM3PEwlxksi2Fjnt80owjs6o8rGwZTUYR
 blmiIOsxLfquzJ2JLrhT2ggazxmqycI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-bRPfJRW9NX2jxwmaDxOn2w-1; Thu, 23 Jan 2020 14:17:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10C0CDB61;
 Thu, 23 Jan 2020 19:17:11 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A50AD60BF3;
 Thu, 23 Jan 2020 19:17:10 +0000 (UTC)
Date: Thu, 23 Jan 2020 19:17:09 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: qemu-img convert vs writing another copy tool
Message-ID: <20200123191709.GM3888@redhat.com>
References: <20200123183500.GA27166@redhat.com>
 <ef3492f5-b1ab-52d2-9484-3c42e2b6af87@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ef3492f5-b1ab-52d2-9484-3c42e2b6af87@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bRPfJRW9NX2jxwmaDxOn2w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: berrange@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 ptoscano@redhat.com, marnold@redhat.com, mkletzan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 07:53:57PM +0100, Max Reitz wrote:
> On 23.01.20 19:35, Richard W.M. Jones wrote:
> >  - NBD multi-conn.  In my tests this makes a really massive
> >    performance difference in certain situations.  Again, virt-v2v has
> >    a lot of information that we cannot pass to qemu: we know, for
> >    example, exactly if the server supports the feature, how many
> >    threads are available, in some situations even have information
> >    about the network and backing disks that the data will travel over
> >    / be stored on.
>=20
> As far as I understand it, you use qemu-img convert with an NBD source
> or target, too?

Virt-v2v has many modes, but yes generally there will be either an NBD
source & target, or an NBD source to a local file target.

> I suppose it=E2=80=99s always easier to let a specialized and freshly wri=
tten
> tool handle such information.  But it sounds like if such information is
> useful and makes that big of a difference, then it would be good to be
> able to specify it to qemu=E2=80=99s NBD block driver, too.

qemu-img convert has worked really well for us, and I'm actually _not_
confident that I could do better with a specialized tool.  But there's
definitely more info we could pass, such as the amount of parallelism
we believe is available in the NBD server / processors / disks.

> >  - Machine-parsable progress bars.  You can, sort of, parse the
> >    progress bar from qemu-img convert, but it's not as easy as it
> >    could be.  In particular it would be nice if the format was treated
> >    as ABI, and if there was a way to have the tool write the progress
> >    bar info to a precreated file descriptor.
>=20
> It doesn=E2=80=99t seem impossible to add this feature to qemu-img, altho=
ugh I
> wonder about the interface.  I suppose we could make it an alternative
> progress output mode (with some command-line flag), and then the
> information would be emitted to stdout (just like the existing progress
> report).  You can of course redirect stdout to whatever fd you=E2=80=99d =
like,
> so I don=E2=80=99t know whether qemu-img itself needs that specific capab=
ility.
>=20
> OTOH, if you need this feature, why not just use qemu itself?  That is,
> a mirror or a backup block job in an otherwise empty VM.

I don't think we've really thought before about this approach.  Maybe
the launching of a VM (even an empty / stopped one) could be a
problem.  I guess this is what the new tool that was recently proposed
upstream might help with?  (Was it called qemu-block-storage?  I can't
find it right this minute)

> >  - External block lists.  This is a rather obscure requirement, but
> >    it's necessary in the case where we can get the allocated block map
> >    from another source (eg. pyvmomi) and then want to use that with an
> >    NBD source that does not support extents (eg. nbdkit-ssh-plugin /
> >    libssh / sftp).  [Having said that, it may be possible to implement
> >    this as an nbdkit filter, so maybe this is not a blocking feature.]
>=20
> That too seems like a feature that=E2=80=99s easily implementable in a
> specialized tool, but hard to implement in qemu-img.
>=20
> I suppose we=E2=80=99d want a dirty bitmap copy mode which copies only th=
e
> regions that the bitmap reports as dirty =E2=80=93 but at that point you=
=E2=80=99re
> probably again better off not using qemu-img, but qemu itself.  Then
> we=E2=80=99d need some way to import bitmaps, and I actually don=E2=80=99=
t think we have
> that yet.
>=20
> But again, if this is a generally useful feature, I think we want it in
> qemu anyway.

I think this is actually one we can more easily implement as an nbdkit
filter.  I'm going to try this and see.

> > One thing which qemu-img convert can do which nbdcp could not:
> >=20
> >  - Read or write from qcow2 files.
> >=20
> > So instead of splitting the ecosystem and writing a new tool that
> > doesn't do as much as qemu-img convert, I wonder what qemu developers
> > think about the above missing features?  For example, are they in
> > scope for qemu-img convert?
>=20
> What I think is that there may be features that we don=E2=80=99t want in
> qemu-img, because they are more appropriate for the mirror or backup
> block job.  For example, I don=E2=80=99t think we want to let qemu-img co=
nvert
> mess around with dirty bitmaps.
>=20
> But apart from that, the features you propose all seem useful to have in
> qemu itself.  Maybe some of them are too hard to implement (specifically
> importing bitmaps from external sources), then it might be pragmatic to
> write a new tool where such features can be easily implemented because
> they don=E2=80=99t need to be integrated into an existing API.
>=20
> As for performance, well, if qemu=E2=80=99s NBD driver is slow, then naiv=
ely I=E2=80=99d
> think that=E2=80=99s a bug, isn=E2=80=99t it?  And if improving performan=
ce requires
> knobs, then that=E2=80=99s how it is.

Thanks,

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/


