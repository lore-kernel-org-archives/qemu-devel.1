Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07017C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49182187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPN4AOEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49182187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2bXY-0008OK-UX
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j2bWW-0007Au-73
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j2bWU-00044q-4q
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:00:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26045
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j2bWT-0003rJ-Vk
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581688848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8o0y/1bb7D3gxegbifJb0fPKaidIbpu1k00C5IYy3hA=;
 b=BPN4AOEGzLiBJAShfhUS4rokueP3GMhtVPKdxfa0Tgh3coF+OqtgszvVy8fu9imEWcI3AI
 KqUsWI53/jkvDiTK3kLi+VI7MVdxW9ReGv18uULtZjRb/t6r1N4gXR/yGk5WLst6qUVFV/
 T26gcR/t8rKVECmy12mZsTWZ+PAT5UU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-1U1poIMVNHChGKKl6jcWzw-1; Fri, 14 Feb 2020 09:00:47 -0500
Received: by mail-ot1-f72.google.com with SMTP id n22so5111760otr.23
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 06:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8o0y/1bb7D3gxegbifJb0fPKaidIbpu1k00C5IYy3hA=;
 b=otA32si6D7i8xRB7es8ib9ubEEARzQ0HMh696MmcgdtF9/rhm839skTKyYsT44fhVk
 0b6qNKY9/xhQZZBQuqyfbuLSbdcGpYQrt6B8zh/C4Vzf9PPTk2c1fbFutysJLncwD+9d
 rf1CuUwvnAm3nsPOB9rx3ELyNlYlIQv5o9Dis3CU7kofFPQYyTLxjhZU0QCgNRXeJAxA
 IPSykAbkaR8TzmDPbw722fcsLAK2XVxrbjTuQzK8PjlOCgc1By1WXot9lsEtSVOuQKKV
 3DuHN0NHyu1YQSoiigj4P1bZTvlxENGN1xl/5gLJwDnI5IEgSmrM6V9JBOl0WK9Ip6sO
 TZ6w==
X-Gm-Message-State: APjAAAUvEhoLqcZWOPXBFlYYSfK6EbPp3NtqViL1kWkYYnszU9rxtQk/
 P8/a88XUs/WTcNK90GLfkzQgeBsGSjKsxUwqhQrA/49hxtqG73qCiVGXJIeiiVe2+8Aqv4CS8mW
 dbVMM8mPR1PZ8dQyTLObFw0bvPnLerEA=
X-Received: by 2002:a9d:4f02:: with SMTP id d2mr2264353otl.368.1581688846265; 
 Fri, 14 Feb 2020 06:00:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwari+xjjJwmu2VGO0e51GA3RozPYiNHqzI+RHgZgR/f914aEu/D6B0FFwaCdMpUY8PN1JlLpW3/JEyldh3INQ=
X-Received: by 2002:a9d:4f02:: with SMTP id d2mr2264316otl.368.1581688845733; 
 Fri, 14 Feb 2020 06:00:45 -0800 (PST)
MIME-Version: 1.0
References: <15a5fbc76266fb51b365e66872c105b9e2832999.camel@intel.com>
 <CAMxuvazRMzO=7N3FjH74QBk1ehxwaM8rymFcn5_aDppU8_z+LA@mail.gmail.com>
 <98d72096ad005ecfd5861e4f8f74a9c503e976b2.camel@intel.com>
