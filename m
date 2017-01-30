Received: from eggs.gnu.org ([2001:4830:134:3::10]:57752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1cYGyM-0003DU-Q9
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1cYGyK-0002ae-8l
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:46:38 -0500
Date: Mon, 30 Jan 2017 13:55:22 -0500
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20170130185522.GA17997@localhost.localdomain>
References: <1485800032-24404-1-git-send-email-hch@lst.de>
	<1485800032-24404-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485800032-24404-2-git-send-email-hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH 1/2] nvme: implement the DSM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, Jan 30, 2017 at 07:13:51PM +0100, Christoph Hellwig wrote:
> Support deallocating of LBAs using the DSM command by wiring it up to
> the qemu discard implementation.  The other DSM operations which are
> purely advisory are ignored for now.
> 
> Based on an implementation by Keith Busch in the qemu-nvme.git repository,
> but rewritten to use the qemu AIO infrastructure properly to not block
> the main thread on discard requests, and cleaned up a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for doing this. I've one comment below, but I don't think it should
block this unless you see a good way to fix it.

Reviewed-by: Keith Busch <keith.busch@intel.com>

> +    for (i = 0; i < nr; i++) {
> +        uint64_t slba = le64_to_cpu(range[i].slba);
> +        uint32_t nlb = le32_to_cpu(range[i].nlb);
> +
> +        if (slba + nlb > le64_to_cpu(ns->id_ns.nsze)) {
> +            return NVME_LBA_RANGE | NVME_DNR;
> +        }
> +
> +        req->aio_inflight++;
> +        req->aiocb = blk_aio_pdiscard(n->conf.blk, slba << data_shift,
> +                                      nlb << data_shift, nvme_discard_cb, req);

Overwriting the request's aiocb here for a multiple ranges is potentially
a problem if we have to cancel the request later. That scenario is
extremely unlikely, though, so I don't think it's worth addressing.
