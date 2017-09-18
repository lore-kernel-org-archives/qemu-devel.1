Received: from eggs.gnu.org ([2001:4830:134:3::10]:54110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dtsIH-0005Or-Ge
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dtsID-0005uj-KW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:24:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34566
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dtsIC-0005u5-K9
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:24:41 -0400
References: <1505464398-28897-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170918110846.74476f91@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <857a7c4c-7593-2365-cee1-7d217be15817@cn.fujitsu.com>
Date: Mon, 18 Sep 2017 17:24:31 +0800
MIME-Version: 1.0
In-Reply-To: <20170918110846.74476f91@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] NUMA: Enable adding NUMA node
 implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Igor,

At 09/18/2017 05:08 PM, Igor Mammedov wrote:
> On Fri, 15 Sep 2017 16:33:18 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>> In QEMU, if we enable NUMA and have nodes, QEMU will build ACPI SRAT table
>> for transfering NUMA configuration to the guest. So, the maximum memory in
>> SRAT can be used to determine whether to use the swiotlb for IOMMU or not.
>> However, if QEmu doesn't enable NUMA explicitly on CLI, The SRAT will
>> never be built. When memory hotplug is enabled, some guest's devices may
>> start failing due to SWIOTLB is disabled.
>>
>> Add numa_implicit_add_node0 in struct MachineClass, Invoke it before QEMU
>> parse NUMA options to enable adding NUMA node implicitly.
>
>
> I'd rewrite commit message with something like:
>
> Linux and Windows need ACPI SRAT table to make memory
> hotplug work properly, however currently QEMU doesn't
> create SRAT table if numa options aren't present on CLI.
>
> Which breaks both linux and windows guests in certain
> conditions:
>  * windows: won't enable memory hotplug without SRAT table at all
>  * linux: if QEMU is started with initial memory all below
>    4Gb and no SRAT table present, guest kernel will use
>    nommu DMA ops, which breaks 32bit hw drivers when memory
>    is hotplugged and guest tries to use it with that drivers.
>
> Fix above issues by automatically creating a numa node when
> QEMU is started with memory hotplug enabled but without '-numa'
> options on CLI.
> (PS: auto-create numa node only for new machine types so
> not to break migration).
>
> Which would provide SRAT table to guests without explicit
> -numa options on CLI and would allow:
>  * windows: to enable memory hotplug
>  * linux: switch to SWIOTLB DMA ops, to bounce DMA transfers
>    to 32bit allocated buffers that legacy drivers/hw can handle.
>

It's more detailed and clear to understand, I will update the changelog
in the next version.

Thanks,
	dou.
>
>> Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Alistair Francis <alistair23@gmail.com>
>> Cc: f4bug@amsat.org
>> Cc: Takao Indoh <indou.takao@jp.fujitsu.com>
>> Cc: Izumi Taku <izumi.taku@jp.fujitsu.com>
>>
>> ---
>>  hw/i386/pc.c        |  6 ++++++
>>  include/hw/boards.h |  4 ++++
>>  vl.c                | 14 ++++++++++++++
>>  3 files changed, 24 insertions(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 2108104..3c40117 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2308,6 +2308,11 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>>      return ms->possible_cpus;
>>  }
>>
>> +static void numa_implicit_add_node0(void)
>> +{
>> +    qemu_opts_parse_noisily(qemu_find_opts("numa"), "node", true);
>> +}
>> +
>>  static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
>>  {
>>      /* cpu index isn't used */
>> @@ -2349,6 +2354,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>>      mc->get_hotplug_handler = pc_get_hotpug_handler;
>>      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
>>      mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
>> +    mc->numa_implicit_add_node0 = numa_implicit_add_node0;
>>      mc->has_hotpluggable_cpus = true;
>>      mc->default_boot_order = "cad";
>>      mc->hot_add_cpu = pc_hot_add_cpu;
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 7f044d1..898d841 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -141,6 +141,8 @@ typedef struct {
>>   *    should instead use "unimplemented-device" for all memory ranges where
>>   *    the guest will attempt to probe for a device that QEMU doesn't
>>   *    implement and a stub device is required.
>> + * @numa_implicit_add_node0:
>> + *    Enable NUMA implicitly by add a NUMA node.
> how about:
> s/auto_enable_numa_with_memhp/
> boolean instead, see below how it could improve patch.
>
>>   */
>>  struct MachineClass {
>>      /*< private >*/
>> @@ -191,6 +193,8 @@ struct MachineClass {
>>      CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
>>                                                           unsigned cpu_index);
>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>> +
>> +    void (*numa_implicit_add_node0)(void);
>>  };
>>
>>  /**
>> diff --git a/vl.c b/vl.c
>> index fb1f05b..814a5fa 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -3030,6 +3030,7 @@ int main(int argc, char **argv, char **envp)
>>      Error *main_loop_err = NULL;
>>      Error *err = NULL;
>>      bool list_data_dirs = false;
>> +    bool has_numa_config_in_CLI = false;
>>      typedef struct BlockdevOptions_queue {
>>          BlockdevOptions *bdo;
>>          Location loc;
>> @@ -3293,6 +3294,7 @@ int main(int argc, char **argv, char **envp)
>>                  if (!opts) {
>>                      exit(1);
>>                  }
>> +                has_numa_config_in_CLI = true;
>>                  break;
>>              case QEMU_OPTION_display:
>>                  display_type = select_display(optarg);
>> @@ -4585,6 +4587,18 @@ int main(int argc, char **argv, char **envp)
>>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>>
>> +    /*
>> +     * If memory hotplug is enabled i.e. slots > 0 and user hasn't add
>> +     * NUMA nodes explicitly on CLI
>> +     *
>> +     * Enable NUMA implicitly for guest to know the maximum memory
>> +     * from ACPI SRAT table, which is used for SWIOTLB.
>> +     */
>> +    if (ram_slots > 0 && !has_numa_config_in_CLI) {
>> +        if (machine_class->numa_implicit_add_node0) {
>> +            machine_class->numa_implicit_add_node0();
>> +        }
>> +    }
>>      parse_numa_opts(current_machine);
> it would be better to put this logic inside of parse_numa_opts()
> I'd suggest to move:
>
>     current_machine->ram_size = ram_size;
>     current_machine->maxram_size = maxram_size;
>     current_machine->ram_slots = ram_slots;
>
> before parse_numa_opts() is called, and then
> handle 'memhp present+no numa on CLI" logic inside of
> parse_numa_opts(). With this you won't have to track
> 'has_numa_config_in_CLI', drop callback numa_implicit_add_node0()
> and numa nuances would be in place they are supposed to be: numa.c
>
>>
>>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>
>
>
>
