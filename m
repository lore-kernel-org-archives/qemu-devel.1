Received: from eggs.gnu.org ([2001:4830:134:3::10]:44750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1co7hp-0006Se-K4
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1co7ho-0004CK-J1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:07:05 -0400
Date: Wed, 15 Mar 2017 13:06:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170315120656.GI4030@noname.str.redhat.com>
References: <20170314171120.80741-1-vsementsov@virtuozzo.com>
	<20170315110351.GG4030@noname.str.redhat.com>
	<20170315111445.GE3088@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315111445.GE3088@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] blk: fix aio context loss on media change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

Am 15.03.2017 um 12:14 hat Fam Zheng geschrieben:
> On Wed, 03/15 12:03, Kevin Wolf wrote:
> > Am 14.03.2017 um 18:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > If we have separate iothread for cdrom, we lose connection to it on
> > > qmp_blockdev_change_medium, as aio_context is on bds which is dropped
> > > and switched with new one.
> > > 
> > > As an example result, after such media change we have crash on
> > > virtio_scsi_ctx_check: Assertion `blk_get_aio_context(d->conf.blk) == s->ctx' failed.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > ---
> > > 
> > > Hi all!
> > > 
> > > We've faced into this assert, and there some kind of fix. I don't sure that
> > > such fix doesn't break some conceptions, in this case, I hope, someone will
> > > propose a true-way solution.
> > 
> > The "true way" would be proper AioContext management in the sense that
> > all users of a BDS can specify a specific AioContext that they need and
> > if they all agree, callbacks are invoked to change everyone to that
> > AioContext. If they conflict, attaching the new user would have to error
> > out.
> > 
> > But we discussed this earlier, and while I'm not completely sure any
> > more about the details, I seem to remeber that Paolo said something
> > along the lines that AioContext is going away anyway and building the
> > code for proper management would be wasted time.
> 
> Matches my impression.
> 
> > 
> > Stefan, Paolo, do you remember the details why we didn't even do a
> > simple fix like the one below? I think there were some patches on the
> > list, no?
> 
> ISTM the concern was mostly "what about other BB in the graph?"
> 
> Should the new op blocker API be used in this one (a new type of perm)?

If we know what operation to block, that's an option. Would "change the
node's AioContext" work for it?

I think it would effectively mean that you need to attach the device
first and then jobs etc. respect the AioContext, whereas the opposite
order breaks because they don't have callbacks to adjust the AioContext
after the fact.

This seems to match what's actually safe, so it might really be as easy
as this.

Kevin
