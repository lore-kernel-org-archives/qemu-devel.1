Received: from eggs.gnu.org ([2001:4830:134:3::10]:44680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydfv-000826-TH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydfq-0002oH-7G
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:21:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eydfq-0002nO-1T
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:21:02 -0400
References: <20180321124026.70292-1-marcel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8fc94472-c9dc-edf6-d89b-90f6d6ac281a@redhat.com>
Date: Wed, 21 Mar 2018 08:20:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180321124026.70292-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/rdma: fix clang compilation
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, mst@redhat.com

On 03/21/2018 07:40 AM, Marcel Apfelbaum wrote:
> Fix some enum castings and extra parentheses.
> 
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>   hw/rdma/vmw/pvrdma_cmd.c  | 5 +++--
>   hw/rdma/vmw/pvrdma_main.c | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 293dfed29f..25f747a190 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -73,7 +73,7 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
>       tbl_idx = 1;
>       addr_idx = 1;
>       while (addr_idx < nchunks) {
> -        if ((tbl_idx == (TARGET_PAGE_SIZE / sizeof(uint64_t)))) {
> +        if (tbl_idx == (TARGET_PAGE_SIZE / sizeof(uint64_t))) {

Can't you still simplify that further to

if (tbl_idx == TARGET_PAGE_SIZE / sizeof(uint64_t)) {

> @@ -292,7 +292,8 @@ static void init_ports(PVRDMADev *dev, Error **errp)
>       memset(dev->rdma_dev_res.ports, 0, sizeof(dev->rdma_dev_res.ports));
>   
>       for (i = 0; i < MAX_PORTS; i++) {
> -        dev->rdma_dev_res.ports[i].state = PVRDMA_PORT_DOWN;
> +        dev->rdma_dev_res.ports[i].state =
> +            (enum ibv_port_state)PVRDMA_PORT_DOWN;
>   

This one looks suspicious - shouldn't you instead be using IBV_PORT_DOWN 
instead of having to cast?  (Even if IBV_PORT_DOWN and PVRDMA_PORT_DOWN 
both have the value of 1 for now, the compiler warning is telling you 
that either one of the two enums can change independently in the future, 
and using a cast to shut up the compiler feels unsafe).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
