Received: from eggs.gnu.org ([2001:4830:134:3::10]:40281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkwHQ-0001VE-N5
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 14:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkwHP-0006a8-Q3
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 14:55:28 -0400
Date: Wed, 1 Aug 2018 19:55:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180801185515.GE2691@work-vm>
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<20180626135035.133432-5-vsementsov@virtuozzo.com>
	<700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
	<20180801102031.GC2691@work-vm>
	<64aad02b-3d5c-70d6-0f5a-93dd5b88e4bc@redhat.com>
	<20180801174005.GD2691@work-vm>
	<cbdecba1-925c-5f6e-bf3c-a27cc4d944da@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbdecba1-925c-5f6e-bf3c-a27cc4d944da@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 4/6] dirty-bitmaps: clean-up bitmaps
 loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, Eric Blake <eblake@redhat.com>

* Denis V. Lunev (den@openvz.org) wrote:
> On 08/01/2018 08:40 PM, Dr. David Alan Gilbert wrote:
> > * John Snow (jsnow@redhat.com) wrote:
> >>
> >> On 08/01/2018 06:20 AM, Dr. David Alan Gilbert wrote:
> >>> * John Snow (jsnow@redhat.com) wrote:
> >>>
> >>> <snip>
> >>>
> >>>> I'd rather do something like this:
> >>>> - Always flush bitmaps to disk on inactivate.
> >>> Does that increase the time taken by the inactivate measurably?
> >>> If it's small relative to everything else that's fine; it's just I
> >>> always worry a little since I think this happens after we've stopped the
> >>> CPU on the source, so is part of the 'downtime'.
> >>>
> >>> Dave
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>
> >> I'm worried that if we don't, we're leaving behind unusable, partially
> >> complete files behind us. That's a bad design and we shouldn't push for
> >> it just because it's theoretically faster.
> > Oh I don't care about theoretical speed; but if it's actually unusably
> > slow in practice then it needs fixing.
> >
> > Dave
> 
> This is not "theoretical" speed. This is real practical speed and
> instability.
> EACH IO operation can be performed unpredictably slow and thus with
> IO operations in mind you can not even calculate or predict downtime,
> which should be done according to the migration protocol.

We end up doing some IO anyway, even ignoring these new bitmaps,
at the end of the migration when we pause the CPU, we do a
bdrv_inactivate_all to flush any outstanding writes; so we've already
got that unpredictable slowness.

So, not being a block person, but with some interest in making sure
downtime doesn't increase, I just wanted to understand whether the
amount of writes we're talking about here is comparable to that
which already exists or a lot smaller or a lot larger.
If the amount of IO you're talking about is much smaller than what
we typically already do, then John has a point and you may as well
do the write.
If the amount of IO for the bitmap is much larger and would slow
the downtime a lot then you've got a point and that would be unworkable.

Dave

> That is why we have very specifically (for the purpose) improved
> migration protocol to migrate CBT via postcopy method, which
> does not influence downtime.
> 
> That is why we strictly opposes any CBT writing operation in migration
> code. It should also be noted, that CBT can be calculated for all discs,
> including raw but could be written for QCOW2 only. With external CBT storage
> for such discs the situation during migration would become even worse.

> Den
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
