Received: from eggs.gnu.org ([2001:4830:134:3::10]:44047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cehMA-0007M9-26
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cehM9-0003qM-1N
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:09:46 -0500
Date: Fri, 17 Feb 2017 13:09:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170217120935.GC5338@noname.redhat.com>
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-9-git-send-email-vsementsov@virtuozzo.com>
	<20170216112506.GB4869@noname.redhat.com>
	<20170216114944.GD4869@noname.redhat.com>
	<8d7a5d17-7b1b-578a-67fc-c79beb196a4c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d7a5d17-7b1b-578a-67fc-c79beb196a4c@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v15 08/25] block: introduce auto-loading
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

Am 17.02.2017 um 12:46 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 16.02.2017 14:49, Kevin Wolf wrote:
> >Am 16.02.2017 um 12:25 hat Kevin Wolf geschrieben:
> >>Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>>Auto loading bitmaps are bitmaps stored in the disk image, which should
> >>>be loaded when the image is opened and become BdrvDirtyBitmaps for the
> >>>corresponding drive.
> >>>
> >>>Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>Reviewed-by: John Snow <jsnow@redhat.com>
> >>>Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>Why do we need a new BlockDriver callback and special code for it in
> >>bdrv_open_common()? The callback is only ever called immediately after
> >>.bdrv_open/.bdrv_file_open, so can't the drivers just do this internally
> >>in their .bdrv_open implementation? Even more so because qcow2 is the
> >>only driver that supports this callback.
> >Actually, don't we have to call this in qcow2_invalidate_cache()?
> >Currently, I think, after a migration, the autoload bitmaps aren't
> >loaded.
> >
> >By moving the qcow2_load_autoloading_dirty_bitmaps() call to
> >qcow2_open(), this would be fixed.
> >
> >Kevin
> 
> Bitmap should not be reloaded on any intermediate qcow2-open's,
> reopens, etc. It should be loaded once, on bdrv_open, to not create
> extra collisions (between in-memory bitmap and it's stored version).
> That was the idea.
> 
> For bitmaps migration there are separate series, we shouldn't load
> bitmap from file on migration, as it's version in the file is
> outdated.

That's not what your series is doing, though. It loads the bitmaps when
migration starts and doesn't reload then when migration completes, even
though they are stale. Migration with shared storage would just work
without an extra series if you did these things in the correct places.

As a reminder, this is how migration with shared storage works (or
should work with your series):

1. Start destination qemu instance. This calls bdrv_open() with
   BDRV_O_INACTIVE. We can read in some metadata, though we don't need
   much more than the image size at this point. Writing to the image is
   still impossible.

2. Start migration on the source, while the VM is still writing to the
   image, rendering the cached metadata from step 1 stale.

3. Migration completes:

    a. Stop the VM

    b. Inactivate all images in the source qemu. This is where all
       metadata needs to be written back to the image file, including
       bitmaps. No writes to the image are possible after this point
       because BDRV_O_INACTIVE is set.

    c. Invalidate the caches in the destination qemu, i.e. reload
       everything from the file that could have changed since step 1,
       including bitmaps. BDRV_O_INACTIVE is cleared, making the image
       ready for writes.

    d. Resume the VM on the destination

4. Exit the source qemu process, which involves bdrv_close(). Note that
   at this point, no writing to the image file is possible any more,
   it's the destination qemu process that own the image file now.

Your series loads and stores bitmaps in steps 1 and 4. This means that
they are stale on the destination when migration completes, and that
bdrv_close() wants to write to an image file that it doesn't own any
more, which will cause an assertion failure. If you instead move things
to steps 3b and 3c, it will just work.

Kevin
