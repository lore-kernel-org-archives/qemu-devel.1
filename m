Received: from eggs.gnu.org ([2001:4830:134:3::10]:58025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faA5U-0002Vv-8t
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faA5T-0002b5-9O
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:26:36 -0400
Date: Tue, 3 Jul 2018 09:26:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180703012626.GB485@lemon.usersys.redhat.com>
References: <20180702025836.20957-1-famz@redhat.com>
	<02d1f79b-c055-bb2a-edd5-3429ff64af90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d1f79b-c055-bb2a-edd5-3429ff64af90@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Trivial fixes in offloading code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Mon, 07/02 14:35, Max Reitz wrote:
> On 2018-07-02 04:58, Fam Zheng wrote:
> > These are the low priority ones spotted by Kevin and Max last week.
> > 
> > Fam Zheng (4):
> >   qcow2: Drop unused cluster_data
> >   file-posix: Fix fd_open check in raw_co_copy_range_to
> >   qcow2: Drop unreachable break
> >   raw: Drop superfluous semicolon
> > 
> >  block/file-posix.c | 2 +-
> >  block/qcow2.c      | 3 ---
> >  block/raw-format.c | 2 +-
> >  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> Thanks, applied to my block branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> 
> 
> Do you want to make qcow2_co_copy_range_to() do something special on
> BDRV_REQ_ZERO_WRITE?  To me, it seems natural, but on the other hand
> maybe it wouldn't bring anything.  If the protocol layer supports copy
> offloading, then it'll probably do that zero write efficiently anyway.
> If it doesn't, qemu-img convert will just fall back to the usual
> implementation which involves writing zeroes when zeroes are read, so...
>  What's your opinion?

In bdrv_co_copy_range_internal() there is

    if (flags & BDRV_REQ_ZERO_WRITE) {
        return bdrv_co_pwrite_zeroes(dst, dst_offset, bytes, flags);
    }

before calling driver .bdrv_co_copy_range_to() callback. I think this is enough?

Fam
