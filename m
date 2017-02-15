Received: from eggs.gnu.org ([2001:4830:134:3::10]:49219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1ce7u7-0003zg-8S
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1ce7u3-0008I8-AP
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:18:27 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:32594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1ce7u3-0008Hd-06
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:18:23 -0500
Date: Wed, 15 Feb 2017 17:18:10 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170215221810.GA25208@char.us.ORACLE.com>
References: <20161010003423.4333-1-haozhong.zhang@intel.com>
	<20161010003423.4333-2-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161010003423.4333-2-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH 1/8] nvdimm: do not initialize
 label_data if label_size is zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xensource.com, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, Oct 10, 2016 at 08:34:16AM +0800, Haozhong Zhang wrote:
> When memory-backend-xen is used, the label_data pointer can not be got
> via memory_region_get_ram_ptr(). We will use other functions to get

Could you explain why it cannot be retrieved via that way?

> label_data once we introduce NVDIMM label support to Xen.

Is this an particular patch in this series that does that?
You may want to enumerate which one it is.

> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/mem/nvdimm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 7895805..d25993b 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -87,7 +87,9 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>      align = memory_region_get_alignment(mr);
>  
>      pmem_size = size - nvdimm->label_size;
> -    nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
> +    if (nvdimm->label_size) {
> +        nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
> +    }
>      pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
>  
>      if (size <= nvdimm->label_size || !pmem_size) {
> -- 
> 2.10.1
> 
