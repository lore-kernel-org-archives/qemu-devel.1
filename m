Received: from eggs.gnu.org ([2001:4830:134:3::10]:38193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6ZZ9-0003wh-Ct
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6ZZ8-0007cz-D3
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:30:23 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170505090044.28754-1-hch@lst.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f282c1fb-6c8b-a16d-8ce0-5ce244ec4fb2@redhat.com>
Date: Fri, 5 May 2017 11:30:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170505090044.28754-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvme: Implement Write Zeroes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 05/05/2017 11:00, Christoph Hellwig wrote:
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> [hch: ported over from qemu-nvme.git to mainline]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  hw/block/nvme.c | 26 ++++++++++++++++++++++++++
>  hw/block/nvme.h |  1 +
>  2 files changed, 27 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index ae303d44e5..3f4d2bf2ba 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -227,6 +227,29 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      return NVME_NO_COMPLETE;
>  }
>  
> +static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> +    NvmeRequest *req)
> +{
> +    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> +    const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> +    const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> +    uint64_t slba = le64_to_cpu(rw->slba);
> +    uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
> +    uint64_t aio_slba = slba << (data_shift - BDRV_SECTOR_BITS);
> +    uint32_t aio_nlb = nlb << (data_shift - BDRV_SECTOR_BITS);
> +
> +    if (slba + nlb > ns->id_ns.nsze) {
> +        return NVME_LBA_RANGE | NVME_DNR;
> +    }
> +
> +    req->has_sg = false;
> +    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> +                     BLOCK_ACCT_WRITE);
> +    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, aio_slba, aio_nlb, 0,
> +                                        nvme_rw_cb, req);

Hi Christoph,

could you pass BDRV_REQ_MAY_UNMAP for the flags here if the deallocate
bit (dword 12 bit 25) is set?

Thanks,

Paolo

> +    return NVME_NO_COMPLETE;
> +}
> +
>  static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
> @@ -279,6 +302,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      switch (cmd->opcode) {
>      case NVME_CMD_FLUSH:
>          return nvme_flush(n, ns, cmd, req);
> +    case NVME_CMD_WRITE_ZEROS:
> +        return nvme_write_zeros(n, ns, cmd, req);
>      case NVME_CMD_WRITE:
>      case NVME_CMD_READ:
>          return nvme_rw(n, ns, cmd, req);
> @@ -895,6 +920,7 @@ static int nvme_init(PCIDevice *pci_dev)
>      id->sqes = (0x6 << 4) | 0x6;
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
> +    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS);
>      id->psd[0].mp = cpu_to_le16(0x9c4);
>      id->psd[0].enlat = cpu_to_le32(0x10);
>      id->psd[0].exlat = cpu_to_le32(0x4);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 8fb0c10756..a0d15649f9 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -179,6 +179,7 @@ enum NvmeIoCommands {
>      NVME_CMD_READ               = 0x02,
>      NVME_CMD_WRITE_UNCOR        = 0x04,
>      NVME_CMD_COMPARE            = 0x05,
> +    NVME_CMD_WRITE_ZEROS        = 0x08,
>      NVME_CMD_DSM                = 0x09,
>  };
>  
> 
