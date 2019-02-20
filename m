Received: from eggs.gnu.org ([209.51.188.92]:43277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGc6-0007Dk-SC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGbs-0000J8-3N
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:23:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwGbc-0007u2-TC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:23:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so9478440wrt.11
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 17:21:38 -0800 (PST)
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<20190220005124.24224-3-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41b3ffb8-cdca-28d6-db1f-264fce9096f1@redhat.com>
Date: Wed, 20 Feb 2019 02:21:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190220005124.24224-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] mem/nvdimm: remove nvdimm_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com

On 2/20/19 1:51 AM, Wei Yang wrote:
> nvdimm_realize is used to prepare its memory region, while this is done
> in pre_plug stage.

Via the device parent:

pc_dimm_pre_plug()
 -> memory_device_pre_plug()
     -> MemoryDeviceClass::get_memory_region()
        nvdimm_md_get_memory_region()

> 
> This is time to remove it.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> ---
> v2: split nvdimm part here
> ---
>  hw/mem/nvdimm.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index bf2adf5e16..8f69576926 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -136,15 +136,6 @@ static MemoryRegion *nvdimm_md_get_memory_region(MemoryDeviceState *md,
>      return nvdimm->nvdimm_mr;
>  }
>  
> -static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> -{
> -    NVDIMMDevice *nvdimm = NVDIMM(dimm);
> -
> -    if (!nvdimm->nvdimm_mr) {
> -        nvdimm_prepare_memory_region(nvdimm, errp);
> -    }
> -}
> -
>  /*
>   * the caller should check the input parameters before calling
>   * label read/write functions.
> @@ -192,12 +183,10 @@ static Property nvdimm_properties[] = {
>  
>  static void nvdimm_class_init(ObjectClass *oc, void *data)
>  {
> -    PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
>      MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
>      NVDIMMClass *nvc = NVDIMM_CLASS(oc);
>      DeviceClass *dc = DEVICE_CLASS(oc);
>  
> -    ddc->realize = nvdimm_realize;
>      mdc->get_memory_region = nvdimm_md_get_memory_region;
>      dc->props = nvdimm_properties;
>  
> 
