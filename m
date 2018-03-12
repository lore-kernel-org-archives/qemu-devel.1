Received: from eggs.gnu.org ([2001:4830:134:3::10]:58138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evM6a-0005Za-6Y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evM6Z-0003qw-4I
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:59:04 -0400
Date: Mon, 12 Mar 2018 12:58:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180312115846.GC31537@localhost.localdomain>
References: <20180207163622.29935-3-pbonzini@redhat.com>
	<20180208013517.GB24289@lemon.usersys.redhat.com>
	<5ac0b76e-213a-60c3-c010-87512d3a564a@redhat.com>
	<20180212135206.GG5103@localhost.localdomain>
	<81af35f9-4934-0c21-e3b1-b27c2fa7fdd9@redhat.com>
	<20180212143040.GH5103@localhost.localdomain>
	<3d6031b0-7d75-c3ab-e466-ce3d87d630df@redhat.com>
	<20180212144824.GI5103@localhost.localdomain>
	<31e295bd-3012-c34c-a96d-54122557b20c@redhat.com>
	<2d47ca9e-6f68-ab4e-0ec0-9f932128a93f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d47ca9e-6f68-ab4e-0ec0-9f932128a93f@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] scsi: add block job
 opblockers for scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 12.03.2018 um 12:10 hat Paolo Bonzini geschrieben:
> On 12/02/2018 15:50, Paolo Bonzini wrote:
> > On 12/02/2018 15:48, Kevin Wolf wrote:
> >> Am 12.02.2018 um 15:32 hat Paolo Bonzini geschrieben:
> >>> Okay, we are in agreement about this and you expressed very well why I
> >>> (at the gut feeling level) didn't like the old op blockers.  But you
> >>> bypassed the real question, which is: should I send a pull request for
> >>> these two patches or not? :)
> >> I didn't spell it out that explicitly, but this is essentially a NACK.
> >> I'd very much prefer if you could replace it with the proper solution.
> >> Of course, we can always make exceptions when there is a good reason,
> >> but with 2.12 still two months away, I doubt we have one.
> > Ok, I don't mind explicitness.  I'll keep these two patches in the queue
> > for now.
> 
> It's now one month away.  Regarding the solution below:
> 
> > I propose a new BLK_PERM_BYPASS that allows its users to bypass the
> > block layer I/O functions. In other words, bdrv_aio_ioctl() would
> > require that you got this permission. A dirty bitmap would keep a
> > BdrvChild with perm=0, shared=BLK_PERM_ALL & ~BLK_PERM_BYPASS, so you
> > can never have a dirty bitmap and a device using ioctls attached to the
> > BDS at the same time.
> 
> I suppose it would be like:
> 
> - scsi-block/scsi-generic call blk_set_perm with perm == shared ==
> BLK_PERM_BYPASS

perm = BLK_PERM_BYPASS is fine, but for shared it seems overly
restrictive. I don't think the device minds another user accessing the
device.

Other block devices do this in blkconf_apply_backend_options():

    shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                  BLK_PERM_GRAPH_MOD;
    if (resizable) {
        shared_perm |= BLK_PERM_RESIZE;
    }
    if (conf->share_rw) {
        shared_perm |= BLK_PERM_WRITE;
    }

I suppose scsi-generic is never resizable, so that part can go away, but
we do have a share-rw qdev property that can be used.

> - users of dirty bitmaps would call use perm/shared_perm as in your
> message above
> 
> - dirty bitmaps creation calls bdrv_get_cumulative_perm (which should
> now become public) and checks that it doesn't have BLK_PERM_BYPASS in
> shared_perm

My proposal was really that users of dirty bitmaps don't change
anything, but we do everything in the dirty bitmap implementation. Dirty
bitmap creation would add a BdrvChild with the above permissions.
Deleting a dirty bitmap would remove the BdrvChild again.

Then you don't need to manually call bdrv_get_cumulative_perm(), because
the permission check is included when you attach the BdrvChild.

> Anything I'm missing?

Ideally, bdrv_co_ioctl() should take a BdrvChild instead of a BDS and
assert that the caller correctly requested the permission:

    assert(child->perm & BLK_PERM_BYPASS);

Kevin
