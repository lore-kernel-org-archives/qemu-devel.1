Received: from eggs.gnu.org ([2001:4830:134:3::10]:58353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gWjs4-0005oH-7J
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gWjrz-0002um-3E
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:22:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gWjry-0002tp-Ne
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:22:46 -0500
Date: Tue, 11 Dec 2018 17:22:32 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181211152231.GB28105@lap1>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211132642.3027-3-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] pvrdma: add uar_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>, yuval.shaia@oracle.com

On Tue, Dec 11, 2018 at 06:56:39PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Define skeleton 'uar_read' routine. Avoid NULL dereference.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index ca5fa8d981..a6211d416d 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -455,6 +455,11 @@ static const MemoryRegionOps regs_ops = {
>      },
>  };
>  
> +static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0;
> +}
> +
>  static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>  {
>      PVRDMADev *dev = opaque;
> @@ -496,6 +501,7 @@ static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>  }
>  
>  static const MemoryRegionOps uar_ops = {
> +    .read = uar_read,

Are you sure it is needed?
Looking at memory_region_dispatch_read1 i can see that there is a check but
not sure this is the right place. Anyways, if it is not, i believe this
should be framework responsibility.

>      .write = uar_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .impl = {
> -- 
> 2.19.2
> 