In-Reply-To: <98d72096ad005ecfd5861e4f8f74a9c503e976b2.camel@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 14 Feb 2020 15:00:34 +0100
Message-ID: <CAMxuvaztAsaXeGeuMp=mhq3BC7cRLbQh+6d9a2RuZ59DU9U5_g@mail.gmail.com>
Subject: Re: docs: Update vhost-user spec regarding backend program conventions
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
X-MC-Unique: 1U1poIMVNHChGKKl6jcWzw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Feb 14, 2020 at 2:24 PM Boeuf, Sebastien
<sebastien.boeuf@intel.com> wrote:
>
> Hi Marc-Andre,
>
> On Tue, 2020-02-11 at 22:24 +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Feb 11, 2020 at 4:24 PM Boeuf, Sebastien
> > <sebastien.boeuf@intel.com> wrote:
> > > From c073d528b8cd7082832fd1825dc33dd65b305aa2 Mon Sep 17 00:00:00
> > > 2001
> > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > Date: Tue, 11 Feb 2020 16:01:22 +0100
> > > Subject: [PATCH] docs: Update vhost-user spec regarding backend
> > > program
> > >  conventions
> > >
> > > The vhost-user specification is not clearly stating the expected
> > > behavior from a backend program whenever the client disconnects.
> > >
> > > This patch addresses the issue by defining the default behavior and
> > > proposing an alternative through a command line option.
> > >
> > > By default, a backend program will have to keep listening even if
> > > the
> > > client disconnects, unless told otherwise through the newly
> > > introduced
> > > option --exit-on-disconnect.
> > >
> > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  docs/interop/vhost-user.rst | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-
> > > user.rst
> > > index 5f8b3a456b..da9a1ebc4c 100644
> > > --- a/docs/interop/vhost-user.rst
> > > +++ b/docs/interop/vhost-user.rst
> > > @@ -1323,6 +1323,10 @@ The backend program must end (as quickly and
> > > cleanly as possible) when
> > >  the SIGTERM signal is received. Eventually, it may receive SIGKILL
> > > by
> > >  the management layer after a few seconds.
> > >
> > > +By default, the backend program continues running after the client
> > > +disconnects. It accepts only 1 connection at a time on each UNIX
> > > domain
> > > +socket.
> >
> > I don't think that's the most common behaviour. libvhost-user will
> > panic() on disconnect in general, unless the error/exit is handled
> > gracefully by the backend.
>
> It's not the default behavior from libvhost-user, but that's exactly
> something I'd like to see changing. This should be the normal case if
> you think about a standard client/server connection, where the server
> would simply listen again after the client disconnects.

I disagree, a "normal" lifecycle is a single connection & instance per devi=
ce.

Having the backend handle multiple connections is needlessly more
complicated. You need to correctly handle multiple states, flushed
anything private between connections etc. It should be optional.


> >
> > The most common case is to have 1-1 relation between device/qemu
> > instance and backend.
>
> Yes this part is fine, but that's not a reason why the backend should
> terminates.

It is simpler to ensure it is reset correctly.

>
> >
> > Why not restart the backend for another instance?
>
> Because you need some management tool to do so. And I think that by
> default it could be interesting to have the least amount of extra
> management involved.

The management layer should be involved if any side crashes or restart anyw=
ay.

>
> >
> > > +
> > >  The following command line options have an expected behaviour.
> > > They
> > >  are mandatory, unless explicitly said differently:
> > >
> > > @@ -1337,6 +1341,12 @@ are mandatory, unless explicitly said
> > > differently:
> > >    vhost-user socket as file descriptor FDNUM. It is incompatible
> > > with
> > >    --socket-path.
> > >
> > > +--exit-on-disconnect
> > > +
> > > +  When this option is provided, the backend program must terminate
> > > when
> > > +  the client disconnects. This can be used to keep the backend
> > > program's
> > > +  lifetime synchronized with its client process.
> >
> > This section list options that are mandatory. It's probably a bit
> > late
> > to add more mandatory options (I regret already some of them)
>
> The spec states "They are mandatory, unless explicitly said
> differently", and in this case I'm explicitely saying "When this option
> is provided", which means if it's not provided it's fine and we can
> ignore the fact it's not there.

Ah ok,  I think we can guard it with a capability too.

>
> >
> > Do we need to specify the behaviour on client disconnect? Can't we
> > leave that to the backend and management layer to decide?
>
> My goal here is to make the spec a bit less loose. I know libvhost-user
> is the de-facto implementation but we cannot just assume everything out
> of the libvhost-user implementation, especially since there is a
> dedicated spec. That's the reason why I thought it'd be nice to have
> the backend behavior well defined in the spec.

Sure, the goal of the spec is to have basic interoperability between
implementations, not to follow whatever libvhost-user is currently
doing.

> The point is, relying on the current definition, there's not enough
> information to make sure a VMM will properly interface with a vhost-
> user backend.

I don't know why having the backend handle multiple connections would
help with that.

Having undefined behaviour for things that should not happen in normal
circumstances seems acceptable. Having QEMU (or the /master/) restart
is currently undefined, because it's not considered a simple/normal
situation: the vhost-user spec doesn't say much about it, does it?

I'd prefer to keep things simple and have 1-1 device-backend instance
relationship by default.


