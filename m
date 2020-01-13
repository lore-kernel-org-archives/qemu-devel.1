Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE8C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE41C2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKRvjhvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE41C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir316-0004hj-TU
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ir2zB-0002IH-JT
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ir2z9-0005T1-UV
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:54:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35876
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ir2z9-0005S6-QT
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578934479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYfxt9R85X0iDsHK43TBfAf5XlccozGTjLK0pvzm/ZE=;
 b=BKRvjhvcUGy78eI9oyxiwnAxf1owuQbz7QYRrxbvNpL1RkFBZdDpOX/on6tkEtvyPUt9ZJ
 c/ddzc0eIv/0DVSkOsLVWxZAthVn46SwGF4VUhe7+KapMKHdJSsp942h8DZDcBd7+Hi6Jp
 By3npmHEDDjPrs02LNfiSFeyh2R96tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-A97uRdNgOaSfg6XpK_N1Zw-1; Mon, 13 Jan 2020 11:54:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5A1510054E3;
 Mon, 13 Jan 2020 16:54:36 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 113E760BE2;
 Mon, 13 Jan 2020 16:54:32 +0000 (UTC)
Date: Mon, 13 Jan 2020 17:54:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 00/25] monitor: add asynchronous command type
Message-ID: <20200113165431.GG5549@linux.fritz.box>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191213160330.GD3428@localhost.localdomain>
 <CAJ+F1CLSfYPFPych4twnvOMt3qR4UnGauWq_k=VN8W5kKUze9g@mail.gmail.com>
 <20191216120701.GC6610@linux.fritz.box>
 <CAJ+F1CJjrh3LJs=YtNOkk3rYo-MpmXr3ho9pt0z7tnqm4kp96w@mail.gmail.com>
 <20200107051728.GA4076@linux.fritz.box>
 <CAJ+F1CLocmL-9d06jsbfUFq1peV7w-Ho30vKnp7cVVk8jfXVnw@mail.gmail.com>
 <87h80zwdom.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87h80zwdom.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: A97uRdNgOaSfg6XpK_N1Zw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.01.2020 um 16:58 hat Markus Armbruster geschrieben:
> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> writes:
>=20
> > Hi
> >
> > On Tue, Jan 7, 2020 at 9:17 AM Kevin Wolf <kwolf@redhat.com> wrote:
> >>
> >> Am 06.01.2020 um 19:21 hat Marc-Andr=E9 Lureau geschrieben:
> >> > > What my patch does is moving everything into a coroutine. This is =
wrong
> >> > > because not everything can be run in a coroutine, so it needs to b=
e made
> >> > > optional (like you did with your async flag).
> >> >
> >> > "everything" is a bit too much ;) You proposal is to replace
> >> > qmp_dispatch_bh by a coroutine version (except for OOB commands). Th=
is
> >> > is nice because indeed, it allows to reenter the mainloop with a
> >> > simple yield in QMP commands. It is also simpler than my "async"
> >> > proposal, because some of the state is part of the coroutine, and
> >> > because it doesn't allow QMP commands concurrency (beside existing
> >> > OOB).
> >> >
> >> > Iow, coroutine (for async) + oob (for concurrency) make my proposal
> >> > kinda obsolete. I can only regret that a simple callback-based
> >> > solution looked simpler to me than one that mixes both threads &
> >> > coroutines, but I don't mind if everybody likes it better :) I can
> >> > definitely see the point for block commands, which rely on coroutine=
s
> >> > anyway, and qemu is already that complex in general.
> >>
> >> Callbacks are indeed simple enough for implementing the infrastructure=
,
> >> but for the users they only look simple as long as they do trivial
> >> things. :-)
> >>
> >> Anyway, now that you have seen my POC hack, do you agree that this
> >> should help solving the screendump problem, too?
> >
> > Yes, and I will work on it as soon as you have a working patch series
> > or branch :)
> >
> >>
> >> > > The problem isn't with completely coroutine-unaware code, though: =
That
> >> > > one would just work, even if not taking advantage from the corouti=
ne. A
> >> > > potential problem exists with code that behaves differently when r=
un in
> >> > > a coroutine or outside of coroutine context (generally by checking
> >> > > qemu_in_coroutine())), or calls of coroutine-unaware code into suc=
h
> >> > > functions.
> >> > >
> >> > > Running some command handlers outside of coroutine context wouldn'=
t be
> >> > > hard to add to my patch (basically just a BH), but I haven't looke=
d into
> >> > > the QAPI side of making it an option.
> >> >
> >> > Yes, I think we should have a 'coroutine': true, for commands that
> >> > should be run with a coroutine.
> >> >
> >> > Or perhaps replace existing allow-oob with 'dispatch':
> >> > - 'bh' (default)
> >> > - 'coroutine'
> >> > - 'allow-oob' (oob + bh fallback, since oob don't have coroutine - a=
t
> >> > this point)
> >>
> >> If it's "at this point", then making it two separate bools would make
> >> more sense. But I seem to remember that OOB handlers are fundamentally
> >> not supposed to block, so coroutine support would be pointless for the=
m
> >> and an enum could work.
> >
> > I think so too
> >
> >>
> >> I'll defer to Markus on this one.
> >
> > Yup, Markus should take a look at your proposal and give some
> > guidance. And hopefully, it won't take >2y.
>=20
> Is it "[PATCH 0/4] qmp: Optionally run handlers in coroutines"?

Yes, that's the one.

Kevin


