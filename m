Received: from eggs.gnu.org ([2001:4830:134:3::10]:47851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dKDX4-0005AF-7e
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 20:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dKDX1-0001dI-70
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 20:48:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:35464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dKDX0-0001ci-Sh
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 20:48:35 -0400
Date: Mon, 12 Jun 2017 08:48:28 +0800
From: "Haozhong Zhang" <haozhong.zhang@intel.com>
Message-ID: <20170612004828.ox2decbasttybxrs@hz-desktop>
References: <20170609151615.2589-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170609151615.2589-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: fix nvdimm check error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/09/17 16:16 +0100, Stefan Hajnoczi wrote:
> Commit e987c37aee1752177906847630d32477da57e705 ("hw/i386: check if
> nvdimm is enabled before plugging") introduced a check to reject nvdimm
> hotplug if -machine pc,nvdimm=on was not given.
> 
> This check executes after pc_dimm_memory_plug() has already completed
> and does not reverse the effect of this function in the case of failure.
> 
> Perform the check before calling pc_dimm_memory_plug().  This fixes the
> following abort:
> 
>   $ qemu -M accel=kvm -m 1G,slots=4,maxmem=8G \
>          -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G
>   (qemu) device_add nvdimm,memdev=mem1
>   nvdimm is not enabled: missing 'nvdimm' in '-M'
>   (qemu) device_add nvdimm,memdev=mem1
>   Core dumped
> 
> The backtrace is:
> 
>   #0  0x00007fffdb5b191f in raise () at /lib64/libc.so.6
>   #1  0x00007fffdb5b351a in abort () at /lib64/libc.so.6
>   #2  0x00007fffdb5a9da7 in __assert_fail_base () at /lib64/libc.so.6
>   #3  0x00007fffdb5a9e52 in  () at /lib64/libc.so.6
>   #4  0x000055555577a5fa in qemu_ram_set_idstr (new_block=0x555556747a00, name=<optimized out>, dev=dev@entry=0x555556705590) at qemu/exec.c:1709
>   #5  0x0000555555a0fe86 in vmstate_register_ram (mr=mr@entry=0x55555673a0e0, dev=dev@entry=0x555556705590) at migration/savevm.c:2293
>   #6  0x0000555555965088 in pc_dimm_memory_plug (dev=dev@entry=0x555556705590, hpms=hpms@entry=0x5555566bb0e0, mr=mr@entry=0x555556705630, align=<optimized out>, errp=errp@entry=0x7fffffffc660)
>       at hw/mem/pc-dimm.c:110
>   #7  0x000055555581d89b in pc_dimm_plug (errp=0x7fffffffc6c0, dev=0x555556705590, hotplug_dev=<optimized out>) at qemu/hw/i386/pc.c:1713
>   #8  0x000055555581d89b in pc_machine_device_plug_cb (hotplug_dev=<optimized out>, dev=0x555556705590, errp=0x7fffffffc6c0) at qemu/hw/i386/pc.c:2004
>   #9  0x0000555555914da6 in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffc7e8) at hw/core/qdev.c:926
> 
> Cc: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Haozhong Zhang <haozhong.zhang@intel.com>

> ---
>  hw/i386/pc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5b8c6fb..db41cca 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1692,6 +1692,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr = ddc->get_memory_region(dimm);
>      uint64_t align = TARGET_PAGE_SIZE;
> +    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>  
>      if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
>          align = memory_region_get_alignment(mr);
> @@ -1703,17 +1704,18 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>          goto out;
>      }
>  
> +    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
> +        error_setg(&local_err,
> +                   "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> +        goto out;
> +    }
> +
>      pc_dimm_memory_plug(dev, &pcms->hotplug_memory, mr, align, &local_err);
>      if (local_err) {
>          goto out;
>      }
>  
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> -        if (!pcms->acpi_nvdimm_state.is_enabled) {
> -            error_setg(&local_err,
> -                       "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> -            goto out;
> -        }
> +    if (is_nvdimm) {
>          nvdimm_plug(&pcms->acpi_nvdimm_state);
>      }
>  
> -- 
> 2.9.4
> 
