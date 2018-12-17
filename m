Received: from eggs.gnu.org ([2001:4830:134:3::10]:38793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYy8B-0000hH-Py
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYy87-00062s-UT
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:00:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYy87-00060M-Ev
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:00:39 -0500
Date: Mon, 17 Dec 2018 21:00:25 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181217190024.GA18696@lap1>
References: <20181212193039.11445-1-ppandit@redhat.com>
	<20181212193039.11445-4-ppandit@redhat.com>
	<20181216203052.GA5065@lap1>
	<nycvar.YSQ.7.76.1812180006430.28971@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1812180006430.28971@xnncv>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] pvrdma: check number of pages when
 creating rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, yuval.shaia@oracle.com

On Tue, Dec 18, 2018 at 12:17:59AM +0530, P J P wrote:
>   Hello Yuval,
> 
> +-- On Sun, 16 Dec 2018, Yuval Shaia wrote --+
> | With this patch the last step fails, the guest OS hangs, trying to probably 
> | unload pvrdma driver and finally gave up after 3 minutes.
> 
> Strange...
>  
> | Anyways with debug turned on i have noticed that there is one case that 
> | devices gets 129 nchunks (i think in MPI) while your patch limits it to 128.
> | >From pvrdma source code  we can see that first page is dedicated to ring
> | state, this means that it maybe correct that 128 is the limit but we
> | should check that nchunks does not exceed 129, not 128.
> | 
> | What do you think?
> 
>  -> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c?id=fdf82a7856b32d905c39afc85e34364491e46346#n201
> 
> the vmw_pvrdma kernel driver also seems to set MAX_FAST_REG_PAGE = 128.

So does the user-space library.
Maybe the mr_type is IB_MR_TYPE_MEM_REG.

> 
> 
> | Ie. to replace this line from create_cq_ring
> | +    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
> | with this
> | +    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES + 1) {
> | 
> | Let me know your opinion.
> 
> While it may help to fix the regression. I'm not sure it's a right fix.
> 129 seems a little odd number to have as limit.

Agree, let's stick with this patch.

> 
> Is it possible MPI is erring in getting 129 chunks?

Yeah but still the driver is holding the shutdown, not MPI.

Anyways, I found a wrong setting of respose to driver in "Add support for
RDMA MAD" patchset v6 and fixed that.
Now the regression is fine, i.e. VM goes down smoothly.

> 
> IMO it's better to confirm the right value for 'MAX_FAST_REG_PAGES', before 
> going with > PVRDMA_MAX_FAS_REG_PAGES(=128) + 1.

Agree.

> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
