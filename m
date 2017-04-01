Received: from eggs.gnu.org ([2001:4830:134:3::10]:35325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.r.wilk@gmail.com>) id 1cuI5u-0004gH-LH
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.r.wilk@gmail.com>) id 1cuI5r-0007kx-IN
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:25:26 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <konrad.r.wilk@gmail.com>)
	id 1cuI5r-0007jP-Do
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:25:23 -0400
Received: by mail-qt0-x244.google.com with SMTP id r5so13414219qtb.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 05:25:21 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date: Sat, 1 Apr 2017 08:25:18 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Message-ID: <20170401122517.GB5293@localhost.localdomain>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
	<20170320001249.25521-2-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320001249.25521-2-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v2 01/10] nvdimm xen: disable
 label support on Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xen.org, Dan Williams <dan.j.williams@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

On Mon, Mar 20, 2017 at 08:12:40AM +0800, Haozhong Zhang wrote:
> If xen_enabled(), memory_region_get_ram_ptr() always returns NULL and
> nvdimm_realize() cannot get the correct pointer to the label area. This
> commit disables the label support for Xen accelerator to workaround
> this issue.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> ---
>  hw/mem/nvdimm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index db896b0bb6..0d3e17e94c 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -87,7 +87,11 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>      align = memory_region_get_alignment(mr);
>  
>      pmem_size = size - nvdimm->label_size;
> -    nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
> +    /*
> +     * TODO: explain the reason

Ahem?
> +     */
> +    if (nvdimm->label_size)
> +        nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
>      pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
>  
>      if (size <= nvdimm->label_size || !pmem_size) {
> -- 
> 2.12.0
> 
