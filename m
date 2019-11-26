Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F38C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 18:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C33A2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 18:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCzu1Mi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C33A2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZfg6-0004AY-DF
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 13:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iZfd1-00010t-J9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iZfWc-0008Uh-CE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:25:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29876
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iZfWc-0008UL-74
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574792721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J5KXBw2Z7wIzzvyD5duK9Ack6xhcwHgk5GwwwudnHFM=;
 b=iCzu1Mi0pikOIlII8fGDnF/LgdCEuyBMmz9/f37SoPG6rCusSOhefQJftgjXgFTA9A8BxH
 KJnXXbiPnwRWtbAWN9JweBzoP31btkB1vMEq4B6FpJPKDgN9n8s6kjpfNsDCPqIOnYEVZd
 uESdCS+fTXr2V3k+O2fGgVEPWvghdGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-u33569RqMTihaNa31tSIPQ-1; Tue, 26 Nov 2019 13:25:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71FEC107ACE3;
 Tue, 26 Nov 2019 18:25:18 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94F5B10016E8;
 Tue, 26 Nov 2019 18:25:11 +0000 (UTC)
Date: Tue, 26 Nov 2019 18:25:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: RFC: New device for zero-copy VM memory access
Message-ID: <20191126182509.GN2928@work-vm>
References: <20191031132443.GB3128@work-vm>
 <b36330ecd38ce872982df4d41d3d4695@hostfission.com>
 <CAFEAcA8uWCQY8GwtH4oHU8ybXsvmYaB4Qa5hnxyd+344WFjJ_Q@mail.gmail.com>
 <b87d5b2fb84ac0a3c98a62dcc0c19077@hostfission.com>
 <20191031155204.GD3128@work-vm>
 <cd00c2ba412361d707ab02575d74aacd@hostfission.com>
 <e23eb129dddc5d18bb9f9b15d116f957@hostfission.com>
 <20191104115546.GB3420@work-vm>
 <9b49de1379825ac1445766f4a8d198dc@hostfission.com>
 <CAMxuvaxa820krw5gdRbbY-bbqf9zaE01GkC6mRVbrEaN9Fp56w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxa820krw5gdRbbY-bbqf9zaE01GkC6mRVbrEaN9Fp56w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: u33569RqMTihaNa31tSIPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: geoff@hostfission.com, Peter Maydell <peter.maydell@linaro.org>, "Coquelin,
 Maxime" <maxime.coquelin@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi
>=20
> On Mon, Nov 4, 2019 at 4:05 PM <geoff@hostfission.com> wrote:
> >
> >
> >
> > On 2019-11-04 22:55, Dr. David Alan Gilbert wrote:
> > > * geoff@hostfission.com (geoff@hostfission.com) wrote:
> > >>
> > >>
> > >> On 2019-11-03 21:10, geoff@hostfission.com wrote:
> > >> > On 2019-11-01 02:52, Dr. David Alan Gilbert wrote:
> > >> > > * geoff@hostfission.com (geoff@hostfission.com) wrote:
> > >> > > >
> > >> > > >
> > >> > > > On 2019-11-01 01:52, Peter Maydell wrote:
> > >> > > > > On Thu, 31 Oct 2019 at 14:26, <geoff@hostfission.com> wrote:
> > >> > > > > > As the author of Looking Glass, I also have to consider th=
e
> > >> > > > > > maintenance
> > >> > > > > > and the complexity of implementing the vhost protocol into=
 the
> > >> > > > > > project.
> > >> > > > > > At this time a complete Porthole client can be implemented=
 in 150
