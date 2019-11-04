Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ABBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 11:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2217214D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 11:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wo9d32+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2217214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRayl-0000LT-2t
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 06:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iRaxp-0007mG-7Z
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iRaxm-00062L-NA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:56:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iRaxm-00061F-E8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572868560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEc5daqNfAjzL+KMa4X/qeY2JQJf1O6tehCuZ+mc0Q8=;
 b=Wo9d32+8IzrRpSasfXJ5M73LXhjx0HyWKCzv40cnTVuN71fD4PHj2l4mhhzLvYJey2s7iz
 DNlO4J0CuTPz6F0xb9UVowNf1JV0oJhnLgspAfdr6IbH73XnY5x0ItCEEhhyoJK1raVouW
 bd7APEZwb3qRuoCzHRZB/2qM09VcOpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-skbtHsNzODiSCwjyROIBmw-1; Mon, 04 Nov 2019 06:55:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66FA0107ACC2;
 Mon,  4 Nov 2019 11:55:55 +0000 (UTC)
Received: from work-vm (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60AFB5D6C5;
 Mon,  4 Nov 2019 11:55:49 +0000 (UTC)
Date: Mon, 4 Nov 2019 11:55:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: geoff@hostfission.com, marcandre.lureau@redhat.com,
 maxime.coquelin@redhat.com
Subject: Re: RFC: New device for zero-copy VM memory access
Message-ID: <20191104115546.GB3420@work-vm>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191030185248.GC3114@work-vm>
 <88f1c3701740665b0ebe2f24c8ce7ade@hostfission.com>
 <20191031132443.GB3128@work-vm>
 <b36330ecd38ce872982df4d41d3d4695@hostfission.com>
 <CAFEAcA8uWCQY8GwtH4oHU8ybXsvmYaB4Qa5hnxyd+344WFjJ_Q@mail.gmail.com>
 <b87d5b2fb84ac0a3c98a62dcc0c19077@hostfission.com>
 <20191031155204.GD3128@work-vm>
 <cd00c2ba412361d707ab02575d74aacd@hostfission.com>
 <e23eb129dddc5d18bb9f9b15d116f957@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <e23eb129dddc5d18bb9f9b15d116f957@hostfission.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: skbtHsNzODiSCwjyROIBmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* geoff@hostfission.com (geoff@hostfission.com) wrote:
>=20
>=20
> On 2019-11-03 21:10, geoff@hostfission.com wrote:
> > On 2019-11-01 02:52, Dr. David Alan Gilbert wrote:
> > > * geoff@hostfission.com (geoff@hostfission.com) wrote:
> > > >=20
> > > >=20
> > > > On 2019-11-01 01:52, Peter Maydell wrote:
> > > > > On Thu, 31 Oct 2019 at 14:26, <geoff@hostfission.com> wrote:
> > > > > > As the author of Looking Glass, I also have to consider the
> > > > > > maintenance
> > > > > > and the complexity of implementing the vhost protocol into the
> > > > > > project.
> > > > > > At this time a complete Porthole client can be implemented in 1=
50
> > > > > > lines
> > > > > > of C without external dependencies, and most of that is boilerp=
late
> > > > > > socket code. This IMO is a major factor in deciding to avoid
> > > > > > vhost-user.
> > > > >
> > > > > This is essentially a proposal that we should make our project an=
d
> > > > > code more complicated so that your project and code can be simple=
r.
> > > > > I hope you can see why this isn't necessarily an argument that wi=
ll hold
> > > > > very much weight for us :-)
> > > >=20
> > > > Certainly, I do which is why I am still going to see about using
> > > > vhost,
> > > > however, a device that uses vhost is likely more complex then
> > > > the device
> > > > as it stands right now and as such more maintenance would be
> > > > involved on
> > > > your end also. Or have I missed something in that vhost-user can
> > > > be used
> > > > directly as a device?
> > >=20
> > > The basic vhost-user stuff isn't actually that hard;  if you aren't
> > > actually shuffling commands over the queues you should find it pretty
> > > simple - so I think your assumption about it being simpler if you
> > > avoid
> > > it might be wrong.  It might be easier if you use it!
> >=20
> > I have been looking into this and I am yet to find some decent
> > documentation or a simple device example I can use to understand how to
> > create such a device. Do you know of any reading or examples I can
> > obtain
> > on how to get an initial do nothing device up and running?
> >=20
> > -Geoff
>=20
> Scratch that, the design just solidified for me and I am now making
> progress, however it seems that vhost-user can't do what we need here:
>=20
> 1) I dont see any way to recieve notification of socket disconnection, in
> our use case the client app needs to be able to be (re)connected
> dynamically. It might be possible to get this event by registering it on
> the chardev manually but this seems like it would be a kludge.

My understanding was that someone added support for reconnection of
vhost-user;  I'm not sure of the detail - cc'ing in Maxime and
Marc-Andre.

> 2) I don't see any method of notifying the vhost-user client of the
> removal of a shared memory mapping. Again, these may not be persistently
> mapped in the guest as we have no control over the buffer allocation, and
> as such, we need a method to notify the client that the mapping has becom=
e
> invalid.
>=20
> 3) VHOST_USER_SET_MEM_TABLE is a one time request, again this breaks our
> usage as we need to change this dynamically at runtime.

I've seen (3) being sent multiple times (It's messy but it happens); so
I think that fixes (2) as well for you.

Dave

> Unless there are viable solutions to these problems there is no way that
> vhost-user can be used for this kind of a device.
>=20
> -Geoff
>=20
> >=20
> > >=20
> > > Dave
> > >=20
> > > > >
> > > > > thanks
> > > > > -- PMM
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


