Received: from eggs.gnu.org ([2001:4830:134:3::10]:34379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fIPJf-0008E1-1l
	for qemu-devel@nongnu.org; Mon, 14 May 2018 22:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fIPJe-0008Bu-4V
	for qemu-devel@nongnu.org; Mon, 14 May 2018 22:03:51 -0400
Date: Tue, 15 May 2018 10:03:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180515020339.GC16389@lemon.usersys.redhat.com>
References: <8739e95e-1900-d4e3-7ac8-77e3aa8b927e@virtuozzo.com>
	<20180514064139.GB16389@lemon.usersys.redhat.com>
	<9a59b786-2351-e8ae-f582-5e436ce0383c@virtuozzo.com>
	<37ec5d93-9830-8d49-d1db-74d3d359b2ca@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ec5d93-9830-8d49-d1db-74d3d359b2ca@virtuozzo.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, "gilbert >> Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Juan Q >> Juan Jose Quintela Carreira" <quintela@redhat.com>

On Mon, 05/14 13:23, Vladimir Sementsov-Ogievskiy wrote:
> > So, you agree, that dropping all bitmaps after inactivation is good
> > idea.. The second question, is it possible to not drop them? Is there a
> > way, to check that disk was not changed after pair of
> > inactivate-invalidate? I have an idea:
> > we can create small-bitmap, which will not migrate through migration
> > channel, but remain persistent. It will be very small (big granularity,
> > to not increase downtime of migration), so after invalidate we can check
> > this bitmap. If it is empty, we are happy, we can "activate" all our
> > bitmaps and make them persistent again. If not, we have two ways:
> > 
> > 1. drop all bitmaps
> > 2. merge small-bitmap to all our bitmaps
> 
> However, we must not start source, if disk was changed, as memory and
> devices states will not correspond to disk. So, such a small bitmap may be
> used to check, can we start source or not.

Or it can be a generation number/uuid that is updated when the image is changed
(upon the first write after each open), similar to VMDK's CID and VHDX GUIDs. We
can compare the on disk value with the known value at source QEMU, if they match
it means the image data is not touched.

Fam