> > >> > > > > > lines
> > >> > > > > > of C without external dependencies, and most of that is bo=
ilerplate
> > >> > > > > > socket code. This IMO is a major factor in deciding to avo=
id
> > >> > > > > > vhost-user.
> > >> > > > >
> > >> > > > > This is essentially a proposal that we should make our proje=
ct and
> > >> > > > > code more complicated so that your project and code can be s=
impler.
> > >> > > > > I hope you can see why this isn't necessarily an argument th=
at will hold
> > >> > > > > very much weight for us :-)
> > >> > > >
> > >> > > > Certainly, I do which is why I am still going to see about usi=
ng
> > >> > > > vhost,
> > >> > > > however, a device that uses vhost is likely more complex then
> > >> > > > the device
> > >> > > > as it stands right now and as such more maintenance would be
> > >> > > > involved on
> > >> > > > your end also. Or have I missed something in that vhost-user c=
an
> > >> > > > be used
> > >> > > > directly as a device?
> > >> > >
> > >> > > The basic vhost-user stuff isn't actually that hard;  if you are=
n't
> > >> > > actually shuffling commands over the queues you should find it p=
retty
> > >> > > simple - so I think your assumption about it being simpler if yo=
u
> > >> > > avoid
> > >> > > it might be wrong.  It might be easier if you use it!
> > >> >
> > >> > I have been looking into this and I am yet to find some decent
> > >> > documentation or a simple device example I can use to understand h=
ow to
> > >> > create such a device. Do you know of any reading or examples I can
> > >> > obtain
> > >> > on how to get an initial do nothing device up and running?
> > >> >
> > >> > -Geoff
> > >>
> > >> Scratch that, the design just solidified for me and I am now making
> > >> progress, however it seems that vhost-user can't do what we need her=
e:
> > >>
> > >> 1) I dont see any way to recieve notification of socket disconnectio=
n,
> > >> in
> > >> our use case the client app needs to be able to be (re)connected
> > >> dynamically. It might be possible to get this event by registering i=
t
> > >> on
> > >> the chardev manually but this seems like it would be a kludge.
> > >
> > > My understanding was that someone added support for reconnection of
> > > vhost-user;  I'm not sure of the detail - cc'ing in Maxime and
> > > Marc-Andre.
> > >
> > >> 2) I don't see any method of notifying the vhost-user client of the
> > >> removal of a shared memory mapping. Again, these may not be
> > >> persistently
> > >> mapped in the guest as we have no control over the buffer allocation=
,
> > >> and
> > >> as such, we need a method to notify the client that the mapping has
> > >> become
> > >> invalid.
> > >>
> > >> 3) VHOST_USER_SET_MEM_TABLE is a one time request, again this breaks
> > >> our
> > >> usage as we need to change this dynamically at runtime.
> > >
> > > I've seen (3) being sent multiple times (It's messy but it happens); =
so
> > > I think that fixes (2) as well for you.
> >
> > Yes, but it's ignored.
> >
> >      /*
> >       * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
> >       * we just need send it once in the first time. For later such
> >       * request, we just ignore it.
> >       */
> >      if (vhost_user_one_time_request(msg->hdr.request) && dev->vq_index
> > !=3D 0) {
> >           msg->hdr.flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
> >           return 0;
> >      }
>=20
> This code was added to avoid sending the same mapping for each queue:
> https://github.com/qemu/qemu/commit/b931bfbf042983f311b3b09894d8030b2755a=
638
> (arguably, the filtering could have been done earlier)
>=20
> But if you reconnect, it should still send it again at least once (for vq=
 #0).
>=20
> vhost-user-bridge reconnect used to work quite reliably, I haven't
> tested recently.

Doesn't this also happen sometimes if the guest sees memory devices
change?

Dave

>=20
> >
> > >
> > > Dave
> > >
> > >> Unless there are viable solutions to these problems there is no way
> > >> that
> > >> vhost-user can be used for this kind of a device.
> > >>
> > >> -Geoff
> > >>
> > >> >
> > >> > >
> > >> > > Dave
> > >> > >
> > >> > > > >
> > >> > > > > thanks
> > >> > > > > -- PMM
> > >> > > --
> > >> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


