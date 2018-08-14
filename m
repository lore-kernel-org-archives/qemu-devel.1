Received: from eggs.gnu.org ([2001:4830:134:3::10]:46467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fpPof-0004i9-MX
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fpPoe-0004Rz-Cs
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:16:17 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:42564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fpPoe-0004Rr-6Y
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:16:16 -0400
Received: by mail-qt0-x234.google.com with SMTP id z8-v6so19760555qto.9
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 20:16:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180813113052.GD2488@work-vm>
References: <CAKXe6S+OzWE92HJW-wiR3ynJmak_F556qrg5Kpn6goPn3LYDhA@mail.gmail.com>
	<20180813093545.GB2488@work-vm>
	<CAKXe6SKCx-=cUKMFPQQ+Wm-0==HkD9Qm6ud1Q0S0k3gi5qRKmA@mail.gmail.com>
	<20180813113052.GD2488@work-vm>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 14 Aug 2018 11:15:35 +0800
Message-ID: <CAKXe6SJcOX1Skoq_wL2WfvF+vWzmA0pMJ=EikpMuWbTio15ddg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Question about dirty page statistics for live
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, liqiang02@corp.netease.com

2018-08-13 19:30 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:

> * Li Qiang (liq3ea@gmail.com) wrote:
> > 2018-08-13 17:35 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:
> >
> > > * Li Qiang (liq3ea@gmail.com) wrote:
> > > > Hello Dave, Juan and all,
> > > >
> > > > It is useful to get the dirty page rates in guest to evaluate the
> guest
> > > > loads
> > > > so that we can make a decide to live migrate it or not. So I think
> we can
> > > > add a on-demand qmp for showing the dirty page rates.
> > > >
> > > > I found someone has done this work in here:
> > > > -->https://github.com/grivon/yabusame-qemu-dpt
> > > > and here:
> > > > https://github.com/btrplace/qemu-patch
> > > >
> > > > But seems not go to the upstream.
> > > >
> > > > I want to know your opinions about adding this qmp.
> > >
> > > Something like that could be good;
> >
> > one easy idea we had was
> > > a 'migrate null:' uri and then you would use most of the existing
> > > migration code to do the measurement; you would only have to
> > > add a dummy file backend,
> >
> >
> > As far as I understand, here dummy file backend just means the file
> migrate
> > to, right?
>
> Yes; because then if you have a dummy migration destination, the rest of
> the migration code will run, sync the bitmap and clear the bits, and
> give you an approximation of the dirty rate.
>
> It might still be worth having the separate code to measure it without
> the overhead of the migration code; but then that's more complex - and
> if you're trying to measure it to know how hard it is to migrate then
> perhaps it's better to use the migration code anyway.
>

Agree

But here is another issue, if we choice 'migrate null', then we will break
the 'migrate' interface.
the migrate doesn't return the info, so we need to uses 'info migrate'.
However only we want
is the dirty pages rates. It's too heavy for the user. Anyway we just want
to get the only dirty page rates
using one command.

I will first try to implement a separate qmp.

Thanks,
Li Qiang



> Dave
>
> > Thanks,
> > Li Qiang
> >
> >
> >
> > > and something to stop the migration ever
> > > terminating (maybe just set the downtime very low).
> > >
> > >
> > > Dave
> > >
> > >
> > > > Thanks,
> > > > Li Qiang
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
