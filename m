Received: from eggs.gnu.org ([2001:4830:134:3::10]:34409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evMRn-0007bs-9f
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evMRm-0007to-CE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:20:59 -0400
Date: Mon, 12 Mar 2018 13:20:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180312122053.GE31537@localhost.localdomain>
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-4-kwolf@redhat.com>
	<fb503893-a9e0-2772-41f2-14934b199f8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb503893-a9e0-2772-41f2-14934b199f8d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, qemu-devel@nongnu.org

Am 09.03.2018 um 22:58 hat Eric Blake geschrieben:
> On 03/09/2018 03:46 PM, Kevin Wolf wrote:
> > This adds the .bdrv_co_create driver callback to qcow, which
> > enables image creation over QMP.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/block-core.json |  21 +++++-
> >   block/qcow.c         | 196 ++++++++++++++++++++++++++++++++++-----------------
> >   2 files changed, 150 insertions(+), 67 deletions(-)
> 
> Pre-review question: do we REALLY want to support creation of new qcow
> images from QMP?  Or are we at the point where we want to declare qcow
> a read-only format where we only support it to the extent that you can
> convert an existing qcow file into a better supported format like
> qcow2?

I don't think we want read-only formats if it can be avoided, because
we're in a much worse position to run tests then.

The other option you mentioned in your reply to the qed patch, just not
implementing .bdrv_co_create, but keeping the old callback, would mean
that we'd be stuck in a half-converted state forever. My goal is to get
rid of .bdrv_co_create_opts in the long run.

And actually, qcow and qed were two of the simpler conversions where
little remains to be done before the logic in .bdrv_co_create_opts can
be generalised in block.c.

So I'd just do the conversion.

Kevin
