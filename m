Received: from eggs.gnu.org ([2001:4830:134:3::10]:59949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNgjM-0003gZ-HA
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNgjL-0002fZ-Oi
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:40:12 -0400
Date: Tue, 29 May 2018 17:40:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180529154002.GG4756@localhost.localdomain>
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-5-kwolf@redhat.com>
	<20180529152714.GG6999@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529152714.GG6999@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 04/14] block/create: Make
 x-blockdev-create a job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Am 29.05.2018 um 17:27 hat Jeff Cody geschrieben:
> On Fri, May 25, 2018 at 06:33:17PM +0200, Kevin Wolf wrote:
> > This changes the x-blockdev-create QMP command so that it doesn't block
> > the monitor and the main loop any more, but starts a background job that
> > performs the image creation.
> > 
> 
> This comes down to "user error", but now that the monitor and main loop are
> not blocked (which is good), should we try at all to catch/prevent a
> blockdev-add that is issued before a blockdev-create completion?

Hm, currently, the .bdrv_co_create implementations usually do this:

    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);

I'm not sure if BLK_PERM_ALL is the best options for the shared
permissions, but anyway format drivers can't share BLK_PERM_WRITE on
their part, so I think we already do prevent this by taking the
BLK_PERM_WRITE permission.

Kevin
