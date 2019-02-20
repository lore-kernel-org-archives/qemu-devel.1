Received: from eggs.gnu.org ([209.51.188.92]:43836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGgc-00034u-3X
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGga-0005UN-1t
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:28:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwGgV-0003i9-Vi
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:28:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so10743652wrg.9
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 17:26:19 -0800 (PST)
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<20190220005124.24224-4-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d203d22a-0f29-cbd3-e073-868bf9a35233@redhat.com>
Date: Wed, 20 Feb 2019 02:26:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190220005124.24224-4-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] pc-dimm: revert "introduce realize
 callback"
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
> realize callback in introduced to check if the backend memory is large
> enough to contain label data and init its memory region, while this task
> is handled in pre_plug stage.
> 
> Now it's time to remove it.

Good cleanup!

Michael, can you add:

"This reverts commit 9f318f8f7e689b9653b42bac73047f9719a1f34e."

Thanks,

Phil.

> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mem/pc-dimm.c         | 5 -----
>  include/hw/mem/pc-dimm.h | 3 ---
>  2 files changed, 8 deletions(-)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 152400b1fc..5832c0ba92 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -159,7 +159,6 @@ static void pc_dimm_init(Object *obj)
>  static void pc_dimm_realize(DeviceState *dev, Error **errp)
>  {
>      PCDIMMDevice *dimm = PC_DIMM(dev);
> -    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>  
>      if (!dimm->hostmem) {
>          error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
> @@ -178,10 +177,6 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    if (ddc->realize) {
> -        ddc->realize(dimm, errp);
> -    }
> -
>      host_memory_backend_set_mapped(dimm->hostmem, true);
>  }
>  
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 01436b9f50..d18f8246b7 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -59,8 +59,6 @@ typedef struct PCDIMMDevice {
>  
>  /**
>   * PCDIMMDeviceClass:
> - * @realize: called after common dimm is realized so that the dimm based
> - * devices get the chance to do specified operations.
>   * @get_vmstate_memory_region: returns #MemoryRegion which indicates the
>   * memory of @dimm should be kept during live migration. Will not fail
>   * after the device was realized.
> @@ -70,7 +68,6 @@ typedef struct PCDIMMDeviceClass {
>      DeviceClass parent_class;
>  
>      /* public */
> -    void (*realize)(PCDIMMDevice *dimm, Error **errp);
>      MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
>                                                 Error **errp);
>  } PCDIMMDeviceClass;
> 
