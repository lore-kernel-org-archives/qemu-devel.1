Received: from eggs.gnu.org ([2001:4830:134:3::10]:55248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eI7EI-0005bu-Uo
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eI7EH-0004Pj-Kp
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:12:50 -0500
Date: Fri, 24 Nov 2017 01:12:34 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171124061234.GB14612@localhost.localdomain>
References: <20171123175747.2309-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123175747.2309-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/1] block: Workaround for the iotests
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Nov 24, 2017 at 01:57:46AM +0800, Fam Zheng wrote:
> Jeff's block job patch made the latent drain bug visible, and I find this
> patch, which by itself also makes some sense, can hide it again. :) With it
> applied we are at least back to the ground where patchew's iotests (make
> docker-test-block@fedora) can pass.
> 

Unfortunately, I am still seeing segfaults and aborts even with this patch.
For instance, on tests: 097 141 176.

k
> The real bug is that in the middle of bdrv_parent_drained_end(), bs's parent
> list changes. One drained_end call before the mirror_exit() already did one
> blk_root_drained_end(), a second drained_end on an updated parent node can do
> another same blk_root_drained_end(), making it unbalanced with
> blk_root_drained_begin(). This is shown by the following three backtraces as
> captured by rr with a crashed "qemu-img commit", essentially the same as in
> the failed iotest 020:
> 
> * Backtrace 1, where drain begins:
> 
> (rr) bt
> 
> * Backtrace 2, in the early phase of bdrv_parent_drained_end(), before
>   mirror_exit happend:
> 
> (rr) bt
> 
> * Backtrace 3, in a later phase of the same bdrv_parent_drained_end(), after
>   mirror_exit() which changed the node graph:
> 
> (rr) bt
> 
> IMO we should rethink bdrv_parent_drained_begin/end to avoid such complications
> and maybe in the long term get rid of the nested BDRV_POLL_WHILE() if possible.
> 
> It's late for me so I'm posting the patch anyway in case we could use it for
> -rc3.
> 
> Note this doesn't fix the hanging 056, which I haven't debugged yet.
> 
> Fam
> 
> Fam Zheng (1):
>   block: Don't poll for drain end
> 
>  block/io.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> -- 
> 2.14.3
> 
