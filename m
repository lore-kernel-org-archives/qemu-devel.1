Received: from eggs.gnu.org ([2001:4830:134:3::10]:33712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fpB3s-00046a-TK
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fpB3o-0004PD-FS
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:31:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58174 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fpB3o-0004Ou-9n
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:30:56 -0400
Date: Mon, 13 Aug 2018 12:30:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180813113052.GD2488@work-vm>
References: <CAKXe6S+OzWE92HJW-wiR3ynJmak_F556qrg5Kpn6goPn3LYDhA@mail.gmail.com>
	<20180813093545.GB2488@work-vm>
	<CAKXe6SKCx-=cUKMFPQQ+Wm-0==HkD9Qm6ud1Q0S0k3gi5qRKmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXe6SKCx-=cUKMFPQQ+Wm-0==HkD9Qm6ud1Q0S0k3gi5qRKmA@mail.gmail.com>
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
To: Li Qiang <liq3ea@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, liqiang02@corp.netease.com

* Li Qiang (liq3ea@gmail.com) wrote:
> 2018-08-13 17:35 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:
> 
> > * Li Qiang (liq3ea@gmail.com) wrote:
> > > Hello Dave, Juan and all,
> > >
> > > It is useful to get the dirty page rates in guest to evaluate the guest
> > > loads
> > > so that we can make a decide to live migrate it or not. So I think we can
> > > add a on-demand qmp for showing the dirty page rates.
> > >
> > > I found someone has done this work in here:
> > > -->https://github.com/grivon/yabusame-qemu-dpt
> > > and here:
> > > https://github.com/btrplace/qemu-patch
> > >
> > > But seems not go to the upstream.
> > >
> > > I want to know your opinions about adding this qmp.
> >
> > Something like that could be good;
> 
> one easy idea we had was
> > a 'migrate null:' uri and then you would use most of the existing
> > migration code to do the measurement; you would only have to
> > add a dummy file backend,
> 
> 
> As far as I understand, here dummy file backend just means the file migrate
> to, right?

Yes; because then if you have a dummy migration destination, the rest of
the migration code will run, sync the bitmap and clear the bits, and
give you an approximation of the dirty rate.

It might still be worth having the separate code to measure it without
the overhead of the migration code; but then that's more complex - and
if you're trying to measure it to know how hard it is to migrate then
perhaps it's better to use the migration code anyway.

Dave

> Thanks,
> Li Qiang
> 
> 
> 
> > and something to stop the migration ever
> > terminating (maybe just set the downtime very low).
> >
> >
> > Dave
> >
> >
> > > Thanks,
> > > Li Qiang
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
