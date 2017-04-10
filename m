Received: from eggs.gnu.org ([2001:4830:134:3::10]:56894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxX1k-0008M8-Jf
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxX1j-000622-LO
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:58:32 -0400
Date: Mon, 10 Apr 2017 18:58:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170410105821.GA2055@lemon>
References: <20170321031635.22123-1-famz@redhat.com>
	<20170410090422.GC2567@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410090422.GC2567@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 00/16] block: Protect AIO
 context change with perm API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 04/10 10:04, Stefan Hajnoczi wrote:
> On Tue, Mar 21, 2017 at 11:16:19AM +0800, Fam Zheng wrote:
> > Eject / change of scsi-cd on a virtio-scsi dataplane bus causes abort() because
> > the new BDS doesn't get proper bdrv_set_aio_context().
> > 
> > Store the AioContext in BB and do it in blk_insert_bs. That is done by
> > Vladimir's patch.
> > 
> > Other patches are to make sure such a bdrv_set_aio_context() doesn't interfere
> > with other BBs using other nodes from this graph.
> > 
> > RFC note:
> > 
> > Unfortunately, a use-after-free crash in iotests 030 appears since patch 7,
> > which I believe is a latent bug that bdrv_reopen is "reentered" in existing
> > code, rather than from this series:
> > 
> > > #4  0x0000561ab90425a7 in bdrv_reopen
> > > #5  0x0000561ab8e1d28e in stream_complete
> > > #6  0x0000561ab9048543 in block_job_defer_to_main_loop_bh
> > > #7  0x0000561ab91305bc in aio_bh_call
> > > #8  0x0000561ab9130659 in aio_bh_poll
> > > #9  0x0000561ab9135656 in aio_poll
> > > #10 0x0000561ab90a6cf5 in bdrv_flush
> > > #11 0x0000561ab904285a in bdrv_reopen_prepare
> > > #12 0x0000561ab90423f0 in bdrv_reopen_multiple
> > > #13 0x0000561ab90425ef in bdrv_reopen
> > > #14 0x0000561ab909fa49 in commit_active_start
> > > #15 0x0000561ab8dd6ffb in qmp_block_commit
> > > #16 0x0000561ab8ded485 in qmp_marshal_block_commit
> > > #17 0x0000561ab9123e6c in do_qmp_dispatch
> > > #18 0x0000561ab9123fa4 in qmp_dispatch
> > > #19 0x0000561ab8ca26b7 in handle_qmp_command
> > 
> > I have a fix that I'll post separately.
> > 
> > The last patches are an alternative to patch 7, to "workaround" this in a
> > really non-obvious way.
> 
> Are there qemu-iotests that cover both success and failure scenarios for
> the new permission?

No, I'll add them.

Fam
