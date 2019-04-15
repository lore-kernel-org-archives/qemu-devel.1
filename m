Received: from eggs.gnu.org ([209.51.188.92]:36016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG3D1-0006wO-Ix
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG3D0-0007WM-Em
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:07:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hG3D0-0007W6-71
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:07:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so22448306wrp.2
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:07:46 -0700 (PDT)
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-2-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <efbf9e4e-8be1-04b4-3743-ce384de2b58d@redhat.com>
Date: Mon, 15 Apr 2019 17:07:42 +0200
MIME-Version: 1.0
In-Reply-To: <1555334842-195718-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/5] sparc64: use
 memory_region_allocate_system_memory() only for '-m' specified RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>, Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 4/15/19 3:27 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() was designed to be called for
> allocating inital RAM. Using it mutiple times within one board is not
> supported and could fail if -mem-path with non hugepage path is used.
> 
> Keep using memory_region_allocate_system_memory() only for initial
> RAM and use memory_region_init_ram() for the rest fixed size regions.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/sparc64/niagara.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index f8a856f..39a4522 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -37,6 +37,7 @@
>  #include "sysemu/block-backend.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> +#include "qapi/error.h"
>  
>  
>  typedef struct NiagaraBoardState {
> @@ -108,8 +109,8 @@ static void niagara_init(MachineState *machine)
>      /* init CPUs */
>      sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
>      /* set up devices */
> -    memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.ram",
> -                                         NIAGARA_HV_RAM_SIZE);
> +    memory_region_init_ram(&s->hv_ram, NULL, "sun4v-hv.ram",
> +                           NIAGARA_HV_RAM_SIZE, &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
>  
>      memory_region_allocate_system_memory(&s->partition_ram, NULL,

Using the partition RAM as system memory rather than HV one seems the
correct choice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> @@ -118,17 +119,17 @@ static void niagara_init(MachineState *machine)
>      memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
>                                  &s->partition_ram);
>  
> -    memory_region_allocate_system_memory(&s->nvram, NULL,
> -                                         "sun4v.nvram", NIAGARA_NVRAM_SIZE);
> +    memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRAM_SIZE,
> +                           &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_NVRAM_BASE, &s->nvram);
> -    memory_region_allocate_system_memory(&s->md_rom, NULL,
> -                                         "sun4v-md.rom", NIAGARA_MD_ROM_SIZE);
> +    memory_region_init_ram(&s->md_rom, NULL, "sun4v-md.rom",
> +                           NIAGARA_MD_ROM_SIZE, &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_MD_ROM_BASE, &s->md_rom);
> -    memory_region_allocate_system_memory(&s->hv_rom, NULL,
> -                                         "sun4v-hv.rom", NIAGARA_HV_ROM_SIZE);
> +    memory_region_init_ram(&s->hv_rom, NULL, "sun4v-hv.rom",
> +                           NIAGARA_HV_ROM_SIZE, &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_HV_ROM_BASE, &s->hv_rom);
> -    memory_region_allocate_system_memory(&s->prom, NULL,
> -                                         "sun4v.prom", PROM_SIZE_MAX);
> +    memory_region_init_ram(&s->prom, NULL, "sun4v.prom", PROM_SIZE_MAX,
> +                           &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
>  
>      add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE);
> @@ -145,8 +146,8 @@ static void niagara_init(MachineState *machine)
>          BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
>          int size = blk_getlength(blk);
>          if (size > 0) {
> -            memory_region_allocate_system_memory(&s->vdisk_ram, NULL,
> -                                                 "sun4v_vdisk.ram", size);
> +            memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
> +                                   &error_fatal);
>              memory_region_add_subregion(get_system_memory(),
>                                          NIAGARA_VDISK_BASE, &s->vdisk_ram);
>              dinfo->is_default = 1;
> 
