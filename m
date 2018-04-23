Received: from eggs.gnu.org ([2001:4830:134:3::10]:50030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAgPo-0000QY-K4
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAgPn-00016h-LJ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:42:16 -0400
Date: Mon, 23 Apr 2018 19:41:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180423184153.GB13754@work-vm>
References: <8739e95e-1900-d4e3-7ac8-77e3aa8b927e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8739e95e-1900-d4e3-7ac8-77e3aa8b927e@virtuozzo.com>
Subject: Re: [Qemu-devel] Restoring bitmaps after failed/cancelled migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, "Juan Q >> Juan Jose Quintela Carreira" <quintela@redhat.com>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> Hi all.
> 
> We now have the following problem:
> 
> If dirty-bitmaps migration capability is enabled, persistance flag is
> dropped for all migrated bitmaps, to prevent their storing to the storage on
> inactivate. It works ok, persistence itself is migrated through the
> migration channel. But on source, bitmaps becomes not persistent, so if we,
> for some reasons, want to continue using source vm, we'll lose bitmaps on
> stop/start.
> 
> It's simple to fix it: just make bitmaps persistent again on invalidate
> [1].. But I have some questions.
> 
> 1. What are possible cases? I think about the following:
> 
> a. migration cancel or fail, then invalidate
> b. migration success, then qmp cont => invalidate
> c. migration success, then stop/start (there was no invalidate, so [1] will
> not work)
> 
> 
> 2. Is it safe at all, saving bitmaps after inactivate, even without
> persistence?
> 
> Inactive disk implies, that it may be changed by somebody other, isn't it?
> Is it possible, that target will change the disk, and then we return control
> to the source? In this case bitmaps will be invalid. So, should not we drop
> all the bitmaps on inactivate?

I don't know the full answers; but I do know it's valid to have the case
(b) - i.e. from QEMU's point of view the migration succeeds, but the
destination was run with -S and for some external failure reason, the
management layer decides to kill the destination and restart the source.
And you're right, that at that point there's no one holding the lock,
so the source can't be sure that no one snuck in and fiddled with the
disk before restarting.

Dave

> -- 
> Best regards,
> Vladimir
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
