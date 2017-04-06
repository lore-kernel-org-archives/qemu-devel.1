Received: from eggs.gnu.org ([2001:4830:134:3::10]:53432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cw5xs-0008QT-75
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cw5xn-0003Hb-AR
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:52:36 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1cw5xn-0003HP-5D
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:52:31 -0400
Received: by mail-pg0-x242.google.com with SMTP id 79so7997657pgf.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 04:52:30 -0700 (PDT)
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-3-haozhong.zhang@intel.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <ad9c678b-5859-e54c-2eb6-06d458a41312@gmail.com>
Date: Thu, 6 Apr 2017 19:52:25 +0800
MIME-Version: 1.0
In-Reply-To: <20170331084147.32716-3-haozhong.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/4] nvdimm: add functions to
 initialize and perform flush on back store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: dan.j.williams@intel.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 03/31/2017 04:41 PM, Haozhong Zhang wrote:
> fsync() is used to persist modifications to the back store. If the
> host NVDIMM is used as the back store, fsync() on Linux will trigger
> the write to the host flush hint address.
>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  hw/mem/nvdimm.c         | 22 ++++++++++++++++++++++
>  include/hw/mem/nvdimm.h | 13 +++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index db896b0..484ab8b 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -78,6 +78,26 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
>      return &nvdimm->nvdimm_mr;
>  }
>
> +static void nvdimm_flush_init(NVDIMMDevice *nvdimm, MemoryRegion *hostmem_mr)
> +{
> +    if (nvdimm->flush_hint_enabled) {
> +        nvdimm->backend_fd = memory_region_get_fd(hostmem_mr);

Hmm, IIRC host-mem-file does not initalize backend_fd at all.
