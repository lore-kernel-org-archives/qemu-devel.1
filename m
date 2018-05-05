Received: from eggs.gnu.org ([2001:4830:134:3::10]:41534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEpqE-0006AN-Hl
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEpqB-0001OJ-Rf
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:34:41 -0400
References: <20180423165126.15441-1-david@redhat.com>
	<20180423165126.15441-3-david@redhat.com>
	<20180504192635.GA4903@localhost.localdomain>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0d9452b0-e74a-731a-4743-ea594dfd75d3@gmail.com>
Date: Sat, 5 May 2018 08:34:26 +0300
MIME-Version: 1.0
In-Reply-To: <20180504192635.GA4903@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/11] machine: make MemoryHotplugState
 accessible via the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>



On 05/04/2018 10:26 PM, Eduardo Habkost wrote:
> On Mon, Apr 23, 2018 at 06:51:17PM +0200, David Hildenbrand wrote:
> [...]
>> +    /* always allocate the device memory information */
>> +    machine->device_memory = g_malloc(sizeof(*machine->device_memory));
> [...]
>> -    /* initialize hotplug memory address space */
>> +    /* always allocate the device memory information */
>> +    machine->device_memory = g_malloc(sizeof(*machine->device_memory));
> This makes QEMU crash because machine->device_memory->base is initialized with
> garbage:
>
> #1  0x00007fffef30a8f8 in abort () at /lib64/libc.so.6
> #2  0x00007fffef302026 in __assert_fail_base () at /lib64/libc.so.6
> #3  0x00007fffef3020d2 in  () at /lib64/libc.so.6
> #4  0x0000555555833483 in int128_get64 (a=<optimized out>) at .../qemu-build/include/qemu/int128.h:22
> #5  0x0000555555837c2e in memory_region_size (a=<optimized out>) at .../qemu-build/memory.c:1735
> #6  0x0000555555837c2e in memory_region_size (mr=<optimized out>) at .../qemu-build/memory.c:1739
> #7  0x00005555558a2b14 in pc_memory_init (pcms=pcms@entry=0x555556850050, system_memory=system_memory@entry=0x555556851e00, rom_memory=rom_memory@entry=0x5555568b8120, ram_memory=ram_memory@entry=0x7fffffffd630)
>      at .../qemu-build/hw/i386/pc.c:1440
> #8  0x00005555558a5a73 in pc_init1 (machine=0x555556850050, pci_type=0x555555cb6fd0 "i440FX", host_type=0x555555c43e41 "i440FX-pcihost") at .../qemu-build/hw/i386/pc_piix.c:179
> #9  0x00005555559abbda in machine_run_board_init (machine=0x555556850050) at .../qemu-build/hw/core/machine.c:829
> #10 0x00005555557dc515 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at .../qemu-build/vl.c:4563
>
>
> I will squash the following fixup:
>
>  From 6216fdb28476ed21c4ced4672003c9c7cb0e04d2 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Fri, 4 May 2018 15:54:46 +0200
> Subject: [PATCH] memory-device: fix device_memory creation on pc and spapr
>
> We have to inititalize the struct to 0. Otherwise, without "maxmem",
> the content is undefined, which might result in random asserts
> striking when e.g. reading out the size of the contained memory region.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/i386/pc.c   | 2 +-
>   hw/ppc/spapr.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ffcd7b85d9..868893d0a1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1372,7 +1372,7 @@ void pc_memory_init(PCMachineState *pcms,
>       }
>   
>       /* always allocate the device memory information */
> -    machine->device_memory = g_malloc(sizeof(*machine->device_memory));
> +    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
>   
>       /* initialize device memory address space */
>       if (pcmc->has_reserved_memory &&
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ef05075232..a1abcba6ad 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2637,7 +2637,7 @@ static void spapr_machine_init(MachineState *machine)
>       memory_region_add_subregion(sysmem, 0, ram);
>   
>       /* always allocate the device memory information */
> -    machine->device_memory = g_malloc(sizeof(*machine->device_memory));
> +    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
>   
>       /* initialize hotplug memory address space */
>       if (machine->ram_size < machine->maxram_size) {

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
