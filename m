Received: from eggs.gnu.org ([2001:4830:134:3::10]:35221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fI7B9-0006VP-7i
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fI7B7-0005gn-Sx
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:41:51 -0400
Date: Mon, 14 May 2018 14:41:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180514064139.GB16389@lemon.usersys.redhat.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, "gilbert >> Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Juan Q >> Juan Jose Quintela Carreira" <quintela@redhat.com>

On Wed, 04/18 17:00, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> We now have the following problem:
> 
> If dirty-bitmaps migration capability is enabled, persistance flag is
> dropped for all migrated bitmaps, to prevent their storing to the storage on
> inactivate. 

Why do we prevent source storing persistent bitmaps by clearing the flag instead
of making the bitmap code more BDRV_O_INACTIVE-aware, so it is _not_ stored
when/after inactivation?

> It works ok, persistence itself is migrated through the
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

Is this "cont" on the source even though dst is already up? How will this work?
Isn't it expected that dst is using the image?

> c. migration success, then stop/start (there was no invalidate, so [1] will
> not work)
> 
> 
> 2. Is it safe at all, saving bitmaps after inactivate, even without
> persistence?

This is not safe. No I/O should be done to the image after inactivation.

> 
> Inactive disk implies, that it may be changed by somebody other, isn't it?

Yes.

> Is it possible, that target will change the disk, and then we return control
> to the source? In this case bitmaps will be invalid. So, should not we drop
> all the bitmaps on inactivate?

Yes, dropping all live bitmaps upon inactivate sounds reasonable. If the dst
fails to start, and we want to resume VM at src, we could (optionally?) reload
the persistent bitmaps, I guess.

> 
> -- 
> Best regards,
> Vladimir
> 
