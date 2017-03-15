Received: from eggs.gnu.org ([2001:4830:134:3::10]:60255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coAsN-0000Il-Lt
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coAsM-0007an-OK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:30:11 -0400
Date: Wed, 15 Mar 2017 16:30:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170315153001.GM4030@noname.str.redhat.com>
References: <20170314171120.80741-1-vsementsov@virtuozzo.com>
	<20170315110351.GG4030@noname.str.redhat.com>
	<9a68a30f-8765-ca91-572f-ed8d7083b202@redhat.com>
	<20170315143032.GK4030@noname.str.redhat.com>
	<87bb192d-b910-5ac2-886b-fefeb4a2ec4d@redhat.com>
	<20170315150210.GL4030@noname.str.redhat.com>
	<1f49061f-a73c-35ea-9d8b-89d21e22cbfe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f49061f-a73c-35ea-9d8b-89d21e22cbfe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blk: fix aio context loss on media change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

Am 15.03.2017 um 16:09 hat Paolo Bonzini geschrieben:
> >>>> There should be a policy on which BB sets AioContext on the BDS (e.g.
> >>>> only the device does it), but apart from that, it should not be an issue.
> >>>
> >>> We don't know which BBs are going to be attached. We don't necessarily
> >>> have a device at all, or we could have two of them.
> >>
> >> Wow, can we really have two? :-O
> > 
> > What would prevent you from doing this? The whole blockdev work was
> > about making the block layer more flexible, so now we have this
> > flexibility of attaching more or less anything to anything (unless op
> > blockers prevent it, which is why they are important for actually
> > supporting blockdev).
> 
> Yeah, the actual question was more "will the blockers allow two" devices
> behind the same BDS.  But I suppose there's no reason to prevent that
> (emulating multipath, for example).

For read-only devices, there's no reason anyway. For writable ones, you
have to set the share-rw=on qdev property, but then it's allowed.

> >>> Though maybe we should try to keep a BDS and its children in the same
> >>> AioContext anyway if that's possible? Will it make a difference?
> >>
> >> Everything can make sense---but yes, keeping the whole hierarchy in the
> >> same AioContext makes sense more often.
> > 
> > So I take this to mean that it does make a difference. :-)
> > 
> > If we want to keep users and their child nodes in the same AioContext by
> > default, we'll probably still need to implement all of the callbacks
> > that we would need for proper AioContext management today.
> 
> Or just assume that in the common case people won't specify iothread on
> -blockdev, only on -device.

Right, but then attaching a new device could mean that the BDS moves to
a different AioContext even though the other users are still on the old
one. Not sure if this is bad, but it might be unexpected.

Kevin
